#import "../template.typ": *

= Protocols and protocol layers

Communication in computer networks relies on the exchange of messages.
For effective communication, participants must understand each other, which is achieved through agreed-upon protocols.
These protocols exist at various layers, from low-level bit transmission to high-level information representation.
\
Protocols define the syntax (message format) and semantics (vocabulary and meaning) of valid messages.
Due to the complex requirements of computer networks, communication is structured into layered models.
Each layer addresses a specific aspect of communication and provides interfaces to the layers above and below it.
This modular approach, where data is encapsulated at each layer, allows for flexibility.
\
Protocols within a layer can be changed or replaced without affecting the entire communication system, as long as the interfaces remain consistent.

The three most well-known layered models are the TCP/IP reference model, the OSI reference model, and the hybrid reference model.

#pagebreak()

== TCP/IP reference model

The TCP/IP reference model is a four-layer model that describes the protocols used in the Internet. The four layers are, starting from the top:

#figure(
  image("../resources/tcp_ip_model.png", width: 50%),
  caption: [TCP/IP reference model],
) <tcp_ip_reference_model>

#figure(
  image("../resources/tcp_ip_model_data_view.png", width: 100%),
  caption: [Each layer adds additional data],
) <tcp_ip_model_data_view>

#pagebreak()

== Hybrid reference model

#figure(
  image("../resources/hybrid_reference_model.png", width: 25%),
  caption: [Hybrid reference model],
) <hybrid_reference_model>

=== Physical layer

Responsible for transmitting raw bits (1s and 0s) over a medium.
It defines the physical connection to the transmission medium and how data is converted into signals.
Protocols in this layer determine the data rate and whether transmission can occur simultaneously in both directions.

=== Data link layer

Detects and manages errors that occur during bit transmission.
It controls access to the transmission medium and handles the framing of packets.
Physical (MAC) addresses are used to deliver frames within a physical network, but error recovery is not handled.

=== Network layer

Manages the routing and forwarding of data packets between logical networks, using IP addresses.
It handles packet encapsulation and routing across different subnets, typically using the IP protocol.

=== Transport layer

Ensures reliable data transfer between processes on different devices.
It uses end-to-end protocols, such as TCP for reliable, connection-oriented communication, and UDP for faster, connectionless communication.
It also addresses processes using port numbers and ensures correct data delivery.

=== Application Layer

Contains protocols that interface directly with applications (e.g., HTTP, FTP, SMTP).
It handles the actual exchange of messages, such as emails or web pages, according to the application protocols.

== OSI reference model

The OSI (Open Systems Interconnection) model, is a seven-layer reference framework designed to standardize and facilitate communication between different systems.

#figure(
  image("../resources/osi_model.png", width: 50%),
  caption: [OSI reference model],
) <osi_reference_model>

The additional layers in the OSI model are:

=== Session layer

The Session Layer is responsible for establishing, managing, and terminating sessions, which are virtual connections between applications on separate physical devices.
It also manages dialogue control and introduces checkpoints in long data transmissions for synchronization.
If a connection is interrupted, the transmission can resume from the last checkpoint instead of starting over.

=== Presentation layer

The Presentation Layer defines the rules for formatting (or presenting) messages.
It enables the sender to inform the receiver about the data format (e.g., ASCII) to allow any necessary conversion.
This layer also handles the definition of data structures, such as fields for names or ID numbers, as well as tasks like data compression and encryption.
However, similar to the Session Layer, the Presentation Layer is rarely used in practice today because application protocols typically handle these functions.

#pagebreak()
= Ethernet

Ethernet is a widely used LAN technology that defines the physical and data link layers of the OSI model.
It uses a bus or star topology and supports data rates of:
- 10 Mbps (Ethernet)
- 100 Mbps (Fast Ethernet)
- 1 Gbps (Gigabit Ethernet)
- 10 Gbps (10 Gigabit Ethernet) and higher.

Ethernet data is transmitted in frames, which consist of the following fields:

#table(
  columns: (auto,auto,auto),
  align: (left,center + horizon,left),
  fill:(x,y) => fill_alternating(x, y),
  [Field], [Octets], [Description],
  [Preamble], [7], [Used for synchronization],
  [Start Frame Delimiter (SFD)], [1], [Indicates the start of the frame],
  [Destination MAC Address], [6], [Address of the recipient],
  [Source MAC Address], [6], [Address of the sender],
  [Type/Length], [2], [Indicates the type of data or the length of the frame],
  [Data], [46-1500], [Payload data],
  [Frame Check Sequence (FCS)], [4], [Error detection],
)

#figure(
  image("../resources/ethernet_frame.png", width: 120%),
  caption: [Ethernet frame structure],
) <ethernet_frame>

#pagebreak()
= Switches and Hubs

Switches and hubs are devices used to connect multiple devices in a network.
However, they operate differently and have distinct functions.

== Hubs

Hubs operate at the physical layer (Layer 1) of the OSI model.
They are simple devices that receive data packets from one device and broadcast them to all other connected devices.
Hubs use the bus topology, where all devices share the same communication medium thus increasing the collision domain.
They are considered inefficient for modern networks due to their broadcast nature and lack of intelligence and got replaced by switches.

== Switches

Switches operate at the data link layer (Layer 2) of the OSI model.
They are more intelligent than hubs and can learn the MAC addresses of devices connected to their ports.
Switches use this information to forward data packets only to the intended recipient, reducing unnecessary traffic and collisions by creating separate collision domains for each port.

At startup, the initial MAC address table of a switch is empty.

=== Flooding

When a switch receives a frame with an unknown destination MAC address, it floods the frame to all ports except the source port.
This allows the switch to learn the MAC address of the device that responds to the frame.

=== Forwarding

Once a switch learns the MAC addresses of devices connected to its ports, it forwards frames only to the port where the destination device is located.
This reduces unnecessary traffic and improves network efficiency.

= Spanning Tree Protocol (STP)

Spanning Tree Protocol (STP) is a network protocol that prevents loops in Ethernet networks.
Loops can occur when there are multiple paths between switches in a network, causing broadcast storms and network congestion.

Each switch undergoes a series of port states influenced by three timers.
Immediate transition from a blocking to a forwarding state could lead to loss of topology information and create loops, hence the need for five distinct port states:

#table(
  columns: (auto,auto),
  align: (left,left),
  fill:(x,y) => fill_alternating(x, y),
  [State], [Description],
  [Blocking], [Port does not forward frames],
  [Listening], [Port prepares to forward frames],
  [Learning], [Port learns MAC addresses],
  [Forwarding], [Port forwards frames],
  [Disabled], [Port is administratively disabled],
)<spanning_tree_protocol>

The time a port spends in each state is determined by three timers, with only the Root Bridge having the authority to adjust them:

- Hello Timer: Interval between BPDUs, typically 2 seconds.
- Forward-Delay Timer: Time spent in Listening and Learning states, usually 15 seconds each (total 30 seconds).
- Max Age Timer: Time a switchport retains configuration info, typically 20 seconds.

When STP is enabled, ports pass through these states in sequence:\
Blocking → Listening → Learning → Forwarding, which takes about 50 seconds under standard settings—a significant duration in networking.
The convergence time, or time needed to recalculate the Spanning Tree after a link failure, is substantial, and this delay is a common critique of STP.
