-- FLUENT IMMERSION storefront schema. Applied to Supabase project fluent-immersion.
create schema if not exists fluent_immersion;
revoke all on schema fluent_immersion from public, anon, authenticated;
grant usage on schema fluent_immersion to service_role;

create table if not exists fluent_immersion.products (
 id uuid primary key default gen_random_uuid(), slug text not null unique, title text not null, description text,
 product_type text not null default 'lesson_kit' check (product_type in ('lesson_kit','course','bundle')),
 price_cents integer check (price_cents is null or price_cents >= 0), currency text not null default 'BRL',
 status text not null default 'draft' check (status in ('draft','published','archived')), cover_url text,
 features jsonb not null default '[]'::jsonb, created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table if not exists fluent_immersion.lessons (
 id uuid primary key default gen_random_uuid(), slug text not null unique, title text not null, subtitle text,
 cefr_level text not null default 'A2' check (cefr_level in ('A0','A1','A2','B1','B2','C1','C2')),
 topic text, description text, duration_minutes integer not null default 45 check (duration_minutes > 0),
 is_free boolean not null default false, status text not null default 'draft' check (status in ('draft','published','archived')),
 learning_objectives jsonb not null default '[]'::jsonb, lesson_content jsonb not null default '{}'::jsonb,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table if not exists fluent_immersion.lesson_assets (
 id uuid primary key default gen_random_uuid(), lesson_id uuid not null references fluent_immersion.lessons(id) on delete cascade,
 asset_type text not null check (asset_type in ('student_booklet','teacher_guide','slides','worksheet','listening','speaking','quiz','answer_key','extra_resource','editable_file','other')),
 title text not null, storage_path text, external_url text, is_preview boolean not null default false,
 sort_order integer not null default 0, created_at timestamptz not null default now(),
 constraint lesson_assets_has_location check (storage_path is not null or external_url is not null)
);
create table if not exists fluent_immersion.user_profiles (
 user_id uuid primary key references auth.users(id) on delete cascade, display_name text,
 role text not null default 'student' check (role in ('student','teacher','admin')),
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table if not exists fluent_immersion.purchases (
 id uuid primary key default gen_random_uuid(), user_id uuid not null references auth.users(id) on delete cascade,
 product_id uuid not null references fluent_immersion.products(id) on delete restrict,
 status text not null default 'pending' check (status in ('pending','paid','cancelled','refunded','comped')),
 payment_provider text, provider_reference text, purchased_at timestamptz, created_at timestamptz not null default now(),
 unique (user_id, product_id, provider_reference)
);
create table if not exists fluent_immersion.lesson_progress (
 id uuid primary key default gen_random_uuid(), user_id uuid not null references auth.users(id) on delete cascade,
 lesson_id uuid not null references fluent_immersion.lessons(id) on delete cascade,
 status text not null default 'started' check (status in ('started','in_progress','completed')),
 score numeric(5,2) check (score is null or (score >= 0 and score <= 100)), last_section text,
 completed_at timestamptz, updated_at timestamptz not null default now(), unique (user_id, lesson_id)
);
create table if not exists fluent_immersion.leads (
 id uuid primary key default gen_random_uuid(), name text, email text, whatsapp text, interest text,
 source text not null default 'landing_page', consent_to_contact boolean not null default false,
 created_at timestamptz not null default now()
);
create index if not exists lessons_status_level_idx on fluent_immersion.lessons(status, cefr_level);
create index if not exists lesson_assets_lesson_sort_idx on fluent_immersion.lesson_assets(lesson_id, sort_order);
create index if not exists purchases_user_status_idx on fluent_immersion.purchases(user_id, status);
create index if not exists lesson_progress_user_updated_idx on fluent_immersion.lesson_progress(user_id, updated_at desc);
create index if not exists leads_created_at_idx on fluent_immersion.leads(created_at desc);
alter table fluent_immersion.products enable row level security;
alter table fluent_immersion.lessons enable row level security;
alter table fluent_immersion.lesson_assets enable row level security;
alter table fluent_immersion.user_profiles enable row level security;
alter table fluent_immersion.purchases enable row level security;
alter table fluent_immersion.lesson_progress enable row level security;
alter table fluent_immersion.leads enable row level security;
drop policy if exists "users can view own profile" on fluent_immersion.user_profiles;
create policy "users can view own profile" on fluent_immersion.user_profiles for select to authenticated using ((select auth.uid()) = user_id);
drop policy if exists "users can update own profile" on fluent_immersion.user_profiles;
create policy "users can update own profile" on fluent_immersion.user_profiles for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
drop policy if exists "users can view own purchases" on fluent_immersion.purchases;
create policy "users can view own purchases" on fluent_immersion.purchases for select to authenticated using ((select auth.uid()) = user_id);
drop policy if exists "users can view own progress" on fluent_immersion.lesson_progress;
create policy "users can view own progress" on fluent_immersion.lesson_progress for select to authenticated using ((select auth.uid()) = user_id);
drop policy if exists "users can create own progress" on fluent_immersion.lesson_progress;
create policy "users can create own progress" on fluent_immersion.lesson_progress for insert to authenticated with check ((select auth.uid()) = user_id);
drop policy if exists "users can update own progress" on fluent_immersion.lesson_progress;
create policy "users can update own progress" on fluent_immersion.lesson_progress for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
revoke all on all tables in schema fluent_immersion from anon, authenticated, public;
grant all on all tables in schema fluent_immersion to service_role;
