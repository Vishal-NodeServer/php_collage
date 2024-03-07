 

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