-- Badge definitions
insert into badges (name, description, icon, unlock_rule) values
  ('First Step',        'Complete your first lesson',          '🎯', 'lessons_completed:1'),
  ('Quick Learner',     'Complete 3 lessons',                  '⚡', 'lessons_completed:3'),
  ('Module 1 Complete', 'Finish every lesson in Module 1',     '🏆', 'lessons_completed:6');

-- Atomic lesson completion: inserts progress, increments XP, awards badges.
-- Returns: { already_completed: bool, new_badges: [{name, description, icon}] }
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
begin
  -- Idempotency check
  if exists (
    select 1 from public.user_progress
    where user_id = p_user_id and lesson_id = p_lesson_id
  ) then
    return jsonb_build_object('already_completed', true, 'new_badges', '[]'::jsonb);
  end if;

  insert into public.user_progress (user_id, lesson_id) values (p_user_id, p_lesson_id);

  -- Atomic increment — no read required
  update public.profiles set total_xp = total_xp + 10 where id = p_user_id;

  select count(*) into v_lesson_count
  from public.user_progress where user_id = p_user_id;

  -- Check every lessons_completed:N badge the user doesn't already have
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
        jsonb_build_object(
          'name',        v_badge.name,
          'description', v_badge.description,
          'icon',        v_badge.icon
        )
      );
    end if;
  end loop;

  return jsonb_build_object('already_completed', false, 'new_badges', v_new_badges);
end;
$$;
