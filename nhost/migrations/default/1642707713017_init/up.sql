SET check_function_bodies = false;
CREATE TABLE public.collections (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    description text,
    type text DEFAULT 'SLIDESHOW'::text NOT NULL,
    status text DEFAULT 'PUBLIC'::text NOT NULL,
    profile_id uuid NOT NULL,
    site_id uuid NOT NULL
);
CREATE TABLE public.images (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    meta text NOT NULL,
    path text NOT NULL,
    name text DEFAULT 'unnamed'::text NOT NULL,
    description text,
    status text DEFAULT 'PUBLIC'::text NOT NULL,
    profile_id uuid NOT NULL,
    collection_id uuid
);
CREATE TABLE public.layouts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    name text DEFAULT 'Default'::text NOT NULL,
    value jsonb NOT NULL,
    status text DEFAULT 'PUBLIC'::text NOT NULL,
    profile_id uuid NOT NULL,
    site_id uuid NOT NULL
);
CREATE TABLE public.options (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    key text NOT NULL,
    value jsonb,
    status text DEFAULT 'PUBLIC'::text NOT NULL,
    profile_id uuid NOT NULL,
    site_id uuid NOT NULL
);
CREATE TABLE public.pages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    name text DEFAULT 'Untitle'::text NOT NULL,
    slug text NOT NULL,
    status text DEFAULT 'PUBLIC'::text NOT NULL,
    profile_id uuid NOT NULL,
    site_id uuid NOT NULL,
    collection_id uuid
);
CREATE TABLE public.profiles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL
);
CREATE TABLE public.sites (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    description text,
    status text DEFAULT 'PUBLIC'::text NOT NULL,
    profile_id uuid NOT NULL
);
ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.layouts
    ADD CONSTRAINT layouts_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_slug_key UNIQUE (slug);
CREATE TRIGGER set_public_collections_updated_at BEFORE UPDATE ON public.collections FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_collections_updated_at ON public.collections IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_images_updated_at BEFORE UPDATE ON public.images FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_images_updated_at ON public.images IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_layouts_updated_at BEFORE UPDATE ON public.layouts FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_layouts_updated_at ON public.layouts IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_options_updated_at BEFORE UPDATE ON public.options FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_options_updated_at ON public.options IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_pages_updated_at BEFORE UPDATE ON public.pages FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_pages_updated_at ON public.pages IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_sites_updated_at BEFORE UPDATE ON public.sites FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_sites_updated_at ON public.sites IS 'trigger to set value of column "updated_at" to current timestamp on row update';
ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES public.collections(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.layouts
    ADD CONSTRAINT layouts_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.layouts
    ADD CONSTRAINT layouts_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES public.collections(id) ON UPDATE SET NULL ON DELETE SET NULL;
ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.sites(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;
