-- FLUENT IMMERSION: teacher-owned lesson copies
-- Apply this migration in the Supabase SQL Editor for project nuyzvpkvawixidotuuio.
-- It creates a separate table; it does not modify the administrator's master lessons.
create schema if not exists fluent_immersion;
create table if not exists fluent_immersion.teacher_lesson_edits (
  id uuid primary key default gen_random_uuid(),
  teacher_id uuid not null references auth.users(id) on delete cascade,
  lesson_id text not null,
  content jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (teacher_id, lesson_id)
);
alter table fluent_immersion.teacher_lesson_edits enable row level security;
grant usage on schema fluent_immersion to authenticated;
grant select, insert, update, delete on fluent_immersion.teacher_lesson_edits to authenticated;
drop policy if exists "Teachers read own lesson copies" on fluent_immersion.teacher_lesson_edits;
create policy "Teachers read own lesson copies" on fluent_immersion.teacher_lesson_edits
  for select to authenticated using (teacher_id = (select auth.uid()));
drop policy if exists "Teachers create own lesson copies" on fluent_immersion.teacher_lesson_edits;
create policy "Teachers create own lesson copies" on fluent_immersion.teacher_lesson_edits
  for insert to authenticated with check (teacher_id = (select auth.uid()));
drop policy if exists "Teachers update own lesson copies" on fluent_immersion.teacher_lesson_edits;
create policy "Teachers update own lesson copies" on fluent_immersion.teacher_lesson_edits
  for update to authenticated using (teacher_id = (select auth.uid())) with check (teacher_id = (select auth.uid()));
drop policy if exists "Teachers delete own lesson copies" on fluent_immersion.teacher_lesson_edits;
create policy "Teachers delete own lesson copies" on fluent_immersion.teacher_lesson_edits
  for delete to authenticated using (teacher_id = (select auth.uid()));
