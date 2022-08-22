#!/bin/sh
abort()
{
    echo >&2 '
***************
*** ABORTED runPostgreGKE.sh ***
***************
'
    echo "An error occurred in runPostgreGKE.sh . Exiting..." >&2
    exit 1
}

trap 'abort' 0

set -e

echo "Create PV & PVC"
kubectl apply -f postgres-pv.yaml


kubectl apply -f postgres-deployment.yaml


kubectl apply -f postgres-service.yaml


POD=`kubectl get pods -l app=postgres -o wide | grep -v NAME | awk '{print $1}'`

kubectl exec -it $POD -- psql -U postgres

# create database gke_test_regional;

# \c gke_test_regional;

# CREATE TABLE test(
#    data VARCHAR (255) NULL
# );

# insert into test values
#   ('Learning GKE is fun'),
#   ('Databases on GKE are easy');


# select * from test;

fi
trap : 0

echo >&2 '
************
*** DONE runPostgreGKE ***
************'