---
title: "Monitoring your jobs"
linkTitle: "Monitoring your jobs"
date: 2019-05-09
weight: 1
description: >
  Monitor your OpenCue rendering jobs from CueGUI
---

This guide describes how to monitor your OpenCue jobs from the CueGUI app
and configure plugins for viewing jobs details.

After you submit a job to OpenCue, you can monitor the progress of the
indivdual frames and layers in the jon from the CueGUI app on your
workstation. CueGUI supports the following *views* to monitor and manage
job status:

*   *Cuetopia* includes plugins for monitoring jobs and individual job
    details.
*   *Cuecommaner* includes plugins for for monitoring your OpenCue
    system. System administratos typically run the Cuecommander
    view to monitor and manage OpenCue infrastructure, such as rendering
    hosts.
*   *Other* includes plugins for viewing logs and attributes.

This guide expains how to use the Cuetopia view to monitor jobs. To
learn more about the features available in CueGUI, see
[CueGUI reference](/docs/reference/cuegui-reference/).

## Before you begin

Make sure you are familiar with the steps for
[submiting jobs](/docs/user-guides/submitting-jobs/).

You also need to configure the Cuetopia view.

### Configuring Cuetopia

1.  Start CueGUI.

    {{% alert title="Note" color="info"%}}The instructions for running
    Cuetopia vary depending on the installation method. To learn more, see
    [Installing CueGUI](/docs/getting-started/installing-cuegui/)
    or contact your OpenCue admin.{{% /alert %}}

    After CueGUI loads for the first time, you might see one or more blank
    windows, as illustrated by the following screenshot:
    
    ![CueGUI default view](/docs/images/cuetopia_blank.png)

1.  Click **Window** > **Raise Window: Cuetopia**.

    You load Cuetopia plugins in this window.

1.  Optionally close any other CueGUI windows.

1.  Click **Views/Plugins** > **Cuetopia** > **Monitor Jobs**.

    This adds the *Monitor Jobs* plugin to the Cuetopia view, as
    illustrated by the following screenshot:
    
    ![CueGUI default view](/docs/images/cuetopia_jobs_view.png)

1.  Click **Views/Plugins** > **Cuetopia** > **Monitor Job Details**.

    This adds the *Monitor Job Details* plugin to the Cuetopia view,
    alongside the Monitor Jobs view, as illustrated by the following
    screenshot:
    
    ![CueGUI default view](/docs/images/cuetopia_job_details_view.png)

## Monitoring jobs



## What's next?

-   [Troubleshooting rendering](/docs/other-guides/troubleshooting-rendering)
 
