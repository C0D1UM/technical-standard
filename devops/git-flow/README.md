# Git Flow

In this standard, we suggest you multiple implementations of Git Flow. Each flow is different. Some is better when you're developing, some is better when your project was already go live. This standard will help you pick the right one for your project.

Before we start, one thing that's constant is we will use only _one branch_ as a standard.

## TL;DR

### Flow Selection

Here's how you choose a Git Flow for your project:

| ![Flow Selection](Flow%20Selection.png) |
| :--: |
| _Flow Selection_ |

### Comparison

| Topic | Centralized Workflow | Feature Branching | Trunk-based Development |
| ----- | -------------------- | ----------------- | ----------------------- |
| **Development** |
| Number of branch | 1 | 1 | 1 |
| Branching | - | By feature | By feature |
| Branch live | - | Long-lived | Short-lived |
| When to merge? | - | When feature is done | Depends but every often<br>(everyday, every 2 days, etc.) |
| Code review | No | Possible | Recommended |
| Maximum number of developers | 2 | N/A | N/A |
| **Deployment** |
| Development Server | On pushed to _main branch_ | On pushed to _main branch_ | On pushed to _main branch_ |
| Staging Server (if any) | Manually deploy from _main branch_ | Manually deploy from _main branch_ | On pushed to _release branch_ |
| Production Server | On tag pushed from _main branch_ | On tag pushed from _main branch_ | On tag pushed from _release branch_ |

## Centralized Workflow

| <img src="https://wac-cdn.atlassian.com/dam/jcr:f03a0fbd-a880-477f-aa32-33340383ce07/02%20(3).svg?cdnVersion=1481" width="450"> |
| :--: |
| _Centralized Workflow_ |

### Concepts

- Developers work on a single branch (usually called `main`)
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

- A single _main branch_ (usually called `main`)
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

## Trunk-based Development

| ![Trunk-based Branching](https://trunkbaseddevelopment.com/trunk1c.png) |
| :--: |
| _Trunk-based Development_ |

### Concepts

TBD

### Deployment

- **Development:** Deploy when pushed into _main branch_
- **Staging _(if any)_:** Deploy when pushed into _release branch_
- **Production:** Deploy when pushed tag created from _release branch_

### When do you want?

TBD

### References

- [Trunk Based Development](https://trunkbaseddevelopment.com/)
