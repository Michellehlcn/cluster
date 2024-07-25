
# Create mongoSecrets
```
sudo kubectl create -f mongodb-secrets.yaml
```
# Create pvc
```
sudo kubectl create -f mongodb-pvc.yaml
```
# Deploy standalone MongoDB
```
sudo kubectl create -f mongodb-deployment.yaml
```
# Create svc nodeport
```
sudo kubectl create -f mongodb-nodeport-svc.yaml
```
# Create mongodb client pod. Deploy the client.
```
sudo kubectl create -f mongodb-new-client.yaml
```
# check connection from client pod
```
sudo kubectl exec deployment/mongo-client -it -- /bin/bash
mongosh --host mongo-nodeport-svc --port 27017 -u adminuser -p password123
```

# Check if MongoDB is accessible from the local machine.
#----Foward port
```
sudo kubectl port-forward mongo-58c6b77cf9-pbw2q 28016:27017
```
#----Connect
```
mongosh --host localhost --port 28016 -u adminuser -p password123
```