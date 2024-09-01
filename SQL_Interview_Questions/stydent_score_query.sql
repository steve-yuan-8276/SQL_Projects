-- Q: Student Score Query

-- Data Preparation
CREATE TABLE t_student (
    s_id INT COMMENT 'Student ID',
    s_name VARCHAR(20) COMMENT 'Student Name',
    s_gender INT COMMENT 'Student Gender 0-Male, 1-Female',
    s_birthday DATE COMMENT 'Date of Birth',
    s_hobby VARCHAR(100) COMMENT 'Hobbies',
    c_id INT COMMENT 'Class ID'
) COMMENT = 'Student Table';

CREATE TABLE t_class (
    c_id INT COMMENT 'Class ID',
    c_name VARCHAR(20) COMMENT 'Class Name'
) COMMENT = 'Class Table';

CREATE TABLE t_score (
    sc_id INT COMMENT 'Score ID',
    s_id INT COMMENT 'Student ID',
    course_name VARCHAR(20) COMMENT 'Course Name',
    score NUMERIC(10,0) COMMENT 'Score'
) COMMENT = 'Score Table';

INSERT INTO t_class VALUES (901, 'Class 1');
INSERT INTO t_class VALUES (902, 'Class 2');
INSERT INTO t_class VALUES (903, 'Class 3');
INSERT INTO t_class VALUES (905, 'Class 5');

INSERT INTO t_student VALUES (101, 'Luffy', 0, '1990-01-26', 'Eating meat, sleeping', 901);
INSERT INTO t_student VALUES (102, 'Nami', 1, '1995-10-05', 'Football, basketball', 901);
INSERT INTO t_student VALUES (103, 'Chopper', 0, '1992-08-11', 'Singing, eating meat', 901);
INSERT INTO t_student VALUES (104, 'Naruto', 0, '1991-03-29', 'Ramen, ninjutsu', 901);
INSERT INTO t_student VALUES (105, 'Kakashi', 1, '1989-05-10', 'Reading, eating meat', 902);
INSERT INTO t_student VALUES (106, 'Usopp', 1, '1988-02-02', 'Dancing, basketball', 902);
INSERT INTO t_student VALUES (107, 'Qiao Feng', 0, '1990-12-12', 'Running, badminton', 902);
INSERT INTO t_student VALUES (108, 'Duan Yu', 0, '1990-12-13', 'Eating meat, working overtime', 903);
INSERT INTO t_student VALUES (109, 'Xu Zhu', 1, '1991-01-22', 'Watching movies, traveling', 903);
INSERT INTO t_student VALUES (110, 'Yang Guo', 0, '2000-03-04', 'Traveling', 903);
INSERT INTO t_student VALUES (111, 'Linghu Chong', 0, '1997-03-04', 'Drinking', 904);

INSERT INTO t_score VALUES (1, 101, 'Mathematics', 39);
INSERT INTO t_score VALUES (2, 102, 'Mathematics', 20);
INSERT INTO t_score VALUES (3, 103, 'Mathematics', 54);
INSERT INTO t_score VALUES (4, 104, 'Mathematics', 38);
INSERT INTO t_score VALUES (5, 105, 'Mathematics', 70);
INSERT INTO t_score VALUES (6, 106, 'Mathematics', 15);
INSERT INTO t_score VALUES (7, 107, 'Mathematics', 75);
INSERT INTO t_score VALUES (8, 108, 'Mathematics', 84);
INSERT INTO t_score VALUES (9, 109, 'Mathematics', 87);
INSERT INTO t_score VALUES (10, 110, 'Mathematics', 67);
INSERT INTO t_score VALUES (11, 101, 'Chinese', 73);
INSERT INTO t_score VALUES (12, 102, 'Chinese', 71);
INSERT INTO t_score VALUES (13, 103, 'Chinese', 82);
INSERT INTO t_score VALUES (14, 104, 'Chinese', 83);
INSERT INTO t_score VALUES (15, 105, 'Chinese', 36);
INSERT INTO t_score VALUES (16, 106, 'Chinese', 87);
INSERT INTO t_score VALUES (17, 107, 'Chinese', 74);
INSERT INTO t_score VALUES (18, 108, 'Chinese', 19);
INSERT INTO t_score VALUES (19, 109, 'Chinese', 29);
INSERT INTO t_score VALUES (20, 110, 'Chinese', 26);
INSERT INTO t_score VALUES (21, 101, 'English', 55);
INSERT INTO t_score VALUES (22, 102, 'English', 24);
INSERT INTO t_score VALUES (23, 103, 'English', 38);
INSERT INTO t_score VALUES (24, 104, 'English', 82);
INSERT INTO t_score VALUES (25, 105, 'English', 12);
INSERT INTO t_score VALUES (26, 106, 'English', 15);
INSERT INTO t_score VALUES (27, 107, 'English', 50);
INSERT INTO t_score VALUES (28, 108, 'English', 68);
INSERT INTO t_score VALUES (29, 109, 'English', 77);
INSERT INTO t_score VALUES (30, 110, 'English', 19);

-- Q1: Query the information of students whose scores in all courses are greater than 50.
# method 1
select
    s_id,
    s_name
from
    t_student s1
where not exists (
    select
        1
    from
        t_score s2
    where s1.s_id = s2.s_id
    and s2.score <= 50
);

# method 2
select
    s_id,
    s_name
from
    t_student
where s_id not in (
    select
        s_id
    from
        t_score
    group by s_id
    having min(score) <= 50
);

-- Q2: Query student information with at least 2 courses scoring >= 60 points.
select
    s_id,
    s_name
from
    t_student
where s_id in (
    select
        s_id
    from
        t_score
    where score >= 60
    group by s_id
    having count(*) >= 2
    );

-- Q3: Query each student's personal information, class information, and all subject
-- scores, sorted in ascending order by class ID and descending order by course scores.

select
    st.s_id,
    st.s_name,
    st.s_gender,
    st.s_birthday,
    st.s_hobby,
    ts.c_id,
    ts.c_name,
    sc.course_name,
    sc.score
from
    t_student st left join t_class ts on st.c_id = ts.c_id
    left join t_score sc on st.s_id = sc.s_id
order by ts.c_id ASC , sc.score DESC;

select * from t_score;

-- Q4: Query the student ID, student name, class name, total score, and average score
-- for each student, sorted in ascending order by class name and descending order by
-- total score.
-- addition: The average score is greater than 60.
select
    st.s_id,
    st.s_name,
    ts.c_name,
    sum(sc.score) as total_score,
    round(avg(sc.score), 2) as avg_score
from
    t_student st left join t_class ts on st.c_id = ts.c_id
    left join t_score sc on st.s_id = sc.s_id
group by st.s_id, st.s_name, ts.c_name
having round(avg(sc.score), 2) > 60
order by ts.c_name ASC, sum(sc.score) DESC;

-- Q5: Query the information of all students whose math scores are higher than their
-- Chinese scores, along with their math and Chinese scores.
with cte as (
    select
        s_id,
        max(case when course_name = 'Mathematics' then score else null end) as math_score,
        max(case when course_name = 'Chinese' then score else null end) as chinese_score
    from
        t_score
    group by s_id
)

select
    st.s_id,
    st.s_name,
    st.s_gender,
    st.s_birthday,
    st.s_hobby,
    st.c_id,
    cte.math_score,
    cte.chinese_score
from
    t_student st left join cte
    on st.s_id = cte.s_id
    and math_score > chinese_score
where cte.math_score is not null
and cte.chinese_score is not null;

-- Q6: Query the information of students whose scores in English and Chinese are both
-- greater than 60.
with cte as (
    select
        s_id,
        max(case when course_name = 'English' then score else null end) as english_score,
        max(case when course_name = 'Chinese' then score else null end) as chinese_score
    from
        t_score
    group by s_id
)
select
    st.s_id,
    st.s_name,
    st.s_gender,
    st.s_birthday,
    st.s_hobby,
    st.c_id,
    cte.english_score,
    cte.chinese_score
from
    t_student st left join cte
    on st.s_id = cte.s_id
where
    cte.english_score > 60
    and cte.chinese_score > 60;

-- Q7: Query the student ID, student name, and average score of each student, sorted in
-- descending order by average score.
select
    st.s_id,
    st.s_name,
    round(avg(sc.score), 2) as avg_score
from
    t_student st left join t_score sc
    on st.s_id = sc.s_id
where sc.s_id is not null
group by st.s_id, st.s_name
order by round(avg(sc.score)) DESC;

-- Q8: Query the student with highest average score.
with cte as (
    select
        st.s_id,
        st.s_name,
        round(avg(score), 2) as avg_score
    from
        t_student st left join t_score sc
        on st.s_id = sc.s_id
    group by st.s_id, st.s_name
)

select
    s_id,
    s_name,
    avg_score
from
    cte
order by avg_score DESC
limit 1;

-- Q9: Information about students tied for the 3rd highest score.
with t1 as (
    select
        st.s_id,
        st.s_name,
        round(avg(score), 2) as avg_score
    from
        t_student st left join t_score sc
        on st.s_id = sc.s_id
    group by st.s_id, st.s_name
), t2 as (
    select
        s_id,
        s_name,
        avg_score,
        dense_rank() over (order by avg_score DESC) as rk
    from
        t1
)
select
    s_id,
    s_name,
    avg_score,
    rk
from
    t2
where
    rk = 3;
