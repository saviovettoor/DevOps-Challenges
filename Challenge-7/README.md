# Jenkins Pipeline: 
##NodeJs App - ##DockerImage - ##DockerHub - ##k8s - ##ISTIO

```
Jenkins
-------
	Installation:
		https://jenkins.io/doc/book/installing/
	Plugins: (Additional pluings used over the default recomented plugin)
		"Kubernetes Continuous Deploy" Plugin for k8s deployment: https://github.com/jenkinsci/kubernetes-cd-plugin
		"httpRequest" plugin for Smoke testt: https://jenkins.io/doc/pipeline/steps/http_request/
		
Kubernetes Setup
----------------
############
Master Node
############

]#sudo su
]#swapoff -a
]#vi /etc/fstab --> commandout /root/swap swap swap sw 0 0
]#yum update -y
]#setenforce 0
]# vi /etc/selinux/config -> change in the file also
]#yum -y install docker
]#systemctl enable docker; systemctl start docker

#]cat <<EOF > /etc/yum.repos.d/kubernetes.repo
	[kubernetes]
	name=Kubernetes
	baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
	enabled=1
	gpgcheck=1
	repo_gpgcheck=1
	gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
   EOF
]# yum install -y kubelet kubeadm kubectl
]# systemctl start kubelet; systemctl enable kubelet
]#cat <<EOF >  /etc/sysctl.d/k8s.conf
	net.bridge.bridge-nf-call-ip6tables = 1
	net.bridge.bridge-nf-call-iptables = 1
	EOF
]#sysctl --system -> check
]#kubeadm init --pod-network-cidr=10.244.0.0/16
/etc/kubernetes/manifests/kube-apiserver.yaml

]#exit
]$HOME/.kube/config
]$sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config 	
]$sudo chown $(id -u):$(id -g) $HOME/.kube/config
]$export kubever=$(kubectl version | base64 | tr -d '\n')
]$kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$kubever"

NOTE: Also i had changed the nodeport default range by adding - --service-node-port-range=8000-31274 to file 
	  /etc/kubernetes/manifests/kube-apiserver.yaml
	  
###########
Worker Node
############
]#sudo su
]#swapoff -a
]#vi /etc/fstap --> commandout /root/swap swap swap sw 0 0
]#yum update -y
]#setenforce 0
]# vi /etc/selinux/config -> change in the file also
]#yum -y install docker
]#systemctl enable docker
]#systemctl start docker
#]cat <<EOF > /etc/yum.repos.d/kubernetes.repo
	[kubernetes]
	name=Kubernetes
	baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
	enabled=1
	gpgcheck=1
	repo_gpgcheck=1
	gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
   EOF
]# yum install -y kubelet kubeadm kubectl
]# systemctl start kubelet
]#systemctl enable kubelet
]#cat <<EOF >  /etc/sysctl.d/k8s.conf
	net.bridge.bridge-nf-call-ip6tables = 1
	net.bridge.bridge-nf-call-iptables = 1
	EOF
]#sysctl --system -> check
]# kubeadm join --token ----> what copied from master

Istio Setup
-----------
	Installation:
		https://istio.io/docs/setup/kubernetes/install/kubernetes/
		To change istio service from LoadBalance to NodePort i updated it in install/kubernetes/istio-demo.yaml, (Search for LoadBalancer and replaced it with NodePort.)
		
The app is deployed in the namespace Demo
		
How to test
------------
Login to k8s master Node:
Get the cluster IP
	 ~]$ kubectl get svc -n=demo
	NAME    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
	myapp   ClusterIP   10.109.54.88   <none>        80/TCP    15h

To check the load is routed to each app by istio as expected
	[cloud_user@savifrnds58356a322c ~]$ while : ;do export GREP_COLOR='1;33';curl -s 10.109.54.88:80 | grep --color=always "V1" ; export GREP_COLOR='1;36'; curl -s  10.109.54.88:80 | grep --color=always "V3" ; sleep 1; done

Now based on waitage which i mentioned in the virtualservice.yml, Currently 70 for V1 and 30 for V2
```
