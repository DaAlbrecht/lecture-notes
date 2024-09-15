#import "../template.typ": *

= IPv6 (Internet Protocol version 6)

The predecessor of IPv4 was the Network Control Program (NCP), operational since 1972.
TCP (Transport Control Protocol) was developed between 1973 and 1978, separating NCP into IP and TCP.
IPv6, initially referred to as IPv7 in 1998, has been in development since and is now the modern standard, as described in RFC 8200.

IPv6 addresses the limitation of IPv4’s address space, offering around 340 sextillion addresses compared to IPv4's 4 billion.

IPv6 goals included:

- Simplifying the protocol for faster router processing,
- Reducing routing table size,
- Supporting multimedia and real-time applications,
- Enhancing security,
- Improving multicasting,
- Supporting virtual connections and mobile hosts.

IPv6 was designed to coexist with IPv4 during the transition. Despite its advantages, IPv6 adoption is still partial, with most traffic relying on IPv4. As of January 2018, over 22% of Google users used IPv6.

== Representation

IPv6 addresses are 128 bits long, divided into eight 16-bit blocks separated by colons.

Each block is represented in hexadecimal, with a range of 0 to FFFF (0 to 65535 in decimal).

The following rules apply to simplify IPv6 address representation:

- Leading zeros in a block can be omitted.
- A single sequence of consecutive blocks of zeros can be replaced with two colons (::) to represent multiple blocks of zeros.
- The address can be shortened to its smallest representation.

#example[
  #set text(font: "Berkeley Mono", size: 10pt,spacing: 80%)
  #show table.cell.where(y: 0): strong

  #table(
    columns: (2fr,1.5fr),
    table.header([IPv6 Address], [Shortened Address]),
    [0000:0000:0000:0000:0000:0000:0000:0001], [::1],
    [2001:0db8:0000:0042:0000:8a2e:0370:7334], [2001:db8:0:42:0:8a2e:370:7334],
    [2001:0db8:0000:0042:0000:8a2e:0370:7334], [2001:db8::42:0:8a2e:370:7334],
    [2001:0db8:0000:0042:0000:8a2e:0370:7334], [2001:db8:0:42::8a2e:370:7334],
    [2001:0db8:0000:0042:0000:0000:0000:0001], [2001:db8:0:42::1]
  )
]

#pagebreak()

== IPv6 Header

The IPv6 header is simpler than the IPv4 header, with fewer fields and a fixed size of 40 bytes.

#figure(
  image("../resources/Ipv6_header.svg.png", width: 70%),
  caption: [IPv6 header structure],
) <ipv6header>

#pagebreak()

== Addressing

IPv6 addresses are 128 bits in length, unlike IPv4, which uses subnetting to maximize its smaller address space.
In IPv6, subnets use 64 bits for the host portion (interface identifier) and 64 bits for the routing prefix.
The large address space is considered sufficient for the future.

IPv6 addresses are divided into three types:

- Unicast: Identifies a single interface.
- Multicast: Identifies multiple interfaces.
- Anycast: Identifies multiple interfaces, but the packet is delivered to the nearest interface.

=== Scope

*Link-Local Address*

Link-local addresses are used for communication on a single link, such as a local network segment.
They are automatically configured and do not require manual configuration.
Link-local addresses are identified by the prefix `fe80::/10`.

*Local Addressing*

Local addresses are used for communication within a local network.

*Global Addressing*

Global addresses are used for communication across the internet.
The procedure for assigning global IPv6 addresses is similar to constructing local addresses, with the prefix being provided by router advertisements.
Multiple prefix announcements can configure multiple addresses.
Stateless Address Autoconfiguration (SLAAC) requires a /64 block.

== Neighbor Discovery

IPv6 uses Neighbor Discovery (ND) to manage the link layer, replacing ARP (Address Resolution Protocol) and ICMPv4.
ND includes the following functions:

- Router Discovery: Routers advertise their presence.
- Neighbor Discovery: Nodes discover neighbors on the same link.
- Address Autoconfiguration: Nodes automatically configure their addresses.
- Duplicate Address Detection: Nodes verify the uniqueness of their addresses.
- Redirect: Routers inform nodes of a better first-hop router.
- Optimal Path MTU Discovery: Nodes discover the maximum transmission unit (MTU) size.

#pagebreak()

== Solicited-Node Multicast Address

IPv6 uses the Solicited-Node Multicast Address to resolve the MAC address of a node.

The Solicited-Node Multicast Address is formed by appending the last 24 bits of the unicast address to the prefix `ff02::1:ff00:0/104`.

#example[
  #set text(font: "Berkeley Mono", size: 10pt,spacing: 80%)
  #show table.cell.where(y: 0): strong

  #table(
    columns: (1fr,1fr),
    table.header([Unicast Address], [Solicited-Node Multicast Address]),
    [2001:db8::aaa:bffb:ac2c:1fad], [ff02::1:ffac:1fad],
    [2001:db8::1], [ff02::1:ff00:1]
  )
]

== Coexistence with IPv4

IPv6 was designed to coexist with IPv4 during the transition period.
Several mechanisms were developed to facilitate this coexistence:

- Dual-Stack: Nodes support both IPv4 and IPv6.
- Tunneling: IPv6 packets are encapsulated in IPv4 packets.
- Translation: IPv6 packets are translated into IPv4 packets.

== Security

IPv6 includes security features to address the limitations of IPv4:

- IPsec: Integrated into the protocol, IPsec provides authentication, encryption, and data integrity.
- Secure Neighbor Discovery (SEND): Protects against Neighbor Discovery attacks.
- Cryptographically Generated Addresses (CGA): Prevents address spoofing.



