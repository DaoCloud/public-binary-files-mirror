# public-kube-files-mirror

## 背景
很多 Kube 相关的 binary 文件 都在国外。比如 gcr 。国内下载很慢，需要加速。

## 目标

* 一个简洁有效的方法能够加速这些包。简洁的名称映射
* 易于添加，添加新的包，不需要去修改代码。
* 稳定可靠，更新实时。
* 可以直接用于 kubespray

## 快速开始

```
用浏览器打开 https://files.m.daocloud.io/ 来浏览这些文件。点击下载。（当然也可以用 curl 下载）
```

## 快速开始

在原始 URL 上面加入 `files.m.daocloud.io` 的 *前缀* 就可以使用。比如：

https://github.com/etcd-io/etcd/releases/download/v3.4.20/etcd-v3.4.20-linux-amd64.tar.gz =>
https://files.m.daocloud.io/github.com/etcd-io/etcd/releases/download/v3.4.20/etcd-v3.4.20-linux-amd64.tar.gz

## 支持的文件

[mirror.txt](mirror.txt)

如果想要新增, 提 PR 修改即可。例如 TODO

## 支持的镜像

[mirror.txt](mirror.txt)

如果想要新增, 提 PR 修改即可。例如 [PR#1](https://github.com/DaoCloud/public-image-mirror/pull/1/)

## 替换规则

| 源站                    | 替换为                        |
| ----------------------- | ----------------------------- |
| cr.l5d.io               | l5d.m.daocloud.io             |
| docker.elastic.co       | elastic.m.daocloud.io         |
| docker.io               | docker.m.daocloud.io          |
| gcr.io                  | gcr.m.daocloud.io             |
| ghcr.io                 | ghcr.m.daocloud.io            |
| k8s.gcr.io              | k8s-gcr.m.daocloud.io         |
| registry.k8s.io         | k8s.m.daocloud.io             |
| mcr.microsoft.com       | mcr.m.daocloud.io             |
| nvcr.io                 | nvcr.m.daocloud.io            |
| quay.io                 | quay.m.daocloud.io            |
| registry.jujucharms.com | jujucharms.m.daocloud.io      |
| rocks.canonical.com     | rocks-canonical.m.daocloud.io |


## 使用场景1 - 安装 Helm

TODO

## 使用场景2 - 安装 KubeSpray

TODO


## 使用场景3 - 安装 K9S

TODO



## 使用场景4 欢迎贡献更多的场景



## 最佳实践
* 通过 加速 安装 kubeadm
``` bash
kubeadm config images pull --image-repository k8s-gcr.m.daocloud.io
```

* 通过 加速 安装 kind

``` bash
kind create cluster --name kind --image docker.m.daocloud.io/kindest/node:v1.22.1
``` 

* 通过 加速 部署 应用(这里以 Ingress 为例)

``` bash
wget -O image-filter.sh https://github.com/DaoCloud/public-image-mirror/raw/main/hack/image-filter.sh && chmod +x image-filter.sh

wget -O deploy.yaml https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.0/deploy/static/provider/baremetal/deploy.yaml

cat ./deploy.yaml | ./image-filter.sh | kubectl apply -f -
``` 


## 贡献者

<a href="https://github.com/DaoCloud/public-image-mirror/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=DaoCloud/public-image-mirror" />
</a>

Made with [contrib.rocks](https://contrib.rocks).
