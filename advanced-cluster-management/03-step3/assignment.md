---
slug: step3
id: nwdlnze5iicz
type: challenge
title: Application Lifecycle
notes:
- type: text
  contents: |-
    In the next learning module, we cover Application management with ACM and the following Concepts:

    * Label the Managed Clusters with the appropriate "Role"
    * Clone an example application (GitOps)
    * Deploy the example applicaton
    * Review the application has been deployed using the ACM GitOps Controller

    Let's begin!
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root
- title: ACM Hub Console
  type: website
  url: https://multicloud-console.crc-dzk9v-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- title: Hub OCP Console
  type: website
  url: https://console-openshift-console.crc-dzk9v-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- title: Spoke Cluster 1
  type: service
  hostname: spoke1
  path: /
  port: 30001
  new_window: true
- title: Spoke Cluster 2
  type: service
  hostname: spoke2
  path: /
  port: 30001
  new_window: true
difficulty: basic
timelimit: 6000
---
Connect to ACM Hub:

```
oc login -u admin -p admin https://api.crc.testing:6443 --insecure-skip-tls-verify=true
```

Label the Clusters as "prod" to ensure Application placement rules

```
export CLUSTER_NAME=spoke1
```

```
oc label managedclusters ${CLUSTER_NAME} "environment=prod" --overwrite
```

```
export CLUSTER_NAME=spoke2
```

```
oc label managedclusters ${CLUSTER_NAME} "environment=prod" --overwrite
```

Clone the test applicaton

```
git clone https://github.com/waynedovey/blue-green-rhacm.git
```

```
cd blue-green-rhacm
```

Create and Deploy the Application

```
./acm-create.sh
```

# Login into the Spoke1 cluster

Validate the new Application
```
export CLUSTER_NAME=spoke1
```
```
oc login --token=superSecur3T0ken --server=http://${CLUSTER_NAME}:8001
```

Display the newly created namespace
```
kubectl get namespaces
```
Display the newly created pods and application deployed
```
kubectl get pods -n blue-green
```

# Login into the Spoke2 cluster

Validate the new Application
```
export CLUSTER_NAME=spoke2
```
```
oc login --token=superSecur3T0ken --server=http://${CLUSTER_NAME}:8001
```

Display the newly created namespace
```
kubectl get namespaces
```
Display the newly created pods and application deployed
```
kubectl get pods -n blue-green
```

Completed, move onto the next assignment.