use Blinkit;
show tables;
select * from groccery;

select Item_Identifier from groccery;

select count(Item_Identifier) from groccery;

select max(Item_weight) from groccery;

select min(Item_weight) from groccery;

select avg(Item_weight) from groccery;

select count(Item_Fat_Content) from groccery where Item_Fat_Content="Low Fat";

select count(Item_Fat_Content) from groccery where Item_Fat_content="Regular";

select max(Item_mrp) from groccery;

select Item_Identifier , Item_Fat_Content ,Item_Type, Item_MRP from groccery where Item_Mrp>200;

select * from groccery where Item_Mrp  between 50 and 100;

select distinct Item_fat_content from groccery ;

select * from groccery order by item_mrp desc;

select * from groccery order by item_type asc;

select * from groccery where Item_type in ("dairy","meat");

select Distinct(Outlet_Size) from groccery;

select Item_Type,count(Item_type) from groccery 
group by Item_type
order by count(Item_type) desc;

select Outlet_Size , count(item_type) from groccery 
group by Outlet_Size
order by count(item_type) asc;

select Item_type, max(Item_MRP) from groccery 
group by Item_Type 
order by max(Item_MRP) desc;

select Item_type, min(Item_MRP) from groccery 
group by Item_Type 
order by min(Item_MRP);

select Outlet_Establishment_year , max(Item_mrp) from groccery 
group by Outlet_Establishment_Year 
order by max(Item_MRP);

create procedure fat()
select Item_type,Item_Fat_Content  ,sum(Item_outlet_sales)  
from groccery
where Item_Fat_Content in ('Low Fat','LF')
group by Item_Type, Item_Fat_Content ;

call fat();

#view
create view admin_dep as 
select * from staff where department="admin";