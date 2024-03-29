Cloud Exhibit
=============
This exhibit demonstrates what a typical cloud or multi-server
deployment may look like.

On display:

* Running Rundeck behind a reverse proxy
* Storage backend connected to a database server
* Execution logs stored in S3
* Bundling extra plugins

### Reverse proxy

This configuration exposes rundeck at `http://localhost:80` through nginx.
A similiar setup is possible behind a cloud provider proxy, such as AWS ELB[v2],
and the key is the `RUNDECK_SERVER_FORWARDED=true` environment variable which instructs
Rundeck to respect the standard `X-Forwarded-*` headers.

## Setup
**Fetch S3 log plugin**
```
mkdir libext
cd libext
wget https://github.com/rundeck-plugins/rundeck-s3-log-plugin/releases/download/v1.0.8/rundeck-s3-log-plugin-1.0.8.jar
```

**Populate `.env` file**

```bash
cp .env.dist .env
vim .env
```

### NGROK

Start up an NGROK session, if running internally. Export the "Forwarding" address as `RUNDECK_SERVER_FORWARDED`.
Once this is complete, you are able to build and start the docker-compose rundeck services. After a few minutes, you should be able to publiclly reach the NGROK forwarded address into your internal network service running Rundeck.

```bash
RUNDECK_GRAILS_URL: "${RUNDECK_GRAILS_URL}"
RUNDECK_SERVER_FORWARDED: "${RUNDECK_SERVER_FORWARDED}"
```

GRAILS_URL = DNS Entry of cloud instance

**Build and Up**

> **NOTE:** Building is not necessary the first time, however
it will be to use newer or different images after the
first build.
```
docker-compose build
docker-compose up
```
