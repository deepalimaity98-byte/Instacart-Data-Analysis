import pandas as pd
import numpy as np

# load data
aisles = pd.read_csv("C:/Users/hp/Desktop/Instacart_Project/raw_data/aisles.csv")
departments = pd.read_csv("C:/Users/hp/Desktop/Instacart_Project/raw_data/departments.csv")
order_products = pd.read_csv("C:/Users/hp/Desktop/Instacart_Project/raw_data/order_products__prior.csv")
orders = pd.read_csv("C:/Users/hp/Desktop/Instacart_Project/raw_data/orders.csv")
products =  pd.read_csv("C:/Users/hp/Desktop/Instacart_Project/raw_data/products.csv")

# data overview : AISLES
print(aisles.head(10))
print(aisles.tail(10))
print(aisles.info())
print(aisles.describe())
print(aisles.isnull().sum())

# data overview : DEPARTMENTS
print(departments.head(10))
print(departments.tail(10))
print(departments.info())
print(departments.describe())
print(departments.isnull().sum())

# data overview :ORDER PRODUCTS
print(order_products.head(10))
print(order_products.tail(10))
print(order_products.info())
print(order_products.describe())
print(order_products.isnull().sum())  #TO CHECK NULL
print(order_products.duplicated().sum())

# data overview :ORDERS
print(orders.head(10))
print(orders.tail(10))
print(orders.info())
print(orders.describe())
print(orders.isnull()) 
print(orders.duplicated().sum())
print(orders.head(20))
print(orders.isnull().sum())
print(orders['user_id'].nunique())

# cleaning : ORDERS
filter = orders.fillna(0)
print(filter)
print(filter.isnull().sum().sum())
print(filter.duplicated().sum().sum())

# data overview : PRODUCTS
print(products.head(10))
print(products.tail(10))
print(products.info())
print(products.describe())
print(products.isnull().sum())  
print(products.duplicated().sum())


# PRODUCT MASTER TABLE(merging of products,aisles,departments)
products_full = (products.merge(aisles, on= 'aisle_id', how= 'left').
                 merge(departments, on= 'department_id', how= 'left')
)

pd.set_option('display.max_columns', None)   #show all columns
pd.set_option('display.width', None)

print(products_full.head())

# Quality check(loss of any row)
print(orders.shape)
print(order_products.shape)
print(products_full.shape)

# unique check
print(orders['order_id'].nunique())
print(products_full['product_id'].nunique())
print(order_products['order_id'].nunique())

print(orders.duplicated())
print(products_full.duplicated().sum())
print(order_products.duplicated().sum())

# export clean data (for sql)
filter.to_csv("C:/Users/hp/Desktop/Instacart_Project/cleaned_data/orders.csv", index= False)
order_products.to_csv("C:/Users/hp/Desktop/Instacart_Project/cleaned_data/order_products_clean.csv", index= False)
products_full.to_csv("C:/Users/hp/Desktop/Instacart_Project/cleaned_data/products_clean.csv",index=False)