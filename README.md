# k3s vagrant setup

Minimal [vagrant](https://www.vagrantup.com/) setup to test [k3s](https://k3s.io/).

Use `./up.sh` to spawn a `k3s` cluster composed of 1 server and 3 agents.
Use `./clean.sh` to clean things up.

You can adapt the `Vagrantfile` if you need to change the composition of the
cluster.
