# Beaver Habit Tracker

![GitHub Release](https://img.shields.io/github/v/release/daya0576/beaverhabits)
![Docker Pulls](https://img.shields.io/docker/pulls/daya0576/beaverhabits)
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/daya0576/beaverhabits/fly.yml)
![Uptime Robot ratio (30 days)](https://img.shields.io/uptimerobot/ratio/m787647728-b1a273391c2ad5c526b1c605)

A self-hosted habit tracking app to save your precious moments in your fleeting life.

<img src='https://github.com/daya0576/beaverhabits/assets/6239652/0418fa41-8985-46ef-b623-333b62b2f92e' width='250'>
<img src='https://github.com/daya0576/beaverhabits/assets/6239652/c0ce98cf-5a44-4bbc-8cd3-c7afb20af671' width='250'>
<img src='https://github.com/daya0576/beaverhabits/assets/6239652/516c19ca-9f55-4c21-9e6d-c8f0361a5eb2' width='250'>

# Getting Started

## Cloud Service

- Demo: https://beaverhabits.com/demo
- Login: https://beaverhabits.com

## Self-hosting

### Ship with Docker

Example:

```bash
docker run -d --name beaverhabits \
  -u $(id -u):$(id -g) \
  -e FIRST_DAY_OF_WEEK=0 \
  -e HABITS_STORAGE=USER_DISK \
  -e MAX_USER_COUNT=1 \
  -v /path/to/host/directory:/app/.user/ \
  -p 8080:8080 \
  --restart unless-stopped \
  daya0576/beaverhabits:latest
```

P.S. The container starts as nobody to increase the security and make it OpenShift compatible.
To avoid [permission issues](https://github.com/daya0576/beaverhabits/discussions/31), ensure that the UID owning the host folder aligns with the UID of the user inside the container.

### Options:

| Name | Description |
|:--|:--|
| **HABITS_STORAGE**(str) | The `DATABASE` option stores everything in a single SQLite database file named habits.db. On the other hand, the `USER_DISK` option saves habits and records in a local json file. |
| **FIRST_DAY_OF_WEEK**(int) | By default, the first day of the week is set as Monday. To change it to Sunday, you can set it as `6`. |
| **MAX_USER_COUNT**(int) | By setting it to `1`, you can prevent others from signing up in the future. |
| **ENABLE_IOS_STANDALONE**(bool) | Experiential feature to  enable standalone mode on iOS. The default setting is `false` |
| **INDEX_SHOW_HABIT_COUNT**(bool) | To display the total completed count badge on the main page. The default setting is `false` |

## Development

BeaverHabits favors [uv](https://docs.astral.sh/uv/getting-started/) as package management tool. Here is how to set up the development environment:

```sh
# Install uv and all the dependencies
uv venv && uv sync

# Start the server
./start.sh dev
```


# Features

1. Pages
   - [x] Index page
   - [x] Habit list page
     - [x] Order habits
   - [x] Habit detail page
     - [x] Calendar
     - [x] Streaks
2. Storage:
   - [x] Session-based disk storage
   - [x] User-based disk storage
   - [x] User-based db storage
3. CICD:
   - [x] Custom domain
   - [x] Self-hosting option
   - [x] Unit tests & deployment pipeline
4. Others:
   - [x] Export
   - [x] Import
   - [x] User management
   - [x] User timezone

## Streaks

Here are my table tennis training sessions in the past year :)

<img width="800" alt="image" src="https://github.com/user-attachments/assets/8b353afb-38d5-4210-a083-cb05ea9d3746">


## Import

To import from an existing setup, e.g. uhabit, please check this [wiki](https://github.com/daya0576/beaverhabits/wiki/Import-from-Existing-Setup) for more details.

## Standalone mode for iOS (Web Application)

Please follow this [wiki](https://github.com/daya0576/beaverhabits/wiki/To-Add-Standalone-Mode-for-iOS-(Web-Application)) to add it as an icon on the home screen and make it launch in a separate window

## Reorder Habits

Open page `/gui/order` to change the order of habits.

# Future Plans

1. Native mobile app
2. Habit calendar template, e.g. vacations
3. Open API!
4. ...
