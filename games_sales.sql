create database videogamesales ; 
use videogamesales ; 


create table games_sales(                                                                   -- schema created 
gamerank INT,
games_name varchar(255),
platform varchar(50) ,
year_of_release INT,
genre varchar(50),
Publisher varchar(255) ,
NA_sales float ,
EU_sales float , 
JP_sales float , 
other_sales float ,
global_sales float 
); 

alter table games_sales 
change column name  games_name varchar(255) ,
change column year year_of_release int ;

show columns from games_sales ; 


# check the successful import :

select * from games_sales limit 10 ;                                            --  verification done 


# step 2 : analysis in MYSQL 

-- find top 10 best_selling games globally : 

select games_name , global_sales 
from games_sales 
order by global_sales desc 
limit 10 ;


# sales per platform : 

select platform , round(sum(global_sales),2)   as  total_sales 
from games_sales
group by platform 
order by total_sales desc; 







# advanced queries : 

-- analyze trends over years : 

select year_of_release ,sum(global_sales) as total_sales 
from games_sales 
group by year_of_release
order by year_of_release ;                                                                -- getting unsatisfied result with year_of_release = 0 , so now i decided to revaluate by another query 


-- questionable queries 

select year_of_release , round(sum(global_sales),2) as total_sales                        -- games_sales over the years is solved  by using this query excluding 0 
from games_sales 
where year_of_release > 1979 
group by year_of_release
order by year_of_release ; 


-- genre analysis : 

select genre, round(avg(global_sales),2) as avg_sales
from games_sales 
group by genre 
order by avg_sales desc;                                                                   -- platform on top 













 



















