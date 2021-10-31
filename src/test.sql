DECLARE
    attr_   Attr_Obj;
    attr2_  Attr_Obj;
    tab_    Attr_Tab;
BEGIN
    tab_ := Attr_Tab();
    tab_.Extend(3);
    attr_ := Attr_Obj();
    attr_.Set_( 'pole1', 'aabboo' );
    attr_.Set_( 'pole2', 1234 );
    tab_(1) := attr_;
    attr_ := Attr_Obj();
    attr_.Set_( 'pole11', 'aabboo5' );
    attr_.Set_( 'pole21', 12345 );
    tab_(3) := attr_;
    
    attr_ := Attr_Obj();
    attr_.Set_('TEST', 'ala i ola' );
    --Attr_Api.Set_Attr_Table(  attr_, 'TAB', tab_ );
    bms_api.Log_On();
--    attr2_ := Wcf_api.Exec( 'ECHO', attr_ );
    attr2_ := Wcf_api.Exec( 'ECHO', Attr_Obj() );
    attr2_.Log();
END;



SELECT t.get('file_name'),
       t.getBlob('file_data')
FROM TABLE( Attr_APi.Get_Attr_Table( Wcf_api.Exec( 'ECHO', Attr_Obj() ), 'PICTURE_TAB') )t;



dbms_scheduler.create_job
( job_name => 'GREG_TEST_SHELL',
job_type => 'executable',
job_action => '/home/gregs/run_me.sh',
enabled => TRUE );
end;

