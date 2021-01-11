# aws-kubernates-terraform
## Kubernates Concepts:
![N|Solid](https://i.ibb.co/QcVg3gb/circle-cropped.png)

Its just a rough notes

>> The kubelet is responsible for maintaining a set of pods, which are composed of one or more containers, on a local system. Within a Kubernetes cluster, the kubelet functions as a local agent that watches for pod specs via the Kubernetes API server.

The kube-scheduler is forwarded the requests for running containers coming to the API and finds a suitable node to run that container.

>> The kube-proxy creates and manages networking rules to expose the container on the network.

A Pod consists of one or more containers which share an IP address, access to storage and namespace.
one container in a Pod runs an application, while other containers support the primary application.

Orchestration is managed through a series of watch-loops, also called controllers or operators. Each controller interrogates the kube-apiserver for a particular object state, then modifying the object until the declared state matches the current state. These controllers are compiled into the kube-controller-manager, but others can be added using custom resource definitions. The default and feature-filled operator for containers is a Deployment. A Deployment does not directly work with pods. Instead it manages ReplicaSets. The ReplicaSet is an operator which will create or terminate pods by sending out a podSpec. 

>> The podSpec is sent to the kubelet, which then interacts with the container engine, Docker by default, to spawn or terminate a container until the requested number is running.

The service operator requests existing IP addresses and endpoints and will manage the network connectivity based on labels. These are used to communicate between pods, namespaces, and outside the cluster. There are also Jobs and CronJobs to handle single or recurring tasks, among others.

To easily manage thousands of Pods across hundreds of nodes can be a difficult task. To make management easier, we can use labels, arbitrary strings which become part of the object metadata. These can then be used when checking or changing the state of objects without having to know individual names or UIDs. Nodes can have taints to discourage Pod assignments, unless the Pod has a toleration in its metadata.

>> There is also space in metadata for annotations which remain with the object but cannot be used by Kubernetes commands. This information could be used by third-party agents or other tools

Minikube is a very simple tool meant to run inside of VirtualBox


#### Single-node
With a single-node deployment, all the components run on the same server. This is great for testing, learning, and developing around Kubernetes.

#### Single head node, multiple workers
Adding more workers, a single head node and multiple workers typically will consist of a single node etcd instance running on the head node with the API, the scheduler, and the controller-manager.

Multiple head nodes with HA, multiple workers
Multiple head nodes in an HA configuration and multiple workers add more durability to the cluster. The API server will be fronted by a load balancer, the scheduler and the controller-manager will elect a leader (which is configured via flags). The etcd setup can still be single node.

HA etcd, HA head nodes, multiple workers
The most advanced and resilient setup would be an HA etcd cluster, with HA head nodes and multiple workers. Also, etcd would run as a true cluster, which would provide HA and would run on nodes separate from the Kubernetes head nodes.

#### some commands
kubectl get event

kubectl describe deploy nginx -o yaml

kubectl delete deployment nginx

kubectl get deployment nginx -o json

kubectl describe deploy nginx -o yaml > nginx-dep.yml
kubectl replace -f nginx-dep.yml

kubectl expose deployment nginx

kubectl get ep nginx (endpoint of pods)

NAME    ENDPOINTS      AGE
nginx   21.0.1.61:80   2m8s

apt-get install tcpdump
tcpdump
>> Determine which node the container is running on. Log into that node and usetcpdump, which you may need to installusingapt-get install, to view traffic on thetunl0, as in tunnel zero, interface.  The second node in this example.  Youmay also see traffic on an interface which starts withcaliand some string. Leave that command running while you runcurlin the following step. You should see several messages go back and forth, including aHTTPHTTP/1.1 200 OK: andaackresponse to the same sequence.

tcpdump -i tunl0


The kube-apiserver is central to the operation of the Kubernetes cluster. All calls, both internal and external traffic, are handled via this agent

The kube-scheduler uses an algorithm to determine which node will host a Pod of containers

The state of the cluster, networking, and other persistent information is kept in an etcd database, or, more accurately, a b+tree key-value store. Rather than finding and changing an entry, values are always appended to the end. Previous copies of the data are then marked for future removal by a compaction process. It works with curl and other HTTP libraries, and provides reliable watch queries.


The kube-controller-manager is a core control loop daemon which interacts with the kube-apiserver to determine the state of the cluster. If the state does not match, the manager will contact the necessary controller to match the desired state

Worker Nodes
All nodes run the kubelet and kube-proxy, as well as the container engine, such as Docker or cri-o
