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

[mirror.yaml](mirror.yaml)

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

加入如下配置即可：
```

files_repo: "https://files.m.daocloud.io"

## Kubernetes components
kubeadm_download_url: "{{ files_repo }}/storage.googleapis.com/kubernetes-release/release/{{ kubeadm_version }}/bin/linux/{{ image_arch }}/kubeadm"
kubectl_download_url: "{{ files_repo }}/storage.googleapis.com/kubernetes-release/release/{{ kube_version }}/bin/linux/{{ image_arch }}/kubectl"
kubelet_download_url: "{{ files_repo }}/storage.googleapis.com/kubernetes-release/release/{{ kube_version }}/bin/linux/{{ image_arch }}/kubelet"

## CNI Plugins
cni_download_url: "{{ files_repo }}/github.com/containernetworking/plugins/releases/download/{{ cni_version }}/cni-plugins-linux-{{ image_arch }}-{{ cni_version }}.tgz"

## cri-tools
crictl_download_url: "{{ files_repo }}/github.com/kubernetes-sigs/cri-tools/releases/download/{{ crictl_version }}/crictl-{{ crictl_version }}-{{ ansible_system | lower }}-{{ image_arch }}.tar.gz"

## [Optional] etcd: only if you **DON'T** use etcd_deployment=host
etcd_download_url: "{{ files_repo }}/github.com/etcd-io/etcd/releases/download/{{ etcd_version }}/etcd-{{ etcd_version }}-linux-{{ image_arch }}.tar.gz"

# [Optional] Calico: If using Calico network plugin
calicoctl_download_url: "{{ files_repo }}/github.com/projectcalico/calico/releases/download/{{ calico_ctl_version }}/calicoctl-linux-{{ image_arch }}"
calicoctl_alternate_download_url: "{{ files_repo }}/github.com/projectcalico/calicoctl/releases/download/{{ calico_ctl_version }}/calicoctl-linux-{{ image_arch }}"
# [Optional] Calico with kdd: If using Calico network plugin with kdd datastore
calico_crds_download_url: "{{ files_repo }}/github.com/projectcalico/calico/archive/{{ calico_version }}.tar.gz"

# [Optional] Flannel: If using Falnnel network plugin
flannel_cni_download_url: "{{ files_repo }}/kubernetes/flannel/{{ flannel_cni_version }}/flannel-{{ image_arch }}"

# [Optional] helm: only if you set helm_enabled: true
helm_download_url: "{{ files_repo }}/get.helm.sh/helm-{{ helm_version }}-linux-{{ image_arch }}.tar.gz"

# [Optional] crun: only if you set crun_enabled: true
crun_download_url: "{{ files_repo }}/github.com/containers/crun/releases/download/{{ crun_version }}/crun-{{ crun_version }}-linux-{{ image_arch }}"

# [Optional] kata: only if you set kata_containers_enabled: true
kata_containers_download_url: "{{ files_repo }}/github.com/kata-containers/kata-containers/releases/download/{{ kata_containers_version }}/kata-static-{{ kata_containers_version }}-{{ ansible_architecture }}.tar.xz"

# [Optional] cri-dockerd: only if you set container_manager: docker
cri_dockerd_download_url: "{{ files_repo }}/github.com/Mirantis/cri-dockerd/releases/download/v{{ cri_dockerd_version }}/cri-dockerd-{{ cri_dockerd_version }}.{{ image_arch }}.tgz"

# [Optional] cri-o: only if you set container_manager: crio
crio_download_base: "download.opensuse.org/repositories/devel:kubic:libcontainers:stable"
crio_download_crio: "http://{{ crio_download_base }}:/cri-o:/"

# [Optional] runc,containerd: only if you set container_runtime: containerd
runc_download_url: "{{ files_repo }}/github.com/opencontainers/runc/releases/download/{{ runc_version }}/runc.{{ image_arch }}"
containerd_download_url: "{{ files_repo }}/github.com/containerd/containerd/releases/download/v{{ containerd_version }}/containerd-{{ containerd_version }}-linux-{{ image_arch }}.tar.gz"
nerdctl_download_url: "{{ files_repo }}/github.com/containerd/nerdctl/releases/download/v{{ nerdctl_version }}/nerdctl-{{ nerdctl_version }}-{{ ansible_system | lower }}-{{ image_arch }}.tar.gz"
```

完整方法可以参考 https://gist.github.com/yankay/a863cf2e300bff6f9040ab1c6c58fbae

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

```
cd /tmp
export K9S_VERSION="v0.26.1"

wget https://files.m.daocloud.io/github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_x86_64.tar.gz
tar -zxvf k9s_Linux_x86_64.tar.gz
chmod +x k9s
mv k9s /usr/bin/k9s
k9s version
```

## 使用场景5 - 安装 istio

```
cd /tmp
export ISTIO_VERSION="1.13.5"

wget "https://files.m.daocloud.io/github.com/istio/istio/releases/download/${ISTIO_VERSION}/istio-${ISTIO_VERSION}-linux-amd64.tar.gz"
tar -zxvf istio-${ISTIO_VERSION}-linux-amd64.tar.gz
# Do follow the istio docs to install istio
```

欢迎贡献更多的场景


## 友情提示

本软件，使用的是 CDN 回源机制来同步文件。
所有如果您碰巧是所有下载中的第一次，没有缓存，需要从国外拉取，就会比较慢。第二次就会非常快。
