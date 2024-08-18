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


= Ethernet



= Spanning Tree Protocol (STP)
