---
title: "Google Summer of Code '20 - Cloud Plugin"
linkTitle: "GSoC'20 : Cloud Plugin"
date: 2020-08-27
weight: 1
description: >
  A starter to the CueCommander cloud plugin; work done for Google Summer of Code '20
---

A blog post + starter material for the Cloud Plugin - work done during Google Summer of Code '20 on creating a CueCommander
 plugin that can be used to manage cloud pools from OpenCue
 
## Summer of Code Proposal: 

The main proposal consisted of the plan of action for the 3 months of development, which included research about 
finding a common language among cloud providers when it came to managing a pool of instances and the ability to create, delete 
and resize these cloud groups through their API from the OpenCue interface

I took Google Cloud Platform as the primary cloud provider and tried to find parallels in other providers and 
started designing the main API around it. 

A [Design Document](https://docs.google.com/document/d/1cCPrZsM8fRbcluTppcuPFQ6_tfQo5rZE9W2m6Hms8pw/edit?usp=sharing) 
about the initial design was then shared with the community for feedback and review which included the specs of the API
 (which changed over the course of 3 months) and the API matrix which shows what the parallels in each provider are

 
## Cloud plugin source code

The code base for this plugin is currently on the [cloudplugin](https://github.com/AcademySoftwareFoundation/OpenCue/tree/cloud-plugin) 
branch of the OpenCue repo

## Overview of the cloud api design and the plugin interface design

#### API Design:

Most cloud providers have the ability to manage a group of instances that can be created using a VM template/source VM and can be
managed as a single entity instead of managing separate instances.
They go by different names in different providers: 
[Instance Groups (GCP)](https://cloud.google.com/compute/docs/instance-groups),
[Scale Sets (Azure)](https://azure.microsoft.com/en-us/services/virtual-machine-scale-sets),
[Auto Scaling Groups (AWS)](https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroup.html)

The design takes into consideration how each of the cloud provider's API handle creation/scaling/deletion of these entities
and how they will be used by the plugin's single interface to manage multiple cloud provider's entities.

The design consists of two main abstract classes:
       
1. [CloudManager](https://github.com/AcademySoftwareFoundation/OpenCue/blob/d4a2eca93d271dacb13ca2aaba9b531642c1dc6b/pycue/opencue/cloud/api.py#L73)

    CloudManager class is the interface between the API and the widget. The CloudManager is also an abstract class
    that will be implemented by each registered provider. 
    This abstract class handles the following:
    
    * [connect()](https://github.com/AcademySoftwareFoundation/OpenCue/blob/d4a2eca93d271dacb13ca2aaba9b531642c1dc6b/pycue/opencue/cloud/api.py#L119):
    Connection mechanism to the cloud provider through it's corresponding API
    
    * [create_managed_group()](https://github.com/AcademySoftwareFoundation/OpenCue/blob/d4a2eca93d271dacb13ca2aaba9b531642c1dc6b/pycue/opencue/cloud/api.py#L100):
    Creation of a cloud pool group (CloudInstanceGroup in the API terminology)
    
    * [get_all_groups()](https://github.com/AcademySoftwareFoundation/OpenCue/blob/d4a2eca93d271dacb13ca2aaba9b531642c1dc6b/pycue/opencue/cloud/api.py#L112): 
    Lists all the cloud pool groups that are available in the cloud provider's project
    
    `Google Cloud Platform` implementation of this class can be found here : [GoogleCloudManager](https://github.com/AcademySoftwareFoundation/OpenCue/blob/d4a2eca93d271dacb13ca2aaba9b531642c1dc6b/pycue/opencue/cloud/gce_api.py#L115)

2. [CloudInstanceGroup](https://github.com/AcademySoftwareFoundation/OpenCue/blob/d4a2eca93d271dacb13ca2aaba9b531642c1dc6b/pycue/opencue/cloud/api.py#L18)

    CloudInstanceGroup abstract class the container that handles the cloud provider's managed group entity. 
    This takes care of the following:
    
    * Handles setting important attributes like name, id, group's instances and the status of the cloud group
    
    * [resize()](https://github.com/AcademySoftwareFoundation/OpenCue/blob/d4a2eca93d271dacb13ca2aaba9b531642c1dc6b/pycue/opencue/cloud/api.py#L31): 
    Resizing the group (scaling up/down). Currently it's left to the cloud provider to take care of which instances to 
    remove during the process of scaling down
    
    * [delete_cloud_group()](https://github.com/AcademySoftwareFoundation/OpenCue/blob/d4a2eca93d271dacb13ca2aaba9b531642c1dc6b/pycue/opencue/cloud/api.py#L58):
    Deletion of the cloud group from the cloud provider
    
    `Google Cloud Platform` implementation of this abstract class can be found here: [GoogleCloudGroup](https://github.com/AcademySoftwareFoundation/OpenCue/blob/d4a2eca93d271dacb13ca2aaba9b531642c1dc6b/pycue/opencue/cloud/gce_api.py#L22)
 
#### Plugin widget design

The Cloud Manager plugin is a plugin for CueCommander. It implements the `AbstractTreeWidget` class 
and registers itself as a CueCommander plugin. 

The interface uses the main `CloudManager` api mentioned above, as the entry point to get all cloud groups
associated with all the registered cloud providers


## Cloud Plugin Setup

#### Google Compute Engine setup

Listing the minimum requirements for the cloud plugin to work with GCE

{{% alert title="Note" color="info"%}}My deployment included setting up Cuebot on GCE{{% /alert %}}

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


## Further work and updates

An Azure plugin that uses the same interface is currently a work in progress
