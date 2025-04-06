#!/bin/bash

BOOTSTRAP_NODE=10.10.10.5
USERNAME=sbuglione
CLUSTER_NAME=klustered

# Find op CLI command - check PATH first, then use fallback if needed
OP_CMD="op"
if ! command -v $OP_CMD &> /dev/null; then
    OP_CMD="/mnt/c/Users/steve/AppData/Local/Microsoft/WinGet/Packages/AgileBits.1Password.CLI_Microsoft.Winget.Source_8wekyb3d8bbwe/op.exe"
    if [ ! -f "$OP_CMD" ]; then
        echo "Error: 1Password CLI not found in PATH or at default location"
        exit 1
    fi
fi

CLUSTER_PASSWORD=$($OP_CMD read "op://Home-Lab/klustered-lxd-password/password")

echo "Copying cluster certificate from bootstrap node..."
if ! scp $USERNAME@$BOOTSTRAP_NODE:/var/snap/lxd/common/lxd/cluster.crt /tmp/bootstrap_cluster.crt; then
  echo "Error: Failed to copy cluster certificate. Ensure the LXD cluster is initialized correctly."
  exit 1
fi

echo "Checking if remote already exists..."
if lxc remote list | grep -q "$CLUSTER_NAME"; then
  echo "Remote $CLUSTER_NAME already exists, removing it first..."
  lxc remote switch local
  lxc remote remove $CLUSTER_NAME
fi

echo "Adding remote cluster to local LXD..."
if ! cat /tmp/bootstrap_cluster.crt | lxc remote add $CLUSTER_NAME $BOOTSTRAP_NODE --accept-certificate --password=$CLUSTER_PASSWORD; then
  echo "Error: Failed to add remote cluster."
  exit 1
fi

echo "Setting $CLUSTER_NAME as default remote..."
lxc remote switch $CLUSTER_NAME

echo "Current LXD remote list:"
lxc remote list

echo "Current LXD Cluster: $CLUSTER_NAME"
lxc cluster list

echo "Successfully connected to LXD cluster $CLUSTER_NAME"
exit 0