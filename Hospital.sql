#Show first name, last name, and gender of patients whose gender is 'M'
SELECT first_name,last_name,gender FROM patients
where gender='M';

#Show first name and last name of patients who does not have allergies. (null)
SELECT first_name,last_name FROM patients
where allergies is null;

#Show first name of patients that start with the letter 'C'
SELECT first_name FROM patients
where first_name like 'C%';

#Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
SELECT first_name,last_name FROM patients
where weight between 100 and 120;

#Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
Update patients
set allergies='NKA'
where allergies is null ;

#Show first name, last name, and the full province name of each patient.
select p.first_name,p.last_name,pr.province_name
from patients p join province_names pr
on p.province_id=pr.province_id;

#Show how many patients have a birth_date with 2010 as the birth year.
select count(patient_id)
from patients
where Year(birth_date)=2010;

#Show the first_name, last_name, and height of the patient with the greatest height
select first_name,last_name,height
from patients
where height=(select max(height) from patients)

#Show all the columns from admissions where the patient was admitted and discharged on the same day.
select * from admissions
where admission_date=discharge_date;

#Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'
select first_name,last_name,allergies from patients
where allergies IS NOT NULL AND CITY='Hamilton';

#Intermediate Queries

#Show unique first names from the patients table which only occurs once in the list.
select first_name from patients
group by first_name
having count(first_name)=1


#Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
select patient_id,first_name from patients where 
first_name like 'S%s'
and len(first_name)>=6

#Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
SELECT p.patient_id,p.first_name,p.last_name FROM patients p join admissions ads
on p.patient_id=ads.patient_id
where ads.diagnosis='Dementia'

#Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
select 
    SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS male_count,
    SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS female_count
FROM
    patients;
   
#Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. 
#Show results ordered ascending by allergies then by first_name then by last_name.

select first_name,last_name,allergies from patients
where allergies in('Penicillin','Morphine')
order by allergies, first_name,last_name

#Show first name, last name and role of every person that is either patient or doctor. 
#The roles are either "Patient" or "Doctor"
SELECT first_name, last_name, 'Patient' AS role
FROM patients
UNION ALL
SELECT first_name, last_name, 'Doctor' AS role
FROM doctors;

#Show all allergies ordered by popularity. Remove NULL values from query.
select allergies , count(patient_id) as Popularity
from patients
where allergies is not null
group by allergies
order by Popularity desc ;


#Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
select first_name,last_name,birth_date from patients
where year(birth_date) between 1970 and 1979
order by birth_date;

#We want to display each patient's full name in a single column. 
#Their last_name in all upper letters must appear first, then first_name in all lower case letters. 
#Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
#EX: SMITH,jane
select concat(upper(last_name),',',lower(first_name)) from patients
order by first_name desc;

#Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
select max(weight)-min(weight) from patients
where last_name='Maroni'

#Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
select day(admission_date),count(*)
from admissions
group by day(admission_date)
order by count(*) desc;

#Show all columns for patient_id 542's most recent admission_date.
SELECT *
FROM admissions
WHERE patient_id = 542
AND admission_date = (
    SELECT MAX(admission_date)
    FROM admissions
    WHERE patient_id = 542
);


#Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
#1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
#2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.

select patient_id, attending_doctor_id,diagnosis
from admissions
where attending_doctor_id like '%2%' and len(patient_id)=3
or patient_id % 2<>0 and attending_doctor_id in (1,5,19);


#Show first_name, last_name, and the total number of admissions attended for each doctor.#
#Every admission has been attended by a doctor.
select d.first_name,d.last_name,count(ads.attending_doctor_id)
from doctors d join admissions ads
on d.doctor_id=ads.attending_doctor_id
group by first_name;



#For each doctor, display their id, full name, and the first and last admission date they attended.
select doctor_id, concat(first_name,' ',last_name)as full_name ,min(admission_date),max(admission_date)
from doctors join admissions
on doctor_id=attending_doctor_id
group by first_name;

#Display the total amount of patients for each province. Order by descending.
select province_name,count(patient_id) as Total_Patients
from patients join province_names
on patients.province_id=province_names.province_id
group by province_name
order by Total_Patients desc;


#For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
select concat(p.first_name,' ',p.last_name),ads.diagnosis,concat(d.first_name,' ',d.last_name)as Doctor_name
from patients p join admissions ads
on p.patient_id=ads.patient_id
join doctors d 
on d.doctor_id=ads.attending_doctor_id;


#display the first name, last name and number of duplicate patients based on their first name and last name.
SELECT first_name, last_name, COUNT(*) AS duplicate_count
FROM patients
GROUP BY first_name, last_name
HAVING COUNT(*) > 1;












