use amazon_db;
# THREE TABLES ARE CUSTOMERS PRODUCTS AND ORDERS
select * from customers;
select * from orders;
select* from products;

# TABLE STRUCTURE
desc customers;
desc orders;
desc products;

# MERGED TABLE USE FOR ANALYSIS
select c.customer_Id,
		c.name,
        c.email,
        c.phone,
        c.city,
        c.state,
        c.gender,
        c.age,
        c.total_orders,
        o.order_Id,
        o.category,
        o.quantity,
        o.total_amount,
        o.payment_Mode,
        p.product_id,
        p.product_NAME ,
        p.unit_price,
        P.cost_PRICE,
        p.profit_margin,
        p.stock_quantity,
        (o.quantity*p.unit_price) as sales,
        ( o.quantity*p.cost_price) as cost,
        ( (o.quantity*p.unit_price)-(o.quantity*p.cost_price)) as profit
        from customers c
        join orders o
        on c.customer_id=o.customer_id
        join products p
        on o.product_id=p.product_id;
        
#ANALYSIS ON THIS THREE TABLES
# CUSTOMERS WITH THERE PAYMENT METHODS
 select c.name,o.payment_mode,o.order_id from customers c
 join orders o 
 on c.customer_id=o.customer_id;
 
 # COUNT OF CUSTOMERS FROM EACH STATE
  select count(customer_Id) as total_customers ,state  from customers
  group by state;
  
  # TOP 5  CUSTOMERS WITH HIGHEST lifetime value
  select *,dense_rank()  
  over(order by lifetime_value desc) as RANKING
   from customers
   limit 5;
  
  #  gender with most customers  
  select count(customer_id) as total_customer,gender from customers
  group by gender
  order by count(customer_id) desc;
  
  # TOP 5 MOST SENIOR CUSTOMERS FROM MUMBAI
  select * from customers
  where  city ="mumbai"
  ORDER BY AGE desc
  LIMIT 5;
  
  # TOP 5 CUSTOMER WITH MOST QUANTITY ORDERED
   select c.name,o.quantity,dense_rank()
   OVER( order by o.quantity desc) AS RANKING 
   from customers c
   join orders o
   on c.customer_Id=o.customer_id;
   
 # TOTAL ORDERS IN 2024 YEARS
 
 select count(order_id) as total_customers,year(order_date)  as year from orders
 where year(order_date)=2024
 group by year(order_date);
 
 # TOP 5 CUSTOMERS WHO GOT MOST DISCOUNT
 select c.name ,o.discount from customers c
 join orders o
 on c.customer_id=o.customer_id
 order by discount desc
 limit 5;
 
#CUSTOMERS FROM RAJASTHAN WITH NET BANKING PAYMENT MODE
 select c.name,c.state,o.payment_mode from customers c
 join orders o
 on c.customer_id=o.customer_id
 where c.state="rajasthan" and o.payment_mode="Net banking";
 
 # LIST OF GENZ CUSTOMERS
 select * from customers
 where Age between 19 and 29;
 


        
    
        
        
 
 
 
  
  
  
  
  
  
  