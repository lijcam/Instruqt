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

![Operator Hub](../assets/operatorhub.png)

Next, enter 'Compliance' in the search bar. This will show you several options, one of which is the 'Compliance Operator provided by Red Hat Inc.' Selecting the compliance operator will give you more information.

![Compliance Operator](../assets/compliance-operator.png)

Select 'Install' and you'll be shown a number of options for the Compliance Operator installation. For this lab, we'll configure some basic settings:
- Select 'release-0.1' for the Update Channel
- Select 'A Specific namespace on the cluster' for the Installation mode
- Select 'Operator recommended namespace' for the Installed Namespace. This will install the Compliance Operator into the `openshift-compliance` namespace. 
- Select 'Automatic' for the Update approval

Leave the rest of the options unchecked and select 'Install'. 

![Compliance Operator Install](../assets/compliance-operator-install.png)

On the next screen you'll see the Compliance Operator installation progressing.

![compliance Operator Install progress](../assets/compliance-operator-progress.png)

When the installation completes, this screen will update and allow you to see the installed operator.

![Compliance Operator install complete](../assets/compliance-operator-complete.png)

## Validate the installation

To validate the installation, select 'Operators' from the left-hand menu and then 'Installed Operators'. Ensure that the `openshift-compliance` namespace is selected from the top menu.

If the installation is successful, you should be able to see that the Compliance Operator is available in the `openshift-compliance` namespace, and that the status of the installation is 'Succeeded'.

![Compliance Operator Install successful](../assets/compliance-operator-success.png)
