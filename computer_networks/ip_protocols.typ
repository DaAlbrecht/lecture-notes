#import "../template.typ": *

 = ICMP (Internet Control Message Protocol)

ICMP is a key protocol in the Internet protocol suite, primarily used by network devices (like routers) to send error messages and operational information.
It helps communicate success or failure in network communications, such as when a service is unavailable or a host cannot be reached.
Unlike TCP or UDP, ICMP is not used to exchange data between systems and is mainly used for network diagnostics (e.g., ping and traceroute).

ICMP for IPv4 is defined in RFC 792, while ICMPv6 (for IPv6) is defined in RFC 4443.
It handles diagnostic tasks, error reporting, and control functions, and operates at the network layer (Layer 3 of the OSI model).
ICMP messages are contained within IP packets but are treated as a special case, often directing error messages back to the source IP of the original packet.

== Datagram structure

ICMP messages consist of an ICMP header and a variable-length data section.

=== ICMP header

The ICMP header is a fixed-size structure that contains the following fields:

- *Type*: Specifies the type of ICMP message (e.g., echo request, echo reply, destination unreachable).
- *Code*: Provides additional information about the ICMP message type.
- *Checksum*: Used to verify the integrity of the ICMP message.
- *Rest of header*: Contains additional fields specific to the ICMP message type.

The ICMP header is followed by the data section, which varies in size and structure based on the ICMP message type.

#figure(
  image("../resources/icmp_header.png", width: 120%),
  caption: [ICMP header structure],
) <icmpheader>

#pagebreak()
==== Common ICMP message types

#table(
  columns: (auto,auto,1fr,auto),
  align: (center+horizon,center+horizon,left,center+horizon),
  table.header([Type], [Code], [Description], [Sent by]),
  [3],[1],[Destination Unreachable,Indicates that the destination is unreachable],[Router],
  [3],[0],[Network Unreachable,The destination network is unreachable],[Router],
  [4],[0],[Redirect Datagram for the Network,Redirects the packet to another network],[Router],
  [0],[0],[Echo Reply,Response to an echo request],[Host],
  [11],[0],[Time Exceeded,Indicates that the time to live (TTL) has expired],[Router],
)


= NAT (Network Address Translation)

Network Address Translation (NAT) is a method used to modify network address information in IP packet headers while in transit across a traffic routing device.

== NAT implementation classifications

NAT can be implemented in various ways, each with its own characteristics and use cases:

#table(
  columns: (1fr,2fr,1fr),
  table.header(repeat: true,
    [Type], [Description],[Figure]),
  align: (center+horizon,left,center+horizon),
  [Static NAT (one-to-one NAT)],
  [Once an internal address (iAddr:iPort) is mapped to an external address (eAddr:ePort), any packets from iAddr:iPort are sent through eAddr:ePort.
  \
  \
  Any external host can send packets to iAddr:iPort by sending packets to eAddr:ePort.
  ],
  image("../resources/Full_Cone_NAT.svg.png", width: 90%),
  [(Address)-restricted-cone NAT],
  [Once an internal address (iAddr:iPort) is mapped to an external address (eAddr:ePort), any packets from iAddr:iPort are sent through eAddr:ePort.
  \
  \
  An external host (hAddr:any) can send packets to iAddr:iPort by sending packets to eAddr:ePort only if iAddr:iPort has previously sent a packet to hAddr:any. "Any" means the port number doesn't matter.
  ],
  image("../resources/Restricted_Cone_NAT.svg.png", width: 90%),
  [Port-restricted cone NAT],
  [Once an internal address (iAddr:iPort) is mapped to an external address (eAddr:ePort), any packets from iAddr:iPort are sent through eAddr:ePort.
  \
  \
  An external host (hAddr:hPort) can send packets to iAddr:iPort by sending packets to eAddr:ePort only if iAddr:iPort has previously sent a packet to hAddr:hPort.
  ],
  image("../resources/Port_Restricted_Cone_NAT.svg.png", width: 90%),
  [Symmetric NAT],
  [The combination of one internal IP address plus a destination IP address and port is mapped to a single unique external source IP address and port; if the same internal host sends a packet even with the same source address and port but to a different destination, a different mapping is used.
  \
  \
  Only an external host that receives a packet from an internal host can send a packet back.
  ],
  image("../resources/Symmetric_NAT.svg.png", width: 90%),
)

#pagebreak()
