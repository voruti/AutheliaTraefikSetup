# AutheliaTraefikSetup

Clone onto two machines, insert your configuration in `.env` and start one stack per machine.

Example `hosts` file to set the domain names to point to the correct hosts:

```hosts
192.168.0.1    authelia.example.com
192.168.0.1    traefik-host1.example.com
192.168.0.1    service-host1.example.com
192.168.0.2    traefik-host2.example.com
192.168.0.2    service-host2.example.com
```
