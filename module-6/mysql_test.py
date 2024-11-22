#Rachel Shaw - 6.2 assignment - 11/20/2024

import mysql.connector
from mysql.connector import errorcode

import dotenv
from dotenv import dotenv_values


#Created because raise_on_warnings was returning as a string not a bool. 
def stringtobool(string):
    if string == "True":
        return True
    else:
        return False


secrets = dotenv_values(".env")


config = {
    "user": secrets["USER"],
    "password": secrets["PASSWORD"],
    "host": secrets["HOST"],
    "database":secrets["DATABASE"],
    "raise_on_warnings": stringtobool(secrets["RAISE_ON_WARNINGS"])
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
