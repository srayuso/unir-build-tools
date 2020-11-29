# Repo para EIEC - DevOps - UNIR

Este repositorio incluye comandos para facilitar el arranque de servidores de Jenkins, GitLab y Nexus. El despliegue de una instancia local de GitLab se incluye como ejemplo, ya que el temario cubre el uso de la oferta SaaS.

Los comandos del Makefile funcionarán en Linux y MacOS. En caso de usar Windows, necesitarás adaptarlos o ejecutarlos en una máquina virtual Linux.

## Guía rápida para Jenkins

- Ejecuta `make build-agents` para construir las imágenes de los agentes.
- Ejecuta `make start-jenkins`. El arrange de los agentes fallará.
- Ejecuta `make jenkins-password` y copia la password al portapapeles.
- Accede a http://localhost:8080 y usa la password anterior.
- Completa el asistente de configuración inicial.
- Crea 3 agentes:
  - `agent01`, con _Remote root directory_ `/var/jenkins` y etiqueta `docker`.
  - `agent02`, con _Remote root directory_ `/var/jenkins` y etiqueta `maven`.
  - `agent03`, con _Remote root directory_ `/var/jenkins` y etiqueta `node`.
- Copia el secreto del agente 1 en la variable `JENKINS_DOCKER_AGENT_SECRET` del `Makefile`, el secreto del agente 2 en la variable `JENKINS_MAVEN_AGENT_SECRET` y el secreto del agente 3 en la variable `JENKINS_NODE_AGENT_SECRET`. Los secretos están disponibles en la página del agente. Jenkins muestra el código que hay que ejecutar para arrancar el servicio del agente, y el secreto está embebido en estos comandos, tal como se muestra la imagen.

![agent-secret](/assets/agent-secret.jpg)

- Ejecuta `make stop-jenkins`, seguido de `make start-jenkins`.
- Cuando termines de trabajar con Jenkins, ejecuta `make stop-jenkins`.


## Guía rápida para Nexus

- Ejecuta `make start-nexus`. Si quieres que haya comunicación entre Jenkins y Nexus, ejecuta `make start-nexus-jenkins` _después_ de haber arrancado Jenkins.
- Ejecuta `make nexus-password` y copia la password al portapapeles.
- Accede a http://localhost:8081 y usa la password anterior para crear el primer usuario.
- Cuando termines de trabajar con Nexus, ejecuta `make stop-nexus`.
