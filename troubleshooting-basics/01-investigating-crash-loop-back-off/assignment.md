---
slug: investigating-crash-loop-back-off
id: nan4nxzqkbpm
type: challenge
title: Why is my container crashing?
teaser: Uncover why the container is crashing.
notes:
- type: text
  contents: |-
    The latest version of your team's application is crashing.
    The goal of this exercise, using the Openshift console, or command line. Discover why the container fails to start, and resolve the issue.

    You'll concentrate on a single domain of the stack, and learn to triage issues with container startup.

    ![stack container logs](../assets/stack-container-logs.png)
tabs:
- title: OpenShift Console
  type: website
  url: https://console-openshift-console.crc-dzk9v-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- title: Shell
  type: terminal
  hostname: crc
difficulty: basic
timelimit: 1200
---

A core skill working with Kubernetes is diagnosing containers crash events.

Complete this exercise using the following credentials:

<pre>
  username: admin
  password: admin
</pre>

Switch to the Developer prespective.

You’ve deployed the latest version of the crash-test application to the cluster, and funnily enough, it is crashing on startup.
Looking at the topology view of the crash-test project, you’ll find the container’s halo transition from blue, yellow, and finally red.
Once red, Kubernetes has put the container in `Crash Loop BackOff` state.

![pod status red](../assets/pod-status-red.png)

<details><summary>Command line</summary>
  <pre>oc get pods</pre>
</details>

## Click on the deployment.

![pod show details tab](../assets/pod-show-details-tab.png)

<details><summary>Command line</summary>
  <pre>oc describe pod <em>pod_name</em></pre>
</details>

From OpenShift 4.10 clicking on `Crash Loop BackOff` will reveal more details of the erroneous state and suggested places to start troubleshooting.

![pod error flavour](../assets/pod-error-flavour.png)

Containers can crash for a variety of reasons. Often, applications inside containers stop if they are missing a key piece of configuration needed to run safely.

## Let’s review the logs.

![stack container logs](../assets/stack-container-logs.png)

![pod logs tab 1](../assets/pod-logs-tab-1.png)

<details><summary>Command line</summary>
  <pre>oc logs <em>pod_name</em></pre>
</details>

The error message in the logs suggests that the pod is looking for an environment variable.
We can check environment variables by clicking on the Environment tab.

![pod environment vars](../assets/pod-environment-vars.png)

Do you see a `LOG_ECHO` environment variable?

---

## Diagnosis

The deployment is missing the `LOG_ECHO` environment variable.
Return to the topology screen, and the deployment details.

---

## The fix

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
We can confirm the container is healthy by checking the container logs.

![pod logs tab 2](../assets/pod-logs-tab-2.png)