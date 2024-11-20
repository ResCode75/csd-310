#Rachel Shaw - 6.2 assignment - 11/20/2024

import mysql.connector
from mysql.connector import errorcode

config = {
    "user": "movies_user",
    "password": "*Jackfrost75",
    "host": "127.0.0.1",
    "database": "movies",
    "raise_on_warnings": True
}

try:
    db = mysql.connector.connect(**config)
    print(f"\n Databaseuser {config["user"]} connected to MYSQL on host {(config["host"])} with database {(config["database"])}")

    input("\n\n Press any key to continue...")

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("The supplied username or password are invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("The specified database does not exist")
    else:
        print(err)
finally:
    db.close()
