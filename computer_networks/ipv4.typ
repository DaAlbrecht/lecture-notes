#import "../template.typ": *
{
  #set table(
    fill: (x, y) =>
      if x == 0 or y == 0 {
        gray.lighten(40%)
      },
    align: right,
  )

  #show table.cell.where(x: 0): strong
  #show table.cell.where(y: 0): strong
}

= IPv4 (Internet Protocol version 4)

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

== Subnet Mask

The subnet mask is a 32-bit number that is used to divide an IP address into network and host parts.
It is used by routers to determine the network number of an IP address.
The subnet mask is written in the same format as an IP address, with four octets separated by periods or using 
CIDR notation.

Example 1:
#example[
ip address: `192.168.1.10`

Subnet Mask: 255.255.255.0

Can be written with the CIDR notation as *`192.168.1.10/24`*
]

#pagebreak()

=== Special Network Addresses

There are three types of network addresses:
  - Network Address: The address with all host bits set to 0
  - Broadcast Address: The address with all host bits set to 1
  - General purpose address: An address that is neither a network nor a broadcast address

#example[
  IPv4 Address: 192.168.1.0/24
#show raw: set text(font: "Berkeley Mono", size: 9pt, spacing: 100%)
```
+-----------------+-----------------+-----------------+-----------------+
|     Network     |     First       |     Last        |    Address      |
|     Address     |     Usable      |     Usable      |    Broadcast    |
|                 |     IP          |     IP          |                 |
|    192.168.1.0  |  192.168.1.1    |  192.168.1.254  |  192.168.1.255  |
+-----------------+-----------------+-----------------+-----------------+
```]


=== Examples of Subnetting

#example[
  Given the IP address `10.0.1.1` and the subnet mask `/16`
  - The subnet "magic" happens in the 2nd octet
  - There are 2^16 = 65536 addresses in this subnet
  - There are 255 possible subnets
 #table(
    columns: (auto,auto,auto,auto),
    align: (center + horizon,center+horizon,left+horizon,left+horizon),
    table.header([nth subnet], [Network Address], [Usable IP Range], [Broadcast Address]),
    [1], [10.0.0.0], [10.0.0.1 - 10.0.255.254], [10.0.255.255],
    [2], [10.1.0.0], [10.1.0.1 - 10.1.255.254], [10.1.255.255],
    [3], [10.2.0.0], [10.2.0.1 - 10.2.255.254], [10.2.255.255],
    [4], [10.3.0.0], [10.3.0.1 - 10.3.255.254], [10.3.255.255],
    [255], [10.255.0.0], [10.255.0.1 - 10.255.255.254], [10.255.255.255]
  )
]

== VLSM (Variable Length Subnet Masking)

VLSM is a technique that allows for the creation of subnets with different sizes.
This is useful when you have different requirements for the number of hosts in each subnet.
The requirements for VLSM are:
  - A network address
  - The number of hosts required for each subnet

VLSM works by dividing an already existing subnet into smaller subnets.

#pagebreak()

== IPv4 Header

The IPv4 header is a 20-byte header that is added to the beginning of an IP packet.
The fields in the header are send using big-endian byte order.

The IPv4 header consists of the following fields:
  - Version: The version of the IP protocol being used (4 for IPv4)
  - IHL (Internet Header Length): The length of the header in 32-bit words
  - Type of Service: The type of service requested by the packet
  - Total Length: The total length of the packet, including the header
  - Identification: A unique identifier for the packet
  - Flags: Flags used for fragmentation
  - Fragment Offset: The offset of the fragment in the original packet
  - Time to Live: The maximum number of hops the packet can take
  - Protocol: The protocol used in the data portion of the packet
  - Header Checksum: A checksum of the header
  - Source Address: The source IP address of the packet
  - Destination Address: The destination IP address of the packet
  - Options: Optional fields that can be included in the header

#figure(
  image("../resources/IPv4_Packet-en.svg.png", width: 80%),
  caption: [IPv4 Header], 
) <ipv4_header>

== IPv4 Packet Fragmentation

IPv4 packets can be fragmented when they are too large to be transmitted over a network.
When a packet is fragmented, it is divided into smaller packets, called fragments, that can be reassembled at the destination.

The fragmentation process is handled by routers along the path of the packet.
When a router receives a packet that is too large for the next hop, it fragments the packet into smaller packets and forwards them individually.

The fragments are reassembled at the destination using the identification field in the header to identify which fragments belong to the same packet.

#pagebreak()

== IPv4 Address Resolution Protocol (ARP)

ARP is a protocol used to map an IP address to a MAC address.
When a device wants to send a packet to another device on the same network, it needs to know the MAC address of the destination device.

ARP works by broadcasting a request for the MAC address of the destination device.
The device with the matching IP address responds with an Unicast message containing its MAC address to the requesting device.

== ARP Table

The ARP table is a table that maps IP addresses to MAC addresses.
When a device receives a packet, it checks the ARP table to see if it has the MAC address of the destination device.
If the MAC address is not in the ARP table, the device sends an ARP request to find the MAC address.

#example[
  ARP Table:
  ```
  +-----------------+-------------------+
  |   IP Address    |    MAC Address    |
  +-----------------+-------------------+
  | 192.168.1.1     | AA:BB:CC:DD:EE:FF |
  | 192.168.1.2     | FF:EE:DD:CC:BB:AA |
  | 192.168.1.3     | 11:22:33:44:55:66 |
  +-----------------+-------------------+```
]

After some time, the ARP table clears the entries to prevent stale entries from causing problems.
