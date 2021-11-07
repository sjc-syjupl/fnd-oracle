DROP TABLE Persons_tab;

CREATE TABLE Persons_tab (
    ID NUMBER  NOT NULL,    
    Insurance_ID NUMBER  NOT NULL,    
    Last_Name VARCHAR(255) NOT NULL,
    First_Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    City VARCHAR(255),
    Rowversion DATE DEFAULT SYSDATE NOT NULL
);

ALTER TABLE Persons_tab ADD CONSTRAINT Persons_PK
PRIMARY KEY (Insurance_ID);

DECLARE
BEGIN
   Fnd_Create_Package_Api.Create_All( 'PERSONS_TAB' );
END;
/
