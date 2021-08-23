# Firestrike Infrastructure as Code Repository

## What exists currently

### Cloud resources
* Two clusters up and running on two different AWS accounts (dev and prod)
  * firestrike-singapore-dev
  * firestrike-oregon-prod-2
* Small ec2 instance in Tokyo for testing tcp proxy to gate

### Infrastructure as Code
* Scripts for setting up AWS ECR repository.
* Dockerfile for building firestrike server and generate a runtime docker image under both Ubuntu and CentOS.
* Makefile for pulling down firestrike-server code from SVN and execute docker build and push image to AWS ECR.
* Scripts for building firestrike-server docker image and publish to AWS ecr.
* Generation of Packer image for custom Kubernetes AMI to allow adding of feature gates, in our case we are using the NonPreemptingPriority.
* Scripts to setup Kubernetes cluster on AWS EKS using generated Packer image.
* Scripts for creating nodegroups, monitoring, global and world.
* Scripts for installing/upgrading/deleting Helm charts for monitoring and logging tools in namespace monitoring on monitoring nodegroup.
* Helm chart and script for installing/upgrading/deleting Globals in namespace firestrike-global<n> on global nodegroup.
* Helm chart and script for installing/upgrading/deleting Worlds in namespace firestrike-world<n> on world nodegroup.
* Helm chart and script for installing and upgrading World into firestrike-world<n> namespace on world nodegroup.
* Scripts for installing Helm chart for monitoring and logging tools into the monitoring namespace on monitoring nodegroup.
  * Prometheus, Grafana
  * ElasticSearch, Filebeat with configured multiline support, Kibana
* Custom Grafana dashboards that monitor different metrics in the cluster, one of which was developed for the stress-testing tool.
* SMTP is Setup for Alert manager and one Alert exist on dev cluster.

### Tooling
We use standard tools for managing cluster, cloud resources, environments and infrastructure code.
  * Git and GitHub
  * kubectl
  * kubectx
  * eksctl
  * awscli

### Inhouse built tools
* Stresstesting tool to simulate player load on cluster.

## TODO

### Infrastructrure as Code
* Cleanup of code and unused scripts and improve folder hierarchy.
* Automate the sequential execution of all scripts involved in full cluster creation in an idempotent manner.

### Operational and CI/CD
* Research and choice of suitable CI/CD tool(s).
* Installation/Development of tool(s)
* Creation/Deletion of new cluster in specified region.
* Creation/Deletion/Upgrade of globals and worlds.
* Scaling up and down of nodegroups to match resources required by Globals and Worlds.
* One interface to access UI of all tools including monitoring tools.

### Security
* Remove all secrets from Git repository.
* Automate process of setting up AWS accounts following Principle Of Least Privilege
* Create a VPN tunnel to the cluster or Use a bastion (jumpbox) for communication with Kubernetes API.
* Only expose ports on nodes that are needed following https://en.wikipedia.org/wiki/Principle_of_least_privilege
* RBAC: Create roles and assign users to roles.
* RBAC: Create service accounts tied to roles for services limiting which services they can talk to.
* RBAC: Restrict who can scheadule pods on which nodegroups.
* Define cluster security policies and configure Admission Controller to automatically enforce them.
* Avoid using container images from public repositories like DockerHub, or at least only use them if they’re from official vendors like Ubuntu or Microsoft.
* Implement tools like Clair or MicroScanner to scan containers for potential vulnerabilities after the build step in CI/CD pipeline.
* Create audit policies to decide at which level and what things we'd like to log each time the Kubernetes API is called to be able to backtrack a security breach.
* Go through the benchmark test for Kubernetes from CIS (Center for Internet Security)

### Reliability
* Define the most critical and most likely to happen issues with the cluster.
* Write scripts that make these issues happen (Chaos Engineering)
* Harden cluster towards these issues
* Write scripts for more complex recovery scenarios.
* Create backup processes for important stateful data such as redis.


## How to create a cluster
Because all of the modules/services of firestrike are stateful, and because we need to make sure no previously deployed pods gets evicted when we add new worlds, even with too few compute resources we require a feature gate called NonPreemptingPriority which will enable us to set ``preemptionPolicy: never ``` to our priority classes, making sure that our burstable pods never get evicted.
Because AWS EKS only supports feature-gates that are beta and NonPreemptingPriority is at the time of writing, alpha version, we need to create a custom EKS AMI with this feature-gate enabled.

### Using packer to create AMI

Make sure the following environment variables are set:

```
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_DEFAULT_REGION
```

```
git clone git@github.com:bococ/amazon-eks-ami.git
# Sync and merge upstream
git fetch upstream
cd amazon-eks-ami && make 1.16 # Or whatever kubernetes version you want
# Take not of the AMI id generated
```

### Deploy cluster with custom AMI
Requirements:
* awscli
* eksctl
* kubectl
* kubectx

```
git clone git@github.com:bococ/firestrike_deploy.git
cd eks/scripts
export AWS_PROFILE= # Has to point to a correct config in ~/.aws/config
export ENV=dev # For dev environment
# Edit create-cluster.sh to use the correct AMI
./create-cluster.sh # Provide arguments
```
=======

### Infrastructure as Code
* Scripts for setting up AWS ECR repository.
* Dockerfile for building firestrike server and generate a runtime docker image under both Ubuntu and CentOS.
* Makefile for pulling down firestrike-server code from SVN and execute docker build and push image to AWS ECR.
* Scripts for building firestrike-server docker image and publish to AWS ecr.
* Generation of Packer image for custom Kubernetes AMI to allow adding of feature gates, in our case we are using the NonPreemptingPriority.
* Scripts to setup Kubernetes cluster on AWS EKS using generated Packer image.
* Scripts for creating nodegroups, monitoring, global and world.
* Scripts for installing/upgrading/deleting Helm charts for monitoring and logging tools in namespace monitoring on monitoring nodegroup.
* Helm chart and script for installing/upgrading/deleting Globals in namespace firestrike-global<n> on global nodegroup.
* Helm chart and script for installing/upgrading/deleting Worlds in namespace firestrike-world<n> on world nodegroup.
* Helm chart and script for installing and upgrading World into firestrike-world<n> namespace on world nodegroup.
* Scripts for installing Helm chart for monitoring and logging tools into the monitoring namespace on monitoring nodegroup.
  * Prometheus, Grafana
  * ElasticSearch, Filebeat with configured multiline support, Kibana
* Custom Grafana dashboards that monitor different metrics in the cluster, one of which was developed for the stress-testing tool.
* SMTP is Setup for Alert manager and one Alert exist on dev cluster.

### Tooling
We use standard tools for managing cluster, cloud resources, environments and infrastructure code.
  * Git and GitHub
  * kubectl
  * kubectx
  * eksctl
  * awscli

### Inhouse built tools
* Stresstesting tool to simulate player load on cluster.

## TODO

### Infrastructrure as Code
* Cleanup of code and unused scripts and improve folder hierarchy.
* Automate the sequential execution of all scripts involved in full cluster creation in an idempotent manner.

### Operational
* Setup of suitable CI/CD system for common operations.
	* Creation/Deletion of new cluster in specified region.
	* Creation/Deletion/Upgrade of globals and worlds.
	* Scaling up and down of nodegroups to match resources required by Globals and Worlds
	* One interface to access UI of all monitoring tools.

### Security
* Remove all secrets from Git repository.
* Automate process of setting up AWS accounts following Principle Of Least Privilege
* Create a VPN tunnel to the cluster or Use a bastion (jumpbox) for communication with Kubernetes API.
* Only expose ports on nodes that are needed following https://en.wikipedia.org/wiki/Principle_of_least_privilege
* RBAC: Create roles and assign users to roles.
* RBAC: Create service accounts tied to roles for services limiting which services they can talk to.
* RBAC: Restrict who can scheadule pods on which nodegroups.
* Define cluster security policies and configure Admission Controller to automatically enforce them.
* Avoid using container images from public repositories like DockerHub, or at least only use them if they’re from official vendors like Ubuntu or Microsoft.
* Implement tools like Clair or MicroScanner to scan containers for potential vulnerabilities after the build step in CI/CD pipeline.
* Create audit policies to decide at which level and what things we'd like to log each time the Kubernetes API is called to be able to backtrack a security breach.
* Go through the benchmark test for Kubernetes from CIS (Center for Internet Security)
>>>>>>> ce9f8e5... Added info to README
