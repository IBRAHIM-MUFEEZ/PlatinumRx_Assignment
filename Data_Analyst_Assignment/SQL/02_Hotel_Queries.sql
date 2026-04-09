SELECT u.user_id, b.room_no
FROM users u
LEFT JOIN (
    SELECT user_id, room_no,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY booking_date DESC) AS rn
    FROM bookings
) b
ON u.user_id = b.user_id AND b.rn = 1;
-------------------------------------------------------------------------------------------------------------------

select b.booking_id , sum(bc.item_quantity * i.item_rate) AS total_billing_amount
from bookings b inner join booking_commercials bc on b.booking_id = bc.booking_id
inner join items i on bc.item_id = i.item_id
where year(b.booking_date) = 2021 and month(b.booking_date)=11
group by b.booking_id;
-----------------------------------------------------------------------------------------------------------------
select bc.bill_id , sum(bc.item_quantity * i.item_rate) As bill_amount
from booking_commercials bc inner join items i on bc.item_id = i.item_id
where year(bc.bill_date)=2021 and month(bc.bill_date)=10 group by bc.bill_id
having bill_amount >1000;

------------------------------------------------------------------------------------------------------


with monthly_items as (
    select 
        year(bc.bill_date) as bill_year,
        month(bc.bill_date) as bill_month,
        bc.item_id,
        i.item_name,
        sum(bc.item_quantity) as total_quantity,
        rank() over (partition by month(bc.bill_date) order by sum(bc.item_quantity) desc) as rank_most,
        rank() over (partition by month(bc.bill_date) order by sum(bc.item_quantity) asc) as rank_least
    from booking_commercials bc
    inner join items i on bc.item_id = i.item_id
    where year(bc.bill_date) = 2021
    group by bill_year, bill_month, bc.item_id, i.item_name
)
select 
    bill_month,
    'most ordered' as order_type,
    item_id,
    item_name,
    total_quantity
from monthly_items
where rank_most = 1

union all

select 
    bill_month,
    'least ordered' as order_type,
    item_id,
    item_name,
    total_quantity
from monthly_items
where rank_least = 1
order by bill_month, order_type;


---------------------------------------------------------------------------------------------------------------------------------
with customer_monthly_bills as (
    select 
        month(bc.bill_date) as month,
        u.user_id,
        u.name,
        sum(i.item_rate * bc.item_quantity) as total_bill,
        row_number() over (partition by month(bc.bill_date) order by sum(i.item_rate * bc.item_quantity) desc) as bill_rank
    from booking_commercials bc
    inner join bookings b on bc.booking_id = b.booking_id
    inner join users u on b.user_id = u.user_id
    inner join items i on bc.item_id = i.item_id
    where year(bc.bill_date) = 2021
    group by month(bc.bill_date), u.user_id, u.name
)
select 
    month,
    user_id,
    name,
    total_bill
from customer_monthly_bills
where bill_rank = 2
order by month;
