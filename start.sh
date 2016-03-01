#!/bin/bash

set -u
set -e

ADMIN_USER=${ADMIN_USER:-'admin'}
ADMIN_PASS=${ADMIN_PASS:-'Password123'}
ADMIN_EMAIL=${ADMIN_EMAIL:-'admin@petals.io'}
DB='/opt/app/db.sqlite3'

if [ -f $DB ];
then
	echo "Database already exists!"
else
	echo "Creating database."
	/opt/app/manage.py migrate
	echo "from django.contrib.auth.models import User; User.objects.create_superuser('$ADMIN_USER', '$ADMIN_EMAIL', '$ADMIN_PASS')" | python /opt/app/manage.py shell
fi

echo "Starting supervisor"	
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
