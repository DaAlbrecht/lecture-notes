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

== TCP/IP reference model

The TCP/IP reference model is a four-layer model that describes the protocols used in the Internet. The four layers are:

#figure(
  image("../resources/tcp-ip-model.png", width: 80%),
  caption: ["TCP/IP reference model"],
) <tcp_ip_reference_model>

