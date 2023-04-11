## To run this docker container:
``` 
docker-compose up -d
```

## Releasing a new image
First, build the image:
```
make build VERSION=X.Y
```
Next, release a new version by adding a tag:
```
make tag VERSION=X.Y
```
Finally, release the image:
```
make release VERSION=X.Y
```
Once we released a new image version, we tag the respective git commit:
```
git tag -a -s "vVERSION" -m "Docker image version VERSION"
git push --tags origin main
```

## Adding custom options:
To use custom options when running this image you can add them to `command:` line in the docker-compose.yml like this:

    command: [ "-ephemeral-ports-range", "30000:60000" ]

so the full docker-compose.yml looks something like this:

    version: "3.8"

    services:
        snowflake-proxy:
            network_mode: host
            image: thetorproject/snowflake-proxy:latest
            container_name: snowflake-proxy
            restart: unless-stopped
            command: [ "-ephemeral-ports-range", "30000:60000" ]

### Available options:

To list all the available options run the proxy with `-help`:
```
docker run  thetorproject/snowflake-proxy -help
```
