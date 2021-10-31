DEFINE FND_USER           = FND_USER

CREATE OR REPLACE AND COMPILE JAVA SOURCE NAMED "DirectoryList" AS
import java.io.File;
import java.util.Arrays;
public class DirectoryList
{
  public static String getFileList(String idir, String sep)
  {
    File aDirectory = new File(idir);
    File[] filesInDir = aDirectory.listFiles();
    String result = "";
    for ( int i=0; i<filesInDir.length; i++ )
    {
        if ( filesInDir[i].isFile()
             && !filesInDir[i].isHidden() )
        {
            if (result == ""){
                result = filesInDir[i].getName();
            } else {
                result += sep + filesInDir[i].getName();
            }
        }
    }
    return result;
  }
};
/

CREATE OR REPLACE FUNCTION Dir_List
   (p_dir IN VARCHAR2, p_sep IN VARCHAR2) RETURN VARCHAR2
AS LANGUAGE JAVA NAME
'DirectoryList.getFileList
  (java.lang.String, java.lang.String)
  return String';
/
 
BEGIN
  DBMS_JAVA.grant_permission('&FND_USER',
    'java.io.FilePermission', '<>', 'read');
  DBMS_JAVA.grant_permission('&FND_USER',
    'SYS:java.lang.RuntimePermission',
    'writeFileDescriptor', '');
  DBMS_JAVA.grant_permission('&FND_USER',
    'SYS:java.lang.RuntimePermission',
    'readFileDescriptor', '');
END;
/
