#! /bin/bash

if [ $# -eq 0 ] | [ $# -gt 1 ]
then 
    echo "Please specify one command that you want to use (e.g. archive)"
fi

if [ "$1" == "archive" ]
then
    echo "Please enter directory that you want to archive (e.g. /var/www/wordpress)"
    read dir
    if [ -d $dir ] #check if directory exists
    then
        tar -czf wp.tar.gz $dir #for example /var/www/wordpress is default directory
    else
        echo "Directory doesn't exist"
        exit
    fi
    echo "Please enter database name (e.g. wordpress_db)"
    read dbname
    #echo "/var/lib/mysql/$dbdir"
    #if [ -d /var/lib/mysql/$dbdir ]
    #then
    #    tar -czf wpdb.tar.gz /var/lib/mysql/$dbdir #/var/lib/mysql/ is default directory
    #else
    #    echo "Directory doesn't exist"
    #    exit
    #fi
    mysqldump -u root $dbname > $dbname\_backup.sql
fi

if [ "$1" == "deploy" ]
    then
    echo "Please enter directory name where files will be deployed (e.g. /var/www/wordpress)"
    read dir
    if [ -d $dir ] #check if directory exists
    then
        echo "Please enter .tar.gz file name that you want to deploy (e.g. wp.tar.gz)"
        read tarfile
        tar -xzvf $tarfile $dir
        echo "Please specify database .sql file that you want to deploy (e.g. *_backup.sql)"
        read dbbackup
        echo "Enter database name to deploy to"
        read dbname
        echo "Extracting database..."
        #tar -xzvf $dbtarfile --directory /var/lib/mysql/$dbname 
        mysql -u root $dbname < $dbbackup
    else
        echo "Directory doesn't exist"
        exit
    fi
fi
