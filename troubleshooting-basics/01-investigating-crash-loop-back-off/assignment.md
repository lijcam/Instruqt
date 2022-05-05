---
slug: investigating-crash-loop-back-off
id: nan4nxzqkbpm
type: challenge
title: Why is my container crashing?
teaser: A core skill in working with Kubernetes is diagnosing containers crash events.
notes:
- type: text
  contents: |-
    The latest version of your team's application is crashing.
    The goal of this exercise, using the Openshift console, or command line. Discover why the container fails to start, and resolve the issue.
tabs:
- title: OpenShift Console
  type: website
  url: https://console-openshift-console.crc-dzk9v-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- title: Shell
  type: terminal
  hostname: crc
difficulty: basic
timelimit: 600
---

A core skill working with Kubernetes is diagnosing containers crash events.

Complete this track as the `admin` user using the following credentials:

* Username:
```
admin
```
* Password:
```
admin
```
And switch to the Developer prespective.

You’ve deployed the latest version of the crash-test application to the cluster, but it is crashing on startup.
Looking at the topology view of the crash-test project, you’ll find the container’s halo transition from blue, yellow, and finally red.
Once red, Kubernetes has put the container in `Crash Loop BackOff` state.

![pod status red](../assets/pod-status-red.png)

<details><summary>Command line</summary>
  <pre>oc get pods</pre>
</details>

Click on the deployment to view the state.

![pod show details tab](../assets/pod-show-details-tab.png)

<details><summary>Command line</summary>
  <pre>oc describe pod \<pod name\></pre>
</details>

From OpenShift 4.10 clicking on `Crash Loop BackOff` will reveal more details of the erroneous state and suggested places to start troubleshooting.

![pod error flavour](../assets/pod-error-flavour.png)

Containers crash for a variety of reasons. Often, applications inside containers stop if they are missing a key piece of configuration needed to run safely.
Let’s review the logs.

![pod logs tab 1](../assets/pod-logs-tab-1.png)

<details><summary>Command line</summary>
  <pre>oc logs \<pod name\></pre>
</details>

The error message in the logs suggests that the pod is looking for an environment variable.
We can check environment variables by clicking on the `Environment` tab.

![pod environment vars](../assets/pod-environment-vars.png)

Do you see a `LOG_ECHO` environment variable?

—

The deployment is missing the `LOG_ECHO` environment variable.
Return to the topology screen, and the deployment details.
From the `Actions` menu, click `Edit Deployment`.

![edit deployment](../assets/edit-deployment.png)

Scroll down to the environment variables section and add the `LOG_ECHO` environment variable. Confirm by clicking Save.

![edit environment vars](../assets/edit-environment-vars.png)

<details><summary>Command line</summary>
  <pre>oc edit deployment/crash-test</pre>
</details>

Once saved, Kubernetes will act upon the updated deployment and reconcile towards the new desired state.

![deployment reconciliation](../assets/deployment-reconciliation.png)

Does the container crash this time?
We can reconfirm the container by checking the logs.

![pod logs tab 2](../assets/pod-logs-tab-2.png)