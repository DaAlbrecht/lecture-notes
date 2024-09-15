#import "../template.typ": *

= Network Layer

The network layer is the third layer of the OSI model, responsible for routing packets across different networks.
It provides logical addressing, routing, and packet forwarding.
The network layer is implemented in routers and end systems.

== Circuit Switching

Circuit switching is a method of establishing a dedicated communication path between two devices in a network.
The path is reserved for the duration of the communication session.
Circuit switching is used in traditional telephone networks.

== Packet Switching

Packet switching is a method of transmitting data in a network.
Data is divided into packets, which are sent independently to the destination.
Packets may take different paths to reach the destination.
Packet switching is used in computer networks.

=== Datagram Packet Switching

In datagram packet switching, each packet is treated independently and may take a different path to reach the destination.
It is connectionless and does not establish a dedicated path for communication.
Datagram packet switching is used in IP networks.

=== Virtual Circuit Packet Switching

In virtual circuit packet switching, a path is established before data transfer begins.
Packets follow the same path and are identified by a virtual circuit identifier.
Virtual circuit packet switching is used in ATM networks.


== Routing

Routing is the process of selecting the best path for data to travel from the source to the destination.
Routers use routing tables to determine the next hop for packets.
Routing algorithms are used to calculate the best path based on metrics such as distance, cost, or speed.


== Multiplexing

Multiplexing is the process of combining multiple data streams into a single stream for transmission.
It allows multiple devices to share a single communication channel.

== Demultiplexing

Demultiplexing is the process of separating a single data stream into multiple streams at the receiving end.
It allows devices to receive data intended for them.

== Fragmentation

Fragmentation is the process of breaking a packet into smaller units to fit the maximum transmission unit (MTU) of the network.
It is used when the packet size exceeds the MTU of the network.

== Defragmentation

Defragmentation is the process of reassembling fragmented packets at the receiving end.
It is used to reconstruct the original packet from the smaller units.
