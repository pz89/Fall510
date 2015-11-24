/* %let path=/folders/myfolders/Data_One/;*/
/* libname orion "/folders/myfolders/Data_One/";*/

/* HW 3.2
4a:
How many observations are in the orion.country data set? 
How many variables are in the orion.country data set? 
What is the name of the last country in the data set? */
/*Answers: 
7;
6;
South Africa*/

/* HW 3.2
4b:
Submit a PROC CONTENTS step to generate a list of all members in the orion library. 
What is the name of the last member listed? */
proc contents data=orion._all_ nods;
run;
/* Answer: 
US_SUPPLIERS*/

/* HW 3.2
5a: 
Examine the general data set properties of orion.staff.*/
proc contents data=orion.staff;
run;

/* HW 3.2
5b: 
What sort information is stored for this data set? */
/* Answer: 
All the general information shows that the data set is sorted. And the variable session shows that the data is sorted by the Employee_ID. */

/* HW 3.2-6: 
What is the name of the file? 
What is its purpose? 
How is it created? 
How could this be useful in a SAS session? */
/* Answers: 
autoexec.sas; 
The file has many SAS statements that can executed after SAS initalizes.It is also be used for starting the program and establish some variables for usage;
Use the test editor and use the save as; 
It can be used to establish the certain variable and submit a LIBNAME statement. */

/* HW 4.1-1a,1b: 
Retrieve the starter program p104e01. Run the program and view the output. Observe that there are 617 observations. Observations might be displayed over two lines, depending on output settings.
Add s SUM statement to display the sum of Total_Retail_Price. The last several lines of the report are shown below. */
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

/* HW 4.1-1c:
Add a Where statement to select only the observations with Total_Retail_Price more than 500. Submit the program. Verify that 35 observations were displayed.
What do you notice about the Obs column?
Did the sum of Total_Retail_Price change to reflect only the subset?
Answers: 
The numbers are not sequential. 
All the numbers displayed are orginal numbers.; 
Yes

HW 4.1
1d:
Add an option to suppress the Obs column. Verify that there are 35 observations in the results. How can you verity the number of observations in the results?
Answers: 
Check the log;

HW 4.1-1e:
Add an ID statement to use Customer_ID as the identifying variable. Submit the program. The results contain 35 observatons. How did the output change?
Answer: 
Customer_ID is the left column and shown on each line for the observation;

HW 4.1-1f:
Add a VAR statement to display Customer_ID, Order_ID, Order_Type, Quantity, and Total_Retail_Price. What do you notice about Customer_ID?
Answer:
There will appear two of the Customer_ID columns. One is the ID field and another one is included because the Customer_ID column will be listed in the VAR statement. */

/* HW 4.1-1g:
Modify the VAR statement to address the issue with Customer_ID. */
proc print data=orion.order_fact noobs;
	where Total_Retail_Price>500;
	id customer_id;
	var Order_ID Order_Type Quantity Total_Retail_Price;
   sum Total_Retail_Price;
run;

/* HW 4.1-2a:
 Write a PRINT step to display orion.customer_dim*/
proc print data=orion.customer_dim;
run;

/* HW 4.1-2b:
Modify the program to display a subset of orion.customer_dim by selecting only the observations for customers between the ages of 30 and 40. Also, suppress the Obs column. The resulting report should contain 17 observations. */
proc print data=orion.customer_dim noobs;
	where Customer_Age between 30 and 40; 
run;

/* HW 4.1-2c:
Add a statement to use Customer_ID instead of Obs as the identifying column. Submit the program and verify the results. */
proc print data=orion.customer_dim noobs;
	where Customer_Age between 30 and 40;
	id Customer_ID; 
run;

/* HW 4.1-2d:
Add a statement to limit the variables to those shown in the report below. */
proc print data=orion.customer_dim noobs;
	where Customer_Age between 30 and 40;
	id Customer_ID; 
	var Customer_Name Customer_Age Customer_Type;
run;

/* HW 4.2-5a:
Sorting orion.employee_payroll and Displaying the New Data Set. 
Open p104e05. Add a PROC SORT step before the PROC PRINT step to sort orion.employee_payroll by Salary, placing the sorted observations into a temporary data set named sort_salary. */
proc sort data=orion.employee_payroll
			 out=work.sort_salary;
	by Salary;
run;

/* HW 4.2-5b:
Modify the PROC PRINT step to display the new data set. Verify that your output matches the report below. */
proc print data=work.sort_salary;
run;

/* HW 4.2-6a:
Sorting orion.employee_payroll and Displaying Grouped Observations
Open p104e06. Add a PROC SORT step before the PROC PRINT step to sort orion.employee_payroll by Employer_Gender, and within gender by Salary in descending order. Place the sorted observations into a temporary data set named sort_salary2. */
proc sort data=orion.employee_payroll
			 out=work.sort_salary2;
	by Employee_Gender descending Salary;
run;

/* HW 4.2-6b:
Modify the PROC PRINT step to display the new data set with the observations grouped by Employee_Gender. */
proc print data=work.sort_salary2;
	by Employee_Gender;
run;

/* HW 4.2-7a:
 Sorting orion.employee_payroll and Displaying s Subset of the New Data Set.
 Sort orion.employee_payroll by Employee_Gender, and by descending Salary within gender. Place the sorted observations into a temperory data set named sorted_sal */
proc sort data=orion.employee_payroll
			 out=work.sort_sal;
	by Employee_Gender descending Salary;
run;

/* HW 4.2-7b:
Print a subset if the sort_sal data set. Select only the observations for active employees who earn more than 65,000 dollars. Group the report by Employee_Gender, and include a total and subtotals for Salary. Suppress the Obs column. Display only Employee_ID,Salary,and Marital_Status. The result contains 18 obs. */
proc print data=work.sort_sal noobs;
	by Employee_Gender;
	sum Salary;
	where Employee_Term_Date is missing and Salary>65000;
	var Employee_ID Salary Marital_Status;
 run;

/* HW 4.3-9a:
Open and sumbir p104e09 to display all observations for Australian Sales Rep IVs.
9b:
Add a VAR statement to display only the variables shown in the report below.
9c:
Add TITLE and FOOTNOTE statements to include the titles and footnotes shown in the report below.
9d:
Submit the program and verify the output. The results contain five obversations as shown below.
9e:
Sumbit a null TITLE and null FOOTNOTE statement to clear all titles and footnotes.
 */
title1 'Australian Sales Employees';
title2 'Senior Sales Representatives';
footnote1 'Job_Title: Sales Rep. IV';

proc print data=orion.sales noobs;
	where Country='AU' and Job_Title contains 'Rep. IV';
	var Employee_ID First_Name Last_Name Gender Salary;
run;
title;
footnote;

/* HW 4.3-10a:
Open and sumbit p104e10. Modify the program to define and use the labels. Submit the program and verify the output. */
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

/* HW 4.3-10b:
Modify the program to use a blank space as the SPLIT=character to generate two-line column headings. Submit the modified program and verify that two-line column labels are displayed. */
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

/* HW 4.3-11a:
Write a program to display a subset of orion.employee_addresses as shown below. The program should sort the observations by state, city and Employee_Name and then display the sorted observations grouped by state. The resulting report should contain 311 observations. */
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

/* HW 5.1-1a:
Open p105e01 and sumbit. Review the output.
1b:
Modify the PROC PRINT step to display only employee_ID, Salary, Birth_Date, and Employee_Hire_Date.
1c:
Add a FORMAT statement to display Salary in a dollar format, Birth_Date in 01/31/2012 date style, and Employee_Hire_Date in the 01JAN2012 date style, as shown in the report belew. */
proc print data=orion.employee_payroll;
	var Employee_ID Salary Birth_Date Employee_Hire_Date;
	format Salary dollar11.2 Birth_Date mmddyy10. 
		    Employee_Hire_Date date9.;
run;

/* HW 5.1-2:
Write a PROC PRINT step to display the report below using orion.sales as input. Subset the observations and variables to produce the report shown below. Include titles, labels and formats. The results contains 13 observations. */
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

/* HW 5.2-4a:
Retrieve the starter program p105e04*/
data Q1Birthdays;
   set orion.employee_payroll;
   BirthMonth=month(Birth_Date);
   if BirthMonth le 3;
run;

/* HW 5.2-4b:
Create a character format named $GENDER that displays gender codes as follows F:female; M:Male
4c:
Create a numeric format named MNANE that displays month numbers as follows: 1 January, 2 February, 3 March */
proc format;
   value $gender
      'F'='Female'
      'M'='Male';
   value mname
       1='January'
       2='February'
       3='March';
run;

/* HW 5.2-4d:
Add a PROC PRINT step to display the data set, applying these two user-defined formats to the Employee_Gender and BirthMonth variables, respectively.
4e:
Submit the program to produce the following report. The result contain 113 observations. */
title 'Employees with Birthdays in Q1';
proc print data=Q1Birthdays;
	var Employee_ID Employee_Gender BirthMonth;
   format Employee_Gender $gender.
          BirthMonth mname.;
run;
title;

/* HW 5.2-5a:
Retrieve the starter program p105e05
5b:
Create a character format named $GENDER that displays gender codes as follows F:female; M:Male; Any other value: Invalid code
5c:
Create a numeric format named SALRANGE that displays salary ranges as follows:At least 20,000 but less than 100,000  Below 100,000; At least 100,000 and up to 500,000  100,000 or more; missing  Missing salary;  Any other value  Invalid salary */
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

/* HW 5.2-5d:
In the PROC PRINT step, apply these two user-defined formats to the Gender and Salary variables respectively. Submit the program to produce the following report (too large and will not shown) */
proc print data=orion.nonsales;
   var Employee_ID Job_Title Salary Gender;
   format Salary salrange. Gender $gender.;
run;


title;

/* HW 6.2
5a:
Write a DATA step to create work.delays using orion.orders as input.
5b:
Create a new variable, Order_Month, and set it to the month of Order_Date. 
5c:
Use a WHERE statement and a subsetting IF statement to select only the observations that meet all of the following conditions:
1.delivery_ID values that are more than four days beyond Order_Date.
2.Employee_ID values that are equal to 99999999.
3.Order_Month values occuring in August.
5d:
The new data set should include only Employee_ID, Order_Date, Delivery_Date, and Order_Month.
5e:
Add permanent labels for Order_Date,Delivery_Date, and Order_Month as shown below.
5f
Add permanent formats to display Order_Date and Delivery_Date as MM/DD/YYYY.
 */
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

/* HW 6.2
5g: 
Add a PROC CONTENTS step to verify that the labels and formats were stored permanently. */
proc contents data=work.delays;
run;

/* HW 6.2
5h:
Write a PROC PRINT step to create the report below. Results should contain nine observations. */
proc print data=work.delays;
run;

/* HW 9.1
2a:
Write a DATA step that reads orion.customer to create work.birthday.
2b:
In the DATA step, Create three new variables:Bday2012,BdayDOW2012, and Age2012.
1. Bday2012 is the combination of the month of Birth_Date, the day of Birth_Date, and the constant of 2012 in the MDY function
2. BdayDOW 2012 is the day of the week of Bday2012.
3. Age2012 is the age of the customer in 2012. Subtract Birth_Date from Bday2012 and divide the result by 364,25.
2c:
Include only the following variables in the new data set; Customer_Name,Birth_Date,Bday2012, BdayDOW2012, and Age2012
2d:
Format Bday2012 to display in the form 01Jan2012. Age2012 should be formatted to display with no decimial places. */
data work.birthday;
   set orion.customer;
   Bday2012=mdy(month(Birth_Date),day(Birth_Date),2012);
   BdayDOW2012=weekday(Bday2012);
   Age2012=(Bday2012-Birth_Date)/365.25;
   keep Customer_Name Birth_Date Bday2012 BdayDOW2012 Age2012;
   format Bday2012 date9. Age2012 3.;
run;

/* HW 9.1
2e:
Write a PROC PRINT step to create the report below. The result should contain 77 observations. */
proc print data=work.birthday;
run;

/* HW 9.2
6a:
Write a DATA step that reads orion.customer_dim to create work,season.
6b:
Create two new variables:promo and promo2.The value of Promo is based on the quarter in which the customer was born.
1. If the customer was born in the first quarter, then promo is equal to Winter.
2. If the customer was born in the second quarter, then promo is equal to Spring.
3. If the customer was born in the third quarter, then promo is equal to Summer.
4. If the customer was born in the fourth quarter, then promo is equal to Fall.
The value of promo2 is based on the customer's age.
1. For young adults,whose age is between 18 and 25, set promo2 equal to YA.
2. For seniors, age 65 or older, set promo2 equal to Senior.
3. Promos should have a missing value for all other customers. */
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

/* HW 9.2
6c:
The new data set should include only Customer_FirstName,Customer_LastName, Customer_BirthDate,Customer_Age, Promo and Promo2
6d:
Create the report below. The result should include 77 observations. */
proc print data=work.season;
   var Customer_FirstName Customer_LastName Customer_BirthDate Promo 
       Customer_Age Promo2; 
run;

/* HW 9.2
7a:
Write a DATA step that reads orion.orders to create work.ordertype.
7b:
Create a new variable, DayOfWeek, that is equal to the weekday of Order_Date.
7c:
Create the new variable Type, which is equal to
Retail Sale if Order_Type is equal to 1
Catelog Sale if Order_Type is equal to 2
Internet Sale if Order_Type is equal to 3.
7d:
Create the new variable SaleAds which is equal to 
Mail if Order_Type is equal to 2
Email if Order_Type is equal to 3.
7e:
Do not include Order_Type,Employee_ID, and Customer_ID in the new data set. */
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

/* HW 9.2
7f:
Create the report below. The result should contain 490 observations. */
proc print data=work.ordertype;
run;

/* HW 10.1
3a:
Construct Data Set with Variables of Different Lengths and Types
Open p110e03. Submit the PROC CONTENTS steps or explore the data interactively to complete the table below by filling in attribute information for each variable in each data set.
3b:
Write a Data step to concatenate orion.charities and orion.us_suppliers, creating a temporary data set, contacts. */
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

/* HW 10.1
3c:
Submit a PROC CONTENTS step to examine work.contacts. From which input date set were the variable attributes assigned? */
/* It is the first data set named orion.charities; */

/* HW 10.1
3d:
Write a DATA step to concatenate orion.us_suppliers and orion.charities, creating a temporary data set, contacts2. Note that these are the same data sets as the previous programm but they are in reverse order. */
data work.contacts2;	
	set orion.us_suppliers orion.charities;
run;

proc contents data=work.contacts2;
run;


data work.contacts3;	
	set  orion.us_suppliers orion.consultants;
run;

/* HW 10.1
3e:
Submit a PROC CONTENTS step to examine work.contacts2. From which input data set were the variable attributes assigned? */
/* The first data set named orion.us_suppliers. */

/* HW 10.1
3f:
Write a Data step to concatenate orion.us_suppliers and orion.consultants, creating a temporary data set,contacts3. 
Why did the DATA step fail? */
/* Because for the contact type, it has two definitions which are character and numeric. */

/* HW 10.3
5a:
 Merging a Sorted Set and an Unsorted Data Set in a One-to-Many Merge
 Sort orion.product_list by Product_Level to create a new data set, work.product_list. */
proc sort data=orion.product_list 
          out=work.product_list;
  	by Product_Level;
run;

/* HW 10.3:
5b:
Merge orion.product_level with the sorted data set. Create a new data set, work.listlevel, which includes only Product_ID, Product_Name, Product_Level, and Product_Level_Name. */
data work.listlevel;
  	merge orion.product_level work.product_list ;
  	by Product_Level;
	keep Product_ID Product_Name Product_Level Product_Level_Name;
run;

/* HW 10.3
5c:
Create the report below, including only observations with Product Level equal to 3. The results should contain 13 observations. */
proc print data=work.listlevel noobs;
	where Product_Level=3;   
run;

/* HW 10.4
8a:
Write a PROC SORT step to sort orion.customer by Country to create a new data set, work.customer. */
proc sort data=orion.customer
          out=work.customer;
   by Country;
run;

/* HW 10.4
8b:
Write a DATA step to merge the resulting data set with orion.lookup_country by Country to create a new data set, work.allcustomer.
In the orion.lookup_country data set, rename Start to Country and rename Label to Country_Name. */
data work.allcustomer;
	merge work.customer(in=Cust) 
         orion.lookup_country(rename=(Start=Country Label=Country_Name) in=Ctry);
	by Country;
	keep Customer_ID Country Customer_Name Country_Name;
	if Cust=1 and Ctry=1;
run;

/* HW 10.4
8c:
Create the report below. The results should contain 308 observations.
8d:
Modify the DATA step to store only the observations that contain both customer information and country information. A submitting IF statement that references IN=variables in the MERGE statement must be added.
8e:
Submit the program to create the report below. The results should contain 77 observations. */
proc print data=work.allcustomer;
run;