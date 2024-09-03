-- Q: pivot_query

-- Data Preparation
create table if not exists st_score (
    id int auto_increment primary key,
    student_name varchar(50) not null,
    subject_name varchar(50) not null,
    score float not null
);

INSERT INTO st_score (student_name, subject_name, score) VALUES
('Alice', 'Math', 85.5),
('Alice', 'English', 92.0),
('Alice', 'Science', 78.0),
('Bob', 'Math', 74.5),
('Bob', 'English', 88.0),
('Bob', 'Science', 69.5),
('Charlie', 'Math', 91.0),
('Charlie', 'English', 85.0),
('Charlie', 'Science', 95.0),
('David', 'Math', 64.0),
('David', 'English', 72.0),
('David', 'Science', 81.5),
('Eve', 'Math', 88.5),
('Eve', 'English', 79.0),
('Eve', 'Science', 92.0);

-- review
select * from st_score;

-- Pivot : Rows becomes into columns
create table st_score_row_to_cols as
select
    student_name,
    max(case when subject_name = 'Math' then score else null end) as math_score,
    max(case when subject_name = 'English' then score else null end) as english_score,
    max(case when subject_name = 'Science' then score else null end) as science_score
from st_score
group by student_name;

-- Unpivot: Columns becomes into rows
create table st_score_cols_to_rows as (
    select student_name, 'Math' as subject_name, math_score as score from st_score_row_to_cols
    union
    select student_name, 'English' as subject_name, english_score as score from st_score_row_to_cols
    union
    select student_name, 'Science' as subject_name, science_score as score from st_score_row_to_cols
);