# AKS start and stop with Azure CLI
This is a **basic** bash script for starting and stopping AKS clusters within a subscription.
currently the scripts only look at **powerState** to either start or stop the AKS cluster. 
the powerState indicates which state the AKS cluster is currently in. There are two main states:

**Running**
**Stopped**

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
The script stops or starts all AKS clusters in a subscription. if you need to stop/start specific AKS clusters, recommendation is to adopt labels, for your AKS cluster, so the code will use two parameters as input for its IF statement.
 **PowerState**
 **Tags**