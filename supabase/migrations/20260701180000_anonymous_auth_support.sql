-- Update profile creation trigger to handle anonymous users
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = ''
as $$
declare
  v_display_name text;
begin
  if new.is_anonymous then
    v_display_name := 'Guest_' || floor(random() * 9000 + 1000)::text;
  else
    v_display_name := coalesce(new.raw_user_meta_data->>'user_name', new.email);
  end if;

  insert into public.profiles (id, display_name, total_xp, current_streak)
  values (new.id, v_display_name, 0, 0);
  return new;
end;
$$;
