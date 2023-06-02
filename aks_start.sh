#!/bin/bash


subscription_id=$(az account show --query id -o tsv)

clusters=$(az aks list --subscription $subscription_id --query '[].{name:name,resourceGroup:resourceGroup}' -o json | jq -c '.[]')

echo "Stopping all AKS cluster with powerState set to Running..."

for cluster in $clusters; do
    name=$(echo $cluster | jq -r '.name')
    resourceGroup=$(echo $cluster | jq -r '.resourceGroup')
    powerState=$(az aks show --name $name --resource-group $resourceGroup --query 'powerState' -o tsv)

    if [ "$powerState" == "Stopped" ]; then
        az aks start --name $name --resource-group $resourceGroup
    fi
done

echo "AKS clusters are now running"