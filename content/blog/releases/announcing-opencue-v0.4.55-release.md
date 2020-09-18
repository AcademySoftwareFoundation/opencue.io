---
title: "Announcing the release of OpenCue v0.4.55"
linkTitle: "v0.4.55 release"
date: 2020-08-18
description: "OpenCue v0.4.55 release notes"
---

[v0.4.55 of OpenCue](https://github.com/AcademySoftwareFoundation/OpenCue/releases/tag/v0.4.55)
includes the following changes and updates:

*   Fix bug with host search where search text would be ignored. [#695](https://github.com/AcademySoftwareFoundation/OpenCue/pull/695)
*   Add method addRenderPartition to api wrappers. [#701](https://github.com/AcademySoftwareFoundation/OpenCue/pull/701)
*   Protect job updates to avoid accessing closed views. [#702](https://github.com/AcademySoftwareFoundation/OpenCue/pull/702)
*   Protect getRenderPartition call. [#700](https://github.com/AcademySoftwareFoundation/OpenCue/pull/700)
*   Move from whitelist to acceptlist. [#713](https://github.com/AcademySoftwareFoundation/OpenCue/pull/713)
*   Beginning to migrate pipelines to Github Actions. [#684](https://github.com/AcademySoftwareFoundation/OpenCue/pull/684)
*   Replace sed hack with 2to3. [#709](https://github.com/AcademySoftwareFoundation/OpenCue/pull/709)
*   Fix a few Windows compatibility issues. [#718](https://github.com/AcademySoftwareFoundation/OpenCue/pull/718)
*   Ignore errors when rotating logs on Windows. [#726](https://github.com/AcademySoftwareFoundation/OpenCue/pull/726)
*   Replace getInteger with PySide2-compatible getInt. [#744](https://github.com/AcademySoftwareFoundation/OpenCue/pull/744)
*   Properly handle empty groups in CueMonitorTree. [#743](https://github.com/AcademySoftwareFoundation/OpenCue/pull/743)
*   Fix losing selection issue in FilterDialog. [#741](https://github.com/AcademySoftwareFoundation/OpenCue/pull/741)
*   Upgrade pip in all Docker images. [#746](https://github.com/AcademySoftwareFoundation/OpenCue/pull/746)
*   Fix incorrect frame data access in Preview widget. [#731](https://github.com/AcademySoftwareFoundation/OpenCue/pull/731)
*   Dockerfile update to set permissions for VERSION file. [#751](https://github.com/AcademySoftwareFoundation/OpenCue/pull/751) [#752](https://github.com/AcademySoftwareFoundation/OpenCue/pull/752)
*   Fix burst typecast. [#757](https://github.com/AcademySoftwareFoundation/OpenCue/pull/757)
*   Finish migrating packaging pipeline to Github Actions. [#753](https://github.com/AcademySoftwareFoundation/OpenCue/pull/753)
*   Finish migrating release pipeline to Github Actions. [#762](https://github.com/AcademySoftwareFoundation/OpenCue/pull/762)
