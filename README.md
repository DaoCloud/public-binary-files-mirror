# public-binary-files-mirror

## 背景
很多 binary 文件 都在国外。比如 Kube 。国内下载很慢，需要加速。

## 目标

* 一个简洁有效的方法能够加速这些包。简洁的名称映射
* 易于添加，添加新的包，不需要去修改代码。
* 稳定可靠，更新实时。
* 可以直接用于 kubespray

## 使用方法

在原始 URL 上面加入 `files.m.daocloud.io` 的 *前缀* 就可以使用。比如：

```
# Helm 下载原始URL
wget https://get.helm.sh/helm-v3.9.1-linux-amd64.tar.gz

# 加速后的 URL
wget https://files.m.daocloud.io/get.helm.sh/helm-v3.9.1-linux-amd64.tar.gz
```



即可加速下载

## 支持的域名

[mirror.txt](mirror.txt)

如果想要新增, 提 PR 修改。

## 最佳实践

## 使用场景1 - 安装 Helm

```
cd /tmp
export HELM_VERSION="v3.9.1"

wget "https://files.m.daocloud.io/get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz"
tar -zxvf helm-${HELM_VERSION}-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
helm version
```

## 使用场景2 - 安装 KubeSpray

TODO

## 使用场景3 - 安装 KIND

```
cd /tmp
export KIND_VERSION="v0.14.0"

curl -Lo ./kind https://files.m.daocloud.io/github.com/kubernetes-sigs/kind/releases/download/${KIND_VERSION}/kind-linux-amd64
chmod +x ./kind
mv ./kind /usr/bin/kind
kind version
```

## 使用场景4 - 安装 K9S

TODO

## 使用场景5

欢迎贡献更多的场景


## 原理架构

[docs/architecture.md]
