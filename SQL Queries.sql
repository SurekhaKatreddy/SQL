-- join, where, union-like, nested, group by, and having.
-----------------------------------------
-- fetch the menu items in a given order.
-----------------------------------------
select mnu.name,mnu.price
from 
p_orderitem itm 
inner join p_menu mnu on mnu.id = itm.menu_id
where itm.order_id = :1 ;

-----------------------------------------
-- returns list the menu items with their rating
-----------------------------------------
select name, rating
from p_orderitem ord
inner join p_menu mnu on ord.menu_id = mnu.id;


-----------------------------------------
-- find staff and the number of hours worked 
-- on a particular date
-----------------------------------------
select s.staff_id,(s.shift_end_time-s.shift_start_time) * 24 hoursworked
from p_schedule s
where 
trunc(s.shift_start_time) = to_date(:1)
and 
trunc(s.shift_end_time) = to_date(:1);

-----------------------------------------
-- Find the customer who ordered item1 but not item2
-----------------------------------------
select ord.id, ord.customer_id,
firstname || ' ' || lastname  CustomerName
from 
p_order ord 
inner join p_orderitem itm on ord.id = itm.order_id
inner join p_menu mnu on mnu.id = itm.menu_id
inner join p_customer c on c.id = ord.customer_id
where mnu.name = :item1
minus
select ord.id, ord.customer_id,
firstname || ' ' || lastname  CustomerName
from 
p_order ord 
inner join p_orderitem itm on ord.id = itm.order_id
inner join p_menu mnu on mnu.id = itm.menu_id
inner join p_customer c on c.id = ord.customer_id
where mnu.name = :item2;

-----------------------------------------
-- find customers who ordered all items
-----------------------------------------
SELECT DISTINCT c.id, c.firstname || ' ' ||c.lastname
FROM 
p_customer c
inner join p_order o on c.id = o.customer_id
WHERE NOT  EXISTS 
              ((SELECT  m.id
                 FROM  p_menu m)
                MINUS 
                 (SELECT  i.menu_id
                  FROM  p_orderitem i
                  WHERE  i.order_id = o.id));
                  
-----------------------------------------
-- what is the most frequently ordered item 
-----------------------------------------
with order_itm_count as
(
select name, count(0) frequency
from p_orderitem ord
inner join p_menu mnu on ord.menu_id = mnu.id
group by mnu.name 
)
select name from order_itm_count where 
frequency = 
(select max(frequency) from order_itm_count);


-----------------------------------------
-- find the tip paid per order with order 
-- having order having highest tip at the top
-----------------------------------------
select o.id,
sum(p.total_paid)-sum(i.quantity * m.price) Tip
from p_payment p
inner join p_order o on p.order_id = o.id
inner join p_orderitem i on i.order_id = o.id
inner join p_menu m on m.id = i.menu_id
group by o.id
order by 2 desc;

-----------------------------------------
-- List all the seating arrangements along tables 
-- list that can accomodate minimum of 8 customers
-----------------------------------------
select seating_id , LISTAGG (table_no, ',') as tables_in_a_seating_arrangemnt, sum(t.number_of_seats)
from p_seating s
inner join p_seatmap sm on s.id = sm.seating_id
inner join p_table_list t on sm.table_no = t.id
group by seating_id
having sum(t.number_of_seats) >= 8;


-----------------------------------------                                 
-- List order ids in the order of the total bill  desc
-----------------------------------------
select items.order_id, sum(items.quantity * mnu.price)
from p_orderitem items
inner join p_menu mnu on items.menu_id = mnu.id
inner join p_payment p on p.order_id = items.order_id
group by items.order_id, p.order_id
order by 2 desc;

-- data model : concepts for describing data
-- schema : description of a particular collection of data
-- MS Excel spreadsheet , MS Access, File Cabinet, CSV
-- Operational (DBMS) vs. Warehouse DB
-- Where are FACT and dimension tables used? Star, SnowFlake and Fact constellation
-- 4th and 5th normal forms - where are they used?
-- Data warehouse vs Data mart?
-- Data Cubes ?
-- We used bottom-up design. Where is top-down strategy used?
-- What is the minimum score required for A?
-- Can we get access to define stored procedure / triggers / functions?
-- Exam - all question have same weightage? multiple choice with many answers?
-- Where does UML diagrams come into picture?
-- 