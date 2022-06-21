---
slug: persistent-volume-claim
id: nfjk4le951by
type: challenge
title: Adding persistence to our application.
teaser: Go for the high score!
notes:
- type: text
  contents: |-
    Your team is getting closer to go live! The last feature is to implement high scores in the Pacman application.

    Containers are stateless in nature. If our container fails, is redeployed, or rescheduled to another node. Any data it was processing will be lost. In Kubernetes, we use Persistent Volumes to overcome this, by attached a Persistent Volume Claim to our containers.

    This task, is to attach a Persistent Volume Claim to our Mongo Database, so our high score can live on into eternity!
tabs:
- title: Terminal
  type: terminal
  hostname: crc
- title: Editor
  type: code
  hostname: crc
  path: /root/team-pacman/
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-dzk9v-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 1200
---
This exercise builds on what we learned from the previous exercise. The goal, to attach storage into our mongo pod to keep our high scores!

Containers are stateless in nature. If our container fails, is redeployed, or rescheduled to another node. Any data it was processing will be lost. In Kubernetes, we use Persistent Volumes to overcome this, by attached a Persistent Volume Claim to our containers.

Create a new project.

```
oc new-project team-pacman
```

Use the Editor Tab to see the Persistent Volume Claim Kubernetes Object.
```
oc apply -f mongo-pvc.yml
```

We can view the status of the Persistent Volume Claim in the console in the Administrator view: Storage > PersistentVolumeClaims

## Modify the database deployment

Modify our Pod Template for the database to include the volume, and a volumeMount for the container. [An example can be found in offical documentation](https://docs.openshift.com/container-platform/4.9/storage/understanding-persistent-storage.html#pvc-claims-as-volumes_understanding-persistent-storage) but make sure you set the following parameters correctly.

The file we need to modify is `mongo-deployment.yml`

1. In the container, volumeMounts section, the `mountPath` must be `/data/db/`
2. In the volume section, `claimName` must match the name of the Persistent Volume Claim.

## Deploy the database

Create the mongo Deployment, and Service.

```
oc apply -f mongo-deployment.yml
```

```
oc apply -f mongo-service.yml
```

## Deploy the Pacman application

Use the existing Pacman Kubernetes Objects to deploy the Pacman app.

```
oc apply -f pacman-deployment.yml
```

```
oc apply -f pacman-service.yml
```

```
oc apply -f pacman-route.yml
```