### Prerequisites ### 
1. A new instance (5daa09e5d31c.mylabserver.com) on the linux academy play ground (login and create a server manually).
2. A linux terminal with ansible, helm and git. 

# Run the following command on the linux terminal

#Deploy ssh public key to login cloud_user remotely

ansible-playbook deploy_authorized_keys.yml -l 5daa09e5d31c.mylabserver.com -u cloud_user --ask-pass --ask-become-pass --tags "put pubkey"

#Install minikube

ansible-playbook install_docker.yml -l 5daa09e5d31c.mylabserver.com -u cloud_user

ansible-playbook install_kubectl.yml -l 5daa09e5d31c.mylabserver.com -u cloud_user

ansible-playbook install_minikube.yml -l 5daa09e5d31c.mylabserver.com -u cloud_user

ansible-playbook start_minikube.yml -l 5daa09e5d31c.mylabserver.com -u cloud_user

#Write down the local IP of minikube node

ssh cloud_user@5daa09e5d31c.mylabserver.com 'kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}"' > IP

#Install helm and init app

ansible-playbook install_helm.yml -l 5daa09e5d31c.mylabserver.com -u cloud_user

helm create notejam

cd notejam

git init 

git add .

git remote add origin git@github.com:hohuyhoangbk/notejam-ops.git

git commit 

git push --set-upstream origin master

