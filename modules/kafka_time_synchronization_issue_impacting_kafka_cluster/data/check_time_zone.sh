

#!/bin/bash



# Set the list of affected servers

servers="${SERVER1} ${SERVER2} ${SERVER3}"



# Loop through each server and check the time zone setting

for server in $servers

do

    echo "Checking time zone setting on $server..."

    ssh $server "date"

    ssh $server "timedatectl status"

done