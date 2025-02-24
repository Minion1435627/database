select '1435627' as StuID, event5627.*
from event5627;

-- Q1 
select '1435627' as StuID, event5627.code, event5627.name, eventoccurrence5627.state, 
		year (eventoccurrence5627.startdate) as year
from event5627
inner join eventoccurrence5627
on event5627.code = eventoccurrence5627.eventcode
where eventoccurrence5627.state = 'VIC' or state = 'TAS'
order by event5627.name, eventoccurrence5627.state;

-- Q2 
select '1435627' as StuID, staff5627.staffID, 
		concat(staff5627.lastname, ', ' ,staff5627.firstname) as full_name,
		eventcommittee5627.role, event5627.name, eventoccurrence5627.occurrenceID, eventoccurrence5627.startdate
from staff5627
inner join eventcommittee5627
inner join eventoccurrence5627
inner join event5627
on staff5627.staffID = eventcommittee5627.staffID
and eventcommittee5627.eventoccurrenceID = eventoccurrence5627.occurrenceID
and eventoccurrence5627.eventcode = event5627.code
having full_name = 'Martin, Danielle'
order by event5627.name, eventoccurrence5627.startdate desc;

-- Q3
select '1435627' as StuID, participant5627.state, participant5627.gender, 
		count(participant5627.gender) as NumOfParticiapnts
from participant5627
group by participant5627.state, participant5627.gender
order by participant5627.state, NumOfParticiapnts desc;


-- Q4
select '1435627' as StuID, staff5627.staffID, 
		concat(staff5627.lastname, ', ' ,staff5627.firstname) as full_name,
		count(eventcommittee5627.eventoccurrenceID) as NumOfCommittees
from staff5627
inner join eventcommittee5627
on staff5627.staffID = eventcommittee5627.staffID
group by staff5627.staffID, full_name
having NumOfcommittees >= 6
order by NumOfcommittees;

-- Q5
select distinct '1435627' as StuID, participant5627.personID, participant5627.name
from participant5627
inner join results5627
inner join eventoccurrence5627
on participant5627.personID = results5627.participant
and results5627.event = eventoccurrence5627.occurrenceID
where  year(eventoccurrence5627.startDate) = 2022
having participant5627.personID not in 
	(select participant5627.personID
	from participant5627
	inner join results5627
	inner join eventoccurrence5627
	on participant5627.personID = results5627.participant
	and results5627.event = eventoccurrence5627.occurrenceID
	where year(eventoccurrence5627.startDate) = 2023 )
order by participant5627.personID;



-- Q6
select '1435627' as StuID, eventoccurrence5627.occurrenceID, event5627.name, 
		eventoccurrence5627.startdate, 
        count(results5627.participant) as NumOfParticiapnts
from eventoccurrence5627
inner join event5627
inner join results5627
on eventoccurrence5627.eventcode = event5627.code
and eventoccurrence5627.occurrenceID = results5627.event
where eventoccurrence5627.startdate > '2024-5-5'
group by eventoccurrence5627.occurrenceID, event5627.name, eventoccurrence5627.startdate
order by NumOfParticiapnts desc;

-- Q7
select distinct '1435627' as StuID, concat(staff5627.lastname, ', ' ,staff5627.firstname) as full_name, 
		staff5627.email, event5627.name, eventcommittee5627.role
from staff5627
inner join eventcommittee5627
inner join eventoccurrence5627
inner join event5627
on staff5627.staffID = eventcommittee5627.staffID
and eventcommittee5627.eventoccurrenceID = eventoccurrence5627.occurrenceID
and eventoccurrence5627.eventcode = event5627.code
where eventcommittee5627.role = 'chair' and event5627.name = 'Solving sudoku' 
union
select distinct '1435627' as StuID, concat(staff5627.lastname, ', ' ,staff5627.firstname) as full_name, 
		staff5627.email, event5627.name, eventcommittee5627.role
from staff5627
inner join eventcommittee5627
inner join eventoccurrence5627
inner join event5627
on staff5627.staffID = eventcommittee5627.staffID
and eventcommittee5627.eventoccurrenceID = eventoccurrence5627.occurrenceID
and eventoccurrence5627.eventcode = event5627.code
where eventcommittee5627.role = 'chair' and event5627.name = 'Game programming' 
order by full_name;

-- Q8
select distinct '1435627' as StuID, eventoccurrence5627.occurrenceID as event, 
		year(eventoccurrence5627.startdate) as Event_year, 
		event5627.name, participant5627.TShirtSize, 
        count(participant5627.personID) as No_Of_Tshirts
from eventoccurrence5627
inner join event5627
inner join results5627
inner join participant5627
on eventoccurrence5627.eventcode = event5627.code
and eventoccurrence5627.occurrenceID = results5627.event
and results5627.participant = participant5627.personID
group by eventoccurrence5627.occurrenceID, year(eventoccurrence5627.startdate) , event5627.name, 
		participant5627.TShirtSize
order by eventoccurrence5627.occurrenceID, participant5627.TShirtSize;

-- Q9
select '1435627' as StuID, participant5627.personID, participant5627.name, event5627.name as event_name
from eventoccurrence5627
inner join event5627
inner join results5627
inner join participant5627
on eventoccurrence5627.eventcode = event5627.code
and eventoccurrence5627.occurrenceID = results5627.event
and results5627.participant = participant5627.personID
where event5627.name = 'Game Programming'
and year(eventoccurrence5627.startdate) in (year(now())-1, year(now())-2) 
group by participant5627.personID, participant5627.name, event5627.name
having count(participant5627.personID) >= 2
order by participant5627.name;


-- Q10
select '1435627' as StuID, event5627.code, event5627.name, 
		event5627.category, count(participant5627.personID) as NumOfParticiapnts
from event5627
inner join eventoccurrence5627
inner join results5627
inner join participant5627
on eventoccurrence5627.eventcode = event5627.code
and eventoccurrence5627.occurrenceID = results5627.event
and results5627.participant = participant5627.personID
where event5627.category like 'physical%'
group by event5627.code, event5627.name, event5627.category
order by NumOfParticiapnts;

-- Q11
create view my_view as
select agecategory5627.description, count(participant5627.personID) as NumOfParticiapnts
from agecategory5627
inner join participant5627
on agecategory5627.catID = participant5627.agecategory
group by agecategory5627.description
order by NumOfParticiapnts;

select *
from my_view;

select '1435627' as StuID, agecategory5627.description, 
		count(participant5627.personID) as NumOfParticiapnts
from agecategory5627
inner join participant5627
on agecategory5627.catID = participant5627.agecategory
group by agecategory5627.description
order by NumOfParticiapnts
limit 1;









 







 















