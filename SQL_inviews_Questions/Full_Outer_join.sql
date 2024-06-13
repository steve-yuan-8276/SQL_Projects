-- Preparation:
create table sources(
sid int,
sname varchar(50)
);
create table targets(
tid int,
tname varchar(50)
);
insert into sources values(1,'A'),(2,'B'),(3,'C'),(4,'D');
insert into targets values(1,'A'),(2,'B'),(4,'X'),(5,'F');
select * from sources;
select * from targets;

-- Question:
-- full outer join this two table first;
-- show results like above:
-- 3 new in source
-- 4 mismatched
-- 5 new in targets

select * from sources;
select * from targets;

-- Solution
with cte1 as (
    SELECT
        s.sid,
        s.sname,
        t.tid,
        t.tname
    FROM
        sources s full outer join targets t
        on s.sid = t.tid
), cte2 as (
    SELECT
        *,
        case
        when sid is not null and tid is null then 'new in source'
        when sid is null and tid is not null then 'new in targets'
        when sid = tid and sname <> tname then 'mismatched'
        else 'ok'
        end as review
    FROM
        cte1
)
SELECT
    coalesce(sid, tid) as id,
    review
FROM
    cte2
WHERE
    review <> 'ok';