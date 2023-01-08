#!/bin/bash

if [[ -r secret-attribute-names.sh ]]; then
	source secret-attribute-names.sh
else
	echo "Using example attribute names from secret-attribute-names-example.sh"
	echo "Create a file named secret-attribute-names.sh to customize."
	source secret-attribute-names-example.sh
fi

export B2_ACCOUNT_ID=$(secret-tool lookup $B2_KEY_ID_ATTRIBUTES)
export B2_ACCOUNT_KEY=$(secret-tool lookup $B2_KEY_ATTRIBUTES)
export RESTIC_REPOSITORY=$(secret-tool lookup $RESTIC_REPOSITORY_ATTRIBUTES)
export RESTIC_PASSWORD_COMMAND="secret-tool lookup $RESTIC_PASSWORD_ATTRIBUTES"

restic $@
