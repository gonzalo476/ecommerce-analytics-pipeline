import mysql.connector
from faker import Faker
import random
import json

fake = Faker()

# --- CONFIGURACIÓN ---
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root",
    database="ecommerce_analytics"
)
cursor = conn.cursor()

N_USERS = 1000
N_CATEGORIES = 50
N_PRODUCTS = 200
N_ORDERS = 10000

# -------------------------------------------
# CATEGORIES
# -------------------------------------------

print("Insertando categorías...")
for i in range(N_CATEGORIES):
    parent_id = random.randint(1, i) if i > 5 and random.random() > 0.2 else None
    cursor.execute(
        """
        INSERT INTO categories (category_name, parent_id)
        VALUES (%s, %s)
        """,
        (f"Category {i}", parent_id)
    )
conn.commit()

# -------------------------------------------
# USERS
# -------------------------------------------

print("Insertando usuarios...")
for i in range(N_USERS):
    referred_by = random.randint(1, i) if i > 10 and random.random() > 0.6 else None
    cursor.execute(
        """
        INSERT INTO users (email, full_name, registration_date, referrer_id, country_iso)
        VALUES (%s, %s, %s, %s, %s)
        """,
        (f"user_{i}@example.com", fake.name(), fake.date_time_between(start_date="-2y"), referred_by, "US")
    )
conn.commit()

# -------------------------------------------
# PRODUCTS
# -------------------------------------------

print("Insertando productos...")
for i in range(N_PRODUCTS):

    attributes = {
        "color": random.choice(["Red", "Blue", "Black", "White"]),
        "weight_kg": round(random.uniform(0.5, 5), 2),
        "warranty_months": random.randint(6, 24),
        "tags": ["new", "sale", "imported"]
    }

    cursor.execute(
        """
        INSERT INTO products (category_id, product_name, base_price, product_attributes)
        VALUES (%s, %s, %s, %s)
        """,
        (
            random.randint(1, N_CATEGORIES),
            f"Product SKU-{i}",
            round(random.uniform(10, 500), 2),
            json.dumps(attributes)
        )
    )
conn.commit()

# -------------------------------------------
# ORDERS (opcional)
# -------------------------------------------

print("Insertando órdenes...")
for i in range(N_ORDERS):
    cursor.execute(
        """
        INSERT INTO orders (user_id, order_date, total_amount)
        VALUES (%s, NOW(), %s)
        """,
        (random.randint(1, N_USERS), round(random.uniform(20, 500), 2))
    )

conn.commit()

cursor.close()
conn.close()

print("Proceso terminado.")
