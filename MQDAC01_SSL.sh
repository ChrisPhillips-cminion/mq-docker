runmqsc MQDAC01 < /etc/mqm/MQDAC01.mqs
cd /tmp/
runmqckm -keydb -create -db /tmp/Cte_TEMP_CA.kdb -pw passw0rd -type cms -expire 365 -stash
runmqckm -cert -create -db /tmp/Cte_TEMP_CA.kdb -pw passw0rd -label "Cte TEMP WMQ/IIB CA" -dn "CN=WMQ/IIB TEMP CA, OU=Cte O=IBM " -ca true -expire 365
runmqckm -cert -extract -db /tmp/Cte_TEMP_CA.kdb -pw passw0rd -label "Cte TEMP WMQ/IIB CA" -target "/tmp/Cte_TEMP_CA.cer" -format ascii
runmqckm -keydb -create -db /var/mqm/qmgrs/MQDAC01/ssl/MQDAC01.kdb -pw passw0rd -type cms -expire 365 -stash
runmqckm -cert -add -db /var/mqm/qmgrs/MQDAC01/ssl/MQDAC01.kdb -pw passw0rd -label "Cte TEMP WMQ/IIB CA" -file "/tmp/Cte_TEMP_CA.cer" -format ascii
runmqckm -certreq -create -db /var/mqm/qmgrs/MQDAC01/ssl/MQDAC01.kdb -pw passw0rd -label ibmwebspheremqmqdac01 -dn "CN=MQDAC01, OU=WMQ, O=IBM" -file "/var/mqm/qmgrs/MQDAC01/ssl/MQDAC01.arm"
runmqckm -cert -sign -file "/var/mqm/qmgrs/MQDAC01/ssl/MQDAC01.arm" -db /tmp/Cte_TEMP_CA.kdb -pw passw0rd  -label "Cte TEMP WMQ/IIB CA"  -target "/var/mqm/qmgrs/MQDAC01/ssl/MQDAC01.crt" -format ascii -expire 364
runmqckm -cert -receive -db /var/mqm/qmgrs/MQDAC01/ssl/MQDAC01.kdb -pw passw0rd -file "/var/mqm/qmgrs/MQDAC01/ssl/MQDAC01.crt"  -format ascii
chmod 755 /var/mqm/qmgrs/MQDAC01/ssl/*

runmqckm -cert -extract -db /var/mqm/qmgrs/MQDAC01/ssl/MQDAC01.kdb -pw passw0rd -type cms -label "ibmwebspheremqmqdac01" -target "/tmp/MQDAC01_CER.cer" -format ascii
