# Git Flow

In this standard, we suggest you multiple implementations of Git Flow. Each flow is different. Some is better when you're developing, some is better when your project was already go live. This standard will help you pick the right one for your project.

Before we start, one thing that's constant is we will use only _one branch_ as a standard.

## TL;DR

### Flows

There are three flows we suggested you in this standard:

1. **Centralized Workflow:** only _main branch_ and all changes are committed into _main branch_.
1. **Feature Branching:** have _main branch_ and feature branch(es).
1. **Gitflow Workflow:** have two branches such as _main branch_ and _development branch_
1. **Trunk-based Development**: it is like _Feature Branching_ but feature branch is very short-lived and will be merged into _main branch_ as fast as possible. Project should also implement [feature flags](#feature-flag) to turn on/off feature as well.

### Flow Selection

Here's how you choose a Git Flow for your project:

| ![Flow Selection](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/C0D1UM/technical-standard/main/devops/git-flow/flow-selection.plantuml) |
| :--: |
| _Flow Selection_ |

### Comparison

| Topic | Centralized Workflow | Feature Branching | Gitflow Workflow | Trunk-based Development |
| ----- | -------------------- | ----------------- | ---------------- | ----------------------- |
| **Development** |
| Number of branch(es) | 1 | 1 | 2 | 1 |
| Branching | - | By feature | By feature | By feature |
| Feature branch live | - | Long-lived | N/A | Short-lived |
| When to merge? | - | When feature is done | When feature is done | Depends but every often<br>(everyday, every 2 days, etc.) |
| Code review | No | Possible | Possible | Recommended |
| Maximum number of developers | 2 | N/A | N/A | N/A |
| **Deployment** |
| Development Server | On pushed to _main branch_ | On pushed to _main branch_ | On pushed to _development branch_ | On pushed to _main branch_ |
| Staging Server (if any) | Manually deploy from _main branch_ | Manually deploy from _main branch_ | On pushed to _main branch_ | On pushed to _release branch_ |
| Production Server | On tag pushed from _main branch_ | On tag pushed from _main branch_ | On tag pushed from _main branch_ | On tag pushed from _release branch_ |

## Centralized Workflow

| <img src="https://wac-cdn.atlassian.com/dam/jcr:f03a0fbd-a880-477f-aa32-33340383ce07/02%20(3).svg?cdnVersion=1481" width="450"> |
| :--: |
| _Centralized Workflow_ |

### Concepts

- Developers work on a single branch (usually named `main`)
- Developers push directly to main branch without any branching required

### Deployment

- **Development:** Deploy when pushed into _main branch_
- **Staging _(if any)_:** Manually deploy from _main branch_
- **Production:** Manually deploy by creating a tag from _main branch_

### When do you want?

- Project is in _starting or first phase_
- Team has only a few developers in the team
- Developers are advanced since there is no code review
- Need to speed up the process

### References

- [Atlassian: Centralized Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows#centralized-workflow)

## Feature Branching

| <img src="https://wac-cdn.atlassian.com/dam/jcr:09308632-38a3-4637-bba2-af2110629d56/07.svg?cdnVersion=1481" width="450"> |
| :--: |
| _Feature Branching_ |

### Concepts

- A single _main branch_ (usually named `main`)
- Branching is required to develop a new feature, enhancements, bug fixes, and etc.
- Frequently merge _main branch_ to _feature branch_
- When it is finished, code review (including pipelines) is required before merging into _main branch_.
- Delete _feature branch_ immediately after it has been merged

### Deployment

- **Development:** Deploy when pushed into _main branch_
- **Staging _(if any)_:** Manually deploy from _main branch_
- **Production:** Manually deploy by creating a tag from _main branch_

### When do you want?

- Project is in _development phase_ or _support phase_
- Team has senior developers enough to review the code for every other developers
- There are many features or tasks to do and they need to be implemented at the same time

### References

- [Atlassian: Feature Branch Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow)

## Trunk-based Development (with Feature Flag)

| ![Trunk-based Branching](https://trunkbaseddevelopment.com/trunk1c.png) |
| :--: |
| _Trunk-based Development_ |

### Concepts

Similar as [Feature Branching](#feature-branching) but

- There is a separated branch called `release` to freeze the development in a certain time, preparing to deploy to staging (if any) or production.
- Feature branches are _short-lived_
- Every point in _main branch_ should be _production-ready_. Here comes the [Feature Flag](#feature-flag).

### Feature Flag

**Feature Flag**<sup>[1]</sup> (aka. Feature Toggle) is the ability to turn on or turn off every particular feature without re-deploying which is a time-consumed task.

Feature Flag also helps us to turn off a feature that we don't want to release as well. This will allow us to merge our code as fast as possible to _main branch_ without considering that it will be released on production or not.

### Deployment

- **Development:** Deploy when pushed into _main branch_
- **Staging _(if any)_:** Deploy when pushed into _release branch_
- **Production:** Deploy when pushed tag created from _release branch_

### When do you want?

- Project is in _go-live phase_ but there are features left to be implemented as well as fixing bugs in production server
- Release schedule is strictly
- Has enough senior developers to review everyone's code
- Already set-up CI/CD

### References

- [Trunk Based Development](https://trunkbaseddevelopment.com/)
- <sup>[1]</sup> [Feature flags, what are they?](https://launchdarkly.com/blog/what-are-feature-flags)
