select * from classicmodels.customer_views;
select * from customer_views;

create or replace view customer_views as
select customerNumber, customerName, contactFirstName, contactLastName, phone
from customers
where city = 'Nantes';

drop view customer_views;