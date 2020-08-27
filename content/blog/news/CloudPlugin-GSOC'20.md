---
title: "Google Summer of Code '20 - Cloud Plugin"
linkTitle: "GSoC'20 : Cloud Plugin"
date: 2020-08-27
weight: 1
description: >
  A starter to the CueCommander cloud plugin; work done for Google Summer of Code '20
---

A blog post + starter material for the Cloud Plugin - work done during Google Summer of Code on creating a CueCommander
 plugin that can be used to managed cloud pools
 
## Summer of Code Proposal: 

The main proposal consisted of the plan of action for the 3 months of development, which included research about 
finding a common language among cloud providers when it came to managing a pool of instances and the ability to create
and resize these cloud groups through their API

I took Google Cloud Platform as the primary cloud provider and tried to find parallels in other providers and 
started designing the main API around it. 

A [Design Document](https://docs.google.com/document/d/1cCPrZsM8fRbcluTppcuPFQ6_tfQo5rZE9W2m6Hms8pw/edit?usp=sharing) 
about the initial design was then shared with the community for feedback and review which included the specs of the API
 (which changed over the course of 3 months) and the API matrix which shows what the parallels in each provider are
 
 
## Cloud Plugin Setup

#### Google Compute Engine setup

Listing the minimum requirements for the cloud plugin to work with GCE

`NOTE: My deployment included setting up Cuebot on GCE`

1. GCP project with Compute Engine API and Cloud Logging API enabled

2. Setup `Application Default Credentials` and make sure the google python api client (which is a requirement for this plugin)
 has access to it

3. Use the `cloud_plugin_resources.yaml` under the `cuegui/config` directory to setup your GCP project name and
the zone

4. At least one instance template setup on the cloud: I was using a RQD Blender docker image uploaded as an
[Instance Template](https://cloud.google.com/compute/docs/instance-templates) with its appropriate VM type


#### Cloud Plugin Interface

The Cloud plugin should be available to launch from the menu bar by navigating: 
**Views/Plugins -> CueCommander -> Cloud Plugin**

1. The cloud plugin interface consists mainly of two components:
    1. Main window which shows the list of cloud groups available with all registered providers
    2. A cloud group addition dialog that can be used to create a cloud group from the interface itself
    
#### Cloud Plugin functionality
 
1. To start create a cloud pool group, use the `Add Cloud Group` button to launch the 
dialog that will allow you to create a cloud group

![Add Cloud Group Dialog](/blog/images/AddCloudGroupDialog.png)

2. If the API request is successful you should now see an entry in the Cloud Plugin's main interface

![After cloud group addition](/blog/images/MainInterfacePostAddition.png)

3. The right-click content menu has two additional functionality: 
    1. Resizing (scaling up/down) the number of instances in a group
    2. Deleting the group altogether

![Cloud Plugin Context Menu](/blog/images/CloudPluginContextMenu.png)






