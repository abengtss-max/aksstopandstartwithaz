# AKS start and stop with Azure CLI
This is a **basic** bash script for starting and stopping AKS clusters within a subscription.
currently the scripts only looks at **powerState** and **Tags** set on the AKS service to either start or stop the AKS cluster. 
the powerState indicates which state the AKS cluster is currently in. There are two main states:

**Running**
**Stopped**

The bash script also looks at a tag on AKS resource level, containing the tag value **Hours**.
If an AKS cluster do not have the tag value set to Hours on AKS service level then, that particular AKS cluster will not be stopped or started.

# Prerequisites

The machine needs to have Azure CLI installed more information on how to install Azure CLI can be found here:https://learn.microsoft.com/en-us/cli/azure/install-azure-cli

Before running the script ensure you machine is configured with the correct subscription example steps below:

```bash
az login
az account list -o table
az account set --subscription <subscription-id>
```  


# Configure and Create a cronjob

Example 1: if we want to start the AKS cluster everyday at 08:00 Monday through friday.

```bash
0 8 * * 1-5 /aks_start.sh
crontab -e
```  

Example 2: if you want to stop the AKS cluster everyday at 17:00 Monday through friday.

```bash
0 17 * * 1-5 /aks_stop.sh
```  


# Considerations
The script stops or starts all AKS clusters in a subscription. Before running the code from you Linux machine ensure you have the right subscription configured, locally on your machine, recommendation is to ensure targeted subscription is default, to avoid any unexpected shutdowns of AKS clusters.


