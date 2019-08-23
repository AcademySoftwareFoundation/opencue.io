---
title: "Applying database migrations"
linkTitle: "Applying database migrations"
weight: 1
date: 2019-08-22
description: >
  How to apply new database migrations
---

This page describes how to apply new database migrations when necessary.

## What is a database migration and why do I need one

Occasionally developers will make code changes that require the database schema to be updated. When
this happens the schema changes will be added as a new "migration". The migration contains raw SQL
and only the parts of the schema that have changed. The migration can be applied and safely rolled
back using the database management tool of your choice. This example uses
[flyway](https://flywaydb.org/).

When updating Cuebot it is important to apply any new migrations to ensure the Cuebot code matches
the correct database schema. These changes will also be flagged in the release notes.

To apply a migration:

1. Stop Cuebot, by either killing the Cuebot process or stopping its container.

. Run the `flyway` command to execute the migrations, using the credentials from the original
[database installation](/docs/getting-started/setting-up-the-database). Run this from the root
folder of the OpenCue repo.
    ```shell
    flyway -url=jdbc:postgresql://$DB_HOST/$DB_NAME -user=$USER -n -locations=filesystem:cuebot/src/main/resources/conf/ddl/postgres/migrations migrate
    ``` 

1. Update Cuebot by following the installation instructions on [Deploying Cuebot](/docs/getting-started/deploying-cuebot).

1. Restart Cuebot.
