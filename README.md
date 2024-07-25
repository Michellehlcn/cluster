# 1. Kind Cluster Installation 
```
brew install kind
brew install helm
brea install docker
```

### Install MongoDB 
```
brew install mongosh
```

### Set up a local Kubernetes cluster using Kind.
```
sudo kind create cluster --config=config.yml
```

### If using terraform
```
cd infra
terraform init
terraform plan
terraform apply -auto-approve
```

### Check status
```
sudo kubectl cluster-info --context kind-kind
kind get cluster
docker ps
```

### Check status on each nodes
```
sudo kubectl get nodes
```

# Deploy MongoDB standalone using the Helm chart from Bitnami on the Kind cluster.
### set name space
```
sudo kubectl create namespace devops-database
sudo kubectl config set-context --current --namespace=devops-database
```

### install MongoDB standalone using default configuration
```
sudo helm install my-release oci://registry-1.docker.io/bitnamicharts/mongodb
```

### install MongoDB standalone using custom configuration
# 2. Deploy MongoDB standalone using the Helm chart from Bitnami on the Kind cluster.
```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm pull bitnami/mongodb
tar -xvzf mongodb*.tgz
```
### set name space
```
sudo kubectl config set-context --current --namespace=devops-database
```
### install
```
helm install mongodb-dev mongodb/ -f mongodb-values.yml  
```

### get the password run
```
export MONGODB_ROOT_PASSWORD=$(sudo kubectl get secret --namespace devops-database my-release-mongodb -o jsonpath="{.data.mongodb-root-password}" | base64 -d)
```
### if needed, edit secret & add username (use vim)
```
sudo kubectl edit secret --namespace devops-database my-release-mongodb
```

### check pods
```
sudo kubectl get pod -o wide
```
### connect DB 
```
sudo kubectl get pod my-release-mongodb-77cd8958f6-6lxzs  --template='{{(index (index .spec.containers 0).ports 0).containerPort}}{{"\n"}}'
```
### Forward port 
```
sudo kubectl port-forward my-release-mongodb-77cd8958f6-6lxzs 28015:27017
```
### Connect from the local machine.
```
mongosh --host localhost --port 28015 -u root -p $MONGODB_ROOT_PASSWORD
```

<!-- # NAME                                  READY   STATUS    RESTARTS   AGE
# my-release-mongodb-77cd8958f6-7vdx5   1/1     Running   0          7m7s -->


<!------------ RESULTS
# NAME: my-release
# LAST DEPLOYED: Thu Jul 25 22:15:35 2024
# NAMESPACE: devops-database
# STATUS: deployed
# REVISION: 1
# TEST SUITE: None
# NOTES:
# CHART NAME: mongodb
# CHART VERSION: 15.6.16
# APP VERSION: 7.0.12

# ** Please be patient while the chart is being deployed **

# MongoDB&reg; can be accessed on the following DNS name(s) and ports from within your cluster:

#     my-release-mongodb.devops-database.svc.cluster.local

# To get the root password run:

#     export MONGODB_ROOT_PASSWORD=$(kubectl get secret --namespace devops-database my-release-mongodb -o jsonpath="{.data.mongodb-root-password}" | base64 -d)

# ``` -->


#----Test using Mongosh shell script
```
test> show dbs
```
<!-- # admin   100.00 KiB
# config   72.00 KiB
# local    72.00 KiB -->
```
test> db.blogs.insert({name: "devopscube" })
```
<!-- # {
#   acknowledged: true,
#   insertedIds: { '0': ObjectId('66a2670a01d79a1cf5cab0a2') }
# } -->
```
test> db.blogs.find()
```
<!-- # [ { _id: ObjectId('66a2670a01d79a1cf5cab0a2'), name: 'devopscube' } ] -->



# 3. Python Script for MongoDB Interaction
```
python3 release_info.py -u root -p $MONGODB_ROOT_PASSWORD -s test -t v1.0 
```

- How would you handle errors related to MongoDB connectivity or document insertion in your script?
- Explain the importance of using Helm charts for deploying applications like MongoDB in Kubernetes.
- Describe a solution where the script requested above is integrated into.
- Explain your thought process and how you could improve the script to improve your use case.