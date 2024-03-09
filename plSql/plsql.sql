 

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


--ONE MORE EXAMPLE ------------------->

CREATE OR REPLACE PROCEDURE add_dept(
p_id IN departents.department_id%TYPE,
p_dname out departents.Department_name%TYPE)
IS
BEGIN
  SELECT department_name
  INTO p_dname
  from departents
  Where departent_id = p_id;
  END;
  /


  -------

  declare 
  dname varchar(20);

  begin
     add_dept(500,dname);
     dbms_output_PUT_line(dname);
     end;
     /

--One more example of procedure

CREATE OR REPLACE PROCEDURE formate_phone_number(p_phone_no IN OUT varchar2) IS
BEGIN 
p_phone_no := '(' || SUBSTR(p_phone_no , 1 ,3) || ')' ||
                     SUBSTR(p_phone_no , 4,3) || '-' ||
                    SUBSTR(p_phone_no,7);
                    END;
                    /

   ----

   declare
     v_p_no varchar2(10);
     begin
     v_p_no := '1234567890';
     formate_phone_number(v_p_no);
     dbms_output.PUT_line(v_p_no);
     end;
     /


--PACKAGE

CREATE OR REPLACE PACKAGE manage_employees IS 
PROCEDURE add_emp (p_id NUMBER, p_name VARCHAR2); 
PROCEDURE edit_emp (p_id NUMBER, p_name VARCHAR2); 
END manage_employees; 
END;


     CREATE OR REPLACE PACKAGE BODY manage_employees IS 
     PROCEDURE add_emp (p_id number, p_name VARCHAR2) IS 
     BEGIN 
     dbms_output.put_line ('Employee Added');
      END add_emp; 
      PROCEDURE edit_emp (p_id NUMEBR, p_name VARCHAR2) IS
       BEGIN dbms_output.put_line('Employee Updated'); 
       END edit_emp;
        END; 

        --EXECUTE
        execute manage_employees.add_emp(102,'kwhjj');
         execute manage_employees.edit_emp(102,'kwhjj');



--Triger  --Restricted ------------->>

CREATE or REPLACE TRIGGER restricted_insert 
BEFORE INSERT ON tbl_employees
BEGIN
 IF (TO_CHAR(SYSDATE , 'HH24:MI') NOT BETWEEN '9:00' AND '18:00') THEN
   RAISE_APPLICATION_ERROR(-20123 , 'you can add employee b/w 9 am to 18 pm ');
   END IF;
   END;
   /


  --as well delele or update in one

  CREATE or REPLACE TRIGGER restricted_insert 
BEFORE INSERT OR UPDATE OR DELETE ON tbl_employees
BEGIN
 IF (TO_CHAR(SYSDATE , 'HH24:MI') NOT BETWEEN '9:00' AND '18:00') THEN
   RAISE_APPLICATION_ERROR(-20123 , 'you can add employee b/w 9 am to 18 pm ');
   END IF;
   END;
   / 
     
    
  --

  CREATE OR REPLACE TRIGGER salary_update_check 
  BEFORE UPDATE OF salary ON tbl_employees
  FOR EACH ROW
  BEGIN
      IF :NEW.salary < :OLD.salary THEN 
       RAISE_APPLICATION_ERROR(-20125 , 'the new salary can not be lasser than current salary');
       END IF;
       END;
       /


       CREATE OR REPLACE TRIGGER empdel
    BEFORE DELETE ON employee
   FOR EACH ROW
    BEGIN
    INSERT INTO EMP VALUES
    (:OLD.id,:OLD.NAME,:OLD.AGE,:OLD.ADDRESS;,:OLD.SALARY);
    END;
    /  


   -- Assignment - 3

1.Write a procedure to display employee details whose department is 'it' and designation is 'manager'.


CREATE OR REPLACE PROCEDURE emp_it_manager AS
BEGIN
    FOR emp IN (SELECT * FROM EMPLOYEE WHERE department='it' AND designation='manager') 
    LOOP
        DBMS_OUTPUT.PUT_LINE('Employee Number: ' || emp.eno );
        DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp.ename);
        DBMS_OUTPUT.PUT_LINE('Department: ' || emp.department );
        DBMS_OUTPUT.PUT_LINE('Designation: ' || emp.designation );
        DBMS_OUTPUT.PUT_LINE('Salary: ' || emp.salary );
    END LOOP;
END;
/

2.Write a procedure to update the salary of the employee whose name starts with 'a'.

CREATE OR REPLACE PROCEDURE update_salary_a AS 
BEGIN 
    UPDATE EMPLOYEE SET salary=45000 WHERE ename LIKE 'a%';
END;
/

3.Write a procedure to delete the record from employee whose department is finance.

CREATE OR REPLACE PROCEDURE delete_record_dep_finance AS 
BEGIN 
    DELETE FROM EMPLOYEE where department='finance';
END;
/

4.Write a function to display data from person table who is oldest. 🧓

CREATE OR REPLACE FUNCTION display_whos_old RETURN VARCHAR2
IS 
    details VARCHAR2(1000);
BEGIN 
    SELECT 'pid : '|| pid || '| pname : ' || pname || '| age: ' || age || '| height: '||height || '| weight: '||weight ||
    '| bloodgroup: '||bloodgroup
    INTO details 
    FROM person
    WHERE age = (SELECT MAX(age) FROM person);
    RETURN details;
END;
/



DECLARE
    old_person_details VARCHAR2(1000);
BEGIN 
    old_person_details := display_whos_old;
    DBMS_OUTPUT.PUT_LINE(old_person_details);
END;
/

5. Write a function to display total heights of all persons. 📏

CREATE OR REPLACE FUNCTION total_heights RETURN NUMBER 
IS
    result_data NUMBER;
BEGIN 
    SELECT SUM(age) INTO result_data FROM person;
    RETURN result_data;
END;
/

DECLARE
    total_heights_of_persons NUMBER;
BEGIN 
    total_heights_of_persons := total_heights;
    DBMS_OUTPUT.PUT_LINE('Total height of persons is : ' || total_heights_of_persons);
END;
/

6. Write a function to display average weight of the persons. ⚖️

create or replace function avg_weight return number 
is 
    average_weight number;
begin
  select AVG(weight)
    into average_weight
    from person;

    return average_weight;
end;
/

declare 
    average_weight_result number;
begin
    average_weight_result := avg_weight;
    dbms_output.put_line('The average of person in the table is : ' || average_weight_result);
end;
/


7. Write a function to display minimum salary of employee. 💰

create or replace function minimums_salary_emp return number 
is 
    min_salary number;
begin
  select MIN(salary) into min_salary from employee;
  return min_salary;
end;
/

declare 
    min_salary number;
begin
  min_salary := minimums_salary_emp;
  dbms_output.put_line('The minimum salary of a employee is :  ' || min_salary);
end;
/

8. Write PL/SQL block to fetch the details of employee whose eid is 3 and check that salary is above 50000 or not. If salary is above 50000, then display data; otherwise, raise an exception and print proper message.

declare 
emp_salary number;
salary_not_found EXCEPTION;
begin
    select salary
    into emp_salary
    from employee
    where eno=3;

    if(emp_salary > 50000) then
        dbms_output.put_line('Employee with eid:3 has salary above 50000');
    else
        raise salary_not_found;
    end if;
exception 
    when salary_not_found then 
        dbms_output.put_line('Employee with eid:3 do not have salary above 50000');
end;
/




9. Write a procedure to display person’s details whose age is 20.

create or replace procedure display_details_age20 as
begin
    for p in (select * from person where age=20)
    loop
      dbms_output.put_line('p id : ' ||p.pid);
      dbms_output.put_line('pname : ' ||p.pname);
      dbms_output.put_line('age : ' ||p.age);
      dbms_output.put_line('height : ' ||p.height);
      dbms_output.put_line('weight : ' ||p.weight);
      dbms_output.put_line('bloodgroup : ' ||p.bloodgroup || CHR(10));
    end loop;
end;
/


10. Write PL/SQL block to fetch the data of person whose pid is 4. Check the age is above 18 or not. If age is above 18, then print 'you are eligible for voting'; else, print 'not eligible'.

declare 
person_age number;
age_exception exception;
begin
    select age into person_age from person where pid=4;

    if(person_age>18)then
        dbms_output.put_line('You are eligible to vote');
    else
        raise age_exception;
    end if;
exception
    when age_exception then
        dbms_output.put_line('Oops you are not eligible to vote!!');
end;
/