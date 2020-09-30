#VM node1
#ip

[vagrant@node1 ~]$ ip a
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:f7:6d:e3 brd ff:ff:ff:ff:ff:ff
    inet 192.168.2.21/24 brd 192.168.2.255 scope global noprefixroute eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fef7:6de3/64 scope link
       valid_lft forever preferred_lft forever
 
 
#hostname - nom vagrant
 
[vagrant@node1 ~]$ echo $HOSTNAME
node1.tp2.b2


#memory usage

[vagrant@node1 ~]$ free -m
              total        used        free      shared  buff/cache   available
Mem:            990          90         739           6         161         761
Swap:          2047           0        2047


#VM node2
#ip 

[vagrant@node2 ~]$ ip a
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:45:5c:e9 brd ff:ff:ff:ff:ff:ff
    inet 192.168.2.22/24 brd 192.168.2.255 scope global noprefixroute eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe45:5ce9/64 scope link
       valid_lft forever preferred_lft forever


#hostname-nom vagrant

 [vagrant@node2 ~]$ echo $HOSTNAME
node2.tp2.b2


#memory usage

[vagrant@node2 ~]$ free -m
              total        used        free      shared  buff/cache   available
Mem:            486          81         246           4         158         387
Swap:          2047           0        2047
<<<<
