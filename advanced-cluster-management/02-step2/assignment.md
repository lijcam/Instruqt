---
slug: step2
id: ftiwbxv0fmlr
type: challenge
title: Cluster Management
notes:
- type: text
  contents: |-
    In the next learning module, we cover enabling ACM and the following Concepts:

    * Create the ACM Managed Cluster instances from the ACM Hub
    * Deploy the required import secrets and Kube config
    * Provision the Import files to the managed clusters
    * Verify the import and start managing the clusters

    Let's begin!
tabs:
- title: Work Terminal 1
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
difficulty: advanced
timelimit: 6000
---
Connect to ACM Hub:

```
oc login -u admin -p admin https://api.crc.testing:6443 --insecure-skip-tls-verify=true
```

# Start the Import for spoke1 Cluster
```
export CLUSTER_NAME=spoke1
```

Create a project with the Cluster name
```
oc new-project ${CLUSTER_NAME}
```

Ensure there are namespace labels
```
oc label namespace ${CLUSTER_NAME} cluster.open-cluster-management.io/managedCluster=${CLUSTER_NAME}
```

Create and import the Required artifacts
```
cat <<EOF | oc apply -n ${CLUSTER_NAME} -f -
apiVersion: cluster.open-cluster-management.io/v1
kind: ManagedCluster
metadata:
  name: ${CLUSTER_NAME}
spec:
  hubAcceptsClient: true
EOF
```
```
cat <<EOF | oc apply -n ${CLUSTER_NAME} -f -
apiVersion: agent.open-cluster-management.io/v1
kind: KlusterletAddonConfig
metadata:
  name: ${CLUSTER_NAME}
  namespace: ${CLUSTER_NAME}
spec:
  clusterName: ${CLUSTER_NAME}
  clusterNamespace: ${CLUSTER_NAME}
  applicationManager:
    enabled: true
  certPolicyController:
    enabled: true
  clusterLabels:
    cloud: auto-detect
    vendor: auto-detect
  iamPolicyController:
    enabled: true
  policyController:
    enabled: true
  searchCollector:
    enabled: true
EOF
```

Export the CRD and Secret required
```
oc get secret ${CLUSTER_NAME}-import -n ${CLUSTER_NAME} -o jsonpath={.data.crds\\.yaml} | base64 --decode > /root/${CLUSTER_NAME}-klusterlet-crd.yaml
```
```
oc get secret ${CLUSTER_NAME}-import -n ${CLUSTER_NAME} -o jsonpath={.data.import\\.yaml} | base64 --decode > /root/${CLUSTER_NAME}-import.yaml
```

Login into the Managed cluster
```
oc login --token=superSecur3T0ken --server=http://${CLUSTER_NAME}:8001
```

Import the CRD and Secret required
```
kubectl apply -f /root/${CLUSTER_NAME}-klusterlet-crd.yaml
```
```
kubectl apply -f /root/${CLUSTER_NAME}-import.yaml
```

# Start the Import for spoke2 Cluster

```
oc login -u admin -p admin https://api.crc.testing:6443 --insecure-skip-tls-verify=true
```

```
export CLUSTER_NAME=spoke2
```
Create a project with the Cluster name
```
oc new-project ${CLUSTER_NAME}
```

Ensure there are namespace labels
```
oc label namespace ${CLUSTER_NAME} cluster.open-cluster-management.io/managedCluster=${CLUSTER_NAME}
```

Create and import the Required artifacts
```
cat <<EOF | oc apply -n ${CLUSTER_NAME} -f -
apiVersion: cluster.open-cluster-management.io/v1
kind: ManagedCluster
metadata:
  name: ${CLUSTER_NAME}
spec:
  hubAcceptsClient: true
EOF
```
```
cat <<EOF | oc apply -n ${CLUSTER_NAME} -f -
apiVersion: agent.open-cluster-management.io/v1
kind: KlusterletAddonConfig
metadata:
  name: ${CLUSTER_NAME}
  namespace: ${CLUSTER_NAME}
spec:
  clusterName: ${CLUSTER_NAME}
  clusterNamespace: ${CLUSTER_NAME}
  applicationManager:
    enabled: true
  certPolicyController:
    enabled: true
  clusterLabels:
    cloud: auto-detect
    vendor: auto-detect
  iamPolicyController:
    enabled: true
  policyController:
    enabled: true
  searchCollector:
    enabled: true
EOF
```

Export the CRD and Secret required
```
oc get secret ${CLUSTER_NAME}-import -n ${CLUSTER_NAME} -o jsonpath={.data.crds\\.yaml} | base64 --decode > /root/${CLUSTER_NAME}-klusterlet-crd.yaml
```
```
oc get secret ${CLUSTER_NAME}-import -n ${CLUSTER_NAME} -o jsonpath={.data.import\\.yaml} | base64 --decode > /root/${CLUSTER_NAME}-import.yaml
```

Login into the Managed cluster
```
oc login --token=superSecur3T0ken --server=http://${CLUSTER_NAME}:8001
```

Import the CRD and Secret required
```
kubectl apply -f /root/${CLUSTER_NAME}-klusterlet-crd.yaml
```
```
kubectl apply -f /root/${CLUSTER_NAME}-import.yaml
```


Validate both Clusters are imported

```
oc login -u admin -p admin https://api.crc.testing:6443 --insecure-skip-tls-verify=true
```

```
cm get clusters
```

After about 1 min...

Spoke1 and Spoke2 should be registered

```
  JOINED=True
```

Cleanup a few things
```
rm -fr *.txt *.yaml
```

Completed, move onto the next assignment.