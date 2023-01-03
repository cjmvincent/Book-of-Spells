w32tm /config /manualpeerlist:BCBOE-DC1.bryan.k12.ga.us /syncfromflags:DOMHIER

net stop w32time
net start w32time

w32tm /config /update
w32tm /resync /rediscover
