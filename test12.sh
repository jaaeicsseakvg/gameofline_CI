#!/bin/bash
ELASTICSEARCH_PATH="/c/test2/es_yamls/deploy.sh"
MIDDLEWARE_PATH="/c/test2/middleware_yamls/deploy.sh"
PIPELINE_PATH="/c/test2/pipeline_yamls/deploy.sh"
Es=$ELASTICSEARCH_PATH $CLUSTER_NAME $DEPLOYMENT_TYPE
Md=$MIDDLEWARE_PATH $CLUSTER_NAME $DEPLOYMENT_TYPE
Pi=$PIPELINE_PATH $CLUSTER_NAME $ACTION_FILE $DEPLOYMENT_TYPE

#Input Arguments
CLUSTER_NAME=$1
ACTION_FILE=$3
#Possible values for DEPLOYMENT_TYPE are INITIAL and UPGRADE
DEPLOYMENT_TYPE=$2
#Possible values for SCOPE_TYPE are ELASTICSEARCH or MIDDLEWARE or PIPELINE or ALL
SCOPE_TYPE=$4
#Export Path
export $CLUSTER_NAME
export $ACTION_FILE
export $DEPLOYMENT_TYPE

usage() {
	echo "ERROR : Script usage error.."
	echo
	echo "Manual:"
	echo "./deploy.sh CLUSTER_NAME DEPLOYMENT_TYPE"
	echo "where:"
	echo "CLUSTER_NAME = The Azure cluster where the pipelines will have to be deployed"
	echo "DEPLOYMENT_TYPE = The type of deployment whether INITIAL or UPGRADE"
	echo "SCOPE_TYPE = The type of scope whether, ELASTICSEARCH or MIDDLEWARE or PIPELINE or ALL"
	echo
}


deploy() {
	
	if [[ "$SCOPE_TYPE" == "ELASTICSEARCH" ]]; then
		echo "SCOPE_TYPE $SCOPE_TYPE - SELECTED"
		echo
		cd es_yamls
		$ELASTICSEARCH_PATH $CLUSTER_NAME $DEPLOYMENT_TYPE
		echo
											
	elif [[ "$SCOPE_TYPE" == "MIDDLEWARE" ]]; then
		echo "SCOPE_TYPE $SCOPE_TYPE - SELECTED"
		echo
		cd middleware_yamls
		$MIDDLEWARE_PATH $CLUSTER_NAME $DEPLOYMENT_TYPE
		echo
		
	elif [[ "$SCOPE_TYPE" == "PIPELINE" ]]; then
		echo "SCOPE_TYPE $SCOPE_TYPE - SELECTED"
		echo
		cd pipeline_yamls
		$PIPELINE_PATH $CLUSTER_NAME $ACTION_FILE $DEPLOYMENT_TYPE
		echo
		
	elif [[ "$SCOPE_TYPE" == "ALL" ]]; then
		echo "SCOPE_TYPE $SCOPE_TYPE - SELECTED"
		echo
		cd es_yamls
		$ELASTICSEARCH_PATH $CLUSTER_NAME $DEPLOYMENT_TYPE
		cd ..
		cd middleware_yamls
		$MIDDLEWARE_PATH $CLUSTER_NAME $DEPLOYMENT_TYPE
		cd ..
		cd pipeline_yamls
		$PIPELINE_PATH $CLUSTER_NAME $ACTION_FILE $DEPLOYMENT_TYPE
		echo
		   	
	else
		usage
	fi
	
}


if [ $# -ne 4 ] ; then

    usage
else
    deploy
fi





