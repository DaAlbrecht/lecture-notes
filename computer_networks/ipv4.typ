#import "../template.typ": *

= IPv4

An Internet Protocol address (IP address) is a numerical *32-bit* label such as 196.168.1.1 that is assigned to a device connected to a computer network that uses the Internet Protocol.

IP Addresses serve two main functions:
 - host or network interface identification
 - location addressing.

== IP Address management

The allocation of internet addresses is clearly regulated.
This task is handled by Internet Registries (IR).
The central organization in the internet is the Internet Assigned Number Authority (IANA).
Regional Internet Registries (RIRs) receive address spaces from IANA and serve large geographic regions.
Local Internet Registries (LIRs), typically Internet Service Providers (ISPs), receive address spaces from the RIRs and are responsible for distributing them to end users such as businesses and organizations.

#figure(
  image("../resources/ICANN.jpg", width: 60%),
  caption: [IPv4 Address Allocation], 
) <ipv4_address_allocation>


#pagebreak()

== IPv4 Address format

IPv4 addresses are 32-bit binary numbers, which are typically represented in dotted decimal notation.

This means that the 32-bit address is divided into four 8-bit octets, which are then converted to decimal numbers and separated by periods.

#example[
  The binary address:
  ```
   11000000.10101000.00000001.00000001
  |--------|--------|--------|--------|
  |  192   |  168   |   1    |   1    |
  |--------|--------|--------|--------|```
  is represented as: 192.168.1.1
]

An IPv4 address consists of two parts:
  - the network addresse: identifies the network to which the device is connected
  - the host address: identifies the device on that network.


== IPv4 Address Classes

IPv4 addresses are divided into five classes:
  - A - C: used for unicast addresses
  - D: used for multicast addresses
  - E: reserved for future use

#table(
  columns: (auto,auto,auto,auto),
  align: (center + horizon,center+horizon,left+horizon,left+horizon),
  table.header([Class], [Leading Bits], [Range], [Default Subnet Mask]),
  [A], [0], [1.0.0.0 to 126.225.225.225], [/8 (255.0.0.0)],
  [B], [10], [128.0.0.0 to 191.255.255.255], [/16 (255.255.0.0)],
  [C], [110], [192.0.0.0 to 223.255.255.255], [/24 (255.255.255.0)],
  [D], [1110], [244.0.0.0 to 239.255.255.255], [Reserved for multicast addresses],
  [E], [11110], [244.0.0.0 to 254.255.255.255], [Reserved for future use],
)

#pagebreak()

== Routing

IP addresses are classified into several classes of operational characteristics:
- unicast
- multicast
- anycast 
- broadcast 

=== Unicast

Unicast is the most common form of IP addressing.
It is used to identify a single network interface.
When a packet is sent to a unicast address, it is delivered to the network interface that has that address.

=== Multicast

Multicast is used to send a packet to a group of devices.
The packet is sent to a multicast group address, and all devices that are part of that group receive the packet.

=== Anycast

Anycast is used to send a packet to a group of devices but only one of the devices in the group receives the packet.
The device that receives the packet is the one, the router determines to be the closest to the sender.

=== Broadcast

Broadcast is used to send a packet to all devices on a network.
The packet is sent to the broadcast address, and all devices on the network receive the packet.

== Private IP Addresses

Private IP addresses are reserved for use in private networks and are not routable on the public internet.
They are defined in RFC 1918 and are used to conserve public IP addresses.

#table(
  columns: (auto,auto,auto,auto),
  align: (center + horizon,center+horizon,left+horizon,left+horizon),
  table.header([Name], [CIDR block], [Address Range], [Number of Addresses]),
  [24-bit block], [10.0.0.0/8], [10.0.0.0 – 10.255.255.255], [16,777,216],
  [20-bit block], [172.16.0.0/12], [172.16.0.0 – 172.31.255.255], [1,048,576],
  [16-bit block], [192.168.0.0/16],[192.168.0.0 – 192.168.255.255], [65,536],
)

#pagebreak()

== Subnetting

The classification of IP addresses over time led to address wastage.
The two-level addressing system (network number and host number) caused problems when organizations wanted to structure their internal networks, as each subdivision required a new network number.
This increased the size of routing tables in backbone routers.

In 1985, RFC 950 introduced subnets to address these organizational issues and reduce the load on global internet routing tables.

Subnet addressing allowed for better organization of internal networks by splitting the host address into two parts:
  - subnet number
  - host number

creating a three-tier hierarchy (network number, subnet number, host number).
Without subnets, routers identified the target address class from the first bits of the IP address.
With subnets, routers need additional information, provided by a network mask, to identify the target network and host address.
The network mask is a 32-bit field where each bit corresponds to a bit in the IP address, indicating whether it is part of the network number.

When a router receives a packet, it uses the network mask to determine the destination network and host parts of the address.
The router performs a logical AND operation between the IP packet's destination address and the network mask in its forwarding table to find the best route.


