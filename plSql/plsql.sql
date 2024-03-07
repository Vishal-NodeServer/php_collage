 

 declare
   var1 varchar2(10);
   num1 number(3);
   begin
   var1 := 'vishal';
   num1 := 020;
   dbms_output.put_line(var1);
   dbms_output.put_line('number is '|| num1 );
   end;
 
  

  declare
  namee varchar2(10);
  sal number(10,2);

  begin
  select  name , salary into namee,  sal from employees
  where id = 200;
  dbms_output.put_line('Name : ' || namee);
  dbms_output.put_line('salary : '|| sal);
  end;
  /

  
  declare
  name employees.name%TYPE; --type attribute to take a same data type from table
  sal employees.salary%TYPE;
  lastname name%TYPE;
  begin
  select first_name , salary into name , sal from employees
  where employees_id = 100;
  dbms_output.put_line('Name : ' || name);
  dbms_output.put_line('Sallary : ' || sal);

  end;
  /

--Select the all row data form the table

declare 
record employees%ROWTYPE;
begin
select * into record from employees
where id = 100;
dbms_output.put_line('Your name is : '|| record.name);
dbms_output.NEW_line;
dbms_output.put_line('Your Income : '|| record.salary );
end;
/


--While loop
declare
a number(2) := 10;
BEGIN 
 WHILE a < 20 LOOP
   dbms_output.put_line('value of a : ' || a);

   a := a + 1;
   IF a = 15 THEN
     
     a := a + 1;
     CONTINUE;
     END IF;
     END LOOP;
     END;

--While with EXIT 
declare
a number(2) := 10;
BEGIN 
 WHILE a < 20 LOOP
   dbms_output.put_line('value of a : ' || a);

   a := a + 1;
   IF a = 15 THEN
     
  
     EXIT;
     END IF;
     END LOOP;
     END;


--for loop to print table of 5

declare 
n number := 10;
t number;
result number;
BEGIN
t:= &n;
for i IN 1..n loop
result := t * i;
dbms_output.put_line(result);
END LOOP;
end;
/

--Implicit cursor 

 declare
 cnt number(3);

 begin
  update employee set salary = salary + 2 where e_name = 'vijay';
  cnt := SQL%RowCount;
  dbms_output.put_line(cnt || 'updated row');
  End;
  /


  --Cursor

  declare

  v_empno employees.employee_id%TYPE;
  v_ename employee.lastname%TYPE;
  Cursor emp_cursor is  
            SELECT employee_id , lastname from employees;


            begin

            open emp_cursor;
            LOOP
                FETCH emp_cursor into v_empno , v_ename;
                EXIT when emp_cursor%RowCount > 10 or emp_cursor%NOTFOUND;
                dbms_output_PUT_line(v_empno || ': ' || v_ename);
                END LOOp;
                CLOSE emp_cursor;
                END;
                /


--Advance Cursor 
--ONE's update then not upadate after this execution
-- in department_id = 50;
--to release this lock just need to write a cmd 
-- rollback  <--(This cmd is used to release the lock)

declare 
Clusor emp_cursor is
            Select emloyee_id , lastname , salary 
            from employees 
            Where department_id = 50
            for update of salary NOWAIT;

            BEGIN
        UPDATE employees SET salary = salary + 10 where department_id = 50;
        END;
        /


--Exception Handling (implicit predefined)

declare
  v_lastname employees.last_name%TYPE;
  v_salary employees.salary%TYPE;

  BEGIN
  select last_name , salary 
  INTO v_lastname , v_salary
  from employees 
  where employee_id = 300;

  dbms_output.put_line(v_lastname || 'earns' || v_salary);
 
 Exception
      when NO_DATA_FOUND THEN
           dbms_output.put_line('No records');
    when TOO_MANY_ROWS THEN 
        dbms_output_PUT_line('MOre than 1 record');
        When other THEN 
    dbms_output_PUT_line('some error found');

  END;
  /

  --UserDefined Exception(Explicit Exception)

  declare
     v_lastname employees.last_name%TYPE;
     v_salary employees.salary%TYPE;
     e_invalid_dept Exception;  --treat as a Exception :-)

     begin
    upadate employees 
    SET salary = salary + 200
    WHERE department_id = 200;

    IF SQL%NOTFOUND THEN  
            RAISE e_invalid_dept;
    END IF;
    COMMIT;

    Exception
       when NO_DATA_FOUND THEN  
           dbms_output.put_line('NO records');
        WHEN TOO_MANY_ROWS THEN
           dbms_output_PUT_line('More than 1 records found');
        WHEN e_invalid_dept then 
            dbms_output_PUT_line('not such departent EXists'); --This is my own Exception
        When other THEN 
            dbms_output_PUT_line('Some eror found');
            END;
            / 


--procedure is a sub program or a database object used to perform repeated execution

CREATE OR REPLACE PROCEDURE test_procedure IS
BEGIN
  dbms_output.put_line('Test procedure executed successfully');
  END;
  /

--to drop a procedure

drop procedure procedure_name;

--procedure with parameter 

CREATE OR REPLACE PROCEDURE add_dept
  (p_did IN departments.department_id%TYPE,
   p_dname IN departments.department_name%TYPE,
   p_mid IN departments.department_manager_id%TYPE,
   p_lid IN departments.location_id%TYPE)
IS
BEGIN
   INSERT INTO departments VALUES (p_did, p_dname, p_mid, p_lid);
   DBMS_OUTPUT.PUT_LINE('Department added');
END;
/


--for execute this (to pass the parameter)

execute add_dept(102,Operation Department,Ahmedabad);

--to display the compilation error in procedure just use

SHOW ERRORS PROCEDURE ADD_DEPT;



    
    