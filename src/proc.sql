DECLARE 
    new_message_id_      NUMBER;
    info_                VARCHAR2(2000);
    objid_               VARCHAR2(2000);
    objversion_          VARCHAR2(2000);
    attr_                VARCHAR2(32000);
    message_line_        NUMBER;
    head_msg_line_       NUMBER;

    customer_no_         VARCHAR2(50);       
    ship_addr_no_        VARCHAR2(50);
    doc_no_              VARCHAR2(50);
    customer_part_no_    VARCHAR2(50);
    schedule_no_         NUMBER;
    cust_pa_id_          VARCHAR2(50);
    new_qty_due_         NUMBER;
    new_doc_no_          VARCHAR2(50);
    new_unit_code_       VARCHAR2(50);
    exists_              NUMBER;
    i_                   NUMBER;
    cust_sched_rec_      ifsapp.Cust_Sched%ROWTYPE;
    ext_cust_sched_rec_  ifsapp.Ext_Cust_Sched%ROWTYPE;
    
    CURSOR get_cust_sched IS
    SELECT *
      FROM ifsapp.Cust_Sched
     WHERE customer_no = customer_no_
       AND ship_addr_no = ship_addr_no_
       AND doc_no = doc_no_
       AND customer_part_no = customer_part_no_
       AND schedule_no = schedule_no_;

    CURSOR get_ext_cust_sched( original_message_id_ IN NUMBER ) IS
    SELECT *
      FROM ifsapp.Ext_Cust_Sched
     WHERE original_message_id = original_message_id_;


    CURSOR exists_cust_sched( doc_no_ IN VARCHAR2 ) IS
    SELECT 1
      FROM ifsapp.Cust_Sched
     WHERE customer_no = customer_no_
       AND ship_addr_no = ship_addr_no_
       AND doc_no = doc_no_
       AND customer_part_no = customer_part_no_
       AND schedule_no = schedule_no_;

BEGIN
    customer_no_         := 'CZ02183765';
    ship_addr_no_        := 'WITTE W303';
    doc_no_              := '83';
    customer_part_no_    := '01073329000';
    schedule_no_         := '1';


    --new_message_id_ := ifsapp.IN_MESSAGE_API.Get_Next_Message_Id__();
    message_line_ := 0;
    
    OPEN get_cust_sched;
    FETCH get_cust_sched INTO cust_sched_rec_;
    CLOSE get_cust_sched;
    Client_SYS.Clear_Attr(attr_);
    --Client_SYS.Add_To_Attr('MESSAGE_ID', new_message_id_, attr_);
    ifsapp.Client_SYS.Add_To_Attr('RECEIVER', cust_sched_rec_.yvvda_contract, attr_);
    ifsapp.Client_SYS.Add_To_Attr('SENDER', cust_sched_rec_.yvvda_contract, attr_);
    --Client_SYS.Add_To_Attr('SENDER_ID', cust_sched_rec_.yvvda_contract, attr_);
    --Client_SYS.Add_To_Attr('SENDER_MESSAGE_ID', cust_sched_rec_.doc_no, attr_);
    --Client_SYS.Add_To_Attr('APPLICATION_MESSAGE_ID', , attr_);
    --Client_SYS.Add_To_Attr('RECEIVED_TIME', SYSDATE, attr_);
    --Client_SYS.Add_To_Attr('TRANSFERRED_TIME', SYSDATE, attr_);
    ifsapp.Client_SYS.Add_To_Attr('EXEC_TIME',               SYSDATE,                   attr_);
    ifsapp.Client_SYS.Add_To_Attr('VERSION', '02', attr_);
    ifsapp.Client_SYS.Add_To_Attr('CONNECTIVITY_VERSION', '02', attr_);
    ifsapp.Client_SYS.Add_To_Attr('CLASS_ID', 'VDA4905', attr_);    
    --ifsapp.IN_MESSAGE_API.New__ ( info_, objid_, objversion_, attr_, 'DO' );
    ifsapp.Connectivity_SYS.Create_Message(new_message_id_, attr_);


    OPEN get_ext_cust_sched( cust_sched_rec_.original_message_id  );
    FETCH get_ext_cust_sched INTO ext_cust_sched_rec_;
    CLOSE get_ext_cust_sched;
    
    new_doc_no_ := ext_cust_sched_rec_.Doc_No;
    i_ := 1;
    LOOP
        IF new_doc_no_ LIKE '%/%' THEN
            new_doc_no_ := substr( new_doc_no_, 1, instr(new_doc_no_,'/')-1);
        END IF;
        new_doc_no_ := new_doc_no_||'/'||i_;
        exists_ := 0;
        OPEN exists_cust_sched( new_doc_no_ );
        FETCH exists_cust_sched INTO exists_;
        CLOSE exists_cust_sched;
        EXIT WHEN nvl(exists_,0) = 0;
        i_ := i_ + 1;
    END LOOP;
dbms_output.put_line( 'new_doc_no_='||new_doc_no_ );           
    
    
    info_ := NULL;
    objid_ := NULL;
    objversion_ := NULL;
    attr_ := NULL;
    Client_SYS.Add_To_Attr('MESSAGE_ID', new_message_id_, attr_);
    Client_SYS.Add_To_Attr('MESSAGE_LINE', message_line_, attr_);
    head_msg_line_ := message_line_;
    message_line_ := message_line_ + 1;
    Client_SYS.Add_To_Attr('NAME', 'HEADER', attr_);
    Client_SYS.Add_To_Attr('C03', ext_cust_sched_rec_.Customer_Part_No, attr_);
    Client_SYS.Add_To_Attr('C05', ext_cust_sched_rec_.Last_Delnote_No, attr_);
    Client_SYS.Add_To_Attr('C06', ext_cust_sched_rec_.Note_Text, attr_);
    Client_SYS.Add_To_Attr('C07', ext_cust_sched_rec_.Cust_Schedule_Type_DB, attr_);
    Client_SYS.Add_To_Attr('C99', ext_cust_sched_rec_.Ean_Location_Del_Addr, attr_);
    Client_SYS.Add_To_Attr('C27', new_doc_no_, attr_);
    Client_SYS.Add_To_Attr('C28', ext_cust_sched_rec_.Customer_No, attr_);
    Client_SYS.Add_To_Attr('C69', ext_cust_sched_rec_.Customer_No, attr_); -- !!!
    Client_SYS.Add_To_Attr('C29', ext_cust_sched_rec_.Delivery_Point, attr_);
    Client_SYS.Add_To_Attr('C31', ext_cust_sched_rec_.Ref_Schedule_No, attr_);
    Client_SYS.Add_To_Attr('N01', ext_cust_sched_rec_.Stock_Qty, attr_);
    Client_SYS.Add_To_Attr('N02', ext_cust_sched_rec_.Cum_Receipt_Qty, attr_);
    Client_SYS.Add_To_Attr('N03', ext_cust_sched_rec_.Last_Receipt_Qty, attr_);
    Client_SYS.Add_To_Attr('D01', ext_cust_sched_rec_.Cum_Receipt_Date, attr_);
    Client_SYS.Add_To_Attr('D02', ext_cust_sched_rec_.Last_Receipt_Date, attr_);
    Client_SYS.Add_To_Attr('D03', ext_cust_sched_rec_.Valid_From, attr_);
    Client_SYS.Add_To_Attr('D04', ext_cust_sched_rec_.Valid_Until, attr_);
    Client_SYS.Add_To_Attr('C08', ext_cust_sched_rec_.Yvvda_Plant_Customer, attr_);
    Client_SYS.Add_To_Attr('C24', ext_cust_sched_rec_.Yvvda_Unloading_Point, attr_);
    Client_SYS.Add_To_Attr('C25', ext_cust_sched_rec_.Yvvda_Place_Of_Storage, attr_);
    Client_SYS.Add_To_Attr('C26', ext_cust_sched_rec_.Yvvda_Consum_Point, attr_);
    Client_SYS.Add_To_Attr('C32', ext_cust_sched_rec_.Yvvda_Critical_Stock, attr_);
    Client_SYS.Add_To_Attr('C33', ext_cust_sched_rec_.Yvvda_Posting, attr_);
    Client_SYS.Add_To_Attr('C34', ext_cust_sched_rec_.yvvda_usage_key, attr_);
    new_unit_code_ := NULL;
    SELECT MAX( trans_unit_code )
      INTO new_unit_code_
      FROM ifsapp.yvvda_unit_cross_ref
     WHERE protocol_type = 'VDA'
       AND unit_code = ext_cust_sched_rec_.Yvvda_Quantity_Unit;
    Client_SYS.Add_To_Attr('C35', nvl(new_unit_code_, ext_cust_sched_rec_.Yvvda_Quantity_Unit), attr_);
    Client_SYS.Add_To_Attr('C36', ext_cust_sched_rec_.Yvvda_Deliv_Interval_DB, attr_);
    Client_SYS.Add_To_Attr('C37', ext_cust_sched_rec_.Yvvda_Date_Code, attr_);
    Client_SYS.Add_To_Attr('C38', ext_cust_sched_rec_.Yvvda_Deliv_State_Code1, attr_);
    Client_SYS.Add_To_Attr('C40', ext_cust_sched_rec_.Yvvda_Sign_Of_Customer, attr_);
    Client_SYS.Add_To_Attr('C50', ext_cust_sched_rec_.Yvvda_Part_No, attr_);
    Client_SYS.Add_To_Attr('C51', ext_cust_sched_rec_.Yvvda_Sub_Forwarder, attr_);
    Client_SYS.Add_To_Attr('C52', ext_cust_sched_rec_.Yvvda_Old_Sched_No, attr_);
    Client_SYS.Add_To_Attr('C53', ext_cust_sched_rec_.Yvvda_Close_Ord_No, attr_);
    Client_SYS.Add_To_Attr('C54', ext_cust_sched_rec_.yvvda_consum_point_add, attr_);
    Client_SYS.Add_To_Attr('N05', ext_cust_sched_rec_.Yvvda_Old_Transfer_No, attr_);
    Client_SYS.Add_To_Attr('N06', ext_cust_sched_rec_.Yvvda_Cum_Qty_Diff, attr_);
    Client_SYS.Add_To_Attr('N09', ext_cust_sched_rec_.Yvvda_Zero_Cum_Qty, attr_);
    Client_SYS.Add_To_Attr('D05', ext_cust_sched_rec_.Yvvda_Zero_Cum_Qty_Date, attr_);
    Client_SYS.Add_To_Attr('D06', ext_cust_sched_rec_.Yvvda_Old_Sched_Date, attr_);
    Client_SYS.Add_To_Attr('D07', ext_cust_sched_rec_.Yvvda_New_Sched_Date, attr_);
    Client_SYS.Add_To_Attr('D12', ext_cust_sched_rec_.Yvvda_End_Sched_Horiz, attr_);
    Client_SYS.Add_To_Attr('C10', ext_cust_sched_rec_.Yvvda_Kanban_No, attr_);
    Client_SYS.Add_To_Attr('C11', ext_cust_sched_rec_.Yvvda_Model_Year, attr_);
    Client_SYS.Add_To_Attr('C68', ext_cust_sched_rec_.yvvda_agreement_id, attr_);
    --ifsapp.IN_MESSAGE_LINE_API.New__ ( info_, objid_, objversion_, attr_, 'DO' );
    ifsapp.Connectivity_SYS.Create_Message_Line(attr_);

    FOR sched_line_ IN (SELECT *
                          FROM ifsapp.Ext_Cust_Sched_line 
                         WHERE message_id = ext_cust_sched_rec_.message_id
                         ORDER BY message_line ) LOOP
        SELECT MAX(cf$_calc_qty_due)
          INTO new_qty_due_
          FROM ifsapp.Cust_Sched_line_cfv
         WHERE customer_no = customer_no_
           AND ship_addr_no = ship_addr_no_
           AND doc_no = doc_no_
           AND customer_part_no = customer_part_no_
           AND schedule_no = schedule_no_
           AND due_date = sched_line_.due_date;
                      
dbms_output.put_line( 'old_qty='||sched_line_.Qty_Due||'  new_qty_due_='||new_qty_due_ );           
        info_ := NULL;
        objid_ := NULL;
        objversion_ := NULL;
        attr_ := NULL;
        Client_SYS.Add_To_Attr('MESSAGE_ID', new_message_id_, attr_);
        Client_SYS.Add_To_Attr('MESSAGE_LINE', message_line_, attr_);
        message_line_ := message_line_ + 1;
        Client_SYS.Add_To_Attr('NAME', 'LIN', attr_);
        Client_SYS.Add_To_Attr('N99', head_msg_line_, attr_);
        IF sched_line_.Yvvda_Demand_Type IN ('WEEKLYDEMAND','MONTHLYDEMAND','SEVERALWEEKDEMAND') THEN
            Client_SYS.Add_To_Attr('N98', 1, attr_);
        ELSE
            Client_SYS.Add_To_Attr('N98', 0, attr_);
        END IF;
        Client_SYS.Add_To_Attr('C03', sched_line_.Note_Text, attr_);
        Client_SYS.Add_To_Attr('C04', sched_line_.Ref_Id, attr_);
        Client_SYS.Add_To_Attr('C14', sched_line_.Line_Type_Id, attr_);
        Client_SYS.Add_To_Attr('C09', sched_line_.Dock_Code, attr_);
        Client_SYS.Add_To_Attr('C10', sched_line_.Sub_Dock_Code, attr_);
        Client_SYS.Add_To_Attr('C12', sched_line_.Location_No, attr_);
        Client_SYS.Add_To_Attr('N01', nvl(new_qty_due_, sched_line_.Qty_Due), attr_);
        Client_SYS.Add_To_Attr('C13', sched_line_.Yvvda_Sched_Org_Date, attr_);
        Client_SYS.Add_To_Attr('C21', sched_line_.Yvvda_Demand_State_Code, attr_);
        Client_SYS.Add_To_Attr('D01', sched_line_.yvvda_from_date, attr_);
        Client_SYS.Add_To_Attr('D02', sched_line_.yvvda_until_date, attr_);
        --ifsapp.IN_MESSAGE_LINE_API.New__ ( info_, objid_, objversion_, attr_, 'DO' );
        ifsapp.Connectivity_SYS.Create_Message_Line(attr_);
    END LOOP;

    FOR sched_pack_ IN (SELECT *
                          FROM ifsapp.Yvvda_Ext_Cust_Pack_Aid 
                         WHERE message_id = ext_cust_sched_rec_.message_id
                         ORDER BY seq_no ) LOOP
        SELECT MAX(cust_pa_id)
          INTO cust_pa_id_
          FROM ifsapp.yvvda_pack_aid_cust_conn
         WHERE customer_id = ext_cust_sched_rec_.customer_no
           AND pa_id = sched_pack_.pa_id
           AND address_id = ext_cust_sched_rec_.ean_location_del_addr;
                         
        info_ := NULL;
        objid_ := NULL;
        objversion_ := NULL;
        attr_ := NULL;
        Client_SYS.Add_To_Attr('MESSAGE_ID', new_message_id_, attr_);
        Client_SYS.Add_To_Attr('MESSAGE_LINE', message_line_, attr_);
        message_line_ := message_line_ + 1;
        Client_SYS.Add_To_Attr('NAME', 'PACK', attr_);
        Client_SYS.Add_To_Attr('N99', head_msg_line_, attr_);
        Client_SYS.Add_To_Attr('N02', sched_pack_.capacity, attr_);
        Client_SYS.Add_To_Attr('C03', cust_pa_id_, attr_);
        --ifsapp.IN_MESSAGE_LINE_API.New__ ( info_, objid_, objversion_, attr_, 'DO' );
        ifsapp.Connectivity_SYS.Create_Message_Line(attr_);
    END LOOP;

    FOR sched_text_ IN (SELECT *
                          FROM ifsapp.Yvvda_Ext_Cust_Sched_Text 
                         WHERE message_id = ext_cust_sched_rec_.message_id
                         ORDER BY seq_no ) LOOP
        info_ := NULL;
        objid_ := NULL;
        objversion_ := NULL;
        attr_ := NULL;
        Client_SYS.Add_To_Attr('MESSAGE_ID', new_message_id_, attr_);
        Client_SYS.Add_To_Attr('MESSAGE_LINE', message_line_, attr_);
        message_line_ := message_line_ + 1;
        Client_SYS.Add_To_Attr('NAME', 'TEXT', attr_);
        Client_SYS.Add_To_Attr('N99', head_msg_line_, attr_);
        Client_SYS.Add_To_Attr('C01', sched_text_.text, attr_);
        --ifsapp.IN_MESSAGE_LINE_API.New__ ( info_, objid_, objversion_, attr_, 'DO' );
        ifsapp.Connectivity_SYS.Create_Message_Line(attr_);
    END LOOP;
    
    ifsapp.Connectivity_SYS.Release_Message(new_message_id_);
    ifsapp.Out_Message_Util_API.Transfer_Data__( cust_sched_rec_.yvvda_contract );
    ifsapp.IN_MESSAGE_UTIL_API.Process_Inbox_();
    --ifsapp.YVVDA_C4905_UTIL_API.Receive_Message( new_message_id_ );
    --BEGIN
    --ifsapp.Ext_Cust_Sched_API.Approve_Messages(new_message_id_);
    --EXCEPTION WHEN OTHERS THEN
    --    NULL;
    --END;

END;
