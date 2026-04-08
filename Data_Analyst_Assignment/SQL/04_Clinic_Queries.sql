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
select 
    month(cs.datetime) as month,
    sum(cs.amount) as revenue,
    coalesce(sum(e.amount), 0) as expense,
    sum(cs.amount) - coalesce(sum(e.amount), 0) as profit,
    case 
        when (sum(cs.amount) - coalesce(sum(e.amount), 0)) > 0 
        then 'profitable'
        else 'not-profitable'
    end as status
from clinic_sales cs
left join expenses e 
    on cs.cid = e.cid 
    and month(cs.datetime) = month(e.datetime)
    and year(e.datetime) = 2021
where year(cs.datetime) = 2021
group by month(cs.datetime)
order by month;
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