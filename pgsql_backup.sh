#!/bin/bash

#diretório mapeado com o storage account/fileshare
DIR_BACKUP='/mnt/pgsqlbackup'

#DBNAME="dbname"
USER='user_backup'
DBSERVERNAME='dbservernamehost'
DATA=$(date +%d-%m-%Y_%H-%M-%S)
SUFIXO='pgsql-prod'

export PGPASSWORD='teste@123'

#pg_dump é usado para backup das bases de forma individual.
#pg_dump -Fc -v --host=$DBSERVERNAME --dbname=$DBNAME --username=$USER-f $DBNAME-prd-$DATA.dump

#gera o backup do servidor pgsql (pg_basebackup é usado para fazer backups básicos de um cluster de banco de dados PostgreSQL em execução)
#https://www.postgresql.org/docs/10/app-pgbasebackup.html
pg_basebackup -v -h $DBSERVERNAME --username=$USER -w -D /tmp/$SUFIXO-backup-$DATA -Ft -z -Xs -P

#mover o backup para o diretorio mapeado com o storageaccount
sudo mv /tmp/$SUFIXO-backup-$DATA $DIR_BACKUP
