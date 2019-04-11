---
title: "Announcing the release of OpenCue 0.1.107"
linkTitle: "v0.1.107 release"
date: 2019-03-26
description: "OpenCue v0.1.107 release notes"
---

[v0.1.107 of OpenCue](https://github.com/imageworks/OpenCue/releases/tag/v0.1.107)
includes the following changes and updates:

*   [Pull request #226](https://github.com/imageworks/OpenCue/pull/250) - 
    Renamed PyOutline wrappers to follow OpenCue naming convention.
*   [Issue #248](https://github.com/imageworks/OpenCue/issues/248) -
    You can now configure the location of log directories by setting the `CUE_FRAME_LOG_DIR` environment
    variable on a Cuebot instance.
*   [Issue #237](https://github.com/imageworks/OpenCue/issues/237) - 
    Adds support to reuse exsiting gRPC connections between Cuebot and RQD.
*   [Issue #246](https://github.com/imageworks/OpenCue/issues/246) -
    Pycuerun no longer errors after submitting a job and prints submitted job IDs.
*   [Issue #176](https://github.com/imageworks/OpenCue/issues/176) -
    Docs now include system requirements for RQD and Cuebot.
*   [Issue #229](https://github.com/imageworks/OpenCue/issues/229) -
    You can now configure Pycue to randomly distribute loads across multiple Cuebot nodes.
*   [Issue #227](https://github.com/imageworks/OpenCue/issues/227) - 
    Fixes for CueGui monitor cue view.
