#!/bin/bash

source secret-attribute-names.sh

export B2_ACCOUNT_ID=$(secret-tool lookup $B2_KEY_ID_ATTRIBUTES)
export B2_ACCOUNT_KEY=$(secret-tool lookup $B2_KEY_ATTRIBUTES)
export RESTIC_REPOSITORY=$(secret-tool lookup $RESTIC_REPOSITORY_ATTRIBUTES)
export RESTIC_PASSWORD_COMMAND="secret-tool lookup $RESTIC_PASSWORD_ATTRIBUTES"

restic backup $@
