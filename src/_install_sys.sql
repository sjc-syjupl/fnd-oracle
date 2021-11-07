--
--sqlplus sysmen@xe as sysdba


DEFINE FND_USER           = FND_USER
DEFINE LOCAL_PATH        = c:\Fnd\Oracle

GRANT CREATE JOB TO &FND_USER;
GRANT CREATE EXTERNAL JOB TO &FND_USER;
GRANT execute ON sys.Dbms_LOCK TO &FND_USER  with grant option;
GRANT execute ON sys.Dbms_Scheduler TO &FND_USER  with grant option;
GRANT EXECUTE ON UTL_FILE TO &FND_USER;
grant execute on utl_http  to &FND_USER;
GRANT SELECT ON scheduler$_event_log TO &FND_USER;
GRANT SELECT ON dba_scheduler_running_jobs TO &FND_USER;


DROP DIRECTORY NC;
DROP DIRECTORY FND_BIN;
DROP DIRECTORY FND_DOC;
DROP DIRECTORY FND_PDF;
DROP DIRECTORY FND_TEMP;

CREATE DIRECTORY NC AS '&LOCAL_PATH\files';
CREATE DIRECTORY FND_BIN AS '&LOCAL_PATH\bin';
CREATE DIRECTORY FND_DOC AS '&LOCAL_PATH\doc';
CREATE DIRECTORY FND_PDF AS '&LOCAL_PATH\pdf';
CREATE DIRECTORY FND_TEMP AS '&LOCAL_PATH\temp';
GRANT READ, WRITE ON DIRECTORY NC TO &FND_USER;
GRANT READ, WRITE ON DIRECTORY FND_BIN TO &FND_USER;
GRANT READ, WRITE ON DIRECTORY FND_DOC TO &FND_USER;
GRANT READ, WRITE ON DIRECTORY FND_PDF TO &FND_USER;
GRANT READ, WRITE ON DIRECTORY FND_TEMP TO &FND_USER;





/*


DROP TYPE XML_OBJ;
DROP TYPE attr_tab;
DROP TYPE attrS_tab;
DROP TYPE AttrS_Obj;
DROP TYPE Attr_Obj;



DROP table sap_cache_items_tab;

CREATE OR REPLACE TYPE string_tab AS TABLE OF VARCHAR2(512);

CREATE TABLE sap_cache_items_tab (
    cache_id           NUMBER NOT NULL,
    row_no             NUMBER NOT NULL,
    row_values         string_tab
) nested table row_values store as sap_cache_items_val_tab
  nologging;


CREATE INDEX sap_cache_items_ix1 ON sap_cache_items_tab (cache_id, row_no);






CREATE OR REPLACE TYPE attr_tab AS TABLE OF Attr_Obj;
CREATE OR REPLACE TYPE attrs_tab AS TABLE OF Attrs_Obj;


DECLARE
BEGIN
   FND_API.Compile();
   FND_API.Compile();
END;


*/

