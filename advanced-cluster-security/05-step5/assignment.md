---
slug: step5
id: uf4dzxrpgbif
type: challenge
title: Network Policies
notes:
- type: text
  contents: |-
    In the last learning module, we cover Network Policies with RHACS and the following Concepts:

    * Use Helm to Deploy example Wordpress Application on Test Cluster.
    * Review the current running NetworkPolicies.
    * Use RHACS to Generate and Apply NetworkPolicies to the Running Cluster.
    * Review the Network Graph and active connections.
    * Review the new running NetworkPolicies.

    Let's begin!
tabs:
- title: Work Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root
- title: Wordpress
  type: service
  hostname: spoke1
  path: /
  port: 31500
  new_window: true
- title: RHACS Console
  type: website
  url: https://central-acs.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: advanced
timelimit: 6000
---
Login to the Spoke1 Cluster
```
export CLUSTER_NAME=spoke1
```

Login to the Spoke1 cluster
```
oc login --token=superSecur3T0ken --server=http://${CLUSTER_NAME}:8001
```

Ensure the namespaces have been removed (Ignore any errors)

```
kubectl delete ns ssh-test ssh-test-enforce test-runtime
```

Add the required Helm Repo

```
helm repo add bitnami https://charts.bitnami.com/bitnami
```

Update to the latest

```
helm repo update
```

Create the required Namespace for Wordpress
```
kubectl create namespace wordpress
```

Now install the Wordpress sample application and pay attention to the Nodeport for Console access
```
helm install wp-test bitnami/wordpress -n wordpress --set service.nodePorts.http=31500
```

Check the running App
```
oc get pods -n wordpress
```

Once both pods "STATUS" is set to Runnin, you can now browse to the "Wordpress" Link

![perspective-toggle](../assets/acs-wordpress-p1.png)
![perspective-toggle](../assets/acs-wordpress-p2.png)


Check for any current NetworkPolicies on the namespace
```
oc get NetworkPolicy -n wordpress
```

Login to the RHACS Console

![perspective-toggle](../assets/acs-login-console.png)

Navigate to the "Network Graph" link on the Console

Ensure the "spoke1" cluster is selected and "wordpress" under "Namespaces"

![perspective-toggle](../assets/acs-wordpress-p3.png)

Click on the "wp-test-mariadb" Deployment and review the various Ports and Protocols

![perspective-toggle](../assets/acs-wordpress-p4.png)

Now Click on the "Network Policies" Tab and observe "No network policies define for this deployment"

![perspective-toggle](../assets/acs-wordpress-p5.png)

Next, Click on the "Network Policy Simulator" on the top Right

![perspective-toggle](../assets/acs-wordpress-p6.png)

Then click on the "Generate and simulate network policies" Tab

![perspective-toggle](../assets/acs-wordpress-p7.png)

This will output a message "Successfully generated YAML" and the appropriate NetworkPolicy file

![perspective-toggle](../assets/acs-wordpress-p8.png)
![perspective-toggle](../assets/acs-wordpress-p9.png)

Now Select the "Apply Network Policies" button, confirm and "APPLY"

![perspective-toggle](../assets/acs-wordpress-p10.png)
![perspective-toggle](../assets/acs-wordpress-p11.png)

This will output a message "Successfully applied YAML"

![perspective-toggle](../assets/acs-wordpress-p12.png)

Return to the "Work" Screen and check the NetworkPolicy and Describe them

```
oc get NetworkPolicy -n wordpress
```

```
oc describe NetworkPolicy stackrox-generated-wp-test-mariadb -n wordpress
```

This will show the appropriate ports that are allowed.

You can also test the "Wordpress" URL again.

Completed, move onto the next assignment.