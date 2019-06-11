# Gamacloud Metrics

The idea is to collect logs from all nodes

Prerequisites:
* Change Your Docker log diver to journald

```bash
kubectl apply -f namespace.yaml
kubectl apply -f roles.yaml
kubectl apply -f influxdb.yaml
kubectl apply -f telelog.yaml
kubectl apply -f chronograf.yaml
kubectl apply -f kapacitor.yaml
kubectl apply -f stress.yaml
```

or if you're a one liner:

```bash
kubectl apply -f namespace.yaml -f roles.yaml -f influxdb.yaml -f telelog.yaml -f chronograf.yaml -f kapacitor.yaml -f stress.yaml
```

Finally to access Chronograf from within our local browser we need the following port forward.

```bash
kubectl port-forward svc/chronograf -n logging 8888:80
```

Go to [localhost:8888](http://localhost:8888) now!

## Run with local up cluster

_TBD_.

## Developing the Kapacitor UDF

File `docker-compose.yaml` is useful during the development and debugging of the Kapacitor UDF.

To make it working do not forget to forward the port of the influxdb within minikube.

```bash
kubectl port-forward svc/influxdb -n logging 8686:8686
```

Then run

```bash
docker-compose up -d
```

## Other suitable docker log drivers

It is possible to use this with **[syslog docker log driver](https://docs.docker.com/config/containers/logging/syslog/#options)** with following log options:

- `syslog-format=rfc5424micro`
- `syslog-address=udp://1.2.3.4:1111` (telegraf syslog plugin)

In such case:

- there is not need for rsyslog
- telegraf syslog plugin in UDF mode (at the moment in TCP/TLS mode there is not way to disable octet framing requirement - ie., RFC5425)
- syslog facility will be fixed (depending on the `syslog-facility` option)

_TBD_: create an alternative setup for this setup.

---
