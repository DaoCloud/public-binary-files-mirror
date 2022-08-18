# public-binary-files-mirror

## 背景
很多 binary 文件 都在国外。比如 Kube 。国内下载很慢，需要加速。

## 目标

* 一个简洁有效的方法能够加速这些包。简洁的名称映射
* 易于添加，添加新的包，不需要去修改代码。
* 稳定可靠，更新实时。
* 可以直接用于 kubespray

## 快速开始

```
用浏览器打开 https://files.m.daocloud.io/ 来浏览这些文件。点击下载。（当然也可以用 curl 下载）
```

## 使用方法

在原始 URL 上面加入 `files.m.daocloud.io` 的 *前缀* 就可以使用。比如：

https://github.com/etcd-io/etcd/releases/download/v3.4.20/etcd-v3.4.20-linux-amd64.tar.gz =>
https://files.m.daocloud.io/github.com/etcd-io/etcd/releases/download/v3.4.20/etcd-v3.4.20-linux-amd64.tar.gz

## 支持的文件

[mirror.txt](mirror.txt)

如果想要新增, 提 PR 修改即可。例如 TODO

## 最佳实践

## 使用场景1 - 安装 Helm

TODO

## 使用场景2 - 安装 KubeSpray

TODO

## 使用场景3 - 安装 KIND

TODO

## 使用场景4 - 安装 K9S

TODO


## 使用场景5

欢迎贡献更多的场景


