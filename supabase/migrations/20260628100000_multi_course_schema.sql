-- Multi-course data model

-- 1. Courses
create table courses (
  id          uuid default gen_random_uuid() primary key,
  title       text not null,
  description text not null,
  icon        text not null,
  sort_order  integer not null,
  created_at  timestamp with time zone default now()
);

-- 2. Modules
create table modules (
  id          uuid default gen_random_uuid() primary key,
  course_id   uuid references courses(id) on delete cascade not null,
  title       text not null,
  description text not null,
  sort_order  integer not null,
  created_at  timestamp with time zone default now()
);

-- 3. Add module_id to lessons (nullable during migration window)
alter table lessons add column module_id uuid references modules(id) on delete cascade;

-- 4. Seed course
insert into courses (title, description, icon, sort_order) values
  ('Software Development with Claude Code',
   'Learn how software actually works — from how the internet functions to building and shipping real apps with AI.',
   '🚀', 1);

-- 5. Seed module
insert into modules (course_id, title, description, sort_order)
select id,
  'Module 1: Internet Fundamentals',
  'Learn how browsers, servers, and the internet work together every time you tap a button in an app.',
  1
from courses where title = 'Software Development with Claude Code';

-- 6. Point all existing lessons at the new module
update lessons
set module_id = (
  select m.id from modules m
  join courses c on m.course_id = c.id
  where c.sort_order = 1 and m.sort_order = 1
);

-- 7. Enforce NOT NULL, drop old column
alter table lessons alter column module_id set not null;
alter table lessons drop column chapter;

-- 8. RLS (public read, same as lessons/badges)
alter table courses enable row level security;
alter table modules enable row level security;
create policy "Anyone can view courses" on courses for select using (true);
create policy "Anyone can view modules" on modules for select using (true);
