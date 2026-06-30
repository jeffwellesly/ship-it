-- Add Course Complete badge and extend award_lesson_completion to check it.

insert into badges (name, description, icon, unlock_rule) values
  ('Course Complete', 'Finish every module in a course', '🎓', 'course_complete');

create or replace function award_lesson_completion(p_user_id uuid, p_lesson_id uuid)
returns jsonb
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_lesson_count integer;
  v_new_badges   jsonb := '[]'::jsonb;
  v_badge        record;
  v_threshold    integer;
  v_course_id    uuid;
  v_total        integer;
  v_done         integer;
begin
  -- Idempotency
  if exists (
    select 1 from public.user_progress
    where user_id = p_user_id and lesson_id = p_lesson_id
  ) then
    return jsonb_build_object('already_completed', true, 'new_badges', '[]'::jsonb);
  end if;

  insert into public.user_progress (user_id, lesson_id) values (p_user_id, p_lesson_id);
  update public.profiles set total_xp = total_xp + 10 where id = p_user_id;

  select count(*) into v_lesson_count
  from public.user_progress where user_id = p_user_id;

  -- Existing: lessons_completed:N badges
  for v_badge in
    select b.id, b.name, b.description, b.icon, b.unlock_rule
    from public.badges b
    where b.unlock_rule like 'lessons_completed:%'
      and not exists (
        select 1 from public.user_badges ub
        where ub.user_id = p_user_id and ub.badge_id = b.id
      )
  loop
    v_threshold := (regexp_match(v_badge.unlock_rule, 'lessons_completed:(\d+)'))[1]::integer;
    if v_lesson_count >= v_threshold then
      insert into public.user_badges (user_id, badge_id) values (p_user_id, v_badge.id);
      v_new_badges := v_new_badges || jsonb_build_array(
        jsonb_build_object('name', v_badge.name, 'description', v_badge.description, 'icon', v_badge.icon)
      );
    end if;
  end loop;

  -- New: course_complete — fires when user finishes every lesson in a course
  select m.course_id into v_course_id
  from public.lessons l
  join public.modules m on m.id = l.module_id
  where l.id = p_lesson_id;

  if v_course_id is not null then
    select count(*) into v_total
    from public.lessons l
    join public.modules m on m.id = l.module_id
    where m.course_id = v_course_id;

    select count(*) into v_done
    from public.user_progress up
    join public.lessons l on l.id = up.lesson_id
    join public.modules m on m.id = l.module_id
    where up.user_id = p_user_id and m.course_id = v_course_id;

    if v_total > 0 and v_done >= v_total then
      for v_badge in
        select b.id, b.name, b.description, b.icon
        from public.badges b
        where b.unlock_rule = 'course_complete'
          and not exists (
            select 1 from public.user_badges ub
            where ub.user_id = p_user_id and ub.badge_id = b.id
          )
      loop
        insert into public.user_badges (user_id, badge_id) values (p_user_id, v_badge.id);
        v_new_badges := v_new_badges || jsonb_build_array(
          jsonb_build_object('name', v_badge.name, 'description', v_badge.description, 'icon', v_badge.icon)
        );
      end loop;
    end if;
  end if;

  return jsonb_build_object('already_completed', false, 'new_badges', v_new_badges);
end;
$$;
