select * from support_tickets  ;                                            -- extracting database data by  using select statement 

--  Run SQL queries for key metrics 

-- Average Resolution and Response time per agent 

select Agent_id ,
round(avg(timestampdiff(hour,Created_date,Resolved_date)),2) as avg_resolution_hours ,
round(avg(timestampdiff(minute,Created_date,First_response_date)),2) as Avg_response_minutes
from support_tickets
group by Agent_id ; 


-- explanation of  the code 

/* Agent_ID → The agent who handled the tickets.

	• AVG(TIMESTAMPDIFF(HOUR, Created_Date, Resolved_Date)) → Calculates the average time (in hours) it takes each agent to resolve tickets fully.

	• AVG(TIMESTAMPDIFF(MINUTE, Created_Date, First_Response_Date)) → Calculates the average time (in minutes) it takes each agent to reply for the first time.

	• ROUND(..., 2) → Rounds the numbers to 2 decimal places (like 1.57 hours).

	• GROUP BY Agent_ID → Groups the data by each agent, so we get averages for each agent separately. */
    
    
-- Ticket Volume by Issue Type(monthly) 

select
Issue_type,
date_format(created_date,'%Y-%m') as month ,
count(*) as Ticket_count
from support_tickets
group by Issue_type,month
order by month ; 


-- Explanation for this query 

/* Issue_type
	• This tells you what kind of problem each ticket was about (like “Login Issue”, “Payment”, etc.).

# 
DATE_FORMAT(Created_date, '%Y-%m') AS month
	• This takes the full Created_date (like 2025-02-07 00:08:49) and formats it to just the year and month, like 2025-02.
	• %Y-%m means:
		○ %Y = full year (e.g., 2025)
		○ %m = month in 2-digit format (e.g., 02 for February)

#
COUNT(*) AS Ticket_Count
	• This counts how many tickets were created for that specific issue type in that month.


Grouping and Sorting

GROUP BY Issue_type, month
	• This tells SQL to group the data by each issue type and each month.
	• Example: “Payment Issues” in “2025-02” will be grouped together.

ORDER BY month
	• This sorts the result by month, so it appears in order from oldest to newest.
*/ 

-- Escalation Rate by Issue Type 

select 
Issue_type,
count(*) as total_tickets,
sum(case when Escalated = 'Y' then 1 else 0 end) as escalated_tickets,
Round((sum(case when Escalated = 'Y' then 1 else 0 END) / count(*)) * 100,2) as escalated_rate
from support_tickets
Group by Issue_Type ; 

-- Explanation 

/* 	It gives you a summary report for each issue type:
		• Total tickets
		• How many were escalated
		• What percentage were escalated (escalation rate)
	
	
	SELECT 
	  Issue_type,
	# Shows the type of issue (like "Login Problem", "Billing", etc.)
	
	
	Count(*) as total_tickets
	
	#  Counts the total number of tickets for that issue type
	
	  SUM(CASE WHEN Escalated = 'Y' THEN 1 ELSE 0 END) AS Escalated_Tickets,
	
	# This counts how many tickets were escalated (only those where Escalated = 'Y').
		• It checks each row:
			○ If escalated → adds 1
			○ If not → adds 0
		• So you get totally escalated tickets.
	
	
	  ROUND((SUM(CASE WHEN Escalated = 'Y' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Escalation_Rate
	
	
	
	Calculates the escalation rate (in %):
		• Formula: (Escalated Tickets / Total Tickets) × 100
		• ROUND(..., 2) → Rounds it to 2 decimal places
	
	
	FROM support_tickets
	GROUP BY Issue_Type;
	
	
Groups the result by each issue type so that you get a separate row for every type of issue. */






