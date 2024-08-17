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
