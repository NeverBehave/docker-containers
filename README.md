# Folding At Home for Docker 

> https://www.wikiwand.com/en/Folding@home

[中文说明](README_CN.md)

## Edited 

- Pass all parameter as ENV

Run this image for CoronaVirus! https://foldingathome.org/2020/03/10/covid19-update/

## Run

### Quick Start

```bash
docker run -d  --restart unless-stopped --name fah-client -p 127.0.0.1:36330:36330 -p 127.0.0.1:7396:7396 neverbehave/folding-at-home 
```

With your team and name

```bash
docker run -d  --restart unless-stopped --name fah-client -p 127.0.0.1:36330:36330 -p 127.0.0.1:7396:7396 -e TEAM_ID=239854 -e USER_ID=NeverBehave neverbehave/folding-at-home 
```

**FOR GPU User**

```bash
docker run -d  --restart unless-stopped --name fah-client -p 127.0.0.1:36330:36330 -p 127.0.0.1:7396:7396 -e GPU_STATUS=true -e EXTRA_CONFIG="<slot id='1' type='GPU'/>" neverbehave/folding-at-home 
```

Then head to http://client.foldingathome.org/ to check your status

#### Stop

```bash
docker stop fah-client
```

For more details, please check https://docs.docker.com

### Setting

#### Environment Variables

| Name        | Accept Value              | Required | Default                |
| ----------- | ------------------------- | -------- | ---------------------- |
| GPU_STATUS     | Boolean              |          | false              |
|  ALLOW_SUBNET_HTTP| CIDR Range                  |          | 0.0.0.0/0                  |
| PASSWORD    | String                    |  |    PASSWORD |
| TEAM_ID    | [Number](https://apps.foldingathome.org/team)                    |          | 239854              |
| USER_ID      | String           |          | Anonymous |
|   PASSKEY   | [String](https://apps.foldingathome.org/getpasskey)                   |          |                |
| ALLOW_SUBNET_WEB | CIDR Range              |          | 0.0.0.0/0       |
| POWER        | light,medium,full    |       | medium  |
|EXTRA_CONFIG|e.g. `<slot id='1' type='GPU'/>`||

#### Custom Config

```bash
docker run neverbehave/folding-at-home -v your-location:/config
```

