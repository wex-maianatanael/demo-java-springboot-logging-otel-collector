# demo-java-springboot-logging-otel-collector
How to use opentelemetry collector.

> [!IMPORTANT]  
> The logs are being sent as raw data.\
> For some reason the otel collector is not recognizing the source type `_json`.

## How to run it locally?
### Docker compose

Execute the following command in order to run all the containers needed.

```shell
docker compose up --build -d
```

Once it's done, all the container will be up and running:

 - splunk;
 - otel-collector;
 - api (java application).

### Splunk

1. Create the `demo` index;
2. Attach the new index to the existing hec/token;
3. You're ready to search the logs.

### API

Open the browser and hit the following url:

- `http://localhost:8080/swagger-ui/index.html`

Now you can test each endpoint and send requests. The OpenTelemetry collector will ingest the logs and then send them to splunk via hec.

### Environment shutdown

Once you're done with the tests, execute the following command to stop the container and remove the infra resources created at runtime.

```shell
docker compose down
```