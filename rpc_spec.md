## All the below rpcs are assumed to exist on the root node in the godot scene hierarchy, which in this project is called a Peer. Servers and every type of client inherit from Peer.


# CLIENT <-> SERVER

## World Loading

The server is changing worlds, the client is responsible for filtering it
<- on_world_change(url)

Suggest a new world, the server is responsible for deciding if this is a good idea and then filtering it
  (Fancy worldservers can give clients a filtered version of the world if they are running their own webserver)
-> request_change_world(url)


# CLIENT <-> PEER

## Avatars

Player is attempting to send a VRM, your client is responsible for filtering this
  (Does godot download it automatically? Can you set a max DL size? Make sure a peer can't overload you)
<-> peer_loaded_avatar(buffer)

## Tracking

Player added tracker, make sure to set a maximum so they can't spam this
<-> peer_tracker_activated(tracker_name)

Player removed tracker, make sure to handle them removing a nonexistent tracker
<-> peer_tracker_deactivated(tracker_name)

Update positions of all trackers at once, any value may be null - should maybe be netcoded better for online games?
<-> (unreliable) update_peer_tracker_pos(head_pos, lhand_pos, rhand_pos, tracker_pos_arr)
