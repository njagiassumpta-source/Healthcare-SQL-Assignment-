functions.sql -- 
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

--17. Add a new patient record to the Patients table, providing appropriate information for all 
--required fields.  
insert into patients (patient_id, first_name, last_name, dob, gender, phone_number, email)
values ('P1002', 'Zahara', 'Lona', '1976-05-15', 'F', '555-011002', 'zahara.lona@example.com');

-18. Modify the appointments table so that any appointment with a NULL status is updated to 
--show “Scheduled.”  

update appointments
set status = 'Scheduled'
where status is null;

--19. Remove all prescription records that belong to appointments marked as “Cancelled.”  
delete from prescriptions p
using appointments a
where p.appointment_id = a.appointment_id
  and a.status = 'Cancelled';


--20. Create a stored procedure that adds a new record to the Doctors table. 
 $$

create procedure add_doctor(
    in doc_id int,
    in first_name varchar(50),
    in last_name varchar(50),
    in specialization varchar(50),
    in email varchar(100),
    in phone_number varchar(20)
)
begin
    insert into doctors (doctor_id, first_name, last_name, specialization, email, phone_number)
    values (doc_id, first_name, last_name, specialization, email, phone_number);
end$$

 ;
 
 
