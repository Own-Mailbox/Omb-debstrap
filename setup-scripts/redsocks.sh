# Replace the old redsocks conf file
mv /etc/redsocks.conf /etc/redsocks.conf.old
cp files/redsocks.conf /etc/

# Restart redsocks 
killall redsocks
redsocks
