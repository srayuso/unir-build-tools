FROM jenkins/inbound-agent as agent

FROM node:12.20.0-alpine3.12

RUN apk -U add openjdk8-jre git make

COPY --from=agent /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-agent
COPY --from=agent /usr/share/jenkins/agent.jar /usr/share/jenkins/agent.jar

ENTRYPOINT ["/usr/local/bin/jenkins-agent"]