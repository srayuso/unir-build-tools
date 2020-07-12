JENKINS_DOCKER_AGENT_SECRET := 23d26b0920a09d45e01b599897e206334051dd267a27a9cbd42a07ba8e95b0e5
JENKINS_MAVEN_AGENT_SECRET := e5c1844b4d36b785474c0edac1cd98cbbc29ca9f4b7c458190689815b9eb143e

.PHONY: all $(MAKECMDGOALS)

build-agents:
	docker build -t jenkins-agent-docker ./jenkins-agent-docker
	docker build -t jenkins-agent-maven ./jenkins-agent-maven

start-jenkins:
	docker network create jenkins || true
	docker run -d --rm --stop-timeout 60 --network jenkins --name jenkins-docker --privileged --network-alias docker  --env DOCKER_TLS_CERTDIR=/certs  --volume jenkins-docker-certs:/certs/client  --volume jenkins-data:/var/jenkins_home -p 2376:2376 -p 80:80 docker:dind
	docker run -d --rm --stop-timeout 60 --network jenkins --name jenkins-server --env DOCKER_HOST=tcp://docker:2376 --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 --volume jenkins-data:/var/jenkins_home --volume jenkins-docker-certs:/certs/client:ro -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts
	sleep 30
	docker run -d --rm --network jenkins --name jenkins-agent-docker --init --env DOCKER_HOST=tcp://docker:2376 --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 --volume jenkins-docker-certs:/certs/client:ro --env JENKINS_URL=http://jenkins-server:8080 --env JENKINS_AGENT_NAME=agent01 --env JENKINS_SECRET=$(JENKINS_DOCKER_AGENT_SECRET) --env JENKINS_AGENT_WORKDIR=/home/jenkins/agent jenkins-agent-docker
	docker run -d --rm --network jenkins --name jenkins-agent-maven --init --env JENKINS_URL=http://jenkins-server:8080 --env JENKINS_AGENT_NAME=agent02 --env JENKINS_SECRET=$(JENKINS_MAVEN_AGENT_SECRET) --env JENKINS_AGENT_WORKDIR=/home/jenkins/agent jenkins-agent-maven

stop-jenkins:
	docker stop jenkins-agent-docker || true
	docker stop jenkins-agent-maven || true
	docker stop jenkins-docker || true
	docker stop jenkins-server || true
	docker network rm jenkins || true


