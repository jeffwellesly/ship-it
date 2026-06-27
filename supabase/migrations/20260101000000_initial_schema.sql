-- Initial schema baseline — reflects what already exists in the live database.
-- Do NOT run this against the live DB (it's already applied).
-- Apply only to new/local environments via: npx supabase db reset

-- 1. PROFILES
create table profiles (
  id uuid references auth.users(id) primary key,
  display_name text,
  total_xp integer default 0,
  current_streak integer default 0,
  created_at timestamp with time zone default now()
);

-- 2. LESSONS
create table lessons (
  id uuid default gen_random_uuid() primary key,
  chapter text not null,
  title text not null,
  sort_order integer not null,
  content text not null,
  created_at timestamp with time zone default now()
);

-- 3. QUESTIONS
create table questions (
  id uuid default gen_random_uuid() primary key,
  lesson_id uuid references lessons(id) on delete cascade,
  question_text text not null,
  choices jsonb not null,
  correct_choice_index integer not null,
  created_at timestamp with time zone default now()
);

-- 4. USER_PROGRESS
create table user_progress (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users(id) on delete cascade,
  lesson_id uuid references lessons(id) on delete cascade,
  completed_at timestamp with time zone default now(),
  unique (user_id, lesson_id)
);

-- 5. BADGES
create table badges (
  id uuid default gen_random_uuid() primary key,
  name text not null,
  description text not null,
  icon text,
  unlock_rule text not null,
  created_at timestamp with time zone default now()
);

-- 6. USER_BADGES
create table user_badges (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users(id) on delete cascade,
  badge_id uuid references badges(id) on delete cascade,
  earned_at timestamp with time zone default now(),
  unique (user_id, badge_id)
);

-- ROW LEVEL SECURITY
alter table profiles enable row level security;
alter table user_progress enable row level security;
alter table user_badges enable row level security;
alter table lessons enable row level security;
alter table questions enable row level security;
alter table badges enable row level security;

create policy "Users can view own profile" on profiles for select using (auth.uid() = id);
create policy "Users can update own profile" on profiles for update using (auth.uid() = id);
create policy "Users can insert own profile" on profiles for insert with check (auth.uid() = id);

create policy "Users can view own progress" on user_progress for select using (auth.uid() = user_id);
create policy "Users can insert own progress" on user_progress for insert with check (auth.uid() = user_id);

create policy "Users can view own badges" on user_badges for select using (auth.uid() = user_id);
create policy "Users can insert own badges" on user_badges for insert with check (auth.uid() = user_id);

create policy "Anyone can view lessons" on lessons for select using (true);
create policy "Anyone can view questions" on questions for select using (true);
create policy "Anyone can view badges" on badges for select using (true);

-- PROFILE AUTO-CREATION TRIGGER
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = ''
as $$
begin
  insert into public.profiles (id, display_name, total_xp, current_streak)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'user_name', new.email),
    0,
    0
  );
  return new;
end;
$$;

create or replace trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
