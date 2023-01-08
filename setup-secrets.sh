#!/bin/bash

source secret-attribute-names.sh

echo "Please enter the Backblaze B2 application key ID."
secret-tool store --label='Backblaze B2 application key ID for backups' $B2_KEY_ID_ATTRIBUTES

echo "Please enter the Backblaze B2 application key"
secret-tool store --label='Backblaze B2 application key for backups' $B2_KEY_ATTRIBUTES

echo "Please enter the restic repository name"
secret-tool store --label='Restic repository for backups' $RESTIC_REPOSITORY_ATTRIBUTES

echo "Please enter the restic repository password"
secret-tool store --label='Restic repository password for backups' $RESTIC_PASSWORD_ATTRIBUTES
