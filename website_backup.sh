# ALL PATHS SHOULD BE EDITED TO THE PATH YOU WANT THE FILES STORED IN.

# run command to list current databases
sudo mysql -e 'SHOW DATABASES;' > /home/ron/database_list.txt

# MariaDB or MySQL has core databases that we are not concerned
# with backing up at this time. We only want user databases.
# Clean up unwanted databases in the list.

grep -wv 'Database\|information_schema\|mysql\|performance_schema' /home/ron/database_list.txt > /home/ron/cleaned_database_list.txt

# Loop through cleaned database file, and back each database in an .sql file

FILENAME="/home/ron/cleaned_database_list.txt"

LINES=$(cat $FILENAME)

for LINE in $LINES
do
    sudo mysqldump --skip-lock-tables "$LINE" > /home/ron/${LINE}.sql
done

# Backup the website directory
tar -czf websites.tar.gz /var/www/html

# Backup the webserver config directory
tar -czf webserver_config.tar.gz /etc/httpd