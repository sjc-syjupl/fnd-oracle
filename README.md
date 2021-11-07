# fnd-oracle

Theys is simple foundation library that I use when I have to write a simple application in Oracle.<br>
Those packages give me access to simple error handling, logger and other basic useful functions.<br>

This library follows the idea where changes in the Oracle table should be done only by call package methods.<br>
Every time when I want to add or modify record I have to call the method Package_Name_API.New( .... ) or similar to modify or remove data.<br>
Using this library means that exists only one place (the package connected with the table) where are located all data checking constraints.<br>
Also, In this package is located additional actions executed before or after changing data.<br>
<br>
If you have used triggers to check constraints and call others procedures and faced problems with mutation or problems with the order of execution then moving your code from triggers to the package may be a solution for you.<br>

# How to use

The first step is to create tables and indexes.<br>
I have done this manually by a script (examples/person_tab.sql)<br>
<br>
Then I call PL/SQL method

```
DECLARE
BEGIN
    Fnd_Create_Package_Api.Create_All( 'TABEL_NAME_TAB' );
END;
```

this procedure generates packages and views in Oracle.
You can look at example generated packages in the example folder.
If you change the table (added new columns) call this method once again.

When the packages are generated then you can modify data like in a below way..

```
DECLARE
    rec_ PERSONS_APT.REC;
BEGIN
    rec_ := PERSONS_APT.Get_Rec( insurance_id* => 'id' );
    rec_.ADDRESS := :ADDRESS;
    rec_.CITY := :CITY;
    PERSONS_APT.Modify( rec_ );
END;
```
