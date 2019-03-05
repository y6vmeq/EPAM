#!/bin/bash
httpd -D FOREGROUND
/usr/bin/filebeat --strict.perms=false -c filebeat.yml &
wait