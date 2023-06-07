#!/bin/bash


subscription_id=$(az account show --query id -o tsv)

clusters=$(az aks list --subscription $subscription_id --query '[].{name:name,resourceGroup:resourceGroup}' -o json | jq -c '.[]')

echo "Initiating the process for stopping all AKS cluster with powerState set to Running and Tags with value set to Hours"

for cluster in $clusters; do
    name=$(echo $cluster | jq -r '.name')
    resourceGroup=$(echo $cluster | jq -r '.resourceGroup')
    powerState=$(az aks show --name $name --resource-group $resourceGroup --query 'powerState' -o tsv)
    businessHours=$(az aks show -g $resourceGroup -n $name --query '[tags]' -o tsv)

    if [ "$powerState" == "Running" ] && [ "$businessHours" == "Hours" ]; then
        az aks stop --name $name --resource-group $resourceGroup
        echo "AKS cluster with powerState set to Running and AKS Tags with value set to Hours are now Stopped"
    fi
done

