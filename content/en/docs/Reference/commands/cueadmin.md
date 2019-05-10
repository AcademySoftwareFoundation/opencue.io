---
title: "cueadmin"
linkTitle: "cueadmin"
date: 2019-05-10
weight: 2
description: >
  Administer your OpenCue deployment
---

This page lists the arguments and flags you can specifiy for the `cueadmin`
command. You can run `cueadmin` to administer and monitor your OpenCue
deployment from the command line.

## Optional arguments

### `-h` and `--help`           

Show the help message and exit.

## General options

### `-server` 

Arguments: `HOSTNAME [HOSTNAME ...]`

Specify cuebot addres(s).
  
### `-facility`

Arguments: `CODE`

Specify the facility code.

### `-verbose` and `-v`

Turn on verbose logging.

###  `-force`

Force operations that usually require confirmation.

## Query options

### `-lj` and `-laj`

Arguments: `[SUBSTR [SUBSTR ...]]`

List jobs with optional name substring match.
 
### `-lji`

Arguments: `[SUBSTR [SUBSTR ...]]`

List job info with optional name substring match.
  
### `-ls`

List shows.

### `-la`

List allocations.

### `-lb`

Arguments: `SHOW [SHOW ...]`

List subscriptions.


### `-lp` and `-lap`

Arguments: `[[SHOW ...] [-host HOST ...] [-alloc ...] [-job JOB ...] [-memory ...] [-limit ...] [[SHOW ...] [-host HOST ...] [-alloc ...] [-job JOB ...] [-memory ...] [-limit ...] ...]],

List running procs. Optionally filter by show, show, memory, alloc. Use -limit to limit the results to N procs.


### `-ll` and `-lal`

Arguments: `[[SHOW ...] [-host HOST ...] [-alloc ...] [-job JOB ...] [-memory ...] [-limit ...] [[SHOW ...] [-host HOST ...] [-alloc ...] [-job JOB ...] [-memory ...] [-limit ...] ...]]

List running frame log paths. Optionally filter by show, show, memory, alloc. Use -limit to limit the results to N logs.

### `-lh`

Arguments: `[[SUBSTR ...] [-state STATE] [-alloc ALLOC] [[SUBSTR ...] [-state STATE] [-alloc ALLOC] ...]]`

List hosts with optional name substring match.

### `-lv`

Arguments: `[[SHOW] [[SHOW] ...]]`

List default services.

### `-lba`

Arguments: `ALLOC`

List all subscriptions to a specified allocation.

### `-state`

Arguments: `STATE [STATE ...]`

Filter host search by hardware state, up or down.
