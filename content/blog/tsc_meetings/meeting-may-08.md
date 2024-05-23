---
title: "TSC meeting May 8th 2024"
linkTitle: "TSC meeting May 8th 2024"
date: 2024-05-08
description: "Meeting notes"
---

Participants:
 - Diego Tavares
 - Ramon Figueiredo
 - Nuwan Jayawardene

## TSC chair handoff

As proposed on the last meeting, [Diego Tavares](https://github.com/DiegoTavares) is taking 
over the TSC chair position. [Brian Cipriano](https://github.com/bcipriano), previous chair
person is staying on the project as a member of Technical Steering Committee. 

## New agenda media

It was discussed that it is a good idea to have the agenda for the TSC meetings being posted
on the [blog page](https://www.opencue.io/blog/) for more visibility. Old meeting notes can 
still be found at the [opencue repo](https://github.com/AcademySoftwareFoundation/OpenCue/tree/master/tsc/meetings).

## Code owners update

The project [code owners list](https://github.com/AcademySoftwareFoundation/OpenCue/pull/1358/files) has been updated to map the current list of TSC members actively maintaining the repository. 

## Pull Request clean up

Latest updates on stale PRs

 * PR#888 - Add job node graph plugin
    - Can we drop cuegui python/2.7 compatibility
    - An email has been sent to the mailing list titled __Proposal to drop Python 2.7 compatibility__ asking for objections
 * PR#935 - Remove env var logic for pre-setshot
    - Pending failures on test pipeline
 * PR#976 - Frame dropDepends
    - Approved - Waiting to be merged
 * PR#1167 - Make frames and layers readonly after job is done
    - [Akim Ruslanov](https://github.com/akim-ruslanov) is working on pending conflicts

## Imageworks Updates

 * Seconds phase of the [Cueweb project](https://github.com/AcademySoftwareFoundation/OpenCue/commit/78b96d4593be93e94208d7ee1b451c4e5c1cdd0a) is being developed by a Co-op.

## Blender updates

 * [Nuwan Jayawardene](https://github.com/AcademySoftwareFoundation/OpenCue/issues?q=is%3Apr+is%3Aopen+author%3An-jay) is working on documentation updates for the Blender plugin
