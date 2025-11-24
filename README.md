# Healthcare-SQL-Assignment-
--1. Retrieve the list of all male patients who were born after 1990, including their patient ID, first 
--name, last name, and date of birth.

select* from patients;

select patients.first_name ,patients.last_name,patients.patient_id,patients.dob
from patients
where dob>'1990-12-31'
and Gender = 'M'; 

--2. Produce a report showing the ten most recent appointments in the system, ordered from the 
--newest to the oldest.  
select* from appointments;

select appointment_date 
from appointments
limit 10;

--3. Generate a report that shows all appointments along with the full names of the patients and 
--doctors involved. 
select* from doctors;
select* from patients;

select p.first_name,p.last_name ,appointment_id,appointment_date,d.doctor_id
from patients p
join appointments a
on p.patient_id= a.patient_id
join doctors d
on d.doctor_id=a.doctor_id ; 

--4. Prepare a list that shows all patients together with any treatments they have received, ensuring 
--that patients without treatments also appear in the results. 
select* from treatments;


select p.patient_id,t.treatment_type,t.outcome
from patients p
join appointments a
on p.patient_id = a.patient_id
join treatments t
on a.appointment_id =t.appointment_id;

--5. Identify any treatments recorded in the system that do not have a matching appointment.  

select t.treatment_id,t.treatment_type, t.outcome, t.appointment_id
from treatments t
left join appointments a
on t.appointment_id = a.appointment_id
where a.appointment_id is null;

--6. Create a summary that shows how many appointments each doctor has handled, ordered from 
--the highest to the lowest count.  
select d.doctor_id ,a.appointment_date, 
count(*) as total_appointments 
from appointments a
left join  doctors d
on a.doctor_id =d. doctor_id
group by a.appointment_date, d.doctor_id
order by total_appointments desc; 

--7. Produce a list of doctors who have handled more than twenty appointments, showing their 
--doctor ID, specialization, and total appointment count. 

select d.doctor_id,d.specialization,
    count(a.appointment_id) AS total_appointments
from doctors d
join  appointments a
on d.doctor_id = a.doctor_id
group by  d.doctor_id, d.specialization
having count(a.appointment_id) > 20; 

--8. Retrieve the details of all patients who have had appointments with doctors whose 
--specialization is “Cardiology.”  

select  p.patient_id, p.first_name, p.last_name , a.appointment_id, a.appointment_date, d.doctor_id, d.specialization
from patients p
join appointments a
on p.patient_id = a.patient_id
join doctors d
on a.doctor_id = d.doctor_id
where d.specialization = 'Cardiology';


--9. Produce a list of patients who have at least one bill that remains unpaid. 
select * from bills;
select * from patients ;
select* from admissions;

select p.patient_id,ad.admission_id,b.outstanding_amount
from patients p
join admissions ad
on p.patient_id =ad.patient_id
join bills b
on b.admission_id = ad.admission_id
where outstanding_amount > '1';


--10. Retrieve all bills whose total amount is higher than the average total amount for all bills in 
--the system.  
select *
from bills
where total_amount > (
    select avg(total_amount) 
    from bills);

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


--15. Build a query that identifies all patients who currently have an outstanding balance, based on 
--information from admissions and billing records. 
select 
    p.patient_id,
    p.first_name,
    p.last_name,
    b.total_amount,
    b.paid_amount,
    b.outstanding_amount
from patients p
join admissions a
    on p.patient_id = a.patient_id
join bills b
    on a.admission_id = b.admission_id
where outstanding_amount > 0;


--16. Create a query that generates all dates from January 1 to January 15, 2021, and show how 
--many appointments occurred on each of those dates. 


select appointment_date,count(*) as appointments_count
from appointments
where appointment_date between '2021-01-01' and  '2021-01-15'
group by appointment_date
order by appointment_date; 

--17. Add a new patient record to the Patients table, providing appropriate information for all 
--required fields.  
insert into patients (patient_id, first_name, last_name, dob, gender, phone_number, email)
values ('P1002', 'Zahara', 'Lona', '1976-05-15', 'F', '555-011002', 'zahara.lona@example.com');


--18. Modify the appointments table so that any appointment with a NULL status is updated to 
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
