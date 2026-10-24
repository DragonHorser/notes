# Docker

> 个人学习笔记 · 介绍 / 常用命令 / 网络管理 / Docker Compose

## 目录

- [介绍](#介绍)
- [常用命令](#常用命令)
  - [管理镜像](#管理镜像)
  - [管理容器](#管理容器)
  - [挂载数据卷](#挂载数据卷)
  - [挂载目录](#挂载目录)
- [构建镜像](#构建镜像)
- [网络管理](#网络管理)
- [容器编排：docker compose](#容器编排docker-compose)

---

## 介绍

Docker 是容器引擎，可以创建并管理容器。

**作用：** 可以非常方便的部署应用程序软件。

### 概念

| 概念 | 说明 |
| --- | --- |
| 容器（container） | 理解为一个微小操作系统 + 应用软件。比如：MySQL 容器相当于 操作系统 + MySQL 软件 |
| 镜像（image） | 理解为安装包、程序包（容器运行所必须的代码） |
| 镜像仓库（registry） | 提供了大量的镜像供我们下载使用 |

---

## 常用命令

### 管理镜像

**从镜像仓库里拉取镜像：**

```bash
docker pull 镜像名称:tag
docker pull nginx:alpine
```

**列出所有本地镜像：**

```bash
docker images
```

**删除某个本地镜像：**

```bash
docker rmi 镜像名称:tag
docker rmi nginx:alpine
```

### 管理容器

**创建容器并在后台运行：**

```bash
docker run -d --name 容器名称 -p 宿主机端口:容器内的端口 镜像名称:tag
docker run -d --name nginx -p 80:80 nginx:alpine
```

**查看容器：**

查看运行中的容器：

```bash
docker ps
docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}'
```

查看所有容器（包括已停止的）：

```bash
docker ps -a
docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}' -a
```

**查看容器的运行日志：**

持续跟踪日志：

```bash
docker logs -f 容器名
```

> 停止查看日志：按 `Ctrl + C`。

**关闭容器：**

```bash
docker stop 容器名
```

**启动容器：**

```bash
docker start 容器名
```

**想在容器内执行命令：**

```bash
docker exec -it 容器名 要执行的命令
docker exec -it nginx ls /
```

> 上述命令表示：要在 nginx 容器内执行命令 `ls /`。

**删除容器：**

删除已停止的容器：

```bash
docker rm 容器名
```

强制删除容器（运行中的也能删除）：

```bash
docker rm -f 容器名
```

### 挂载数据卷

**作用：** 可以很方便的实现宿主机里文件与容器内文件的自动同步。

**特点：**

- 如果修改了宿主机的文件夹里的内容：docker 会自动同步到它绑定的容器里文件夹内容
- 如果容器内文件夹内容有变化：docker 也会自动同步到它绑定的宿主机里文件夹内容

> **注意**
> - 只能在创建容器时，为容器内的文件/文件夹绑定数据卷
> - 如果数据卷不存在，将会自动创建

**用法：**

创建容器并挂载数据卷：

```bash
docker run -d --name 容器名称 -p 宿主机端口:容器内端口 -v 数据卷名称:容器内的文件夹 镜像名称:tag
docker run -d --name nginx -p 80:80 -v html:/usr/share/nginx/html nginx:alpine
```

查看所有数据卷：

```bash
docker volume ls
```

查看某个数据卷（文件夹路径）：

```bash
docker volume inspect 数据卷名称
```

删除某个数据卷：

```bash
docker volume rm 数据卷名称
```

清理多余数据卷：

```bash
docker volume prune
```

### 挂载目录

作用和挂载数据卷一样，只不过是将宿主机里自定义的文件夹挂载给容器里的目录。

```bash
docker run -d --name 容器名称 -p 宿主机端口:容器内端口 -v 宿主机里文件夹:容器内的文件夹 镜像名称:tag
```

---

## 构建镜像

---

## 网络管理

**目的：** 多个容器之间互相通信时，不必关注目标容器的 IP 地址，只要知道目标容器的名称就可以连接上目标容器了。

**效果：** 容器之间互相通信，利用容器名代替 IP 地址。

**做法：**

先创建一个网络：

```bash
docker network create 网络名
```

将多个容器连接上这个网络：

```bash
docker network connect 网络名 容器名
```

**其它命令：**

查看所有网络：

```bash
docker network ls
```

查看某个网络的详细信息：

```bash
docker network inspect 网络名
```

---

## 容器编排：docker compose

**作用：** 根据 yml 配置文件批量管理容器。

**用法：**

1. 需要准备 `docker-compose.yml` 文件
   - 文件里配置了所有容器的信息
2. 执行命令

根据 yml 文件，批量创建并后台运行容器：

```bash
docker compose up -d
```

根据 yml 文件，批量关闭并删除容器：

```bash
docker compose down
```

根据 yml 文件，仅批量启动已有容器：

```bash
docker compose start
```

根据 yml 文件，仅批量关闭已有容器：

```bash
docker compose stop
```