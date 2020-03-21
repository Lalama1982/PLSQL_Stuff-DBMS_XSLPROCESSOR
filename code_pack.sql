GRANT EXECUTE ON DBMS_XSLPROCESSOR TO test_user; -- execute on SYS
CREATE DIRECTORY test_dir AS 'G:\Edu\SQLDeveloper_WorkSpace\dbms_xslprocessor';
/
create or replace PACKAGE pkg_dbms_xslprocessor AS 
    FUNCTION fn_read_file_to_clob ( in_dir_name IN VARCHAR2, in_file_name IN VARCHAR2 ) RETURN CLOB;
    PROCEDURE pro_write_clob_to_file (  in_dir_name IN VARCHAR2, in_file_name IN VARCHAR2, in_clob IN CLOB );
    PROCEDURE pro_read_and_write ( in_dir_name IN VARCHAR2, in_data_file_name IN VARCHAR2, out_data_file_name IN VARCHAR2 );
    
END pkg_dbms_xslprocessor;
/
create or replace PACKAGE BODY pkg_dbms_xslprocessor AS
    FUNCTION fn_read_file_to_clob ( in_dir_name IN VARCHAR2, in_file_name IN VARCHAR2 ) RETURN CLOB AS
        l_clob1      CLOB;
    BEGIN
        l_clob1 := dbms_xslprocessor.read2clob(in_dir_name, in_file_name);

        RETURN l_clob1;
    END fn_read_file_to_clob;

    PROCEDURE pro_write_clob_to_file ( in_dir_name IN VARCHAR2, in_file_name IN VARCHAR2, in_clob IN CLOB ) AS
    BEGIN
          dbms_xslprocessor.clob2file ( in_clob, in_dir_name,  in_file_name );
    END pro_write_clob_to_file;

    PROCEDURE pro_read_and_write ( in_dir_name IN VARCHAR2, in_data_file_name IN VARCHAR2, out_data_file_name IN VARCHAR2 ) AS
        l_clob1      CLOB;
    BEGIN
        l_clob1 := dbms_xslprocessor.read2clob(in_dir_name, in_data_file_name);
        dbms_xslprocessor.clob2file ( l_clob1, in_dir_name,  out_data_file_name );
    END pro_read_and_write;
    
END pkg_dbms_xslprocessor;
/
-- execution
SELECT pkg_dbms_xslprocessor.fn_read_file_to_clob('TEST_DIR', 'datafile.txt') clob_data FROM dual;
/
BEGIN
    pkg_dbms_xslprocessor.pro_read_and_write('TEST_DIR', 'datafile.txt', 'newfile.txt');
END;    
