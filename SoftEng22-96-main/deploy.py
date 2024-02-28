import subprocess
import os

##############################################
###   DOWNLOAD THE DEPENDENCIES
##

# Path of project folder
dir_path = os.path.dirname(os.path.realpath(__file__))

subprocess.check_call('pip install -r requirements.txt', shell=True)

print("Dependencies downloaded successfully........")

##############################################
###   CREATE THE DATABASE
##
import mysql.connector
# Connect to MySQL
db = mysql.connector.connect(
  host="127.0.0.1",
  user="root",
  password="",
  port=3306,
  charset="utf8mb4"
)

# Create cursor
cursor = db.cursor()

with  open(os.path.join(dir_path, "data/intelliq.sql"), 'r') as fd:
    sqlFile = fd.read()
fd.close()

#Creating a database
for result in cursor.execute(sqlFile, multi=True):
    if result.with_rows:
        print("Rows produced by statement '{}':".format(result.statement))
        print(result.fetchall())
    else:
        print("Number of rows affected by statement '{}': {}".format(result.statement, result.rowcount))

##############################################
###   IMPORT THE DATA (providers)
##

db.close()
