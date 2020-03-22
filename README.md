# k3s vagrant setup

Minimal [vagrant](https://www.vagrantup.com/) setup to test [k3s](https://k3s.io/).

Use `./up.sh` to spawn a `k3s` cluster composed of 1 server and 3 agents.
Use `./clean.sh` to clean things up.

You can adapt the `Vagrantfile` if you need to change the composition of the
cluster.

## Caveats

The biggest challenge with this setup was virtualbox related.

Using virtualbox, I add two ifaces to each vm:

 - A NAT iface used for external connectivity
 - A hostnet iface used for node to node and host to node connections

By default k3s and flannel pick the NAT one. Some configuration is needed to:

 - tell k3s which IP address it should advertise for the node
 - tell flannel which iface should be used to route traffic to others nodes

These configuration options are set in the systemd services (`NODE_IP` and
`--flannel-iface`).
