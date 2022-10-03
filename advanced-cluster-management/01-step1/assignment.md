---
slug: step1
id: fzhnqixxlhiy
type: challenge
title: Enable ACM
notes:
- type: text
  contents: |-
    In this learning module, we cover enabling ACM and the following Concepts:

    * Create the required Namespace.
    * Install the ACM Operator.
    * Provision the Custom Resource.
    * Access the ACM console.

    Let's begin!
tabs:
- title: Work Terminal 1
  type: terminal
  hostname: container
- title: CRC Terminal 2
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: container
  path: /root
- title: Hub Web Console
  type: website
  url: https://console-openshift-console.crc-dzk9v-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: advanced
timelimit: 6000
---
Let's begin by connecting to OpenShift:

```
oc login -u admin -p admin https://api.crc.testing:6443 --insecure-skip-tls-verify=true
```

Create a new namespace called `open-cluster-management`:

```
oc create namespace open-cluster-management
```

Switch to new namespace called `open-cluster-management`:

```
oc project open-cluster-management
```

Let's now create the OperatorGroup for ACM:

```
oc create -f https://raw.githubusercontent.com/waynedovey/instruqt-advanced-cluster-management/main/01-step1/content/operator-group.yaml
```

Then create the Subscription:

```
oc create -f https://raw.githubusercontent.com/waynedovey/instruqt-advanced-cluster-management/main/01-step1/content/acm-operator-subscription.yaml
```

Wait until the Subscription is Installed:

```
while sleep 10;
do
oc get csv
done
```

The Phase should change from "Installing" to Succeeded"

Press "Control+C" to Break Loop

Get the Pull Secret
```
curl -s https://raw.githubusercontent.com/waynedovey/instruqt-advanced-cluster-management/main/01-step1/content/pull-secret.txt -o /root/pull-secret.txt
```

Decrypt the Pull secret with Ansible Vault (***Password Supplied by Red Hat Admin***)
```
ansible-vault decrypt /root/pull-secret.txt
```

Create the Password for ACM

```
oc create secret generic pull-secret \
--from-file=.dockerconfigjson=/root/pull-secret.txt \
--type=kubernetes.io/dockerconfigjson
```


Finally enable the Custom Resource:

```
oc create -f https://raw.githubusercontent.com/waynedovey/instruqt-advanced-cluster-management/main/01-step1/content/custom-resource.yaml
```

Check for the status of the Operator Installation (Can take up to 10min):

```
while sleep 300;
do
echo $(oc get mch -o=jsonpath='{.items[0].status.phase}')
done
````

The Status should change from "Installing" to Runnng"

Press "Control+C" to Break Loop

Get the Route for the ACM Service and Navigate to this:

Login with admin/admin

```
echo https://$(oc get route | awk '{print $2}' | grep -v HOST)
```

Completed, move onto the next assignment.