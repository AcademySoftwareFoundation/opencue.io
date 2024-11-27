---
title: "Configuring OpenCue with Loki for framelogs"
linkTitle: "Configuring OpenCue with Loki for framelogs"
weight: 8
date: 2024-11-27
description: >
  Configuring OpenCue with Loki for framelogs
---

This page describes how to configure OpenCue to use Loki for framelogs

## How it works
The Loki framelog backend is configured on the cuebot server. When jobs are submitted to the
configured server it will register Loki-enablement on the job submitted together with the configured
address of the Loki instance. When jobs are dispatched to RQD the loki-enablement and address will
be sent to RQD and used for log writing instead of file based logs. Changing loki-enablement and/or
address will not change already submitted jobs.

The framelogs being sent to Loki can be read using a custom LokiView widget in cuegui

## Requirements
 - Loki version 2.4+

## Configuring cuebot
The cuebot server can be configure to use Loki either by setting command line arguments or using the
opencue.properties file

#### Command line arguments :
```bash
# Enable loki
--log.loki.enabled=true
# Base url for the loki instance (eg. http://localhost:3100)
--log.loki.url=<loki-url>
```

#### opencue.properties file :
```toml
# Enable loki
log.loki.enabled=true
# Base url for the loki instance (eg. http://localhost:3100)
log.loki.url=<loki-url>
```

## Configuring Loki
By default Loki will not allow to query logs older than 30 days. This limitation can be removed with
following option :
```yaml
limits_config:
  max_query_length: 0h # Default: 721h
```
Refer to the Loki documentation on how to configure Loki

Note : When the Loki instance has just started, it can take a few seconds before it's ready to
receive requests. It can be "kickstarted" by accessing the <loki-url>/ready 
(eg. http://localhost:3100/ready)

## LokiView widget
![LokiView Widget](/docs/images/lokiview_widget.png)
