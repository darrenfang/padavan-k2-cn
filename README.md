# padavan-k2-cn
K2 padavan 中文版

## 使用

```shell
docker build -t padavan-k2-cn .
```

## 获取固件

```shell
docker run --rm -v $(pwd):/data padavan-k2-cn cp -R /root/images/ /data
```
