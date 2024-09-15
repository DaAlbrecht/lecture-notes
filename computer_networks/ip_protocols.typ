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

== DHCP (Dynamic Host Configuration Protocol)

The Dynamic Host Configuration Protocol (DHCP) automates the assignment of IP addresses and network parameters to hosts within a network, which is especially helpful for large-scale networks.
Rather than manually configuring IP settings for each device, DHCP allows a DHCP server to dynamically allocate IP addresses, subnet masks, DNS server addresses, routers, and other parameters to clients (DHCP clients) during their boot process.

DHCP evolved from the BOOTP protocol and is backward compatible with it.
It supports both automatic and dynamic IP address assignments, where dynamic assignments require periodic renewal by the client.
Servers maintain records of allocated and available IP addresses.
DHCP can also assign fixed IP addresses to specific clients via server configuration.

The process is entirely automatic, eliminating the need for manual configuration, and helps simplify network management, particularly in environments with many devices.

DHCP messages are encapsulated within UDP packets, which are in turn encapsulated within IP packets.

#pagebreak()

== DHCP Frame Structure

DHCP messages consist of a fixed-size header and a variable-length options field.

- *Op*: Specifies the message type (e.g., request, reply).
- *Htype*: Specifies the hardware address type (e.g., Ethernet).
- *Hlen*: Specifies the hardware address length.
- *Hops*: Used by relay agents to forward messages.
- *Xid*: Transaction ID to match requests and replies.
- *Secs*: Time elapsed since the client began the DHCP process.
- *Flags*: Flags field.
- *Ciaddr*: Client IP address.
- *Yiaddr*: Your IP address (server).
- *Siaddr*: Server IP address.
- *Giaddr*: Gateway IP address.
- *Chaddr*: Client hardware address.
- *Sname*: Server name.
- *File*: Boot file name.
- *Options*: Variable-length field containing DHCP options.

#figure(
  image("../resources/dhcp_header.png", width: 120%),
  caption: [DHCP header structure],
) <dhcpheader>

#pagebreak()

== DHCP Message Types

DHCP messages can be classified into the following types and passed as the *Op* field in the DHCP header:

#table(
  columns: (1fr,1fr,3fr),
  align: (center+horizon,center+horizon,left),
  table.header([Value], [Message Type], [Description]),
  [1],[DHCPDISCOVER],[Broadcast message from the client to discover DHCP servers on the network.],
  [2],[DHCPOFFER],[Unicast message from the server to offer IP address and configuration parameters to the client.],
  [3],[DHCPREQUEST],[Broadcast message from the client to request offered parameters from a specific server.],
  [4],[DHCPDECLINE],[Broadcast message from the client to decline the offered parameters.],
  [5],[DHCPACK],[Unicast message from the server to acknowledge the client's request and provide configuration parameters.],
  [6],[DHCPNAK],[Unicast message from the server to indicate that the client's requested parameters are not available.],
  [7],[DHCPRELEASE],[Broadcast message from the client to release the assigned IP address.],
  [8],[DHCPINFORM],[Unicast message from the client to request additional configuration parameters.],
)

== Sequence of DHCP Message Exchange

The DHCP process involves a series of messages exchanged between the client and server to allocate an IP address and other network parameters.

#figure(
  image("../resources/DHCP_session.svg.png", width: 30%),
  caption: [DHCP message exchange sequence],
) <dhcpsequence>

#pagebreak()

= Security Considerations

== ICMP Attack vectors

ICMP can be used for various attacks, such as ICMP flood attacks, ping of death, and ICMP redirect attacks.

- *ICMP flood*: Overwhelms a target with ICMP echo requests, consuming network resources and causing a denial of service.
- *Ping of death*: Sends oversized ICMP packets to crash the target system.
- *ICMP redirect*: Redirects traffic to a malicious host, allowing attackers to intercept and manipulate data.

Preventing ICMP attacks involves filtering ICMP traffic, disabling ICMP echo requests, and implementing intrusion detection systems to detect and block malicious ICMP traffic.

== ARP Attack vectors

ARP spoofing used to be a common attack vector.
It involves sending forged ARP messages to associate an attacker's MAC address with the IP address of a legitimate host, allowing the attacker to act as a man in the middle and intercept traffic intended for the legitimate host.

Preventing ARP attacks involves using static ARP entries, implementing ARP spoofing detection tools, and securing network devices to prevent unauthorized access.

== DHCP Attack vectors

- *DHCP starvation*: Exhausts available IP addresses by sending a large number of DHCP requests, preventing legitimate clients from obtaining IP addresses.
- *DHCP spoofing*: Impersonates a DHCP server to provide false IP addresses and network parameters to clients, allowing attackers to intercept and manipulate network traffic.

Preventing DHCP attacks involves using DHCP snooping, port security, and DHCP authentication mechanisms to verify the legitimacy of DHCP servers and clients.
