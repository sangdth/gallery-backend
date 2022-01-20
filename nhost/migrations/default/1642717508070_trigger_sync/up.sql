CREATE TRIGGER trigger_sync
     AFTER INSERT ON auth.users
     FOR EACH ROW
     EXECUTE PROCEDURE sync_user_profile();
