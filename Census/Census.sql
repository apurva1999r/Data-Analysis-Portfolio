create database Census;
use census;
select * from dataset1;
select * from dataset2;

-- number of rows into our dataset
select count(*) from dataset1;
select count(*) from dataset2;

-- dataset for jharkhand and bihar
Select * from dataset1 where state in ( "Jharkhand" , "Bihar");
Select * from dataset2 where state in ( "Jharkhand" ,"Bihar");

-- Population of India
Select sum(population) as Total_Population from dataset2;

-- Average Growth of India
Select avg(Growth_Percentage)*100 as Avg_Growth from dataset1;

-- Average Growth of India by State
Select state, avg(Growth_Percentage)*100 as Avg_Growth from dataset1 group by state;

-- avg sex ratio
select state,round(avg(sex_ratio),0) avg_sex_ratio from dataset1 group by state order by avg_sex_ratio desc;

-- avg literacy rate
select state,round(avg(literacy),0) avg_literacy_ratio from dataset1 
group by state having round(avg(literacy),0)>90 order by avg_literacy_ratio desc ;

-- top 3 state showing highest growth ratio
select state,avg(Growth_Percentage)*100 avg_growth from dataset1 group by state order by avg_growth desc limit 3;

-- bottom 3 state showing lowest sex ratio
select state,round(avg(sex_ratio),0) avg_sex_ratio from dataset1 group by state order by avg_sex_ratio asc limit 3;

-- top and bottom 3 states in literacy rate
-- drop table if exists topstates;
create table topstates
( state varchar(255),
  topstate float

  );

insert into topstates 
	select state,round(avg(literacy),0) as avg_literacy_ratio from dataset1
group by state order by avg_literacy_ratio desc;

select * from topstates order by topstates.topstate desc limit 3;

drop table if exists bottomstates;
create table bottomstates
( state varchar(255),
  bottomstate float

  );

insert into bottomstates
select state,round(avg(literacy),0) as avg_literacy_ratio from dataset1 
group by state order by avg_literacy_ratio desc;

select * from bottomstates order by bottomstates.bottomstate asc limit 3;
