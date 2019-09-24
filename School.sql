-- drop database  if exists  school;
-- CREATE DATABASE school;
-- -----------------------------------DDL-------------------------------------
drop table if exists  prof_std;
drop table if exists  student;
drop table if exists  professor;
drop table if exists  person_;
drop table if exists  office;
drop table if exists  class_room;
drop table if exists  building;

----------------------------------creating types---------------------------------------
drop type if exists age;
drop type if exists classes;
drop type if exists date_built;
drop type if exists full_name_;
drop type if exists location;
drop type if exists meeting_time;
drop type if exists qualification;

-------------------full name type consists of first_name, mid_name and last_name-------------------------
create type full_name_ as (
        first_name varchar(255),
        mid_name varchar(100),
        last_name varchar(255)
    );

----------------------age consists of year, months and days----------------------------------------------
create type age as (
    total_year int,
    total_months int,
    total_days int
    );


-------------------qualification type consists of is_master, is_phd, number_of_publications ad experience_time---
create type  qualification as (
    is_master boolean,
    is_phd boolean,
    number_of_publications int,
    experience_time int
    );

----------------meeting time consists of starting time to end time-----------------------------------------------
create type meeting_time as (
    from_ time,
    to_ time
    );

------------classes type consists of name of three class---------------------------------------------------------
create type classes as (
    class_1 varchar(255),
    class_2 varchar(255),
    class_3 varchar(255)
    );

------------date_built consists of year, month and day----------------------------------------------------------
create type date_built as (
    year int,
    month int,
    day int
    );

----------location consists of x and y which represent the position -------------------------------------------
create type location as (
    x float8,
    y float8
    );


-----------------------------------------------creating tables ------------------------------------------------

-----------Person table which is the parent of Professor and Student-------------------------------------------
create table person_(
    name full_name_,
    age age
);

---------Building which is the parent of class room and office------------------------------------------------
create table building(
    date_built date_built,
    location location,
    name varchar(255)
);

-------Class room is the child of building table-------------------------------------------------------------
create table class_room(
    id bigserial primary key ,
    capacity int
) inherits (building);

------Office is the child of building table------------------------------------------------------------------
create table office(
    office_id bigserial primary key,
    type char
) inherits (building);

-----Professor is the child of Person ----------------------------------------------------------------------
create table professor (
    professor_id bigserial primary key,
    qualification qualification,
    office_id int,
    meeting_time meeting_time,
    classes classes,
    constraint  professor_office foreign key (office_id) references office(office_id)
) INHERITS (person_);

------Student is the type of Person--------------------------------------------------------------------------
create table student (
    student_id bigserial primary key,
    grade int,
    section char,
    class_room int,
    hostel varchar(255),
    constraint student_class_room foreign key (class_room) references class_room(id)
) INHERITS (person_);

--professor and student relationship
create table prof_std (
    id bigserial,
    professor_id bigint,
    student_id bigint,
    constraint  rel_professor_fk foreign key (professor_id) references professor(professor_id),
    constraint rel_student_fk foreign key (student_id) references  student(student_id)
);


--------------------------------------Insertion------------------------------------------------

-------------------------------------Populating office-----------------------------------------
insert into office(date_built, location, name, type) values ((2015, 11, 25), (500, 400), 'B001', 'A');
insert into office(date_built, location, name, type) values ((2012, 10, 15), (500, 450), 'B002', 'A');
insert into office(date_built, location, name, type) values ((2011, 2, 21), (500, 500), 'B003', 'B');
insert into office(date_built, location, name, type) values ((2010, 12, 3), (500, 550), 'B004', 'C');
insert into office(date_built, location, name, type) values ((2013, 3, 28), (500, 600), 'B005', 'C');

-------------------------------------Populating class room-----------------------------------------
insert into class_room(date_built, location, name, capacity) values ((2015, 11, 15), (800, 400), 'C001', 50);
insert into class_room(date_built, location, name, capacity) values ((2015, 10, 2), (800, 450), 'C002', 45);
insert into class_room(date_built, location, name, capacity) values ((2015, 1, 29), (800, 500), 'C003', 55);
insert into class_room(date_built, location, name, capacity) values ((2015, 3, 31), (800, 550), 'C005', 40);
insert into class_room(date_built, location, name, capacity) values ((2015, 6, 3), (800, 600), 'C006', 50);
insert into class_room(date_built, location, name, capacity) values ((2015, 8, 7), (800, 650), 'C007', 55);

-------------------------------------Populating professor-----------------------------------------
insert into professor(name, age, qualification, office_id, meeting_time, classes)
values (('George', 'Gordon', 'Brown'), (47, 11, 23), (true, true, 12, 20), 1, (time '12:00', time '01:00'), ('C001', 'C002', 'C006'));

insert into professor(name, age, qualification, office_id, meeting_time, classes)
values (('Peter', 'Dwayne', 'White'), (51, 2, 3), (true, true, 18, 25), 2, (time '12:00', time '01:00'), ('C005', 'C006', 'C007'));

insert into professor(name, age, qualification, office_id, meeting_time, classes)
values (('Junior', 'Neaten', 'Brown'), (30, 11, 23), (true, false, 1, 5), 5, (time '12:00', time '01:00'), ('C002', 'C004', 'C006'));


-------------------------------------Populating student-----------------------------------------
insert into student(name, age, grade, section, class_room, hostel)
values (('Wood', 'Jack', 'N'), (18, 2, 5), 13, 'B', 1, 'Boys Hostel 1');

insert into student(name, age, grade, section, class_room, hostel)
values (('William', 's', 'Sons'), (17, 2, 5), 13, 'A', 1, 'Boys Hostel 2');

insert into student(name, age, grade, section, class_room, hostel)
values (('Ein', 's', 'Stein'), (16, 2, 5), 12, 'B', 2, 'Boys Hostel 3');

insert into student(name, age, grade, section, class_room, hostel)
values (('Wood', 'Stark', 'N'), (15, 12, 30), 12, 'B', 2, 'Boys Hostel 3');

insert into student(name, age, grade, section, class_room, hostel)
values (('Jon', 's', 'Don'), (17, 2, 21), 13, 'A', 1, 'Boys Hostel 1');

----------------Professor student relationship---------------------------

insert into prof_std(professor_id, student_id) values (1, 1);
insert into prof_std(professor_id, student_id) values (1, 2);
insert into prof_std(professor_id, student_id) values (1, 5);
insert into prof_std(professor_id, student_id) values (3, 3);
insert into prof_std(professor_id, student_id) values (3, 3);


---------------------------------------------------Basic Operations------------------------------------------------
--all students
select * from student;

--all students having grade 13
select  * from student where grade = 13;

-- all professors which are pHD doctors
select  * from professor where (qualification).is_phd = true;

-- all professor which are not doctor
select * from professor where (qualification).is_phd = false;

-- all building
select * from building;

-- all building which are built before 2013
select * from building where (date_built).year < 2013;

-- all students of professor having id 1
select * from student
inner join prof_std ps on student.student_id = ps.student_id
inner join professor p on ps.professor_id = p.professor_id
where p.professor_id = 1;

