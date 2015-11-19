/* HW 3.2-4a */
/*7;6;South Africa*/

/* HW 3.2-4b */
proc contents data=orion._all_ nods;
run;
/* US_SUPPLIERS*/

/* HW 3.2-5a */
proc contents data=orion.staff;
run;

/* HW 3.2-5b */
/* All the general information shows that the data set is sorted. And the variable session shows that the data is sorted by the Employee_ID. */

/* HW 3.2-6 */
/* autoexec.sas; The file has many SAS statements that can executed after SAS initalizes.It is also be used for starting the program and establish some variables for usage;
Use the test editor and use the save as; It can be used to establish the certain variable and submit a LIBNAME statement. */

/* HW 4.1-1a,1b */
proc print data=orion.order_fact;
   sum Total_Retail_Price;
run;

proc print data=orion.order_fact;
	where Total_Retail_Price>500;
   sum Total_Retail_Price;
run;

proc print data=orion.order_fact noobs;
	where Total_Retail_Price>500;
   sum Total_Retail_Price;
run;

proc print data=orion.order_fact noobs;
	where Total_Retail_Price>500;
	id customer_id;
   sum Total_Retail_Price;
run;

/* HW 4.1-1c
The numbers are not sequential. All the numbers displayed are orginal numbers.; Yes

HW 4.1-1d
Check the log;

HW 4.1-1e
Customer_ID is the left column and shown on each line for the observation;

HW 4.1-1f
There will appear two of the Customer_ID columns. One is the ID field and another one is included because the Customer_ID column will be listed in the VAR statement. */

/* HW 4.1-1g */
proc print data=orion.order_fact noobs;
	where Total_Retail_Price>500;
	id customer_id;
	var Order_ID Order_Type Quantity Total_Retail_Price;
   sum Total_Retail_Price;
run;

/* HW 4.1-2a */
proc print data=orion.customer_dim;
run;

/* HW 4.1-2b */
proc print data=orion.customer_dim noobs;
	where Customer_Age between 30 and 40; 
run;

/* HW 4.1-2c */
proc print data=orion.customer_dim noobs;
	where Customer_Age between 30 and 40;
	id Customer_ID; 
run;

/* HW 4.1-2d */
proc print data=orion.customer_dim noobs;
	where Customer_Age between 30 and 40;
	id Customer_ID; 
	var Customer_Name Customer_Age Customer_Type;
run;

/* HW 4.2-5a */
proc sort data=orion.employee_payroll
			 out=work.sort_salary;
	by Salary;
run;

/* HW 4.2-5b */
proc print data=work.sort_salary;
run;

/* HW 4.2-6a */
proc sort data=orion.employee_payroll
			 out=work.sort_salary2;
	by Employee_Gender descending Salary;
run;

/* HW 4.2-6b */
proc print data=work.sort_salary2;
	by Employee_Gender;
run;

/* HW 4.2-7a */
proc sort data=orion.employee_payroll
			 out=work.sort_sal;
	by Employee_Gender descending Salary;
run;

/* HW 4.2-7b */
proc print data=work.sort_sal noobs;
	by Employee_Gender;
	sum Salary;
	where Employee_Term_Date is missing and Salary>65000;
	var Employee_ID Salary Marital_Status;
 run;

/* HW 4.3-9a,9b,9c,9d,9e */
title1 'Australian Sales Employees';
title2 'Senior Sales Representatives';
footnote1 'Job_Title: Sales Rep. IV';

proc print data=orion.sales noobs;
	where Country='AU' and Job_Title contains 'Rep. IV';
	var Employee_ID First_Name Last_Name Gender Salary;
run;
title;
footnote;

/* HW 4.3-10a */
title 'Entry-level Sales Representatives';
footnote 'Job_Title: Sales Rep. I';

proc print data=orion.sales noobs label;
	where Country='US' and Job_Title='Sales Rep. I';
	var Employee_ID First_Name Last_Name Gender Salary;
	label Employee_ID="Employee ID"
			First_Name="First Name"
			Last_Name="Last Name"
			Salary="Annual Salary";	
run;

title;
footnote;

/* HW 4.3-10b */
title 'Entry-level Sales Representatives';
footnote 'Job_Title: Sales Rep. I';

proc print data=orion.sales noobs split=' ';
	where Country='US' and Job_Title='Sales Rep. I';
	var Employee_ID First_Name Last_Name Gender Salary;
	label Employee_ID="Employee ID"
			First_Name="First Name"
			Last_Name="Last Name"
			Salary="Annual Salary";	
run;

title;
footnote;

/* HW 4.3-11a */
proc sort data=orion.employee_addresses out=work.address;
	where Country='US';
	by State City Employee_Name;
run;

title "US Employees by State";
proc print data=work.address noobs split=' ';
	var Employee_ID Employee_Name City Postal_Code;
	label Employee_ID='Employee ID'
			Employee_Name='Name'
			Postal_Code='Zip Code';
	by State;
run;

/* HW 5.1-1a,1b,1c */
proc print data=orion.employee_payroll;
	var Employee_ID Salary Birth_Date Employee_Hire_Date;
	format Salary dollar11.2 Birth_Date mmddyy10. 
		    Employee_Hire_Date date9.;
run;

/* HW 5.1-2 */
title1 'US Sales Employees';
title2 'Earning Under $26,000';

proc print data=orion.sales label noobs;
	where Country='US' and Salary<26000;
	var Employee_ID First_Name Last_Name Job_Title Salary Hire_Date;
	label First_Name='First Name'
		   Last_Name='Last Name'
			Job_Title='Title'
			Hire_Date='Date Hired';
	format Salary dollar10. Hire_Date monyy7.;
run;
title;
footnote;

/* HW 5.2-4a */
data Q1Birthdays;
   set orion.employee_payroll;
   BirthMonth=month(Birth_Date);
   if BirthMonth le 3;
run;

/* HW 5.2-4b,4c */
proc format;
   value $gender
      'F'='Female'
      'M'='Male';
   value mname
       1='January'
       2='February'
       3='March';
run;

/* HW 5.2-4d,4e */
title 'Employees with Birthdays in Q1';
proc print data=Q1Birthdays;
	var Employee_ID Employee_Gender BirthMonth;
   format Employee_Gender $gender.
          BirthMonth mname.;
run;
title;

/* HW 5.2-5a,5b,5c */
proc format;
   value $gender 'F'='Female'
                 'M'='Male'
               other='Invalid code';

   value salrange .='Missing salary'
      20000-<100000='Below $100,000'
      100000-500000='$100,000 or more'
              other='Invalid salary';
run;

title1 'Salary and Gender Values';
title2 'for Non-Sales Employees';

/* HW 5.2-5d */
proc print data=orion.nonsales;
   var Employee_ID Job_Title Salary Gender;
   format Salary salrange. Gender $gender.;
run;


title;

/* HW 6.2-5a,5b,5c,5d,5e,5f */
data work.delays;
   set orion.orders;
   where Order_Date+4<Delivery_Date 
         and Employee_ID=99999999;
   Order_Month=month(Order_Date);
   if Order_Month=8;
	label Order_Date='Date Ordered'
	      Delivery_Date='Date Delivered'
			Order_Month='Month Ordered';
	format Order_Date Delivery_Date mmddyy10.;
	keep Employee_ID Customer_ID Order_Date Delivery_Date Order_Month;
run;

/* HW 6.2-5g */
proc contents data=work.delays;
run;

/* HW 6.2-5h */
proc print data=work.delays;
run;

/* HW 9.1-2a,2b,2c,2d*/
data work.birthday;
   set orion.customer;
   Bday2012=mdy(month(Birth_Date),day(Birth_Date),2012);
   BdayDOW2012=weekday(Bday2012);
   Age2012=(Bday2012-Birth_Date)/365.25;
   keep Customer_Name Birth_Date Bday2012 BdayDOW2012 Age2012;
   format Bday2012 date9. Age2012 3.;
run;

/* HW 9.1-2e */
proc print data=work.birthday;
run;

/* HW 9.2-6a,6b */
data work.season;
   set orion.customer_dim;
   length Promo2 $ 6;
   Quarter=qtr(Customer_BirthDate);
   if Quarter=1 then Promo='Winter';
   else if Quarter=2 then Promo='Spring';
   else if Quarter=3 then Promo='Summer';
   else if Quarter=4 then Promo='Fall';
   if Customer_Age>=18 and Customer_Age<=25 then  Promo2='YA';
   else if Customer_Age>=65 then  Promo2='Senior';
   keep Customer_FirstName Customer_LastName Customer_BirthDate   
        Customer_Age Promo Promo2; 
run;

/* HW 9.2-6c,6d */
proc print data=work.season;
   var Customer_FirstName Customer_LastName Customer_BirthDate Promo 
       Customer_Age Promo2; 
run;

/* HW 9.2-7a,7b,7c,7d,7e */
data work.ordertype;
   set orion.orders;
   length Type $ 13 SaleAds $ 5;
   DayOfWeek=weekday(Order_Date);
   if Order_Type=1 then 
      Type='Retail Sale';
   else if Order_Type=2 then do;
      Type='Catalog Sale';
	   SaleAds='Mail';
   end;
   else if Order_Type=3 then do;
      Type='Internet Sale';
	   SaleAds='Email';
   end;
   drop Order_Type Employee_ID Customer_ID;
run;

/* HW 9.2-7f */
proc print data=work.ordertype;
run;

/* HW 10.1-3a,3b */
proc contents data=orion.charities;
run;

proc contents data=orion.us_suppliers;
run;

proc contents data=orion.consultants;
run;

data work.contacts;	
	set orion.charities orion.us_suppliers;
run;

proc contents data=work.contacts;
run;

/* HW 10.1-3c */
/* It is the first data set named orion.charities; */

/* HW 10.1-3d */
data work.contacts2;	
	set orion.us_suppliers orion.charities;
run;

proc contents data=work.contacts2;
run;


data work.contacts3;	
	set  orion.us_suppliers orion.consultants;
run;

/* HW 10.1-3e */
/* The first data set named orion.us_suppliers. */

/* HW 10.1-3f */
/* Because for the contact type, it has two definitions which are character and numeric. */

/* HW 10.3-5a */
proc sort data=orion.product_list 
          out=work.product_list;
  	by Product_Level;
run;

/* HW 10.3-5b */
data work.listlevel;
  	merge orion.product_level work.product_list ;
  	by Product_Level;
	keep Product_ID Product_Name Product_Level Product_Level_Name;
run;

/* HW 10.3-5c */
proc print data=work.listlevel noobs;
	where Product_Level=3;   
run;

/* HW 10.4-8a */
proc sort data=orion.customer
          out=work.customer;
   by Country;
run;

/* HW 10.4-8b */
data work.allcustomer;
	merge work.customer(in=Cust) 
         orion.lookup_country(rename=(Start=Country Label=Country_Name) in=Ctry);
	by Country;
	keep Customer_ID Country Customer_Name Country_Name;
	if Cust=1 and Ctry=1;
run;

/* HW 10.4-8c,8d,8e */
proc print data=work.allcustomer;
run;