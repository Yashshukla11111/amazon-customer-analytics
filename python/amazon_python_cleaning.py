
# data loading
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import mysql.connector

conn=mysql.connector.connect(
    host="localhost",
    user="root",
    password="2006",
    database="amazon_db"

)

query="select * from customers"
customers=pd.read_sql_query(query,conn)

print (customers)

# data inspection of customers table

print(customers.info())
print(customers.describe())
print(customers.isnull().sum())
customers.dtypes

query="select * from orders"
orders=pd.read_sql_query(query,conn)
print(orders)

# data inspection of orders table
print(orders)
print(orders.info())
print(orders.describe())
print(orders.isnull().sum())
orders.dtypes

query="select * from products"
products=pd.read_sql_query(query,conn)

print(products)
# data inspection of products table
print(products.info())
print(products.describe())
print(products.isnull().sum())
products.dtypes


query='''select c.customer_Id,
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
        on o.product_id=p.product_id;'''

merged_table=pd.read_sql_query(query,conn)
print(merged_table)