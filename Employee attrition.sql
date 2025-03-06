SELECT * FROM project1.
employee_attrition;

select * from employee_attrition
where age between 27 and 35
and totalWorkingyears >5;

select department, max(monthlyincome),min(MonthlyIncome)
from employee_attrition
where PercentSalaryHike <13
group by department
order by max(MonthlyIncome) desc;

#Calculate the average monthly income of all the employees who worked more than 3 years whose education background is medical

select avg(monthlyincome)
from employee_attrition
where YearsAtCompany >3
and EducationField ='medical'
group by EducationField;

#Identify the total no. of male and female employees under attrition whose maritial status is married and haven't received promotion in the last 2 years.


select gender,count(employeenumber)
from employee_attrition
where MaritalStatus='married'
and YearsAtCompany=2
and Attrition='yes'
group by gender;

#Employees with max performance rating but no promotion for 4 years and above

Select *
from employee_attrition
where PerformanceRating = (select max(performancerating)from employee_attrition)
and YearsSinceLastPromotion >=4;

#Who has max and min percentage salaryhike

select YearsAtCompany,performancerating,yearssincelastpromotion,max(percentsalaryhike),min(percentsalaryhike)
from employee_attrition
group by YearsAtCompany,PerformanceRating,YearsSinceLastPromotion
order by max(PercentSalaryHike) desc;

#Employees working overtime but given min salaryhike and more than 5 years with company

select * from employee_attrition
where overtime='yes'
and PercentSalaryHike=(select min(percentsalaryhike) from employee_attrition)
and YearsAtCompany >5
and attrition='yes';

select * from employee_attrition
where overtime='no'
and percentsalaryhike=(select max(percentsalaryhike) from employee_attrition)
and YearsAtCompany <5
and attrition='no';

#Overall atttrition rate

select (count(case when attrition='yes' then 1 end)*100/ count(*)) as AttritionRate
from employee_attrition;

#Attrition count by Job role

SELECT JobRole,
			  count(*) As TotalEmployees,
              count(case when attrition='yes' then 1 end) as attritioncount,
              (count(case when attrition='yes' then 1 end)*100.0/count(*)) as Attritionrate
              from employee_attrition
              group by jobrole
              order by attritionrate desc;
              
#Attrition count by Department

select department,
                 count(*) as totalemployees,
                 count(case when attrition='yes' then 1 end) as attritioncount,
                 (count(case when attrition='yes' then 1 end)*100.1/count(*)) as attritionrate
                 from employee_attrition
                 group by department
                 order by AttritionRate;
                 
#Average monthly income comparison for Attrition

select attrition, avg(monthlyincome) as AverageIncome
from employee_attrition
group by attrition;

#Attrition based on work-life balance

select worklifebalance,
					count(*) as Totalemployees,
                    count(case when attrition='yes' then 1 end) as attritioncount,
                    (count(case when attrition='yes' then 1 end)*100.0/count(*)) as attritionrate
                    from employee_attrition
                    group by worklifebalance
                    order by worklifebalance;
                    
#Attrition by years at company

select yearsatcompany,
					count(*) as Totalemployees,
                    count(case when attrition='yes' then 1 end) as Attritioncount,
                    (count(case when attrition='yes' then 1 end)*100.0/count(*)) as Attritionrate
                    from employee_attrition
                    group by yearsatcompany
                    order by yearsatcompany;
                    
#Attrition by Age Group

select 
      case
      when age between 20 and 30 then '20-30'
      when age between 31 and 40 then '31-40'
      when age between 41 and 50 then '41-50'
      else '50+'
      end as AgeGroup,
      count(*) as TotalEmployees,
      count(case when attrition='yes' then 1 end) as Attritioncount,
      (count(case when attrition='yes' then 1 end)*100.0/count(*)) as AttritionRate
      from employee_attrition
      group by case
                   when age between 20 and 30 then '20-30'
                   when age between 31 and 40 then '31-40'
                   when age between 41 and 50 then '41-50'
                   else '50+'
                   end
                   order by AttritionRate desc;

#Attrition by Marital Status

Select maritalstatus,
					count(*) as Totalemployees,
                    count(case when attrition='yes' then 1 end) as Attritioncount,
                    (count(case when attrition='yes' then 1 end)*100.0/count(*)) as Attritionrate
                    from employee_attrition
                    group by MaritalStatus
                    order by AttritionRate desc;
                    
#Attrition based on business travel frequency

select businesstravel,
                     count(*) as Totalemployees,
                     count(case when attrition='yes' then 1 end) as Attritioncount,
                     (count(case when attrition='yes' then 1 end)*100.0/count(*)) as Attritionrate
                     from employee_attrition
                     group by BusinessTravel
                     order by Attritionrate desc;
                     
#Attrition based on Job Satisfaction Level

Select Jobsatisfaction,
                      count(*) as Totalemployees,
                      count(case when Attrition='yes' then 1 end) As Attritioncount,
                      (count(case when Attrition='yes' then 1 end)*100.0/count(*)) as AttritionRate
                      from employee_attrition
                      group by JobSatisfaction
                      order by JobSatisfaction;
                      
#Attrition by Environment Satisfation

select Environmentsatisfaction,
                              count(*) as Totalemployees,
                              count(case when Attrition='yes' then 1 end) as Attritioncount,
                              (count(case when Attrition='yes' then 1 end)*100.0/count(*)) as Attritionrate
                              from employee_attrition
                              group by EnvironmentSatisfaction
                              order by EnvironmentSatisfaction;
                              
#Attrition by Salary hike percentage

select percentsalaryhike,
				        count(*) as Totalemployess,
                        count(case when attrition='yes' then 1 end) as Attritioncount,
                        (count(case when attrition='yes' then 1 end)*100.0/count(*)) as Attritionrate
                        from employee_attrition
                        group by PercentSalaryHike
                        order by PercentSalaryHike;
                        
#Department with the highest Employee turnover

select Department,
                 count(*) as Totalemployees,
                 count(case when attrition='yes' then 1 end) as Attritoncount,
                 Round((count(case when attrition='yes' then 1 end)*100.0/count(*)),2) as Attritionrate
                 from employee_attrition
                 group by department
                 order by attritionrate desc;
                      
                      
                      
                      
                      
                      
                      
                      
                      






