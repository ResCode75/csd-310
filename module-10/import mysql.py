import mysql.connector
import dotenv
from dotenv import dotenv_values

secrets = dotenv_values(".env")

# Connect to database
config = {
    "user": secrets["USER"],
    "password": secrets["PASSWORD"],
    "host": secrets["HOST"],
    "database":secrets["DATABASE"],
    "raise_on_warnings": True
}
db = mysql.connector.connect(**config)
print(f"\n Databaseuser {config["user"]} connected to MYSQL on host {(config["host"])} with database {(config["database"])}")

cursor = db.cursor()

cursor.execute("SELECT * FROM transactions")
transactions = cursor.fetchall()

total = transactions[2]

for t in transactions: 
    cursor.execute("UPDATE transactions SET transaction_fee = {}".format(t)
    print("updated")