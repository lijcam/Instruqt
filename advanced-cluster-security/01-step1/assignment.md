---
slug: step1
id: ufvdogcc4guu
type: challenge
title: Enable RHACS
notes:
- type: text
  contents: |-
    In this learning module, we cover enabling RHACS and the following Concepts:

    * Create the required Namespace.
    * Install the RHACS Operator.
    * Enable a Custom admin user.
    * Provision the Custom Resource.
    * Access the RHACS console.

    Let's begin!
tabs:
- title: Work Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root
- title: OCP Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: advanced
timelimit: 6000
---
Let's begin by connecting to OpenShift:

```
oc login -u admin -p admin https://api.crc.testing:6443 --insecure-skip-tls-verify=true
```

Create a new namespace called `acs`:

```
oc create namespace acs
```

Switch to new namespace called `acs`:

```
oc project acs
```

Let's now create the OperatorGroup for RHACS:

```
oc create -f https://raw.githubusercontent.com/waynedovey/rh-advanced-cluster-security/main/01-step1/content/operator-group.yaml
```

Then create the Subscription:

```
oc create -f - << EOF
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: rhacs-operator
  namespace: openshift-operators
spec:
  channel: latest
  installPlanApproval: Automatic
  name: rhacs-operator
  source: redhat-operators
  sourceNamespace: openshift-marketplace
EOF
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

Create admin Secret
```
oc create -f - << EOF
kind: Secret
apiVersion: v1
metadata:
  name: acs-password
  namespace: acs
data:
  password: YWRtaW4=
type: Opaque
EOF
```

Finally enable the Custom Resource:

```
oc create -f - << EOF
apiVersion: platform.stackrox.io/v1alpha1
kind: Central
metadata:
  namespace: acs
  name: stackrox-central-services
spec:
  central:
    adminPasswordSecret:
      name: acs-password
    exposure:
      loadBalancer:
        enabled: false
        port: 443
      nodePort:
        enabled: false
      route:
        enabled: true
    persistence:
      persistentVolumeClaim:
        claimName: stackrox-db
  egress:
    connectivityPolicy: Online
  scanner:
    analyzer:
      scaling:
        autoScaling: Enabled
        maxReplicas: 5
        minReplicas: 2
        replicas: 3
    scannerComponent: Enabled
EOF
```

Check for the status of the Operator Installation :

```
while sleep 10;
do
oc get Central -o yaml | grep installed
done
````

The Status should be "installed"

Press "Control+C" to Break Loop

Get the Route for the RHACS Service and Navigate to this:

Login with admin/admin

```
echo https://$(oc get route | awk '{print $2}' | grep -v HOST | head -n 1)
```

Completed, move onto the next assignment.
