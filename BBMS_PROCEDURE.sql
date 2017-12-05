--------------------------------------------------------
--  File created - Sunday-November-26-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure PROC_BLOODBANK
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "BLOODBANK"."PROC_BLOODBANK" (

BBID	IN OUT VARCHAR2	,
BBNAME 	IN OUT 	VARCHAR2,
STATEID 	IN OUT 	VARCHAR2 ,
CITYID 	IN OUT 	VARCHAR2 ,

LOCID 	IN OUT 	VARCHAR2 ,
CONTACTS 	IN OUT 	VARCHAR2 	,	
STTUS 	IN OUT 	VARCHAR2 ,
CREATEDBY 	IN OUT 	VARCHAR2  ,

CREATEDDATE 	IN OUT 	DATE,
ONDELETE  IN OUT VARCHAR2 ,
QUERYTYPE IN VARCHAR2 ,

bloodbankcursor OUT SYS_REFCURSOR
)

AS 
 prefix_bbid varchar2(5):='BB_ID';
 rowcount  number;

BEGIN
  if QUERYTYPE='insert_bloodbank' then
  begin
    BBID:='empty';
    select COUNT(*)+1 into rowcount from BLOOD_BANK;
    BBID:= prefix_bbid || LPAD(CAST(rowcount as varchar2),15-length(prefix_bbid),'0'); 
    
    insert into BLOOD_BANK values(BBID,BBNAME,STATEID,CITYID,LOCID,CONTACTS,'deactive',CREATEDBY,CURRENT_DATE,'no');
   commit;    
   
  end;
  
  elsif QUERYTYPE='select_bloodbank' then
  begin
    open bloodbankcursor for
     select * from  BLOOD_BANK;
    commit;    
  end;
  elsif QUERYTYPE='select_bloodbankbyid' then
  begin
    open bloodbankcursor for
     select * from  BLOOD_BANK where BB_ID=BBID;
    commit;    
  end;
  
  
  elsif QUERYTYPE='select_bbnameid' then
  begin
    open bloodbankcursor for
     select b.BB_ID,b.BB_NAME from  BLOOD_BANK b;
    commit;    
  end;
  elsif QUERYTYPE='selectall_bbwithbbdetail' then
  begin
    open bloodbankcursor for
     select b.BB_ID,b.BB_NAME,b.STATUS,s.STATE_NAME,c.CITY_NAME,li.LOC_NAME,li.PIN_CODE,reg.NAME,b.CREATED_DATE
     from  BLOOD_BANK b,STATE_INFO s,CITY_INFO c,LOCATION_INFO li,REGISTRATION reg where 
     b.STATE_ID=s.STATE_ID and b.CITY_ID=c.CITY_ID and b.LOC_ID=li.LOC_ID and b.CREATED_BY=reg.REG_ID;
    commit;    
  end;
  elsif QUERYTYPE='deactive_bloodbank' then
  begin
    update BLOOD_BANK set STATUS=STTUS where BB_ID=BBID;
    BBID:='deactivated';
  end; 
  end if;
END PROC_BLOODBANK;

/
--------------------------------------------------------
--  DDL for Procedure PROC_BLOODREQUEST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "BLOODBANK"."PROC_BLOODREQUEST" (

BRID IN OUT 	VARCHAR2 ,
REGID	VARCHAR2 ,
BBID	VARCHAR2 ,
CONTACTS	VARCHAR2 ,


BLDGROUP	VARCHAR2 ,
QNTY	VARCHAR2 ,
REQSTATUS	VARCHAR2 ,
REQDATE	DATE ,


QUERYTYPE VARCHAR2 ,
BREQUESTCURSOR OUT SYS_REFCURSOR

) AS 

  prefix_br varchar2(5):='BR_ID';
  rowcount  number;

BEGIN
  
  if QUERYTYPE='insert_brequest' then
  begin
   select COUNT(*)+1 into rowcount from BLOOD_REQUEST;
      BRID:=prefix_br || LPAD(CAST(rowcount as varchar2),15-length(prefix_br),'0');
   insert into BLOOD_REQUEST values(BRID,REGID,BBID,CONTACTS,BLDGROUP,CAST(QNTY as NUMBER),'pending',CURRENT_DATE,'not assigned');
  end;
  
  
  elsif QUERYTYPE='selectallreq_byuser' then         --pending
  begin
   open BREQUESTCURSOR for 
        select br.BR_ID,br.BLD_GROUP,br.QTY,br.REQ_DATE,br.REQ_STATUS,bb.BB_NAME from BLOOD_REQUEST br,BLOOD_BANK bb where br.REG_ID=REGID and br.BB_ID=bb.BB_ID ;
  end;
  
  elsif QUERYTYPE='selectall_brequest' then
  
  begin
  OPEN BREQUESTCURSOR for
     select br.BR_ID,bb.BB_NAME,reg.NAME,br.QTY,br.BLD_GROUP,br.BB_ID,br.REQ_DATE,br.REG_ID from  BLOOD_REQUEST br,REGISTRATION reg,BLOOD_BANK bb 
     where br.REG_ID=reg.REG_ID and br.BB_ID=bb.BB_ID and br.REQ_STATUS='pending';
  end;
 elsif QUERYTYPE='selectall_brequestbyadmin' then
  
  begin
  OPEN BREQUESTCURSOR for
     select br.BR_ID,bb.BB_NAME,reg.NAME,br.QTY,br.BLD_GROUP,br.REQ_DATE,br.REG_ID from  BLOOD_REQUEST br,REGISTRATION reg,BLOOD_BANK bb 
     where br.REG_ID=reg.REG_ID and br.BB_ID=bb.BB_ID and br.ASSIGNTO_EMP!='assigned';
  end;
 
  elsif QUERYTYPE='blood_supplied' then
  begin
      update BLOOD_REQUEST set REQ_STATUS='supplied' where BR_ID=BRID;
      update EMPREQ_ASSIGNMENT set REQ_STATUS='supplied' where REQ_ID=BRID;
      BRID:='supplied';
      
  end;
end if;
  
END PROC_BLOODREQUEST;

/
--------------------------------------------------------
--  DDL for Procedure PROC_DONATION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "BLOODBANK"."PROC_DONATION" (

DID	IN OUT VARCHAR2,
REGID	VARCHAR2,
BBID	VARCHAR2,
BLDGROUP	VARCHAR2,

QNTY	NUMBER,
DDATE	DATE	,
PROCESSEDBY	VARCHAR2,
DSTATUS	VARCHAR2,

QUERYTYPE varchar2,
BDONATIONCURSOR OUT SYS_REFCURSOR
)

AS 

prefix_donation varchar2(4):='D_ID';
rowcount NUMBER;
availableblood NUMBER:=0;
pendingbldreq NUMBER:=0;

--USERNAME	VARCHAR2,
BEGIN
  if querytype='insert_donation' then
  begin
  DID:='empty';
  select COUNT(*)+1 into rowcount from DONATION;
  DID := prefix_donation || LPAD(CAST(rowcount as varchar2),15-length(prefix_donation),'0');
  insert into DONATION values(DID,REGID,BBID,BLDGROUP,QNTY,CURRENT_DATE,'empty','pending','yes',QNTY);
  
  
  end;
  elsif querytype='select_pendingdonation' then
  begin
  open BDONATIONCURSOR for 
       select bb.BB_ID,bb.BB_NAME,reg.REG_ID,reg.NAME,d.D_ID,d.BGROUP,d.D_DATE,d.QTY from DONATION d,BLOOD_BANK bb,REGISTRATION reg where d.BB_ID=bb.BB_ID and d.REG_ID=reg.REG_ID and d.PROCESSED_BY='empty';
  end;

  elsif querytype='select_forprocessing' then
  begin
  open BDONATIONCURSOR for 
       select bb.BB_ID,bb.BB_NAME,reg.REG_ID,reg.NAME,d.D_ID,d.BGROUP,d.D_DATE,d.QTY from DONATION d,BLOOD_BANK bb,REGISTRATION reg where d.BB_ID=bb.BB_ID and d.REG_ID=reg.REG_ID and d.PROCESSED_BY=PROCESSEDBY and d.STATUS='pending';
  end;
elsif querytype='save_donation' then
  begin
    update DONATION set STATUS='donated' where D_ID=DID;
    DID:='donated';
  end;
  
  
  elsif querytype='get_available_blood' then
  begin
  --totalquantity:=7; d.QTY,
  
  select  SUM(QTY) into availableblood from DONATION d where d.BB_ID=BBID and d.BGROUP=BLDGROUP and   d.AVAILABLITY='yes' ;
  select SUM(QTY) into pendingbldreq from BLOOD_REQUEST br where br.BB_ID=BBID and br.BLD_GROUP=BLDGROUP and  br.REQ_STATUS='pending' ;
  
  if pendingbldreq!=0 then
   begin
   pendingbldreq:=pendingbldreq;
  dbms_output.put_line('Available'||pendingbldreq);
  end;
  else
  begin
  pendingbldreq:=0;
  dbms_output.put_line('Null'||pendingbldreq);
  end;
  end if;
 
 availableblood:=availableblood-pendingbldreq;
 dbms_output.put_line('Null'||availableblood);
 
   open BDONATIONCURSOR for 
       select  bb.BB_ID,bb.BB_NAME,d.BGROUP,availableblood from DONATION d,BLOOD_BANK bb where d.BB_ID=bb.BB_ID and d.BB_ID=BBID and 
       d.BGROUP=BLDGROUP and  d.AVAILABLITY='yes'  and d.STATUS='donated';
  end;
  
  
  
  elsif querytype='donate_availableblood' then
  begin
    update DONATION set AVAILABLITY='not available' where D_ID=DID;
    DID:='donated';
  end;
  
  elsif querytype='donate_somebloodunit' then
  begin
   select QTY into availableblood from DONATION where D_ID=DID;
   availableblood:=availableblood-QNTY;
    update DONATION set QTY=availableblood where D_ID=DID;
    DID:='donated';
  end;



  elsif querytype='selectavailable_blood_bybbid_bgroup' then
  begin
  open BDONATIONCURSOR for 
       select d.D_ID,bb.BB_ID,bb.BB_NAME,d.BGROUP,d.QTY from DONATION d,BLOOD_BANK bb where d.BB_ID=bb.BB_ID and d.BB_ID=BBID and 
       d.BGROUP=BLDGROUP and  d.AVAILABLITY='yes' and d.STATUS='donated' ;
    end;


  elsif querytype='selectlist_donatedByuser' then           
  begin
  open BDONATIONCURSOR for 
       select d.D_ID,d.BGROUP,d.D_DATE,d.DONATED_QUANTITY,d.STATUS,bb.BB_NAME from DONATION d,BLOOD_BANK bb 
       where d.REG_ID=REGID and d.BB_ID=bb.BB_ID ;
    end;

  elsif querytype='get_available_bloodstock' then           
  begin
  open BDONATIONCURSOR for 
       select d.D_ID,d.BGROUP,d.QTY,bb.BB_NAME from DONATION d,BLOOD_BANK bb  where d.BB_ID=BBID and  d.BB_ID=bb.BB_ID and d.AVAILABLITY='yes' and d.STATUS='donated' ;
    end;
end if;
  
END PROC_DONATION;

/
--------------------------------------------------------
--  DDL for Procedure PROC_EMPDONASSIGNMENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "BLOODBANK"."PROC_EMPDONASSIGNMENT" (

EDAID IN OUT	VARCHAR2,	
USERID	VARCHAR2  DEFAULT 'empty',
EMPID	VARCHAR2  DEFAULT 'empty',
DONREQID	VARCHAR2  DEFAULT 'empty',

MSGS	VARCHAR2 DEFAULT 'empty',
QUERYTYPE VARCHAR2,
datacursor OUT SYS_REFCURSOR
)
AS 


 prefix_edaid varchar2(6):='EDA_ID';
 rowcount  number;


BEGIN
  if QUERYTYPE='insert_assigndrtoemp' then
  begin
  
  
    select COUNT(*)+1 into rowcount from EMPDON_ASSIGNMENT;
    EDAID :=prefix_edaid || LPAD(CAST(rowcount as varchar2),15-length(prefix_edaid),'0');
    insert into    EMPDON_ASSIGNMENT values(EDAID,USERID,EMPID,DONREQID,MSGS);
    update DONATION set PROCESSED_BY=EMPID where D_ID=DONREQID;
   
   Exception 
    When Others then
     rollback;
     commit;
   -- dbms_output.put_line('hello');
  end;
  end if;
END PROC_EMPDONASSIGNMENT;

/
--------------------------------------------------------
--  DDL for Procedure PROC_EMPREQASSIGNMENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "BLOODBANK"."PROC_EMPREQASSIGNMENT" (

EAID	IN  OUT VARCHAR2 ,
UID	VARCHAR2 ,
EID	VARCHAR2 ,
MSGS	VARCHAR2 ,

REQID	VARCHAR2 ,
REQSTATUS	VARCHAR2 ,	
APPDATE	VARCHAR2 ,
QUERYTYPE VARCHAR2 ,

datacursor OUT SYS_REFCURSOR 

)

AS 

prefix_eaid VARCHAR(5):='EA_ID';
rowcount number;

BEGIN
   if QUERYTYPE='insert_assignappointmenttoemp' then           --pending
   begin 
   select COUNT(*)+1 into rowcount from EMPREQ_ASSIGNMENT;  
   EAID:= prefix_eaid||LPAD(CAST(rowcount as varchar2),15-length(prefix_eaid),'0');
   insert into EMPREQ_ASSIGNMENT values(EAID,UID,EID,MSGS,REQID,REQSTATUS,APPDATE);
   update BLOOD_REQUEST set ASSIGNTO_EMP='assigned' where BR_ID=REQID;
   end;
   
   elsif QUERYTYPE='select_usersbrappointment' then
   begin
     open datacursor for 
       select era.REQ_ID,reg.NAME,era.MSG,era.APP_DATE from EMPREQ_ASSIGNMENT era,Registration reg where
            era.U_ID=UID and era.REQ_STATUS=REQSTATUS and era.E_ID=reg.REG_ID;
   end;
   end if;
END PROC_EMPREQASSIGNMENT;

/
--------------------------------------------------------
--  DDL for Procedure PROC_FEEDBACK
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "BLOODBANK"."PROC_FEEDBACK" (

F_ID	IN OUT VARCHAR2 ,
USERNAME	VARCHAR2 ,	
EMAIL	VARCHAR2 ,
FEEDBACK	VARCHAR2 ,

INQID	VARCHAR2 ,
querytext	VARCHAR2 ,
datacursor OUT	SYS_REFCURSOR 
)

AS 

prefix_fid VARCHAR2(4):='F_ID';
rowcount NUMBER;
lengthinqid NUMBER;
BEGIN
   if querytext='insert_feedback' then
   begin
   
      select COUNT(*)+1 into rowcount from FEEDBACK;
      F_ID := prefix_fid || LPAD(CAST(rowcount as varchar2),15-length(prefix_fid),'0');
      insert into FEEDBACK values(F_ID,USERNAME,EMAIL,FEEDBACK,INQID);
      lengthinqid:=length(INQID);
      if lengthinqid=15 then
      begin
       update INQUIRY set INQ_STATUS='answered' where INQ_ID=INQID;
      end;
      end if;
    end;
    
    
    elsif querytext='getansrd_inq_wthfeedback' then
   begin
   open datacursor for
    select feed.F_ID,feed.NAME,feed.EMAIL,feed.FEEDBACK, inq.INQ_ID,inq.INQ_SUBJECT,inq.INQUIRY,inq.INQ_DATE from FEEDBACK feed,INQUIRY inq where feed.INQ_ID=inq.INQ_ID;
    end;
   end if;
   
   
END PROC_FEEDBACK;

/
--------------------------------------------------------
--  DDL for Procedure PROC_INQUIRY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "BLOODBANK"."PROC_INQUIRY" (

inqid IN    OUT VARCHAR2 ,
username IN    VARCHAR2     DEFAULT 'empty' ,
inqsubject IN    VARCHAR2  DEFAULT 'empty' ,
inquiry IN    VARCHAR2  DEFAULT 'empty' ,
useremail IN    VARCHAR2 DEFAULT 'empty' ,


inqdate IN Date Default CURRENT_DATE,
inqstatus IN VARCHAR2   DEFAULT 'empty',
querytype IN    VARCHAR2  DEFAULT 'empty' ,

datacursor OUT SYS_REFCURSOR
)
AS 

  prefix_inq varchar2(7):='INQ_ID';
  rowcount  number;
  
BEGIN
if querytype='insert_inquiry' then
 begin
       select COUNT(*)+1 into rowcount from INQUIRY;
       inqid:= prefix_inq || LPAD(CAST(rowcount as varchar2),9,'0'); 
       insert into INQUIRY values(inqid,username,inqsubject,inquiry,useremail,SYSDATE,'not answered');
  end;
  elsif querytype='select_unansweredinquiry' then
 begin
   open datacursor for
    select * from INQUIRY where INQ_STATUS='not answered';
  end;
 end if;
END PROC_INQUIRY;

/
--------------------------------------------------------
--  DDL for Procedure PROC_MANGEADDRESS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "BLOODBANK"."PROC_MANGEADDRESS" (

stateid IN  OUT  VARCHAR2  ,
statename IN  OUT   VARCHAR2  ,
cityid IN    OUT VARCHAR2    ,
cityname IN    OUT VARCHAR2 ,
locationid IN   OUT  VARCHAR2  ,
locationname IN    OUT VARCHAR2   ,
pincode IN   OUT  VARCHAR2   ,
querytype IN    VARCHAR2  DEFAULT 'empty',

 datacursor OUT SYS_REFCURSOR
) AS 

  prefix_state varchar2(7):='STAT_ID';
  prefix_city varchar2(7):='CITY_ID';
  prefix_loc varchar2(7):='LOCN_ID';
  rowcount  number;
  
BEGIN


  if querytype='insert_state' then
    begin
    
     select COUNT(*)+1 into rowcount from STATE_INFO;
    stateid:= prefix_state || LPAD(CAST(rowcount as varchar2),8,'0'); 
    insert into STATE_INFO values(stateid,statename);
   commit;    
cityid:='empty';
cityname:='empty';
locationid:='empty';
locationname:='empty';
pincode:='empty';
    
    end;
  elsif  querytype='insert_city' then
  begin
     select COUNT(*)+1 into rowcount from CITY_INFO;
     cityid:=prefix_city || LPAD(CAST(rowcount as varchar2),8,'0'); 
     insert into CITY_INFO values(cityid,cityname,stateid);
      commit;    
      
statename:='empty';
locationid:='empty';
locationname:='empty';
pincode:='empty';

    end;
  elsif  querytype='insert_location' then
  begin
      select COUNT(*)+1 into rowcount from LOCATION_INFO;
       locationid:=prefix_loc || LPAD(CAST(rowcount as varchar2),8,'0'); 
    insert into LOCATION_INFO values(locationid,locationname,cityid,pincode);
     commit;
stateid:='empty';
statename:='empty';
cityname:='empty';
    
    end;
  elsif  querytype='select_state' then
  begin
   open datacursor for 
      select  * from STATE_INFO;
--      EXCEPTION
--      WHEN OTHERS THEN
--        datacursor:=null;


    end;
  elsif  querytype='select_city' then
  begin
  open datacursor for 
    select *  from CITY_INFO where STATE_ID=stateid;
    
    end;
    
  elsif  querytype='select_location' then
  begin
  open datacursor for
    select *  from LOCATION_INFO where CITY_ID=cityid;
    end;
  elsif  querytype='select_address' then
  begin
    select s.STATE_ID,s.STATE_NAME,c.CITY_ID,c.CITY_NAME,l.LOC_ID,l.LOC_NAME,l.PIN_CODE into stateid,statename,cityid,cityname,locationid,locationname,pincode from STATE_INFO  s,CITY_INFO  c,LOCATION_INFO  l
    where s.STATE_ID=stateid and c.CITY_ID=cityid and l.LOC_ID=locationid;
   
    end;
  
  end if;
  
END PROC_MANGEADDRESS;

/
--------------------------------------------------------
--  DDL for Procedure PROC_PROFILE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "BLOODBANK"."PROC_PROFILE" 
(
  REGID IN VARCHAR2 DEFAULT 'empty',
  QUERYTYPE IN VARCHAR2 DEFAULT 'empty',
  profilecursor OUT SYS_REFCURSOR
) 
AS 

BEGIN
if QUERYTYPE = 'select_registration' then
  begin
   open profilecursor for
    select *  from REGISTRATION where REG_ID=REGID;
    EXCEPTION
      WHEN OTHERS THEN
        profilecursor:=null;
        
  end;
 elsif QUERYTYPE = 'select_profile' then
   begin
   open profilecursor for
    select *  from REGISTRATION,LOGIN_DETAIL where REGISTRATION.REG_ID=REGID and LOGIN_DETAIL.PROFILE_ID=REGID;
    EXCEPTION
      WHEN OTHERS THEN
        profilecursor:=null;
        
  end;
elsif QUERYTYPE = 'selectall_profile' then
   begin
   open profilecursor for
    select *  from REGISTRATION,LOGIN_DETAIL where  REGISTRATION.REG_ID= LOGIN_DETAIL.PROFILE_ID;
    EXCEPTION
      WHEN OTHERS THEN
        profilecursor:=null;
        
  end;
elsif QUERYTYPE = 'selectall_employee' then
   begin
   open profilecursor for
    select reg.REG_ID,reg.NAME,reg.ADDRESS  from REGISTRATION reg,LOGIN_DETAIL log where  reg.REG_ID= log.PROFILE_ID and log.USER_ROLE='employee';
   
    EXCEPTION
      WHEN OTHERS THEN
        profilecursor:=null;
        
  end;
elsif QUERYTYPE = 'selectall_userid' then
   begin
   open profilecursor for
    select  USER_ID from LOGIN_DETAIL;
   end;
  
  end if;

 END PROC_PROFILE;

/
--------------------------------------------------------
--  DDL for Procedure PROCREGISTER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "BLOODBANK"."PROCREGISTER" 
(
REG_ID IN    OUT VARCHAR2 ,
NAME IN    VARCHAR2     DEFAULT 'empty' ,
CONTACT IN    VARCHAR2 DEFAULT 'empty' ,
EMAIL IN    VARCHAR2  DEFAULT 'empty' ,

BIRTH_DATE IN    VARCHAR2  DEFAULT 'empty' ,
GENDER IN    VARCHAR2  DEFAULT 'empty' ,
ADDRESS IN    VARCHAR2       DEFAULT 'empty' ,
CITY IN    VARCHAR2      DEFAULT 'empty' ,

STATE IN    VARCHAR2  DEFAULT 'empty' ,
PINCODE IN    VARCHAR2  DEFAULT 'empty' ,

USERSID IN    VARCHAR2 DEFAULT 'empty' ,
USERPASSWORD    IN VARCHAR2 DEFAULT 'empty' ,
SEC_QUESTION    IN VARCHAR2 DEFAULT 'empty' ,
ANSWER    IN VARCHAR2 DEFAULT 'empty' ,


QUERYTYPE IN    VARCHAR2 , 
USERROLES OUT LOGIN_DETAIL.USER_ROLE%TYPE ,
USERSROLE   IN VARCHAR2 DEFAULT 'empty' ,
USERSTATUS   IN VARCHAR2 DEFAULT 'empty' 
)

AS 


countrow NUMBER;
prefix VARCHAR2(7):='REG_ID';

regid VARCHAR2(15);
userid VARCHAR2(50);
userpass VARCHAR2(50);
userrole VARCHAR2(50);

BEGIN

if QUERYTYPE='insert' then

 begin
 
  USERROLES:='empty';
  --dbms_output.put_line('abc');
  
  select COUNT(*) into countrow from REGISTRATION;
  countrow := countrow+1;
  REG_ID := prefix || LPAD(cast(countrow as VARCHAR2),8,'0');
  insert into REGISTRATION values (REG_ID,NAME,CONTACT,EMAIL,BIRTH_DATE,GENDER,ADDRESS,CITY,STATE,PINCODE);
  insert into LOGIN_DETAIL values (USERSID,USERPASSWORD,SEC_QUESTION,ANSWER,REG_ID,'user','active');
 commit;
 
 end;
elsif QUERYTYPE='login' then

 begin
    select PROFILE_ID,USER_ROLE  into  REG_ID,USERROLES from LOGIN_DETAIL where USER_ID=USERSID and PASSWORD=USERPASSWORD; 
   dbms_output.put_line(REG_ID||'  :  '||USERROLES);
    EXCEPTION
   WHEN NO_DATA_FOUND THEN
     
     REG_ID:='empty';
     USERROLES:='empty';
   --    dbms_output.put_line(regid||'  :  '||userrole);
   WHEN OTHERS THEN
     REG_ID:='empty';
     USERROLES:='empty';
       --dbms_output.put_line(regid||'  :  '||userrole);
 end;
 
elsif QUERYTYPE='update_userrole' then
 begin
  update LOGIN_DETAIL set USER_ROLE=USERSROLE,STATUS=USERSTATUS where PROFILE_ID=REG_ID;
  commit;
 end;
end if;


END ProcRegister;

/
