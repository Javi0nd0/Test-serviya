-- ============================================================
-- SERVIYA — SCHEMA COMPLETO v1.0
-- Ejecutar completo en Supabase SQL Editor
-- ============================================================

-- ──────────────────────────────────────────────────────────────
-- 0. EXTENSIONES
-- ──────────────────────────────────────────────────────────────
create extension if not exists "uuid-ossp";
create extension if not exists "pg_trgm"; -- búsqueda de texto eficiente

-- ──────────────────────────────────────────────────────────────
-- 1. UBICACIONES — DIVIPOLA (Colombia primero)
-- ──────────────────────────────────────────────────────────────
create table if not exists public.countries (
  id serial primary key,
  code char(2) unique not null,
  name text not null
);

create table if not exists public.departments (
  id serial primary key,
  country_id int references public.countries(id),
  divipola_code char(2),
  name text not null
);

create table if not exists public.cities (
  id serial primary key,
  department_id int references public.departments(id),
  divipola_code char(5),
  name text not null
);

create index if not exists idx_cities_department on public.cities(department_id);
create index if not exists idx_cities_name on public.cities using gin(name gin_trgm_ops);

-- Datos Colombia
insert into public.countries (code, name) values ('CO', 'Colombia') on conflict do nothing;

insert into public.departments (country_id, divipola_code, name) values
  (1, '11', 'Bogotá D.C.'),
  (1, '25', 'Cundinamarca'),
  (1, '05', 'Antioquia'),
  (1, '76', 'Valle del Cauca'),
  (1, '08', 'Atlántico'),
  (1, '13', 'Bolívar'),
  (1, '68', 'Santander'),
  (1, '54', 'Norte de Santander'),
  (1, '17', 'Caldas'),
  (1, '63', 'Quindío'),
  (1, '66', 'Risaralda')
on conflict do nothing;

-- Bogotá D.C.
insert into public.cities (department_id, divipola_code, name) values
  (1, '11001', 'Bogotá')
on conflict do nothing;

-- Cundinamarca — municipios principales
insert into public.cities (department_id, divipola_code, name) values
  (2, '25001', 'Agua de Dios'),
  (2, '25019', 'Albán'),
  (2, '25035', 'Anapoima'),
  (2, '25040', 'Anolaima'),
  (2, '25053', 'Arbeláez'),
  (2, '25086', 'Beltrán'),
  (2, '25095', 'Bituima'),
  (2, '25099', 'Bojacá'),
  (2, '25120', 'Cabrera'),
  (2, '25123', 'Cachipay'),
  (2, '25126', 'Cajicá'),
  (2, '25148', 'Caparrapí'),
  (2, '25151', 'Caqueza'),
  (2, '25154', 'Carmen de Carupa'),
  (2, '25168', 'Chaguaní'),
  (2, '25175', 'Chía'),
  (2, '25178', 'Chipaque'),
  (2, '25181', 'Choachí'),
  (2, '25183', 'Chocontá'),
  (2, '25200', 'Cogua'),
  (2, '25214', 'Cota'),
  (2, '25224', 'Cucunubá'),
  (2, '25245', 'El Colegio'),
  (2, '25258', 'El Peñón'),
  (2, '25260', 'El Rosal'),
  (2, '25269', 'Facatativá'),
  (2, '25279', 'Fomeque'),
  (2, '25281', 'Fosca'),
  (2, '25286', 'Funza'),
  (2, '25288', 'Fúquene'),
  (2, '25290', 'Fusagasugá'),
  (2, '25293', 'Gachalá'),
  (2, '25295', 'Gachancipá'),
  (2, '25297', 'Gachetá'),
  (2, '25299', 'Gama'),
  (2, '25307', 'Girardot'),
  (2, '25312', 'Granada'),
  (2, '25317', 'Guachetá'),
  (2, '25320', 'Guaduas'),
  (2, '25322', 'Guasca'),
  (2, '25324', 'Guataquí'),
  (2, '25326', 'Guatavita'),
  (2, '25328', 'Guayabal de Síquima'),
  (2, '25335', 'Guayabetal'),
  (2, '25339', 'Gutiérrez'),
  (2, '25368', 'Jerusalén'),
  (2, '25372', 'Junín'),
  (2, '25377', 'La Calera'),
  (2, '25386', 'La Mesa'),
  (2, '25394', 'La Palma'),
  (2, '25398', 'La Peña'),
  (2, '25402', 'La Vega'),
  (2, '25407', 'Lenguazaque'),
  (2, '25426', 'Macheta'),
  (2, '25430', 'Madrid'),
  (2, '25436', 'Manta'),
  (2, '25438', 'Medina'),
  (2, '25473', 'Mosquera'),
  (2, '25483', 'Nariño'),
  (2, '25486', 'Nemocón'),
  (2, '25488', 'Nilo'),
  (2, '25489', 'Nimaima'),
  (2, '25491', 'Nocaima'),
  (2, '25506', 'Venecia'),
  (2, '25513', 'Pacho'),
  (2, '25518', 'Paime'),
  (2, '25524', 'Pandi'),
  (2, '25530', 'Paratebueno'),
  (2, '25535', 'Pasca'),
  (2, '25572', 'Puerto Salgar'),
  (2, '25580', 'Pulí'),
  (2, '25592', 'Quebradanegra'),
  (2, '25594', 'Quetame'),
  (2, '25596', 'Quipile'),
  (2, '25599', 'Apulo'),
  (2, '25612', 'Ricaurte'),
  (2, '25645', 'San Antonio del Tequendama'),
  (2, '25649', 'San Bernardo'),
  (2, '25653', 'San Cayetano'),
  (2, '25658', 'San Francisco'),
  (2, '25662', 'San Juan de Rioseco'),
  (2, '25718', 'Sasaima'),
  (2, '25736', 'Sesquilé'),
  (2, '25740', 'Sibaté'),
  (2, '25743', 'Silvania'),
  (2, '25745', 'Simijaca'),
  (2, '25754', 'Soacha'),
  (2, '25758', 'Sopó'),
  (2, '25769', 'Subachoque'),
  (2, '25772', 'Suesca'),
  (2, '25777', 'Supatá'),
  (2, '25779', 'Susa'),
  (2, '25781', 'Sutatausa'),
  (2, '25785', 'Tabio'),
  (2, '25793', 'Tausa'),
  (2, '25797', 'Tena'),
  (2, '25799', 'Tenjo'),
  (2, '25805', 'Tibacuy'),
  (2, '25807', 'Tibirita'),
  (2, '25815', 'Tocaima'),
  (2, '25817', 'Tocancipá'),
  (2, '25823', 'Topaipí'),
  (2, '25839', 'Ubalá'),
  (2, '25841', 'Ubaque'),
  (2, '25843', 'Villa de San Diego de Ubaté'),
  (2, '25845', 'Une'),
  (2, '25851', 'Útica'),
  (2, '25862', 'Vergara'),
  (2, '25867', 'Vianí'),
  (2, '25871', 'Villagómez'),
  (2, '25873', 'Villapinzón'),
  (2, '25875', 'Villeta'),
  (2, '25878', 'Viotá'),
  (2, '25885', 'Yacopí'),
  (2, '25898', 'Zipacón'),
  (2, '25899', 'Zipaquirá')
on conflict do nothing;

-- Antioquia — principales
insert into public.cities (department_id, divipola_code, name) values
  (3, '05001', 'Medellín'),
  (3, '05045', 'Apartadó'),
  (3, '05088', 'Bello'),
  (3, '05212', 'Copacabana'),
  (3, '05266', 'Envigado'),
  (3, '05308', 'Girardota'),
  (3, '05310', 'Giraldo'),
  (3, '05360', 'Itagüí'),
  (3, '05380', 'La Estrella'),
  (3, '05631', 'Rionegro'),
  (3, '05756', 'Sabaneta')
on conflict do nothing;

-- Valle del Cauca — principales
insert into public.cities (department_id, divipola_code, name) values
  (4, '76001', 'Cali'),
  (4, '76109', 'Buenaventura'),
  (4, '76111', 'Buga'),
  (4, '76520', 'Palmira'),
  (4, '76563', 'Pradera'),
  (4, '76616', 'Roldanillo'),
  (4, '76736', 'Tuluá'),
  (4, '76845', 'Versalles'),
  (4, '76869', 'Vijes')
on conflict do nothing;

-- Atlántico — principales
insert into public.cities (department_id, divipola_code, name) values
  (5, '08001', 'Barranquilla'),
  (5, '08078', 'Baranoa'),
  (5, '08433', 'Malambo'),
  (5, '08520', 'Palmar de Varela'),
  (5, '08549', 'Polonuevo'),
  (5, '08558', 'Ponedera'),
  (5, '08573', 'Puerto Colombia'),
  (5, '08832', 'Tubará')
on conflict do nothing;

-- ──────────────────────────────────────────────────────────────
-- 2. PERFILES DE USUARIO (reemplaza tabla anterior)
-- ──────────────────────────────────────────────────────────────
drop table if exists public.profiles cascade;

create table public.profiles (
  id uuid references auth.users on delete cascade primary key,
  email text not null,
  name text,
  role text not null default 'consumer'
    check (role in ('consumer', 'provider', 'admin', 'moderator', 'support')),
  -- Ubicación jerárquica
  country_id int references public.countries(id) default 1,
  department_id int references public.departments(id),
  city_id int references public.cities(id),
  -- Datos prestador
  nequi text,
  nequi_verified boolean default false,
  category text,
  subcategories text[],
  description text,
  avatar_url text,
  -- Métricas reputacionales
  rating numeric(3,2) default 0,
  total_services int default 0,
  total_reviews int default 0,
  cancellations int default 0,
  claims int default 0,
  avg_response_minutes int default 0,
  completion_rate numeric(5,2) default 100,
  -- Estado
  verified boolean default false,
  featured boolean default false,
  active boolean default true,
  suspended boolean default false,
  suspension_reason text,
  -- Legales
  terms_accepted boolean default false,
  terms_accepted_at timestamptz,
  privacy_accepted boolean default false,
  -- Timestamps
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create index idx_profiles_role on public.profiles(role);
create index idx_profiles_city on public.profiles(city_id);
create index idx_profiles_category on public.profiles(category);
create index idx_profiles_active on public.profiles(active, suspended);

-- ──────────────────────────────────────────────────────────────
-- 3. SOLICITUDES DE SERVICIO
-- ──────────────────────────────────────────────────────────────
create table if not exists public.service_requests (
  id uuid default uuid_generate_v4() primary key,
  consumer_id uuid references public.profiles(id) on delete set null,
  provider_id uuid references public.profiles(id) on delete set null,
  -- Detalles
  category text not null,
  subcategory text,
  description text not null,
  -- Ubicación
  city_id int references public.cities(id),
  address text,
  -- Modalidad
  mode text default 'scheduled' check (mode in ('urgent', 'scheduled')),
  scheduled_at timestamptz,
  -- Estado del servicio
  status text default 'pending'
    check (status in ('pending','accepted','in_progress','completed','cancelled','disputed')),
  -- Pago Nequi
  agreed_price numeric(12,2),
  payment_confirmed_by_consumer boolean default false,
  payment_confirmed_at timestamptz,
  nequi_payment_accepted boolean default false,
  nequi_payment_accepted_at timestamptz,
  -- Timestamps
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  completed_at timestamptz,
  cancelled_at timestamptz,
  cancelled_by uuid references public.profiles(id)
);

create index idx_requests_consumer on public.service_requests(consumer_id);
create index idx_requests_provider on public.service_requests(provider_id);
create index idx_requests_status on public.service_requests(status);
create index idx_requests_created on public.service_requests(created_at desc);

-- ──────────────────────────────────────────────────────────────
-- 4. RESEÑAS Y CALIFICACIONES
-- ──────────────────────────────────────────────────────────────
create table if not exists public.reviews (
  id uuid default uuid_generate_v4() primary key,
  request_id uuid references public.service_requests(id) on delete cascade,
  reviewer_id uuid references public.profiles(id),
  reviewed_id uuid references public.profiles(id),
  rating int not null check (rating between 1 and 5),
  comment text,
  -- Métricas específicas
  punctuality int check (punctuality between 1 and 5),
  quality int check (quality between 1 and 5),
  communication int check (communication between 1 and 5),
  price_value int check (price_value between 1 and 5),
  created_at timestamptz default now()
);

create index idx_reviews_reviewed on public.reviews(reviewed_id);
create index idx_reviews_request on public.reviews(request_id);

-- ──────────────────────────────────────────────────────────────
-- 5. MENSAJES / CHAT
-- ──────────────────────────────────────────────────────────────
create table if not exists public.messages (
  id uuid default uuid_generate_v4() primary key,
  request_id uuid references public.service_requests(id) on delete cascade,
  sender_id uuid references public.profiles(id),
  content text not null,
  read boolean default false,
  created_at timestamptz default now()
);

create index idx_messages_request on public.messages(request_id);
create index idx_messages_sender on public.messages(sender_id);
create index idx_messages_created on public.messages(created_at desc);

-- ──────────────────────────────────────────────────────────────
-- 6. LOG DE EVENTOS CRÍTICOS
-- ──────────────────────────────────────────────────────────────
create table if not exists public.audit_log (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete set null,
  event_type text not null,
  -- Tipos: login_failed, nequi_changed, email_changed, account_created,
  --        account_suspended, service_cancelled, claim_opened,
  --        terms_accepted, role_changed, bulk_accounts_detected
  description text,
  metadata jsonb default '{}',
  ip_address text,
  user_agent text,
  created_at timestamptz default now()
);

create index idx_audit_user on public.audit_log(user_id);
create index idx_audit_event on public.audit_log(event_type);
create index idx_audit_created on public.audit_log(created_at desc);

-- ──────────────────────────────────────────────────────────────
-- 7. DISPUTAS
-- ──────────────────────────────────────────────────────────────
create table if not exists public.disputes (
  id uuid default uuid_generate_v4() primary key,
  request_id uuid references public.service_requests(id),
  opened_by uuid references public.profiles(id),
  against uuid references public.profiles(id),
  reason text not null,
  description text,
  status text default 'open' check (status in ('open','under_review','resolved','closed')),
  resolution text,
  resolved_by uuid references public.profiles(id),
  resolved_at timestamptz,
  created_at timestamptz default now()
);

create index idx_disputes_request on public.disputes(request_id);
create index idx_disputes_status on public.disputes(status);

-- ──────────────────────────────────────────────────────────────
-- 8. ROW LEVEL SECURITY — RBAC real
-- ──────────────────────────────────────────────────────────────

-- Función helper: obtener rol del usuario actual
create or replace function public.get_user_role()
returns text
language sql
security definer
stable
as $$
  select role from public.profiles where id = auth.uid();
$$;

-- Función helper: es admin o moderador
create or replace function public.is_admin_or_mod()
returns boolean
language sql
security definer
stable
as $$
  select role in ('admin','moderator','support')
  from public.profiles where id = auth.uid();
$$;

-- ── PROFILES ──
alter table public.profiles enable row level security;

create policy "Cualquiera puede ver perfiles activos"
  on public.profiles for select
  using (active = true and suspended = false);

create policy "Admin ve todos los perfiles"
  on public.profiles for select
  using (public.is_admin_or_mod());

create policy "Usuario crea su propio perfil"
  on public.profiles for insert
  with check (auth.uid() = id);

create policy "Usuario actualiza su propio perfil"
  on public.profiles for update
  using (auth.uid() = id)
  with check (auth.uid() = id);

create policy "Admin puede actualizar cualquier perfil"
  on public.profiles for update
  using (public.is_admin_or_mod());

-- ── LOCATIONS ──
alter table public.countries enable row level security;
alter table public.departments enable row level security;
alter table public.cities enable row level security;

create policy "Ubicaciones visibles para todos" on public.countries for select using (true);
create policy "Departamentos visibles para todos" on public.departments for select using (true);
create policy "Ciudades visibles para todos" on public.cities for select using (true);

-- ── SERVICE REQUESTS ──
alter table public.service_requests enable row level security;

create policy "Consumer ve sus propias solicitudes"
  on public.service_requests for select
  using (auth.uid() = consumer_id);

create policy "Provider ve solicitudes asignadas"
  on public.service_requests for select
  using (auth.uid() = provider_id);

create policy "Admin ve todas las solicitudes"
  on public.service_requests for select
  using (public.is_admin_or_mod());

create policy "Consumer crea solicitudes"
  on public.service_requests for insert
  with check (auth.uid() = consumer_id);

create policy "Partes actualizan su solicitud"
  on public.service_requests for update
  using (auth.uid() = consumer_id or auth.uid() = provider_id);

create policy "Admin actualiza cualquier solicitud"
  on public.service_requests for update
  using (public.is_admin_or_mod());

-- ── REVIEWS ──
alter table public.reviews enable row level security;

create policy "Reviews visibles para todos" on public.reviews for select using (true);

create policy "Solo el reviewer crea su reseña"
  on public.reviews for insert
  with check (auth.uid() = reviewer_id);

-- ── MESSAGES ──
alter table public.messages enable row level security;

create policy "Solo partes de la solicitud ven mensajes"
  on public.messages for select
  using (
    exists (
      select 1 from public.service_requests sr
      where sr.id = request_id
      and (sr.consumer_id = auth.uid() or sr.provider_id = auth.uid())
    )
    or public.is_admin_or_mod()
  );

create policy "Partes de la solicitud envían mensajes"
  on public.messages for insert
  with check (
    auth.uid() = sender_id
    and exists (
      select 1 from public.service_requests sr
      where sr.id = request_id
      and (sr.consumer_id = auth.uid() or sr.provider_id = auth.uid())
    )
  );

-- ── AUDIT LOG ──
alter table public.audit_log enable row level security;

create policy "Solo admin ve el log"
  on public.audit_log for select
  using (public.is_admin_or_mod());

create policy "Sistema inserta logs"
  on public.audit_log for insert
  with check (true);

-- ── DISPUTES ──
alter table public.disputes enable row level security;

create policy "Partes ven su disputa"
  on public.disputes for select
  using (auth.uid() = opened_by or auth.uid() = against or public.is_admin_or_mod());

create policy "Usuario abre disputa"
  on public.disputes for insert
  with check (auth.uid() = opened_by);

create policy "Admin resuelve disputa"
  on public.disputes for update
  using (public.is_admin_or_mod());

-- ──────────────────────────────────────────────────────────────
-- 9. FUNCIÓN: actualizar rating del prestador automáticamente
-- ──────────────────────────────────────────────────────────────
create or replace function public.update_provider_rating()
returns trigger
language plpgsql
security definer
as $$
begin
  update public.profiles
  set
    rating = (
      select round(avg(rating)::numeric, 2)
      from public.reviews
      where reviewed_id = NEW.reviewed_id
    ),
    total_reviews = (
      select count(*) from public.reviews where reviewed_id = NEW.reviewed_id
    ),
    updated_at = now()
  where id = NEW.reviewed_id;
  return NEW;
end;
$$;

create trigger trg_update_rating
  after insert on public.reviews
  for each row execute function public.update_provider_rating();

-- ──────────────────────────────────────────────────────────────
-- 10. FUNCIÓN: crear perfil automáticamente al registrarse
-- ──────────────────────────────────────────────────────────────
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
as $$
begin
  insert into public.profiles (id, email, name, role)
  values (
    NEW.id,
    NEW.email,
    coalesce(NEW.raw_user_meta_data->>'full_name', split_part(NEW.email,'@',1)),
    coalesce(NEW.raw_user_meta_data->>'role', 'consumer')
  )
  on conflict (id) do nothing;

  -- Log del evento
  insert into public.audit_log (user_id, event_type, description, metadata)
  values (
    NEW.id,
    'account_created',
    'Nueva cuenta registrada',
    jsonb_build_object('email', NEW.email, 'provider', NEW.app_metadata->>'provider')
  );

  return NEW;
end;
$$;

-- Trigger: ejecutar al crear usuario en auth
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ──────────────────────────────────────────────────────────────
-- 11. FUNCIÓN: log de cambio de Nequi
-- ──────────────────────────────────────────────────────────────
create or replace function public.log_nequi_change()
returns trigger
language plpgsql
security definer
as $$
begin
  if OLD.nequi is distinct from NEW.nequi then
    insert into public.audit_log (user_id, event_type, description, metadata)
    values (
      NEW.id,
      'nequi_changed',
      'Número Nequi modificado',
      jsonb_build_object(
        'old_nequi', left(coalesce(OLD.nequi,''), 3) || '****',
        'new_nequi', left(coalesce(NEW.nequi,''), 3) || '****',
        'changed_at', now()
      )
    );
  end if;
  NEW.updated_at = now();
  return NEW;
end;
$$;

create trigger trg_log_nequi
  before update on public.profiles
  for each row execute function public.log_nequi_change();

-- ──────────────────────────────────────────────────────────────
-- 12. FUNCIÓN: actualizar status de solicitud y log
-- ──────────────────────────────────────────────────────────────
create or replace function public.log_request_status_change()
returns trigger
language plpgsql
security definer
as $$
begin
  if OLD.status is distinct from NEW.status then
    insert into public.audit_log (user_id, event_type, description, metadata)
    values (
      auth.uid(),
      'service_status_changed',
      'Estado de solicitud cambió: ' || OLD.status || ' → ' || NEW.status,
      jsonb_build_object(
        'request_id', NEW.id,
        'old_status', OLD.status,
        'new_status', NEW.status
      )
    );

    if NEW.status = 'completed' then
      NEW.completed_at = now();
    end if;
    if NEW.status = 'cancelled' then
      NEW.cancelled_at = now();
      NEW.cancelled_by = auth.uid();
    end if;
  end if;
  NEW.updated_at = now();
  return NEW;
end;
$$;

create trigger trg_log_request_status
  before update on public.service_requests
  for each row execute function public.log_request_status_change();

-- ──────────────────────────────────────────────────────────────
-- 13. SET ADMIN — Actualiza tu cuenta a rol admin
-- ──────────────────────────────────────────────────────────────
-- ¡IMPORTANTE! Reemplaza el email con el tuyo antes de ejecutar
update public.profiles
set role = 'admin'
where email = 'jareypee@gmail.com';

-- ──────────────────────────────────────────────────────────────
-- FIN DEL SCHEMA
-- ──────────────────────────────────────────────────────────────
select 'ServiYa schema v1.0 instalado correctamente 🚀' as resultado;
