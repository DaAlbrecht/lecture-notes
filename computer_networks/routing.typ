#import "../template.typ": *
#set table(
  fill: (x, y) =>
    if x == 0 or y == 0 {
      gray.lighten(40%)
    },
  align: right,
)

#show table.cell.where(x: 0): strong
#show table.cell.where(y: 0): strong
#show raw: set text(font: "Berkeley Mono", size: 9pt, spacing: 100%)

= Routing

Routing is the process of selecting a path for traffic in a network or between or across multiple networks.
Broadly, routing is performed in many types of networks, including circuit-switched networks, such as the public switched telephone network (PSTN), and computer networks, such as the Internet.

There are many types of routing algorithms and methods but they can be broadly classified into two categories:
- Static routing
- Dynamic routing

A network administrator can use one or both of these methods to route traffic in a network at the same time.

== Static Routing

As the name implies, static routing is a routing method that does not change the routing table unless the network administrator manually changes it.

Commonly used algorithms for static routing include:
- shortest path routing
- flooding

=== Use Cases of Static Routing

- Static routing can be used to define an exit point from a router when no other routes are available or necessary. This is called a default route.
- Static routing can be used for small networks that require only one or two routes. This is often more efficient since a link is not being wasted by exchanging dynamic routing information.
- Static routing is often used as a complement to dynamic routing to provide a failsafe backup if a dynamic route is unavailable.
- Static routing is often used to help transfer routing information from one routing protocol to another (routing redistribution).

=== Advantages of Static Routing

- Static routing causes very little load on the CPU of the router, and produces no traffic to other routers.
- Static routing leaves the network administrator with full control over the routing behavior of the network.
- Static routing is very easy to configure on small networks.

=== Disadvantages of Static Routing

- Human error: In many cases, static routes are manually configured. This increases the potential for input mistakes.
- Fault tolerance: Static routing is not fault tolerant. This means that when there is a change in the network or a failure occurs between two statically defined devices, traffic will not be re-routed.
- Administrative distance: Static routes typically take precedence over routes configured with a dynamic routing protocol. This means that static routes may prevent routing protocols from working as intended. 
- Administrative overhead: Static routes must be configured on each router in the network(s). This configuration can take a long time if there are many routers.

== Dynamic Routing

Dynamic routing, also called adaptive routing, is a process where a router can forward data via a different route for a given destination based on the current conditions of the communication circuits within a system.
This is done by using routing protocols to exchange routing information between routers.

In dynamic routing three main concepts are used:

- Isolated routing: Each router makes its own routing decisions based on its own routing table.
- Centralized routing: A central router makes routing decisions for all routers in the network.
- Distributed routing: Each router makes routing decisions based on the information it receives from other routers.

Commonly used algorithms for dynamic routing include:

- Distance-vector routing (e.g. RIP)
- Link-state routing (e.g. OSPF)

== Shortest Path Routing

Shortest path routing is a type of routing algorithm that determines the shortest path from a source node to a destination node in a network.
Metrics used to determine the shortest path can include:

- Distance
- Bandwidth
- Average traffic
- Average delay

The most common shortest path routing algorithm is Dijkstra's algorithm.

== Flooding

Flooding is a routing algorithm that involves the transmission of data packets to every link in a network.
By sending data packets to every link, the destination node is guaranteed to receive the data packet in the shortest amount of time.
Downsides of flooding are the heavy load on the network.

== Distance-vector Routing

Distance-vector routing protocols use the Bellman–Ford algorithm.
In these protocols, each router does not possess information about the full network topology.n
It advertises its distance value (DV) calculated to other routers and receives similar advertisements from other routers unless changes are done in the local network or by neighbours (routers).
Using these routing advertisements each router populates its routing table.
In the next advertisement cycle, a router advertises updated information from its routing table.
This process continues until the routing tables of each router converge to stable values.

=== Problems

- Count to Infinity Problem
- Slow convergence time (Time needed for all routers to have the same routing table)

==== Count to Infinity Problem
The Bellman–Ford algorithm does not prevent routing loops from happening and suffers from the count to infinity problem. The core of the count-to-infinity problem is that if A tells B that it has a path somewhere, there is no way for B to know if the path has B as a part of it. To see the problem, imagine a subnet connected like A–B–C–D–E–F, and let the metric between the routers be "number of jumps". Now suppose that A is taken offline. In the vector-update-process B notices that the route to A, which was distance 1, is down – B does not receive the vector update from A. The problem is, B also gets an update from C, and C is still not aware of the fact that A is down – so it tells B that A is only two jumps from C (C to B to A). Since B doesn't know that the path from C to A is through itself (B), it updates its table with the new value "B to A = 2 + 1". Later on, B forwards the update to C and due to the fact that A is reachable through B (From C's point of view), C decides to update its table to "C to A = 3 + 1". This slowly propagates through the network until it becomes infinity (in which case the algorithm corrects itself, due to the relaxation property of Bellman-Ford).

== Link-state Routing

The basic concept of link-state routing is that every node constructs a map of the connectivity to the network in the form of a graph, showing which nodes are connected to which other nodes.
Each node then independently calculates the next best logical path from it to every possible destination in the network.
Each collection of best paths will then form each node's routing table.

Link-state routing protocols use a form of the Dijkstra algorithm to calculate the shortest path.

== Routing Information Protocol (RIP)

RIP is a distance-vector routing protocol that uses hop count as a routing metric.
RIP is a simple protocol that uses UDP as its transport protocol.

RIP has two versions:

- RIP version 1 (RIPv1) - Classful routing protocols
- RIP version 2 (RIPv2) - Classless routing protocols

The same issues that apply to distance-vector routing protocols apply to RIP, such as the count-to-infinity problem and 
the slow convergence time.

=== RIPv1 Protocol Data Unit (PDU)

*RIPv1 header*

#example[
```
0                  1                  2                  3                  4
+---------------------------------------------------------------------------+
|                          RIPv1 Protocol Data Unit (PDU)                   |
+------------------+------------------+------------------+------------------+
| Command (1 byte) | Version (1 byte) |   Must be Zero (2 bytes)            |
+------------------+------------------+-------------------------------------+
+---------------------------------------------------------------------------+
|                                 RIPv1 Entries                             |
+---------------------------------------------------------------------------+
```
]

*RIPv1 entry*

#example[
```
0                  1                  2                  3                  4
+-------------------------------------+-------------------------------------+
| Address Family Identifier (2 bytes) |       Must be Zero (2 bytes)        |
+-------------------------------------+-------------------------------------+
|                           IP Address (4 bytes)                            |
+---------------------------------------------------------------------------+
|                           Must be Zero (4 bytes)                          |
+---------------------------------------------------------------------------+
|                           Must be Zero (4 bytes)                          |
+---------------------------------------------------------------------------+
|                           Metric (4 bytes)                                |
+---------------------------------------------------------------------------+
```
]

=== RIPv2 Protocol Data Unit (PDU)

*RIPv2 header* 

The RIPv2 header is the same as the RIPv1 header with the only difference being the version field containing the value 2.

*RIPv2 entry*

#example[
```
0                  1                  2                  3                  4
+-------------------------------------+-------------------------------------+
| Address Family Identifier (2 bytes) | Route Tag (2 bytes)                 |
+-------------------------------------+-------------------------------------+
|                           IP Address (4 bytes)                            |
+---------------------------------------------------------------------------+
|                           Subnet Mask (4 bytes)                           |
+---------------------------------------------------------------------------+
|                           Next Hop (4 bytes)                              |
+---------------------------------------------------------------------------+
|                           Metric (4 bytes)                                |
+---------------------------------------------------------------------------+
```
]

=== Reduce Convergence Time

To reduce the convergence time, RIP uses the following mechanisms:

- Split Horizon: Prevents routing information from being sent back in the direction it came from.
- Route Poisoning: When a route is no longer available, the router advertises the route with an infinite metric.
- Hold-Down Timer: Prevents the router from accepting routing information for a certain period of time after a route has been removed.

== Open Shortest Path First (OSPF)

While RIP or static routing is often still used for smaller networks on the Internet today, OSPF is intended for larger networks.
OSPF is an open standard (Open SPF) for a link-state protocol.
Unlike RIP, this is a state-oriented routing protocol.
The 'link state' refers to the condition of a connection between two IP routers.
IP routers that support OSPF are also referred to as OSPF routers.
The original version of OSPF is specified in RFC 1138.
Currently, OSPF is used in version 2 (OSPFv2) and in version 3 (OSPFv3) (RFC 2328 and RFC 5340, respectively).

=== Concepts

Each OSPF router maintains a Link-State database containing all routing information for the network.
Routing information exchange occurs between immediate neighbors for smaller networks and between conventional and designated neighbors in larger networks.
Each router constructs a Shortest-Path-First (SPF) tree, also known as a spanning tree, using Dijkstra's algorithm.
The branches of this tree represent the optimal routes to known subnets and other IP routers.
Routing and forwarding tables are generated based on the SPF tree, with each edge representing a subnet transition between routers, assigned costs based on factors like load, throughput, or delay.

To ensure all routers are synchronized and aware of the network topology, they communicate changes to their neighbors, forwarding updates in a broadcast manner via IP multicast or point-to-point connections.
A router initiates neighbor relationships by sending Hello packets (Hello-PDUs) to discover which adjacent routers become neighbors.
Once established, neighbors share routing information through Database Description PDUs.

When a new router joins the network, it sends Link-State Advertisements (LSAs) to neighbors, who relay this information throughout the network, flooding it with routing data.
Periodic updates of topology changes are scheduled every 30 minutes to synchronize link-state databases.
Additionally, routers perform a Liveness Check, sending Hello PDUs to indicate activity; if no Hello PDU is received for 40 seconds, the router is considered down.
The detecting router then broadcasts a Link-State Update PDU, which is acknowledged by neighbors.

Once a change is detected, OSPF quickly disseminates updates across the network, ensuring high convergence rates.
For example, if a connection between routers with IP addresses 10.1.1.2 and 10.1.1.4 fails, the routers propagate Link-State updates until all link-state databases are synchronized, allowing for the recalculation of the shortest paths across the network.

=== OSPF In Big Networks

For large networks, OSPF can be segmented into multiple autonomous areas to streamline optimal route calculations in participating routers.
These segments, referred to as Areas, are identified by unique Area IDs (e.g., 0.0.3.1) and serve to hierarchically organize an autonomous system.
All areas connect through an OSPF Backbone, designated as Area 0 (ID 0.0.0.0).

Within each area, routers employ the same Shortest-Path-First algorithm and share a common Link-State database.
Each router is aware only of the routers within its area but must connect to the OSPF Backbone via an Area Border Router (ABR).

OSPF defines four types of routers:

- *Internal Routers:* Operate solely within their area and do not communicate externally.
- *Area Border Routers (ABRs):* Connect two or more areas within an autonomous system.
- *Backbone Routers:* Operate within the Backbone to route traffic internally but are not ABRs.
- *Autonomous System Border Routers (ASBRs):* Facilitate routing information exchange between multiple autonomous systems.

ABRs are aware of the Link-State databases of all connected areas and are included in the Backbone. The Backbone's primary function is to manage traffic between areas, while ASBRs handle external routes to other autonomous systems.
Each router has a unique Router ID, and routing information is exchanged directly or via specific multicast addresses, typically among neighboring routers.
Dividing a large autonomous system into areas reduces the size of Link-State databases and routing tables. In networks with many OSPF routers, the burden can be significant, requiring $n(n-1)/2$ neighbor relationships to be established. To mitigate this in broadcast networks, a designated router (DR) and a backup designated router (BDR) are elected to manage routing information distribution, significantly reducing network load. Only the DR and BDR handle routing information exchange, minimizing the number of necessary neighbor relationships to $n -1$.

#pagebreak()

=== Protocol Data Units (PDUs)

The OSPF packet header
#example[
```
        0                   1                   2                   3
        0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       |   Version #   |     Type      |         Packet length         |
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       |                          Router ID                            |
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       |                           Area ID                             |
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       |           Checksum            |             AuType            |
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       |                       Authentication                          |
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       |                       Authentication                          |
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```
]

OSPFv2-Hello-PDU
#example[
```
        0                   1                   2                   3
        0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       |                        Network Mask                           |
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       |         HelloInterval         |    Options    |    Rtr Pri    |
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       |                     RouterDeadInterval                        |
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       |                      Designated Router                        |
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       |                   Backup Designated Router                    |
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       |                          Neighbor                             |
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       |                              ...                              |
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```
]
The Hello-PDU is used during the initialization of an OSPF router to discover all neighboring routers and to regularly check the availability of connections with these neighbors.
Additionally, in broadcast networks, the Hello-PDU is employed to elect a designated router (DR) and a backup designated router (BDR).




== Forwarding

Each router and each host maintain a forwarding table that could look like this:

#table(
  columns: 5,
  table.
  header([Network Destination], [Netmask], [Gateway], [Interface], [Metric]),
)

== Forwarding Rules

Forwarding rules are used to determine how a router forwards packets.
Before CIDR (Classless Inter-Domain Routing) was introduced, routers used classful routing to determine how to forward packets.
With CIDR the routing protocols need to transmit the netmask along with the IP address.
This mechanism is called longest prefix match.

=== Longest Prefix Match

When an IPv4 packet arrives at a router, several actions are executed to forward the packet as quickly as possible through the correct output channel.
The destination address is checked against the entries in the forwarding table.
The route is determined using the Longest Prefix Matching algorithm, outlined as follows:

- The destination address of the incoming packet is compared with all entries in the forwarding table by performing a bitwise AND operation between the destination address and the network mask of each route entry.
  The result is then compared with the network destination field in the same entry.
  If they match, the entry represents a potential route.
- Among the potential routes, the one with the longest match (i.e., the most matching bits, from left to right) is selected.
  To optimize, the search starts with longer prefixes.
- If multiple routes have the same match length, the route with the best (smallest) metric value is chosen.
  If still tied, the route is selected randomly.
- For packets without a matching route, the default route (with network destination "0.0.0.0" and network mask "0.0.0.0") is used to forward the packet.
  This route is predefined and configured on the router or host.

#pagebreak()
#example[ Forwarding Table
#table(
    columns: 5,
    table.header([Network Destination], [Netmask], [Gateway], [Interface], [Metric]),
    [192.168.1.0], [255.255.255.0], [192.168.1.1], [eth0], [10],
    [192.168.0.0], [255.255.254.0], [192.168.0.1], [eth1], [20],
    [10.0.0.0], [255.0.0.0], [10.0.0.1], [eth2], [5],
    [0.0.0.0], [0.0.0.0], [10.0.0.254], [eth2], [100],
 )
 Incoming packet with destination address 192.168.1.50

 1. Comparison with 192.168.1.0/24 (Netmask: 255.255.255.0):
  - The AND operation results in 192.168.1.0 -> matches 
  - Potential route.
 2. Comparison with 192.168.0.0/23 (Netmask: 255.255.254.0):
  - The AND operation results in 192.168.0.0 -> no match.
  - No potential route.
 3. Comparison with 10.0.0.0/8 (Netmask: 255.0.0.0):
  - The AND operation results in 10.0.0.0 -> no match.
  - No potential route.
 4. Default Route (0.0.0.0/0):
 - The AND operation results in 0.0.0.0, which matches, but it’s used only if no other specific routes match

 Selected Route: The first entry 192.168.1.0/24 (interface eth0), as it provides the longest prefix match.
 ]


=== Forwarding Rules in End Systems

End systems, such as hosts, also have forwarding tables just with some extra entries.

#table(
  columns: (1fr,3fr),
  align: (left, left),
  table.header([Route Name], [Description]),
  
  [Default Route], [Matches any destination address (0.0.0.0/0) and is used when no other specific route matches. Packets are forwarded to the default gateway.],
  
  [Loopback Route], [Handles packets addressed to the local system (127.0.0.0/8). These packets are not sent to the network but remain on the local host.],
  
  [Host Route], [Routes packets sent to the local host’s own IP address. Packets are handled within the system, typically via the loopback interface.],
  
  [Limited Broadcast Route], [Routes packets sent to the broadcast address 255.255.255.255. These packets are confined to the local network segment and not routed further.],
  
  [Directed Broadcast Route], [Sends packets to all hosts within a specific subnet (e.g., 192.168.178.255 for a /24 network).],
  
  [Multicast Route], [Handles multicast traffic to group addresses (224.0.0.0/4). These packets are sent to multiple hosts that are part of the same multicast group.]
)
