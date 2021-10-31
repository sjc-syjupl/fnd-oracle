DECLARE
BEGIN
   EXECUTE IMMEDIATE '
     CREATE SEQUENCE FND_SESSION_SEQ  MINVALUE 1 START WITH 1 CACHE 20
     ';
   EXCEPTION WHEN OTHERS THEN
      NULL;
END;
/


DECLARE
BEGIN
   EXECUTE IMMEDIATE '
    CREATE TABLE FND_PROPERTY_TAB (
       ENVIRONMENT_ID VARCHAR2(35)  NOT NULL,
       PROPERTY_TYPE  VARCHAR2(35)  NOT NULL,  -- GLOBAL / USER / SESSION
       PROPERTY_ID    VARCHAR2(35)  NOT NULL,
       NAME           VARCHAR2(200) NOT NULL,
       VALUE          VARCHAR2(4000),
       CREATED        DATE DEFAULT SYSDATE
       ) ';
   EXECUTE IMMEDIATE '
    CREATE UNIQUE INDEX FND_PROPERTY_PK ON FND_PROPERTY_TAB (ENVIRONMENT_ID, PROPERTY_TYPE, PROPERTY_ID, NAME) ';
   EXCEPTION WHEN OTHERS THEN
      NULL;
END;
/

DECLARE
BEGIN
   EXECUTE IMMEDIATE '
    CREATE TABLE FND_BACKGROUND_JOB_TAB (
       SESSION_ID         NUMBER       NOT NULL,
       STATE              VARCHAR2(30) DEFAULT ''POSTED'' NOT NULL, -- POSTED / EXECUTING / READY / ERROR
       TYPE               VARCHAR2(30) DEFAULT ''PL/SQL'' NOT NULL, -- PL/SQL / EXTERNAL
       PROCEDURE_NAME     VARCHAR2(4000),
       PARAM1             VARCHAR2(2000),
       PARAM2             VARCHAR2(2000),
       PARAM3             VARCHAR2(2000),
       PARAM4             VARCHAR2(2000),
       PARAM5             VARCHAR2(2000),
       ERROR_TEXT         VARCHAR2(2000),
       CREATED            DATE DEFAULT SYSDATE,
       STARTED            TIMESTAMP,
       EXECUTED           TIMESTAMP,
       KEEP_DATA_UNTIL    DATE DEFAULT SYSDATE + 7,
       TMP_LOG_ID         NUMBER
       )
       ';

   EXECUTE IMMEDIATE '
    CREATE INDEX FND_BACKGROUND_JOB_ID1 ON FND_BACKGROUND_JOB_TAB (SESSION_ID)
       ';
   EXECUTE IMMEDIATE '
    CREATE INDEX FND_BACKGROUND_JOB_ID2 ON FND_BACKGROUND_JOB_TAB (STATE, KEEP_DATA_UNTIL)
       ';
   EXCEPTION WHEN OTHERS THEN
      NULL;
END;
/

DECLARE
BEGIN
   EXECUTE IMMEDIATE '
    CREATE TABLE FND_SESSION_DATA_TAB (
       SESSION_ID   NUMBER       NOT NULL,
       DATA_TYPE    VARCHAR2(50) NOT NULL,
       ROW_NO       NUMBER       NOT NULL,
       S01          VARCHAR2(2000),
       S02          VARCHAR2(2000),
       S03          VARCHAR2(2000),
       S04          VARCHAR2(2000),
       S05          VARCHAR2(2000),
       S06          VARCHAR2(2000),
       S07          VARCHAR2(2000),
       S08          VARCHAR2(2000),
       S09          VARCHAR2(2000),
       S10          VARCHAR2(2000),
       S11          VARCHAR2(2000),
       S12          VARCHAR2(2000),
       S13          VARCHAR2(2000),
       S14          VARCHAR2(2000),
       S15          VARCHAR2(2000),
       S16          VARCHAR2(2000),
       S17          VARCHAR2(2000),
       S18          VARCHAR2(2000),
       S19          VARCHAR2(2000),
       S20          VARCHAR2(2000),
       S21          VARCHAR2(2000),
       S22          VARCHAR2(2000),
       S23          VARCHAR2(2000),
       S24          VARCHAR2(2000),
       S25          VARCHAR2(2000),
       S26          VARCHAR2(2000),
       S27          VARCHAR2(2000),
       S28          VARCHAR2(2000),
       S29          VARCHAR2(2000),
       S30          VARCHAR2(2000),
       S31          VARCHAR2(2000),
       S32          VARCHAR2(2000),
       S33          VARCHAR2(2000),
       S34          VARCHAR2(2000),
       S35          VARCHAR2(2000),
       S36          VARCHAR2(2000),
       S37          VARCHAR2(2000),
       S38          VARCHAR2(2000),
       S39          VARCHAR2(2000),
       N01          NUMBER,
       N02          NUMBER,
       N03          NUMBER,
       N04          NUMBER,
       N05          NUMBER,
       N06          NUMBER,
       N07          NUMBER,
       N08          NUMBER,
       N09          NUMBER,
       N10          NUMBER,
       N11          NUMBER,
       N12          NUMBER,
       N13          NUMBER,
       N14          NUMBER,
       N15          NUMBER,
       N16          NUMBER,
       N17          NUMBER,
       N18          NUMBER,
       N19          NUMBER,
       D01          DATE,
       D02          DATE,
       D03          DATE,
       D04          DATE,
       D05          DATE,
       D06          DATE,
       D07          DATE,
       D08          DATE,
       D09          DATE
       )
       ';

   EXECUTE IMMEDIATE '
    CREATE INDEX FND_SESSION_DATA_PK ON FND_SESSION_DATA_TAB (SESSION_ID, DATA_TYPE, ROW_NO)
       ';
   EXCEPTION WHEN OTHERS THEN
      NULL;
END;
/

DECLARE
BEGIN
   EXECUTE IMMEDIATE '
    CREATE TABLE FND_SESSION_DATA_CLOB_TAB (
       SESSION_ID   NUMBER       NOT NULL,
       DATA_TYPE    VARCHAR2(50) NOT NULL,
       ROW_NO       NUMBER       NOT NULL,
       CLOB_DATA    CLOB
       )
       ';

   EXECUTE IMMEDIATE '
    CREATE INDEX FND_SESSION_DATA_CLOB_PK ON FND_SESSION_DATA_CLOB_TAB (SESSION_ID, DATA_TYPE, ROW_NO)
       ';
   EXCEPTION WHEN OTHERS THEN
      NULL;
END;
/

DECLARE
BEGIN
   EXECUTE IMMEDIATE '
    CREATE TABLE FND_SESSION_DATA_BLOB_TAB (
       SESSION_ID   NUMBER       NOT NULL,
       DATA_TYPE    VARCHAR2(50) NOT NULL,
       ROW_NO       NUMBER       NOT NULL,
       BLOB_DATA    BLOB
       )
       ';

   EXECUTE IMMEDIATE '
    CREATE INDEX FND_SESSION_DATA_BLOB_PK ON FND_SESSION_DATA_BLOB_TAB (SESSION_ID, DATA_TYPE, ROW_NO)
       ';
   EXCEPTION WHEN OTHERS THEN
      NULL;
END;
/


DECLARE
BEGIN
   EXECUTE IMMEDIATE '
   CREATE TABLE FND_LOG_TAB (
      ID          NUMBER,
      SESSION_ID  VARCHAR2(35),
      USER_ID     VARCHAR2(35),
      LOG         VARCHAR2(4000),
      ROWVERSION  DATE
      )
   ';
   EXECUTE IMMEDIATE '
   CREATE INDEX FND_LOG_PK ON FND_LOG_TAB (ID)
   ';
   EXECUTE IMMEDIATE '
   CREATE SEQUENCE FND_LOG_SEQ  MINVALUE 1 START WITH 1 CACHE 20
   ';
   EXCEPTION WHEN OTHERS THEN
      NULL;
END;
/


DECLARE
BEGIN
   EXECUTE IMMEDIATE '
   CREATE TABLE FND_ERROR_TAB (
      ERROR_ID          NUMBER,
      LOG_ID            NUMBER,
      TEXT              VARCHAR2(4000),
      ROWVERSION        DATE
      )
   ';
   EXECUTE IMMEDIATE '
   CREATE INDEX FND_ERROR_PK ON FND_ERROR_TAB (ERROR_ID, LOG_ID)
   ';
   EXCEPTION WHEN OTHERS THEN
      NULL;
END;
/

DECLARE
BEGIN
   EXECUTE IMMEDIATE '
   create or replace type two_string_rec as object
   (
   str_1         VARCHAR2(4000),
   str_2         VARCHAR2(4000)
   )
   ';
   EXCEPTION WHEN OTHERS THEN
      NULL;
END;
/

/*
DECLARE
BEGIN
   EXECUTE IMMEDIATE '
   CREATE TABLE sap_rfc_cache_tab (
      time          DATE,
      hash          NUMBER,
      status        VARCHAR2(20),
      response      CLOB
   ) nologging';

   EXECUTE IMMEDIATE 'CREATE INDEX sap_rfc_cache_ix1 ON sap_rfc_cache_tab (hash)';
   EXCEPTION WHEN OTHERS THEN
      NULL;
END;
/


DECLARE
BEGIN
   EXECUTE IMMEDIATE '
   CREATE TABLE sap_cache_head_tab (
      cache_id           NUMBER         NOT NULL,
      cache_type         VARCHAR2(20)   NOT NULL,
      table_name         VARCHAR2(30)   NOT NULL,
      table_description  VARCHAR2(100),
      table_columns      VARCHAR2(4000) NOT NULL,
      table_columns_tab  name_tab,
      table_columns_count  NUMBER,
      table_columns_key  VARCHAR2(1000),
      where_str          VARCHAR2(1000),
      last_update        DATE,
      valid_to           DATE,
      next_update_sec    NUMBER      DEFAULT 10,
      auto_refresh       VARCHAR2(1) DEFAULT ''N'',  --Y/N
      time_execute_sec   NUMBER,
      count_rows         NUMBER,
      state              VARCHAR2(20)  --READY / NEW / EXECUTED 
   ) nested table table_columns_tab store as sap_cache_head_col_tab nologging';

   EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX sap_cache_head_ix1 ON sap_cache_head_tab (cache_id)';
   EXECUTE IMMEDIATE 'CREATE INDEX sap_cache_head_ix2 ON sap_cache_head_tab (table_name)';
   EXCEPTION WHEN OTHERS THEN
      NULL;
END;
/


DECLARE
BEGIN
   EXECUTE IMMEDIATE '
   CREATE TABLE sap_cache_items_tab (
      cache_id           NUMBER NOT NULL,
      row_no             NUMBER NOT NULL,
      key                VARCHAR2(70),
      row_values         string_tab,
      valid_to           DATE
   ) nested table row_values store as sap_cache_items_val_tab nologging';

   EXECUTE IMMEDIATE 'CREATE INDEX sap_cache_items_ix1 ON sap_cache_items_tab (cache_id, row_no)';
   EXECUTE IMMEDIATE 'CREATE INDEX sap_cache_items_ix2 ON sap_cache_items_tab (cache_id, key)';
   EXCEPTION WHEN OTHERS THEN
      NULL;
END;
/

*/



DECLARE
BEGIN
   BEGIN 
   EXECUTE IMMEDIATE 'DROP TYPE XML_OBJ';
   EXCEPTION WHEN OTHERS THEN
      NULL;
   END;
   BEGIN 
   EXECUTE IMMEDIATE 'DROP TYPE attr_tab';
   EXCEPTION WHEN OTHERS THEN
      NULL;
   END;

   BEGIN 
   EXECUTE IMMEDIATE 'DROP TYPE attrS_tab';
   EXCEPTION WHEN OTHERS THEN
      NULL;
   END;

   BEGIN 
   EXECUTE IMMEDIATE 'DROP TYPE AttrS_Obj';
   EXCEPTION WHEN OTHERS THEN
      NULL;
   END;

   BEGIN 
   EXECUTE IMMEDIATE 'DROP TYPE Attr_Obj';
   EXCEPTION WHEN OTHERS THEN
      NULL;
   END;
   
   BEGIN
   EXECUTE IMMEDIATE 'CREATE OR REPLACE TYPE IDX_TAB  AS TABLE OF NUMBER';
   EXCEPTION WHEN OTHERS THEN
      NULL;
   END;

   BEGIN 
   EXECUTE IMMEDIATE 'CREATE OR REPLACE TYPE name_tab AS TABLE OF VARCHAR2(50)';
   EXCEPTION WHEN OTHERS THEN
      NULL;
   END;

   BEGIN 
   EXECUTE IMMEDIATE 'CREATE OR REPLACE TYPE string_tab AS TABLE OF VARCHAR2(512)';
   EXCEPTION WHEN OTHERS THEN
      NULL;
   END;

   BEGIN 
   EXECUTE IMMEDIATE 'CREATE OR REPLACE TYPE text_tab AS TABLE OF VARCHAR2(4000)';
   EXCEPTION WHEN OTHERS THEN
      NULL;
   END;

   BEGIN 
   EXECUTE IMMEDIATE 'CREATE OR REPLACE TYPE long_text_tab AS TABLE OF VARCHAR2(32767)';
   EXCEPTION WHEN OTHERS THEN
      NULL;
   END;

   BEGIN 
   EXECUTE IMMEDIATE 'CREATE OR REPLACE TYPE clob_tab AS TABLE OF CLOB';
   EXCEPTION WHEN OTHERS THEN
      NULL;
   END;

   BEGIN 
   EXECUTE IMMEDIATE 'CREATE OR REPLACE TYPE blob_tab AS TABLE OF BLOB';
   EXCEPTION WHEN OTHERS THEN
      NULL;
   END;

   BEGIN 
   EXECUTE IMMEDIATE 'CREATE OR REPLACE TYPE any_tab AS TABLE OF ANYDATA';
   EXCEPTION WHEN OTHERS THEN
      NULL;
   END;

   BEGIN 
   EXECUTE IMMEDIATE 'CREATE OR REPLACE TYPE two_string_tab AS TABLE OF two_string_rec';
   EXCEPTION WHEN OTHERS THEN
      NULL;
   END;   
END;
/


prompt Compile type Attr_Obj
@@Attr_Obj.tapi
prompt Compile type AttrS_Obj
@@AttrS_Obj.tapi

DECLARE
BEGIN
   BEGIN 
   EXECUTE IMMEDIATE 'CREATE OR REPLACE TYPE Attr_Tab AS TABLE OF Attr_Obj';
   EXCEPTION WHEN OTHERS THEN
      NULL;
   END;

   BEGIN 
   EXECUTE IMMEDIATE 'CREATE OR REPLACE TYPE AttrS_Tab AS TABLE OF AttrS_Obj';
   EXCEPTION WHEN OTHERS THEN
      NULL;
   END;
END;
/

prompt Compile type XML_Obj
@@XML_Obj.tapi
prompt Compile package Attr_API
@@Attr_API.api
prompt Compile package FND_API
@@FND_API.api
prompt Compile package FND_CREATE_PACKAGE_API
@@FND_CREATE_PACKAGE_API.api
prompt Compile package Error_Api
@@Error_Api.api
prompt Compile package SAP_API
--@@SAP_API.api
prompt Compile package Test_API
@@Test_API.api



prompt Compile type body Attr_Obj
@@Attr_Obj.tapy
prompt Compile type body AttrS_Obj
@@AttrS_Obj.tapy
prompt Compile type body XML_Obj
@@XML_Obj.tapy
prompt Compile package body Attr_API
@@Attr_API.apy
prompt Compile package body FND_API
@@FND_API.apy
prompt Compile package body FND_CREATE_PACKAGE_API
@@FND_CREATE_PACKAGE_API.apy
prompt Compile package body Error_Api
@@Error_Api.apy
prompt Compile package body SAP_API
--@@SAP_API.apy
prompt Compile package body Test_API
@@Test_API.apy

ALTER PACKAGE FND_API COMPILE;

DECLARE
BEGIN
   FND_API.Compile();
END;
/

/*
DECLARE
    count_ NUMBER;
BEGIN
    SELECT COUNT(*) 
      INTO count_
      FROM user_scheduler_jobs
     WHERE job_name = 'SAP_REFRESH_CACHE';
 
    IF count_ = 0 THEN
        DBMS_SCHEDULER.CREATE_JOB (
           job_name             => 'SAP_REFRESH_CACHE',
           job_type             => 'PLSQL_BLOCK',
           job_action           => 'BEGIN SAP_API.Refresh_Cache_At_Night(); END;',
           start_date           => TRUNC(SYSDATE)+1+5/24,
           repeat_interval      => 'FREQ=DAILY', 
           enabled              =>  TRUE,
           comments             => 'Refresh SAP cache');
    END IF;
    DBMS_SCHEDULER.Run_JOB ( job_name => 'SAP_REFRESH_CACHE' );
END;
/
*/

exit;
/

