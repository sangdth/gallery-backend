DROP TRIGGER IF EXISTS trigger_sync ON auth.users;

CREATE TRIGGER trigger_sync
     AFTER INSERT ON auth.users
     FOR EACH ROW
     EXECUTE PROCEDURE sync_user_profile();
