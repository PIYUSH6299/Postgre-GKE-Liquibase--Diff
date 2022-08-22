#!/bin/sh
abort()
{
    echo >&2 '
***************
*** ABORTED createCluster.sh ***
***************
'
    echo "An error occurred in createCluster.sh . Exiting..." >&2
    exit 1
}

trap 'abort' 0

set -e

CLUSTERNAME=postgres-gke-regional
ZONE=us-central1-c
# kubectl config get-contexts -o name | grep clustername-app | wc -c)

CLUSTERNAME_FOUND=$(kubectl config get-contexts -o name | grep $CLUSTERNAME | wc -c)
echo "Should i create -" $CLUSTERNAME_FOUND " with name " $CLUSTERNAME
if [[ CLUSTERNAME_FOUND -ne 0 ]]; then
    echo "Cluster Exists. NO Need to be created."${CLUSTERNAME};
else
    # DONE: It is now coming here.
    echo "Cluster Does not exit. Need to be created.";
    echo "gcloud container clusters create $CLUSTERNAME --num-nodes=2"
    
    gcloud container clusters create $CLUSTERNAME  --num-nodes=2 --zone=$ZONE --region "us-central1" \
  --machine-type "e2-standard-2" --disk-type "pd-standard" --disk-size "10" \
  --num-nodes "2" --node-locations "us-central1-b","us-central1-c"
fi
trap : 0

echo >&2 '
************
*** DONE createCluster ***
************'