= Network topology

A Network topology is the arrangement of the various elements (links, nodes, etc.) of a computer network.
Essentially, it is the topological structure of a network and may be depicted physically or logically.

== physical topology

Physical topology refers to the placement of the network's various components, including device location and cable installation.

== logical topology

Logical topology shows how data flows within a network, regardless of its physical design.

== Types of network topologies

The most common network topologies include:

- Bus topology
- Ring topology
- Star topology
- Mesh topology
- Tree topology
- Cell topology

=== Bus topology

In a bus topology, all devices are connected to a single cable, called the bus. Data is transmitted in both directions to all devices on the network.


#figure(
  image("../resources/busnetwork.png", width: 20%),
  caption: [Bus topology],
) <busnetwork>

*Advantages*:
  - Easy to install and expand
  - Requires less cable than other topologies

*Disadvantages*:
  - Performance decreases as more devices are added
  - Difficult to troubleshoot
  - Single point of failure (if the bus fails, the entire network goes down)

=== Ring topology

In a ring topology, each device is connected to two other devices, forming a ring. Data travels in one direction around the ring until it reaches its destination.

#figure(
  image("../resources/ringnetwork.png", width: 20%),
  caption: [Ring topology],
) <ringnetwork>

*Advantages*:
  - No collisions
  - Equal access to the network
  - Each node acts as a repeater allowing the signal to travel long distances

*Disadvantages*:
  - Difficult to troubleshoot
  - Single point of failure (if one device fails, the entire network goes down)
  - Performance decreases as more devices are added

=== Star topology

In a star topology, all devices are connected to a central hub or switch. Data is transmitted from one device to the hub, which then forwards it to the destination device.

#figure(
  image("../resources/starnetwork.png", width: 20%),
  caption: [Star topology],
) <starnetwork>

*Advantages*:
  - Easy to install and manage
  - Centralized control
  - Fault isolation (if one device fails, the rest of the network remains operational)

*Disadvantages*:
  - If the central hub is not redundant, it becomes a single point of failure
  - Requires more cable than other topologies

#pagebreak()
=== Mesh topology

In a mesh topology, each device is connected to other devices in the network. Data can take multiple paths to reach its destination, increasing reliability and fault tolerance.
In a full mesh topology, every device is connected to every other device in the network.

#figure(
  image("../resources/meshnetwork.png", width: 20%),
  caption: [Mesh topology],
) <meshnetwork>

*Advantages*:
  - High fault tolerance
  - Reliable data transmission
  - Scalable

*Disadvantages*:
  - Expensive to install and maintain
  - Requires a large amount of cabling

=== Tree topology

A tree topology combines characteristics of star and bus topologies. Devices are arranged in a hierarchy, with multiple star networks connected to a central bus.

#figure(
  image("../resources/treenetwork.png", width: 20%),
  caption: [Tree topology],
) <treenetwork>

*Advantages*:
  - High scalability
  - Centralized control
  - Fault isolation

*Disadvantages*:
  - Difficult to configure and manage
  - Requires more cable than other topologies
  - Single point of failure (if the central bus fails, the entire network goes down)

=== Cell topology

The cellular network topology is applicable only in wireless networks.
It consists of multiple cells, each served by a base station. Cells are arranged in a pattern to provide coverage to a large area.

= Access methods


In wired networks like Thin Ethernet (10BASE2) or Token Ring all participants share a common transmission medium, referred to as Shared Media.
An access control method is necessary to ensure that only one participant transmits data at any given time to avoid collisions and ensure error-free transmission.
Shared Media access methods are categorized into deterministic and non-deterministic access methods.

== Deterministic access methods

Access to the transmission medium is coordinated among participants at specific times.
An example is the Token-Passing method used in Token Ring and FDDI networks.
In this method, a token grants the right to send data.
The participant holding the token can send data for a limited time.
Once done, or if they choose not to send data, the token is passed to the next participant.
This ensures fairness, as every participant eventually receives the token, allowing them to send data after a predictable wait time.

== Non-deterministic access methods

In this scenario, all participants compete directly for access to the transmission medium.
The wait time for access and the amount of data that can be transmitted are unpredictable, depending on the number of participants and their data transmissions.
An example of this is Carrier Sense Multiple Access with Collision Detection (CSMA/CD) used in Thin Ethernet (10BASE2).
When a participant wants to send data, it first checks if the medium is free.
If it is, they proceed to send.
However, if two or more participants attempt to send simultaneously, a collision occurs.
CSMA/CD detects these collisions, causing the participants to stop transmitting.
After a random delay, each participant attempts to send again, reducing the likelihood of another collision.


= Collision domains

A Collision Domain refers to a network scenario where all devices within the same domain must listen to a message sent by any one device, even if the message isn't intended for them.
This can lead to a problem when two devices transmit simultaneously, causing a collision.
After a collision, the devices must wait and re-transmit their messages one at a time.
This issue occurs only in half-duplex mode.
