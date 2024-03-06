 

 declare
   var1 varchar2(10);
   num1 number(3);
   begin
   var1 := 'vishal';
   num1 := 020;
   dbms_output.put_line(var1);
   dbms_output.put_line('number is '||num1 );
   end;
 
  /

  declare
  name varchar2(10);
  sal number(10,2);

  begin
  select first_name , salary into name,sal from employees
  where employees_id = 100;
  dbms_output.put_line('Name : ' || name);
  dbms_output.put_line('salary : '|| sal);
  end;
  /

  
  declare
  name employees.first_name%TYPE; //type attribute to take a same data type from table
  sal employees.salary%TYPE;
  lastname name%TYPE;
  begin
  select first_name , salary into name , sal from employees
  where employees_id = 100;
  dbms_output.put_line('Name : ' || name);
  dbms_output.put_line('Sallary : ' || sal);

  end;
  /

   ////Select the all row data form the table

declare 
record employees%ROWTYPE;
begin
select * into record from employees
where employees_id = 100;
dbms_outpu

