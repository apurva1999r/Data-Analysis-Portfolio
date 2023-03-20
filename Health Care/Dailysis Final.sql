select * from dbo.['Dialysis - I$']
Select * from dbo.['Dailysis - II$']
 
/*KPI 1 - Number Of Petient in Each Summary */ 
select sum ([Number of patients included in the transfusion summary]) as Transfusion_summary ,
sum([Number of patients in hypercalcemia summary]) as hypercalcemia_summary , 
sum([Number of patients in Serum phosphorus summary]) as Serum_phosphorus_summary , 
sum([Number of Patients included in survival summary]) as survival_summary , 
sum([Number of patients included in hospitalization summary]) as  hospitalization_summary ,
sum([Number of Patients included in fistula summary]) as fistula_summary,
sum([Number of patients in long term catheter summary]) as long_term_catheter_summary,
sum([Number of patients in nPCR summary]) as nPCR_Summary, 
sum([Number of hospitalizations included in hospital readmission summ]) as hospital_readmission_summ
 from dbo.['Dialysis - I$']


/* KPI 2 - Profit Vs Non-Profit Stats */

select [Profit or Non-Profit] , count([Profit or Non-Profit]) as count_of_Profit_Non_profit from dbo.['Dialysis - I$']
group by [Profit or Non-Profit]


/* KPI 3 - Chain Organizations w.r.t. Total Performance Score as No Score */

SELECT ['Dialysis - I$'].[Chain Organization],count(['Dailysis - II$'].[Total Performance Score])  as Total_No_SCORE from dbo.['Dailysis - II$']
full join ['Dialysis - I$'] on ['Dailysis - II$'].[CMS Certification Number (CCN)] = ['Dialysis - I$'].[Provider Number]
where [Total Performance Score] = '0 '
GROUP BY [Chain Organization]
order by Total_No_SCORE ASC

/*
ALTER TABLE ['Dailysis - II$']
ALTER COLUMN [Total Performance Score] varchar (50) ;

SELECT ['Dialysis - I$'].[Chain Organization],count(['Dailysis - II$'].[Total Performance Score])  as Total_No_SCORE from dbo.['Dailysis - II$']
left join ['Dialysis - I$'] on ['Dailysis - II$'].[CMS Certification Number (CCN)] = ['Dialysis - I$'].[Provider Number]
where [Total Performance Score] = 'No Score '
GROUP BY [Chain Organization] 
*/


/* KPI 4 - Dialysis Stations Stats */ 

Select [Facility Name],SUM([# of Dialysis Stations]) as Sum_of_Dailysis_station From dbo.['Dialysis - I$']
group by [Facility Name]
order by Sum_of_Dailysis_station ASC

Select SUM([# of Dialysis Stations]) as Sum_of_#of_Dialysis_Stations from dbo.['Dialysis - I$']

/* KPI 5 */ 

/*
select  [Patient Transfusion category text] from dbo.['Dialysis - I$']
where [Patient Transfusion category text] = 'As Expected' 

select [SWR category text] from dbo.['Dialysis - I$']
where [SWR category text] = 'As Expected'

select [Patient Infection category text] from dbo.['Dialysis - I$']
where [Patient Infection category text] = 'As Expected'

select [Patient Survival Category Text] from dbo.['Dialysis - I$']
where [Patient Survival Category Text] = 'As Expected'

select [Fistula Category Text] from dbo.['Dialysis - I$']
where[Fistula Category Text] = 'As Expected'

select [PPPW category text] from dbo.['Dialysis - I$']
where [PPPW category text] = 'As Expected'

select [Patient hospitalization category text] from dbo.['Dialysis - I$']
where [Patient hospitalization category text] = 'As Expected'
*/

/* KPI 5 - # of Category Text  - As Expected */

Select count([Patient Transfusion category text]) as Patient_Transfusion_category_text From dbo.['Dialysis - I$']
where [Patient Transfusion category text] = 'As Expected' group by  [Patient Transfusion category text] 

select Count([SWR category text]) as SWR_category_text From dbo.['Dialysis - I$']
where [SWR category text] = 'As Expected' group by  [SWR category text] 

select Count([Patient Infection category text]) as Patient_Infection_category_text from dbo.['Dialysis - I$']
where [Patient Infection category text] = 'As Expected' group by [Patient Infection category text] 

select count([Patient Survival Category Text]) as Patient_Survival_Category_Text from dbo.['Dialysis - I$']
where [Patient Survival Category Text] = 'As Expected' group by [Patient Survival Category Text] 

select Count([Fistula Category Text]) as Fistula_Category_Text from dbo.['Dialysis - I$'] 
where [Fistula Category Text] = 'As Expected' group by [Fistula Category Text] 

select count([PPPW category text]) as PPPW_category_text from dbo.['Dialysis - I$']
where [PPPW category text] = 'As Expected' group by [PPPW category text] 

select count([Patient hospitalization category text]) as Patient_hospitalization_category_text from dbo.['Dialysis - I$']
where [Patient hospitalization category text] = 'As Expected' group by [Patient hospitalization category text]


/* KPI 6 - Average Payment Reduction Rate*/

select ['Dailysis - II$'].[PY2020 Payment Reduction Percentage] , count(['Dialysis - I$'].[Facility Name]) as Count_Of_Facility_Name from ['Dialysis - I$']
full join ['Dailysis - II$'] on ['Dialysis - I$'].[Provider Number] = ['Dailysis - II$'].[CMS Certification Number (CCN)] 
group by [PY2020 Payment Reduction Percentage] 
order by [PY2020 Payment Reduction Percentage] ASC 