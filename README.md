# AutheliaTraefikSetup

Clone onto two machines, insert your configuration in `.env` (on both machines) and start one stack per machine.

The domain names should point to the correct hosts:

```txt
authelia.example.com        ->  host1
traefik-host1.example.com   ->  host1
service-host1.example.com   ->  host1
traefik-host2.example.com   ->  host2
service-host2.example.com   ->  host2
```

## Results of testing

Tests are done using a third machine.

Using a browser (Firefox) works as expected. The services on both hosts require a login and are reachable afterwards.

The following requests are made using [Postman](https://github.com/postmanlabs) and should test the behavior with the `Proxy-Authorization` header:

![botToServiceHost1](botToServiceHost1.jpg)
A request to the service running on the same machine as Authelia (host 1) works fine. Apparently no cookies are created (! → <https://github.com/authelia/authelia/discussions/6508#discussioncomment-8120133>).

The exact same request, but targeting the service on host 2 (the `1` is replaced with a `2` within the URL, nothing else is changed):
![botToServiceHost2](botToServiceHost2.jpg)
A redirect to the Authelia login page. The log of Authelia shows (IPs, etc. redacted):

```log
host1-authelia-1  | time="2024-01-14T16:41:02Z" level=debug msg="Check authorization of subject username= groups= ip=192.168.POST.MAN and object https://service-host2.example.com/ (method GET)."
host1-authelia-1  | time="2024-01-14T16:41:02Z" level=info msg="Access to https://service-host2.example.com/ (method GET) is not authorized to user <anonymous>, responding with status code 401 with location redirect to https://autheliatest.example.com/?rd=https%3A%2F%2Fservice-host2.example.com%2F&rm=GET" method=GET path=/api/verify remote_ip=192.168.POST.MAN
```

The `TRAEFIK_ENTRYPOINTS_WEBSECURE_FORWARDEDHEADERS_TRUSTEDIPS` (and `..._PROXYPROTOCOL_...`) are over-configured, but I thinks this doesn't change the result.
