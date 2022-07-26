---
slug: installing-the-compliance-operator
type: challenge
title: Installing the Compliance Operator
teaser: Install the Compliance Operator to Red Hat OpenShift
notes:
- type: text
  contents: |-
    It's coming up to the end of the month, and there is a security and compliance audit required for all systems in a week. 
    You need to ensure that all your systems - including Kubernetes platforms - can meet some basic compliance and security requirements.
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
The Compliance Operator available in Red Hat OpenShift Container Platform is exactly designed for this requirement. It helps you to identify compliance and security issues, create reports, and remediate issues in a Kubernetes-native way.

## Install the Compliance Operator

Let's first install the Compliance Operator. It's available from the OperatorHub, a marketplace for Kubernetes Operator available within Red Hat OpenShift.

From the Administrator perspective select the 'Operators' menu item, and then the 'OperatorHub.

Image

Next, enter 'Compliance' in the search bar. This will show you several options, one of which is the compliance operator.

Image

Select 'Install'
