# Repo para EIEC - Máster DevOps - UNIR

Este repositorio incluye comandos para facilitar el arranque de servidores de Jenkins, GitLab y Nexus. El despliegue de una instancia local de GitLab se incluye como ejemplo, ya que el temario cubre el uso de la oferta SaaS.

Los comandos del Makefile funcionarán en Linux y MacOS. En caso de usar Windows, necesitarás adaptarlos o ejecutarlos en una máquina virtual Linux.

## Guía rápida para Jenkins

- Ejecuta `make start-jenkins`. El arrange de los agentes fallará.
- Ejecuta `make jenkins-password` y copia la password al portapapeles.
- Accede a http://localhost:8080 y usa la password anterior.
- Completa el asistente de configuración inicial.
- Crea 2 agentes:
  - `agent01`, con _Remote root directory_ `/var/jenkins` y etiqueta `docker`.
  - `agent02`, con _Remote root directory_ `/var/jenkins` y etiqueta `maven`.
- Copia el secreto del agente 1 en la variable `JENKINS_DOCKER_AGENT_SECRET` del `Makefile` y el secreto del agente 2 en la variable `JENKINS_MAVEN_AGENT_SECRET`.
- Ejecuta `make stop-jenkins`, seguido de `make start-jenkins`.
- Cuando termines de trabajar con Jenkins, ejecuta `make stop-jenkins`.


## Guía rápida para Nexus

- Ejecuta `make start-nexus`.
- Ejecuta `make nexus-password` y copia la password al portapapeles.
- Accede a http://localhost:8081 y usa la password anterior para crear el primer usuario.
- Cuando termines de trabajar con Nexus, ejecuta `make stop-nexus`.
