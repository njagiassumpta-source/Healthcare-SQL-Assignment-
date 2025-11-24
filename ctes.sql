--11. For each patient in the database, identify their most recent appointment and list it along with 
--the patient’s ID. 
select* from appointments;

select distinct on (patient_id )patient_id,appointment_id,appointment_date 
from appointments
order by patient_id, appointment_date desc;

--12. For every appointment in the system, assign a sequence number that ranks each patient’s 
--appointments from most recent to oldest.  

select
patient_id,appointment_date, 
rank() over (partition by patient_id order by appointment_date desc ) as rank
from appointments ;


--13. Generate a report showing the number of appointments per day for October 2021, including a 
--running total across the month. 
select
    appointment_date,
    count(*) as daily_appointments
from appointments
where appointment_date between '2021-10-01' and '2021-10-31'
group by appointment_date
order by appointment_date; 

--14. Using a temporary query structure, calculate the average, minimum, and maximum total bill 
--amount, and then return these values in a single result set.  
select 
    avg(total_amount) as average_total,
    min(total_amount) as minimum_total,
    max(total_amount) as maximum_total
from bills;
