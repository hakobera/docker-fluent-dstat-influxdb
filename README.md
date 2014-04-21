# docker-fluent-dstat-influxdb

Docker image sample that send dstat output to influxdb using fluentd.

## How to run

```sh
$ docker pull  hakobera/fluent-dstat-influxdb
$ docker run -i -t -p 18083:8083 -p 18086:8086 hakobera/fluent-dstat-influxdb
```

After run, create db.

```sh
$ curl -X POST 'http://[container_ip]:18083/db?u=root&p=root' -d '{"name": "perf"}'
```

and open http://[container_ip]:18083
