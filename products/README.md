# Product Catalog

Organize commercial offers separately from curriculum source files.

- `free-lessons/`: public demonstrations. Never include private answer keys or paid files by mistake.
- `complete-lesson-kits/`: metadata, final components and versions for commercial kits.
- `lesson-series/`: sequences and bundles of lessons.

Each product should have slug, title, CEFR level, description, included components, price when defined, status (draft/published/archived), version and access policy. Connect the public catalog to Supabase only after the database schema and permissions have been verified.