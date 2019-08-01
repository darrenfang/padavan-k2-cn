# padavan-k2-cn
K2 padavan 中文版

## 使用

在本机创建 docker 镜像。

```shell
docker build -t darrenfang/padavan-k2-cn .
```

## 获取固件

或者直接使用已经创建的 docker 镜像。

```shell
docker run --rm -v $(pwd):/data darrenfang/padavan-k2-cn cp -R /root/images/ /data
```
