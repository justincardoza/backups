#!/bin/bash

source secret-attribute-names.sh

echo "Clearing secrets:"
echo "$B2_KEY_ID_ATTRIBUTES"
echo "$B2_KEY_ATTRIBUTES"
echo "$RESTIC_REPOSITORY_ATTRIBUTES"
echo "$RESTIC_PASSWORD_ATTRIBUTES"

secret-tool clear $B2_KEY_ID_ATTRIBUTES
secret-tool clear $B2_KEY_ATTRIBUTES
secret-tool clear $RESTIC_REPOSITORY_ATTRIBUTES
secret-tool clear $RESTIC_PASSWORD_ATTRIBUTES
