#!/bin/sh


abort()
{
    echo >&2 '
***************
*** ABORTED deleteCluster.sh ***
***************
'
    echo "An error occurred in deleteCluster.sh . Exiting..." >&2
    exit 1
}

trap 'abort' 0

set -e

echo "INFO: Docker system pruning to save space:"
CLUSTERNAME=postgres-gke-regional

gcloud container clusters delete $CLUSTERNAME
echo "deletion of gcloud cluster is in progress...in background."


trap : 0

echo >&2 '
************
*** DONE deleteCluster ***
************'