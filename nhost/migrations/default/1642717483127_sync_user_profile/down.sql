-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- CREATE OR REPLACE FUNCTION sync_user_profile() RETURNS TRIGGER AS
-- $BODY$
-- BEGIN
--     INSERT INTO
--         public.profiles(id, user_id)
--         VALUES(new.id, new.id);
--
--         RETURN new;
-- END;
-- $BODY$
-- language plpgsql;
