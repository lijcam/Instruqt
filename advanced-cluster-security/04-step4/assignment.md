---
slug: step4
id: wyufm7ecioj2
type: challenge
title: Runtime Policies
notes:
- type: text
  contents: |-
    In the next learning module, we demonstrate the real time capabilities of RHACS policies after containers are started. Runtime policies meet requirements for threat detection and prevention, incident investigation and response:

    * Manage an existing Policy.
    * Enable the Policy for Runtime.
    * Enforce the Policy for Runtime.
    * Test the Policy to ensure enforcement.
    * Review the outputs and error messages.

    Let's begin!
tabs:
- title: Work Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root
- title: RHACS Console
  type: website
  url: https://central-acs.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- title: OCP Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: advanced
timelimit: 6000
---
Login to the RHACS Console

![perspective-toggle](../assets/acs-login-console.png)

Next, set the policy to enforce.

Go to "Platform Configuration" in the Menu, then select "Policy management"

Search for "Ubuntu Package Manager Execution"

![perspective-toggle](../assets/acs-policy-runtime-p1.png)

Next, select "Edit policy"

![perspective-toggle](../assets/acs-policy-runtime-p2.png)

Similar to the previous assigment, select the "Policy behavior"

![perspective-toggle](../assets/acs-policy-runtime-p3.png)

Then go down to the "Response method" and enable "Inform and enforce"

This time choose the "Enforce on Runtime" option

![perspective-toggle](../assets/acs-policy-runtime-p4.png)

Now click on the "Next" 3 times and then "Save" this policy

Next, deploy the same Pod/Application in a new namespace in the "Work" Shell

Start the management of Spoke1
```
export CLUSTER_NAME=spoke1
```

Login to the Spoke1 cluster
```
oc login --token=superSecur3T0ken --server=http://${CLUSTER_NAME}:8001
```

Create the namespace

```
kubectl create namespace test-runtime
```

Test the Pod/Application on the Spoke1 cluster

```
oc run tmp-shell -n test-runtime --labels="app=tmp-shell" --rm -i --tty --image ubuntu:18.04 -- apt update
```

You should see the error message similar to this:

<div style="background-color: #000A4F">
<br>
Error attaching, falling back to logs: pods "tmp-shell" not found
No resources found
Error from server (NotFound): pods "tmp-shell" not found
<br>
<br>
</div>

Verify that RHACS has enforced the policy

```
kubectl get events -n test-runtime | grep -i StackRox
```

You should see the error message similar to this:

<div style="background-color: #000A4F">
<br>
06s        Warning   StackRox enforcement   pod/tmp-shell   A pod (tmp-shell) violated StackRox policy "Ubuntu Package Manager Execution" and was killed
<br>
<br>
</div>

Cleanup the namespaces

```
kubectl delete ns ssh-test ssh-test-enforce test-runtime
```

Completed, move onto the next assignment.