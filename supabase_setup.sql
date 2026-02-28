-- Crear tabla de perfiles de usuarios
create table if not exists public.profiles (
  id uuid references auth.users on delete cascade primary key,
  email text,
  name text,
  role text default 'consumer' check (role in ('consumer', 'provider', 'admin')),
  city text default 'Bogotá',
  nequi text,
  category text,
  description text,
  rating numeric default 0,
  total_services integer default 0,
  verified boolean default false,
  created_at timestamptz default now()
);

-- Habilitar Row Level Security
alter table public.profiles enable row level security;

-- Política: usuarios pueden ver todos los perfiles
create policy "Perfiles visibles para todos" on public.profiles
  for select using (true);

-- Política: usuarios pueden editar solo su propio perfil
create policy "Usuarios editan su perfil" on public.profiles
  for insert with check (auth.uid() = id);

create policy "Usuarios actualizan su perfil" on public.profiles
  for update using (auth.uid() = id);
