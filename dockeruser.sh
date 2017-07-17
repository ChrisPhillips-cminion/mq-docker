#-----------------------------------------------------------------------------
# Filename...:.docker.sh
# Purpose....: Main driver script for implementing the TNT APIC Queue Manager on docker
# Parameters.: *None
#            : 
# Author.....: Aiden Gallagher
# Department.: Hybrid Cloud Integration
# Company....: IBM United Kingdom Ltd.
#Customer…..: TNT
#            : 
# Version....: Version|   Date            |Inits| Description
#            : 1.00       14-09-2016  	    AG    Initial version
#            : 
# Notes......:
#            : 
# Copyright..: IBM United Kingdom Ltd. 2016
#-------------------------------------------------------------------------------

echo "create group TESTUSERG"
groupadd TESTUSERG -g 12345

echo "create user TESTUSER1"
useradd TESTUSER1 -g TESTUSERG

#echo "add the user to the group"
#usermod TESTUSER1 -g TESTUSERG

echo "give the group authorization"
#setmqaut -m MQDAC01 -t qmgr -g TESTUSERG -all +connect +inq +put
setmqaut -m MQDAC01 -t qmgr -g TESTUSERG +all 
setmqaut -m MQDAC01 -t chl -n MQDAC01.DP.SVRCONN -g TESTUSERG +all
setmqaut -m MQDAC01 -t q -n API1IN  -g TESTUSERG +all
setmqaut -m MQDAC01 -t q -n API1OUT  -g TESTUSERG +all

echo REFRESH SECURITY  > /tmp/run
runmqsc MQDAC01 < /tmp/run
