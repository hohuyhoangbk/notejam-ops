# Prerequisites #
1. A new instance (5daa09e5d31c.mylabserver.com) on the linux academy play ground (login and create a server manually).
2. A linux terminal with ansible, helm and git. 

# Run the following command on the linux terminal #

###Deploy ssh public key to login cloud_user remotely

ansible-playbook deploy_authorized_keys.yml -l 5daa09e5d31c.mylabserver.com -u cloud_user --ask-pass --ask-become-pass --tags "put pubkey"

###Install packages on minikube server

ansible-playbook install_docker.yml -l 5daa09e5d31c.mylabserver.com -u cloud_user

ansible-playbook install_kubectl.yml -l 5daa09e5d31c.mylabserver.com -u cloud_user

ansible-playbook install_minikube.yml -l 5daa09e5d31c.mylabserver.com -u cloud_user

ansible-playbook start_minikube.yml -l 5daa09e5d31c.mylabserver.com -u cloud_user

#Write down the local IP of minikube node

ssh cloud_user@5daa09e5d31c.mylabserver.com 'kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}"' > IP

#Install nginx and get the default configuration

ansible-playbook install_nginx.yml -l 5daa09e5d31c.mylabserver.com -u cloud_user

mkdir -p nginx; scp cloud_user@5daa09e5d31c.mylabserver.com:/etc/nginx/sites-available/default nginx

#Install helm, init app, and push to git repo notejam-ops, branche master.

ansible-playbook install_helm.yml -l 5daa09e5d31c.mylabserver.com -u cloud_user

helm create notejam

cd notejam

git init 

git add .

git remote add origin git@github.com:hohuyhoangbk/notejam-ops.git

git commit -m "First commit"

git push --set-upstream origin master

#Push all ansible scripts and nginx configure to repo, branch main.




