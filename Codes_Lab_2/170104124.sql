SET VERIFY OFF;
SET SERVEROUTPUT ON;

/* Question: If there exists any student who didn't enroll in any course,
then student will enroll in the course where total no of unique enrolled student >= 2 */

DECLARE
course_id course.cnum%TYPE;
dismiss_student_no student.snum%TYPE;
total_no_of_dismiss_student student.snum%TYPE;
BEGIN	
	-- Find the Minimum No. of enrolled courses by the No. of unique students >= 2
	-- and store The least enrolled course no. to the variable
	
	select MIN(course.cnum) into course_id from student
	inner join enrolled on enrolled.snum = student.snum
	inner join course on course.cnum=enrolled.cnum
	group by course.cnum,course.cname having count(distinct student.snum)>=2
	order by count(course.cnum);
	
	-- No of students who didn't enroll in any course
	
	select COUNT(DISTINCT student.snum) into total_no_of_dismiss_student from student
	where student.snum not in (select e.snum from enrolled e);
	
	IF total_no_of_dismiss_student>0 THEN
		FOR i IN 1..total_no_of_dismiss_student LOOP
		
			-- student num who didn't enroll in any course
			select MIN(DISTINCT student.snum) into dismiss_student_no from student
			where student.snum not in (select e.snum from enrolled e)
			order by student.snum;
			
			-- make enrollment to the course where enrolled student no >= given i/p
			insert into enrolled values(dismiss_student_no,course_id);
			
			DBMS_OUTPUT.PUT_LINE('Student No: '||dismiss_student_no||' Enrolled course id: '||course_id);
		END LOOP;
		
	ELSE
		DBMS_OUTPUT.PUT_LINE('No of dismissed student: '||total_no_of_dismiss_student);
	END IF;
END;
/
commit;

select student.snum,student.sname from student
inner join enrolled on enrolled.snum = student.snum
inner join course on course.cnum=enrolled.cnum
group by student.snum,student.sname having count(student.snum)=1
order by student.snum;
