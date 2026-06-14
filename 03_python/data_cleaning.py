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

# TABLE MEARGING 
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
        o.order_date,
        o.delivery_date,
        o.Discount,
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

merged_table.columns=merged_table.columns.str.lower().str.strip()


# DATA CELANING 

# MERGED DATA INSPECTION
print(merged_table.info())
print(merged_table.describe())
print(merged_table.isnull().sum())
print(merged_table.duplicated().sum())

#DATA TYPE CORRECTION
merged_table["phone"]=merged_table["phone"].astype(str)
merged_table["order_date"]=pd.to_datetime(merged_table["order_date"],errors="coerce")
merged_table["delivery_date"]=pd.to_datetime(merged_table["delivery_date"],errors="coerce")

# DEFINING COLUMS
id_colums=["customer_id","order_id","product_id"]
text_colums=["phone","name","product_name","email","payment_mode"]
integer_colums=["total_order","quantity","total_amount","unit_price",      
                "cost_price","profit_margin","age","stock_quantity"]
caregorical_colums=["city","state","gender","category"]
merged_table ["discount_percentage"]=merged_table["discount"]*100

# clean and merge data storage in sql

from sqlalchemy import create_engine

engine = create_engine("mysql+pymysql://root:2006@localhost/amazon_db")

merged_table.to_sql(
    name="merged_table",
    con=engine,
    if_exists="replace",
    index=False
)

print("merged_table successfully stored in MySQL")          




