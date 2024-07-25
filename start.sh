# Installation
brew install kind
brew install helm
brea install docker

# Install MongoDB 
brew tap mongodb/brew
brew update
brew install mongodb-community@7.0


# Create cluster
sudo kind create cluster --config=config.yml

# If Using terraform
terraform init
terraform plan
terraform apply -auto-approve

# Check status
sudo kubectl cluster-info --context kind-kind
kind get cluster
docker ps

# check status on each nodes
sudo kubectl get nodes

# Install MongoDB
helm install my-release oci://registry-1.docker.io/bitnamicharts/mongodb
# check pods
sudo kubectl get pods

# NAME                                  READY   STATUS    RESTARTS   AGE
# my-release-mongodb-77cd8958f6-7vdx5   1/1     Running   0          7m7s

# check access
sudo kubectl exec -it my-release-mongodb.default.svc.cluster.local - sh

# ```
# Pulled: registry-1.docker.io/bitnamicharts/mongodb:15.6.16
# Digest: sha256:4c60f149d28f08250b5190bf2b01bf3b38216766b7842ac7999be1d78af6b721
# NAME: my-release
# LAST DEPLOYED: Thu Jul 25 20:46:31 2024
# NAMESPACE: default
# STATUS: deployed
# REVISION: 1
# TEST SUITE: None
# NOTES:
# CHART NAME: mongodb
# CHART VERSION: 15.6.16
# APP VERSION: 7.0.12

# ```
#Deploy MongoDB standalone using the Helm chart from Bitnami on the Kind cluster.
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
# update psswd
helm pull bitnami/mongodb
tar -xvzf mongodb*.tgz

# set name space
sudo kubectl config set-context --current --namespace=devops-databases


# install
helm install mongodb-dev mongodb/ -f mongodb-values-devops.yml

helm install mongodb . -n de



MongoDB&reg; can be accessed on the following DNS name(s) and ports from within your cluster:

    my-release-mongodb.default.svc.cluster.local

To get the root password run:

    export MONGODB_ROOT_PASSWORD=$(kubectl get secret --namespace default my-release-mongodb -o jsonpath="{.data.mongodb-root-password}" | base64 -d)