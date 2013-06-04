#!/bin/sh
# ------ silverpeas_stop_jboss.sh -----------
cd $JBOSS_HOME/bin

username=vlxuonkpn
password=89bf4019-73c8-4d00-a3ee-4e49d48345ff

sh shutdown.sh -u $username -p $password -S
