# Rachel Shaw - 7.1 Assignment - 11/30/2024

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

#set up database connection
db = mysql.connector.connect(**config)
print(f"\n Databaseuser {config["user"]} connected to MYSQL on host {(config["host"])} with database {(config["database"])}")

# Allows me to perform queries(?)
cursor = db.cursor()

#Perform query to get all data from the studios table
cursor.execute("SELECT * FROM studio")
studio = cursor.fetchall()
# Print output
print("\n--STUDIO IDS--\n")
for studio in studio:
    print("Studio ID: {}\n Studio Name: {}\n".format(studio[0], studio[1]))

#Perform query to get all data from the genre table
cursor.execute("SELECT * FROM genre")
genre = cursor.fetchall()
# print output
print("--FILM GENRES--\n")
for genre in genre:
    print("Genre ID: {}\n Genre Name: {}\n".format(genre[0], genre[1]))

#perform query to get movies with a runtime less than 2 hours
cursor.execute('SELECT film_name, film_runtime FROM film WHERE film_runtime < 120')
film = cursor.fetchall()
#print output
print("--FILMS WITH RUNTIME LESS THAN 2 HOURS--\n")
for film in film:
    print("film name: {}\n Runtime: {}\n".format(film[0], film[1]))

# query to order film names and order them by director name
cursor.execute('SELECT film_name, film_director FROM film ORDER BY film_director')
director = cursor.fetchall()
#print output
print("--FILMS ORDERED BY DIRECTOR--\n")
for director in director:
    print("Film Name: {}\n Director: {}\n".format(director[0], director[1]))