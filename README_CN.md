# Folding At Home for Docker 

> Folding@home（簡稱FAH或F@h）是一个研究蛋白质折叠、误折、聚合及由此引起的相关疾病的分布式计算工程。由斯坦福大学化學系的潘德实验室（Pande Lab）主持。

> https://www.wikiwand.com/zh/Folding@home

[English README](README.md)

## 修订

- 使用环境变量传入参数

如果你的服务器/主机还有空余算力，运行这个镜像来帮助解析冠状病毒!

 https://foldingathome.org/2020/03/10/covid19-update/

## 运行

### 快速开始

```bash
docker run -p 127.0.0.1:36330:36330 -p 127.0.0.1:7396:7396 neverbehave/folding-at-home 
```

使用自己的队伍和名称

```bash
docker run -p 127.0.0.1:36330:36330 -p 127.0.0.1:7396:7396 -e TEAM_ID=239854 -e USER_ID=NeverBehave neverbehave/folding-at-home 
```

**有GPU的用户**

```bash
docker run -p 127.0.0.1:36330:36330 -p 127.0.0.1:7396:7396 -e GPU_STATUS=true -e EXTRA_CONFIG="<slot id='1' type='GPU'/>" neverbehave/folding-at-home 
```

然后打开网页客户端  http://client.foldingathome.org/ 检查客户端状态

### 设置

#### 可用的环境变量

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
|EXTRA_CONFIG|e.g. "<slot id='1' type='GPU'\/>"||

#### 使用自己的配置

```bash
docker run neverbehave/folding-at-home -v your-location:/config
```

