use ibrahimdb;
select sales_channel, sum(amount) as total_revenue
from clinic_sales
where year(datetime) = 2021
group by sales_channel;
------------------------------------------------------------
select uid, sum(amount) as total_spent
from clinic_sales
where year(datetime) = 2021
group by uid
order by total_spent desc
limit 10;
--------------------------------------------------------------------
WITH revenue AS (
    SELECT 
        cid,
        YEAR(datetime) AS yr,
        MONTH(datetime) AS mn,
        SUM(amount) AS total_revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    GROUP BY cid, yr, mn
),
expenses_cte AS (
    SELECT 
        cid,
        YEAR(datetime) AS yr,
        MONTH(datetime) AS mn,
        SUM(amount) AS total_expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY cid, yr, mn
)

SELECT 
    r.mn AS month,
    SUM(r.total_revenue) AS revenue,
    COALESCE(SUM(e.total_expense), 0) AS expense,
    SUM(r.total_revenue) - COALESCE(SUM(e.total_expense), 0) AS profit,
    CASE 
        WHEN SUM(r.total_revenue) - COALESCE(SUM(e.total_expense), 0) > 0 
        THEN 'profitable'
        ELSE 'not-profitable'
    END AS status
FROM revenue r
LEFT JOIN expenses_cte e 
    ON r.cid = e.cid AND r.yr = e.yr AND r.mn = e.mn
GROUP BY r.mn
ORDER BY r.mn;
-----------------------------------------------------

select *
from (
    select 
        cl.city,
        cl.cid,
        cl.clinic_name,
        sum(cs.amount) - coalesce(sum(e.amount), 0) as profit,
        rank() over (partition by cl.city order by 
                     sum(cs.amount) - coalesce(sum(e.amount), 0) desc) as rnk
    from clinics cl
    left join clinic_sales cs 
        on cl.cid = cs.cid 
        and year(cs.datetime) = 2021 
        and month(cs.datetime) = 11
    left join expenses e 
        on cl.cid = e.cid 
        and year(e.datetime) = 2021 
        and month(e.datetime) = 11
    group by cl.city, cl.cid, cl.clinic_name
) t
where rnk = 1;
----------------------------------------------------------------------------------------
select *
from (
    select 
        cl.state,
        cl.cid,
        cl.clinic_name,
        sum(cs.amount) - coalesce(sum(e.amount), 0) as profit,
        rank() over (partition by cl.state order by 
                     sum(cs.amount) - coalesce(sum(e.amount), 0) asc) as rnk
    from clinics cl
    left join clinic_sales cs 
        on cl.cid = cs.cid 
        and year(cs.datetime) = 2021 
        and month(cs.datetime) = 11
    left join expenses e 
        on cl.cid = e.cid 
        and year(e.datetime) = 2021 
        and month(e.datetime) = 11
    group by cl.state, cl.cid, cl.clinic_name
) t
where rnk = 2;