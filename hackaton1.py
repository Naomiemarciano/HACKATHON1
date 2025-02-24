import psycopg2
import re
import requests

# ExchangeRate-API key (replace with your actual key)
API_KEY = 'YOUR_API_KEY_HERE'  # Replace with your valid API key
BASE_CURRENCY = 'ILS'

# Connect to the database with error handling
def connect_to_db():
    try:
        conn = psycopg2.connect(
            dbname='HAckathon1',
            user='postgres',
            password='1973',
            host='localhost',
            port='5432'
        )
        return conn
    except psycopg2.Error as e:
        print(f"Connection error: {e}")
        exit()

# Retrieve data from the database
def get_data(query, params=None):
    try:
        conn = connect_to_db()
        cur = conn.cursor()
        cur.execute(query, params or ())
        results = cur.fetchall()
        cur.close()
        conn.close()
        return results
    except psycopg2.Error as e:
        print(f"Query execution error: {e}")
        return []

# Fetch and cache conversion rates
conversion_rates = {}

def get_conversion_rate(target_currency):
    if target_currency == BASE_CURRENCY:
        return 1

    if target_currency in conversion_rates:
        return conversion_rates[target_currency]

    try:
        url = f"https://v6.exchangerate-api.com/v6/{API_KEY}/latest/{BASE_CURRENCY}"
        response = requests.get(url)
        data = response.json()

        if response.status_code == 200 and 'conversion_rates' in data:
            conversion_rates.update(data['conversion_rates'])
            return conversion_rates.get(target_currency, 1)
        else:
            print("Failed to fetch rates. Using default.")
            return 1
    except Exception as e:
        print(f"API error: {e}")
        return 1

# Currency symbol mapping
def get_currency_symbol(currency_code):
    return {"ILS": "₪", "USD": "$", "EUR": "€", "GBP": "£"}.get(currency_code, "₪")

# Basket and currency setup
basket = []
selected_currency = 'ILS'

def select_currency():
    global selected_currency
    print("\nAvailable Currencies: ILS (Default), USD, EUR, GBP")
    choice = input("Enter currency code (or press Enter for ILS): ").upper().strip()
    if choice in ["USD", "EUR", "GBP", "ILS"]:
        selected_currency = choice
        print(f"Currency set to {selected_currency}.")
    else:
        print("Invalid choice. Defaulting to ILS.")

# User authentication
def authenticate_user():
    print("\n1. Log In\n2. Sign Up\n3. Continue as Guest")
    choice = input("Choose an option: ")

    if choice == '1':
        return login_user()
    elif choice == '2':
        return sign_up_user()
    elif choice == '3':
        print("Guest mode activated.")
        return None
    else:
        print("Invalid choice.")
        return authenticate_user()

def login_user():
    user_input = input("Username or email: ")
    password = input("Password: ")

    conn = connect_to_db()
    cur = conn.cursor()
    query = "SELECT * FROM users WHERE (LOWER(email)=LOWER(%s) OR LOWER(username)=LOWER(%s)) AND password=%s"
    cur.execute(query, (user_input, user_input, password))
    user = cur.fetchone()
    cur.close()
    conn.close()

    if user:
        print(f"Welcome, {user[1]}!")
        return user
    print("Incorrect credentials.")
    return None

def sign_up_user():
    username = input("Username: ")
    email = input("Email: ")
    password = input("Password: ")

    conn = connect_to_db()
    cur = conn.cursor()
    try:
        cur.execute("INSERT INTO users (username, email, password) VALUES (%s, %s, %s)", (username, email, password))
        conn.commit()
        print(f"Account created! Welcome, {username}.")
    except psycopg2.Error as e:
        print(f"Error: {e}")
    finally:
        cur.close()
        conn.close()

# Basket functions
def view_basket():
    if not basket:
        print("\nYour basket is empty.")
        return

    rate = get_conversion_rate(selected_currency)
    symbol = get_currency_symbol(selected_currency)

    print("\nYour Basket:")
    total = 0
    for idx, (name, color, size, price) in enumerate(basket, 1):
        converted_price = round(price * rate, 2)
        total += converted_price
        print(f"{idx}. {name} - Color: {color}, Size: {size}, Price: {converted_price} {symbol}")

    print(f"Total: {round(total, 2)} {symbol}")

def add_to_basket(name, color, size, price):
    basket.append((name, color, size, price))
    print(f"Added {name} (Color: {color}, Size: {size}) to basket.")

def remove_from_basket():
    if not basket:
        print("No items to remove.")
        return

    view_basket()
    choice = input("Enter item number to remove (or press Enter to cancel): ")

    if choice.isdigit() and 1 <= int(choice) <= len(basket):
        removed = basket.pop(int(choice)-1)
        print(f"Removed {removed[0]} from basket.")
    else:
        print("No item removed.")

# Category & product functions
def display_categories():
    categories = get_data("SELECT categorie_id, categorie_name FROM categories")
    print("\nCategories:")
    for idx, (_, name) in enumerate(categories, 1):
        print(f"{idx}. {name}")
    return categories[int(input("Choose category: ")) - 1][0]

def display_product_types(category_id):
    query = """
        SELECT DISTINCT tp.type_name
        FROM types_of_product tp
        JOIN product_types pt ON tp.type_id = pt.type_id
        JOIN product_categories pc ON pt.product_id = pc.product_id
        WHERE pc.category_id = %s
    """
    types = get_data(query, (category_id,))
    print("\nProduct Types:")
    for idx, (t,) in enumerate(types, 1):
        print(f"{idx}. {t}")
    return types[int(input("Choose type: ")) - 1][0]

def select_size(product_id):
    sizes = get_data("""
        SELECT s.size_name FROM product_sizes ps
        JOIN sizes s ON ps.size_id = s.size_id
        WHERE ps.product_id = %s
    """, (product_id,))

    if sizes:
        print("\nSizes:")
        for idx, (size,) in enumerate(sizes, 1):
            print(f"{idx}. {size}")
        return sizes[int(input("Choose size: ")) - 1][0]
    return "Not specified"

def display_and_add_to_basket(category_id, product_type):
    rate = get_conversion_rate(selected_currency)
    symbol = get_currency_symbol(selected_currency)

    products = get_data("""
        SELECT ms.article_id, ms.name_of_article, ms.price
        FROM my_store ms
        JOIN product_types pt ON ms.article_id = pt.product_id
        JOIN product_categories pc ON ms.article_id = pc.product_id
        JOIN types_of_product tp ON pt.type_id = tp.type_id
        WHERE pc.category_id = %s AND tp.type_name = %s
    """, (category_id, product_type))

    if not products:
        print("No products found.")
        return

    print("\nProducts:")
    for idx, (pid, name, price) in enumerate(products, 1):
        print(f"{idx}. {name} - {round(price * rate, 2)} {symbol}")

    selected = products[int(input("Choose product: ")) - 1]
    size = select_size(selected[0])
    add_to_basket(selected[1], "N/A", size, selected[2])

# Payment process
def payment_process():
    if not basket:
        print("Basket empty.")
        return

    rate = get_conversion_rate(selected_currency)
    symbol = get_currency_symbol(selected_currency)
    total = round(sum(price * rate for *_, price in basket), 2)

    print(f"\nTotal: {total} {symbol}")
    print("1. Credit Card\n2. Cash on Delivery")
    method = input("Payment method: ")

    if method == '1':
        card = input("16-digit card: ")
        while not (card.isdigit() and len(card) == 16):
            card = input("Invalid. Retry: ")

        expiry = input("Expiry (MM/YY): ")
        while not re.match(r"^(0[1-9]|1[0-2])/\d{2}$", expiry):
            expiry = input("Invalid format. Retry: ")

        cvv = input("3-digit CVV: ")
        while not (cvv.isdigit() and len(cvv) == 3):
            cvv = input("Invalid CVV. Retry: ")

        print("Payment successful!")
    elif method == '2':
        print("Cash on delivery selected.")
    else:
        print("Invalid choice.")

# Main application loop
def main():
    select_currency()
    authenticate_user()

    while True:
        print("\nOptions:")
        print("1. Shop Products")
        print("2. View Basket")
        print("3. Remove Item from Basket")
        print("4. Checkout")
        print("5. Exit")

        choice = input("Choose option: ")

        if choice == '1':
            cat_id = display_categories()
            p_type = display_product_types(cat_id)
            display_and_add_to_basket(cat_id, p_type)
        elif choice == '2':
            view_basket()
        elif choice == '3':
            remove_from_basket()
        elif choice == '4':
            payment_process()
            break
        elif choice == '5':
            print("Goodbye!")
            break
        else:
            print("Invalid option.")

if __name__ == "__main__":
    main()
