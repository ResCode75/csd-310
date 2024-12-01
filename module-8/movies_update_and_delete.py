#Rachel Shaw - 8.2 Assignment - 11/30/2024

import mysql.connector
from mysql.connector import errorcode

import dotenv
from dotenv import dotenv_values


# Connecting to Database
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
db = mysql.connector.connect(**config)

#Show films function
def show_films(cursor, title):
    cursor.execute("SELECT film_name AS Name, film_director AS Director, genre_name AS Genre, studio_name as 'Studio Name' from film INNER JOIN genre ON film.genre_id = genre.genre_id INNER JOIN studio ON film.studio_id = studio.studio_id")
    films = cursor.fetchall()
    print("\n -- {} --".format(title))
    for film in films:
        print("Film Name: {}\nDirector: {}\nGenre Name: {}\nStudio Name: {}\n".format(film[0], film[1], film[2], film[3]))

#Set up cursor    
cursor = db.cursor()
#Show films before any changes
show_films(cursor, "DISPLAYING FILMS")

#Insert Five Nights at Freddy's
cursor.execute("INSERT INTO film(film_name, film_releaseDate, film_runtime, film_director, studio_id, genre_id) VALUES('Five Nights At Freddys', '2023', '109', 'Emma Tammi', (SELECT studio_id FROM studio WHERE studio_name = 'Blumhouse Productions'),(SELECT genre_id FROM genre WHERE genre_name = 'Horror') )")
show_films(cursor, "DISPLAYING FILMS AFTER INSERT")

# Update Alien's genre
cursor.execute("UPDATE film SET genre_id = 1 WHERE film_id = 2")
show_films(cursor, "DISPLAYING FILMS AFTER UPDATE")

# Delete Gladiator
cursor.execute('DELETE FROM film WHERE film_id = 1')
show_films(cursor, "DISPLAYING FILMS AFTER DELETE")