#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/setup-nfs-server.sh
# Environments:   all
# Purpose:        Setup the NFS Server and serve the /datadrive/export/
#                 from persistent storage and create entries in 
#                 /etc/exports for the worker nodes.
#
# Created on:     23 June 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 23 Jun 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

# Include the banner function for logging purposes (see 
# templates/banner.sh)
#
source ~/scripts/banner.sh

EXPORT_DIRECTORY=/datadrive/export/data
worker_nodes="${workers}"

banner "setup-nfs-server.sh" "Make directories $${EXPORT_DIRECTORY}"
sudo mkdir -p $${EXPORT_DIRECTORY}

banner "setup-nfs-server.sh" "Mount binding $${DATA_DIRECTORY} to $${EXPORT_DIRECTORY}"
parentdir="$$(dirname "$$EXPORT_DIRECTORY")"
sudo chmod -R 777 $${EXPORT_DIRECTORY}
sudo chmod -R 777 $$parentdir

banner "setup-nfs-server.sh" "Appending localhost and Kubernetes workers $${node} to exports configuration file"
IFS=$" "
for node in $${worker_nodes}
do
    echo "/datadrive/export        $${node}(rw,async,insecure,fsid=0,crossmnt,no_subtree_check)" | sudo tee -a /etc/exports
done
echo "/datadrive/export        ${masters}(rw,async,insecure,fsid=0,crossmnt,no_subtree_check)" | sudo tee -a /etc/exports

banner "setup-nfs.sh" "Restart NFS service"
sudo service nfs-kernel-server restart
