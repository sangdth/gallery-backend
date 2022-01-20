CREATE OR REPLACE FUNCTION sync_user_profile() RETURNS TRIGGER AS
$BODY$
BEGIN
    INSERT INTO
        public.profiles(id, user_id)
        VALUES(new.id, new.id);

        RETURN new;
END;
$BODY$
language plpgsql;
