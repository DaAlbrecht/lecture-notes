#import "../template.typ": *
#show raw: set text(font: "Berkeley Mono", size: 10pt, spacing: 100%)

= Layer 4: Transport Layer

The transport layer is responsible for end-to-end communication between two devices.
There exist two main ways to provide this service: connection-oriented and connectionless.

== Connection-Oriented / Connectionless Communication

=== Connection-Oriented Communication

In connection-oriented communication there exist three phases:

1. Connection Establishment
2. Data Transfer
3. Connection Termination

Connection-oriented communication ensures that the data is delivered *in order* and *without errors*.

=== Connectionless Communication

Connectionless communication is simpler than connection-oriented communication but has the following possible downsides:

- The loss of data is possible.
- The data can arrive out of order.
- The data can arrive corrupted.

== End to End Communication

An IP packet does not know for which application on the destination host it is intended. 
The transport layer is responsible for delivering the data to the correct application.
This is done by using ports.

=== Ports

A port is a number that is used to identify a specific application on a host.
There are three types of ports:

- *Well-known ports (0-1023):* These are standardized by the IANA for specific services like HTTP (80) or HTTPS (443).
- *Registered ports (1024-49151):* These are assigned by the IANA to specific services. Organizations or developers can request a port number for their application from the IANA.
- *Dynamic ports (49152-65535):* These can not be assigned by the IANA and are used for temporary, private or customised services.

#pagebreak()

== TCP - Transmission Control Protocol

TCP is a connection-oriented protocol that provides reliable, ordered, and error-checked delivery of a stream of bytes.

Transmission Control Protocol accepts data from a data stream, divides it into chunks, and adds a TCP header creating a TCP segment.
The TCP segment is then encapsulated into an Internet Protocol (IP) datagram, and exchanged with peers.

=== TCP Header

#rect(fill: rgb("#F5F5F5"),
```
    0                   1                   2                   3
    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |          Source Port          |       Destination Port        |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                        Sequence Number                        |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                    Acknowledgment Number                      |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |  Data |       |C|E|U|A|P|R|S|F|                               |
   | Offset| Rsrvd |W|C|R|C|S|S|Y|I|            Window             |
   |       |       |R|E|G|K|H|T|N|N|                               |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |           Checksum            |         Urgent Pointer        |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                           [Options]                           |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                                                               :
   :                             Data                              :
   :                                                               |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```
)
