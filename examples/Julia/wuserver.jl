#!/usr/bin/env julia

#
#   Weather update server
#   Binds PUB socket to tcp://*:5556
#   Publishes random weather updates
#

using ZMQ

context = Context()
socket = Socket(context, PUB)
ZMQ.bind(socket, "tcp://*:5556")

while true
    zipcode = rand(10000:99999)
    temperature = rand(-80:135)
    relhumidity = rand(10:60)
    message = "$zipcode $temperature $relhumidity"
    ZMQ.send(socket, message)
    yield()
end

ZMQ.close(socket)
ZMQ.close(context)
