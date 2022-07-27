---
slug: scan-an-openshift-cluster
type: challenge
title: Scan an OpenShift cluster
teaser: Scan an OpenShift cluster for security and compliance issues
notes:
- type: text
  contents: Now that the Compliance Operator is installed, we can perform a quick
    scan to verify any security and compliance issues
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
With the Compliance Operator installed, we can perform a quick scan to identify any security and compliance issues.

## Scan the cluster

From the Administrator perspective select the 'Operators' menu item, and then 'Installed Operators'.

Ensure that the 'openshift-compliance' namespace is selected from the top menu, and you should see a single operator installed into this namespace, the Compliance Operator.
