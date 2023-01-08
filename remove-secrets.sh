#!/bin/bash

if [[ -r secret-attribute-names.sh ]]; then
	source secret-attribute-names.sh
else
	echo "Using example attribute names from secret-attribute-names-example.sh"
	echo "Create a file named secret-attribute-names.sh to customize."
	source secret-attribute-names-example.sh
fi

echo "Clearing secrets:"
echo "$B2_KEY_ID_ATTRIBUTES"
echo "$B2_KEY_ATTRIBUTES"
echo "$RESTIC_REPOSITORY_ATTRIBUTES"
echo "$RESTIC_PASSWORD_ATTRIBUTES"

secret-tool clear $B2_KEY_ID_ATTRIBUTES
secret-tool clear $B2_KEY_ATTRIBUTES
secret-tool clear $RESTIC_REPOSITORY_ATTRIBUTES
secret-tool clear $RESTIC_PASSWORD_ATTRIBUTES
