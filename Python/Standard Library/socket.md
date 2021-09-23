# Socket Module CheatSheet

## Definition

A network socket is an internal endpoint for sending or receiving data within a node on a computer network.

In practice, socket usually refers to a socket in an Internet Protocol (IP) network, in particular for the **Transmission Control Protocol (TCP)**, which is a protocol for *one-to-one* connections.  
In this context, sockets are assumed to be associated with a specific socket address, namely the **IP address** and a **port number** for the local node, and there is a corresponding socket address at the foreign node (other node), which itself has an associated socket, used by the foreign process. Associating a socket with a socket address is called *binding*.

## Socket Creation & Connection

```python
import socket

# socket over the internet, socket is a stream of data
socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

socket.connect = (("URL", port: int))  # connect to socket
socket.close()  # close connection
```

## Making HTTP Requests

```python
import socket
HTTP_Method = "GET http://url/resource HTTP/version\n\n".encode()  # set HTTP request (encoded string from UTF-8 to bytes)
socket.send(HTTP_Method)   # make HTTP request

data = socket.recv(buffer_size)  # receive data from socket
decoded = data.decode()  # decode data (from bytes to UTF-8)
```
