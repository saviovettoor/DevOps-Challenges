```
Installing Docker
-----------------
OS: CentOS Linux release 7.6.1810 (Core)
	]#yum install -y yum-utils device-mapper-persistent-data lvm2
	]#yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo ##CE since community edition(EE for enterprice)
	]#yum update -y
	]#yum install docker-ce -y
	]#systemctl enable docker && systemctl start docker && systemctl status docker
Granting non privilage user savio to run docker command
	/var/run/docker.sock
	#adding the user savio to docker group
		]#usermod -aG docker savio
Installing Docker Compose
	]#sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	]#sudo chmod +x /usr/local/bin/docker-compose
	]#docker-compose --version	#to view the version which you have installed
Listout the running container
	]#docker container ls
How to login to Notification container
	]#docker exec -ti  984f1b08d6ae  /bin/sh

How to run the task without a docker compose file?
Create following folders in the server and place the file
	/opt/e-bot7/
		Dockerfile
		notifications.sh
	/opt/e-bot7/nginx/
	/opt/e-bot7/nginx/conf.d/
		auth.htpasswd
		default.conf
	/opt/e-bot7/nginx/index-page
		index.html
	1. Create a data volume to share the log file between container
		]# docker volume create --label=shared_volume
	2. Starting our our nginx app
		]#docker run -d --name e-bot7-webserver -v /opt/e-bot7/nginx/index-page/:/usr/share/nginx/html -v /opt/e-bot7/nginx/conf.d/:/etc/nginx/conf.d/ -v shared_volume:/var/log/nginx/ -p 80:80 nginx
	3. Building our notifiebserver container image
		docker build -t notification .
	4. Starting notification server
		docker run -d -it --name=notifications -v shared_volume:/opt/ notification
```
