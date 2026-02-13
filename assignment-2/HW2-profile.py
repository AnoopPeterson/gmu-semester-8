"""An example of constructing a profile with two nodes, node 1 and node 2. 
IP address of node 1 is 192.168.1.1, IP address of node 2 is 192.168.1.2
Node 1 also has a public IP address. 

Instructions:
Wait for the profile instance to start, and then log in to either VM via the
ssh ports specified. (Source: Geni-Lab tutorials)
"""

import geni.portal as portal
import geni.rspec.pg as rspec

request = portal.context.makeRequestRSpec()

# Node 1: The web server
node1 = request.XenVM("web-server")
iface1 = node1.addInterface("if1")

# Specify the component id and the IPv4 address for node 1
iface1.component_id = "eth1"
iface1.addAddress(rspec.IPv4Address("192.168.1.1", "255.255.255.0"))

# Request a routable IP for node 1. By default nodes are given private addresses 
# that cannot be accessed from the public Internet. Use this if you need to run a service
# you want to access from the public Internet.
node1.routable_control_ip = True

# Node 2: The data server
node2 = request.XenVM("data-server")
iface2 = node2.addInterface("if2")

# Specify the component id and the IPv4 address for node 2
iface2.component_id = "eth2"
iface2.addAddress(rspec.IPv4Address("192.168.1.2", "255.255.255.0"))

# Request a lan connetion and add the two interfaces to it
link = request.LAN("lan")

link.addInterface(iface1)
link.addInterface(iface2)

# output the RSpec profile
portal.context.printRequestRSpec()