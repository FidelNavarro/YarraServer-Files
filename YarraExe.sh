#!/bin/bash
#Mount RDS
#First create path for RDS if it dosen't exist
folder_path="/home/yarraserver/yarra/myRDS"
if [ ! -d "$folder_path" ]; then
        # If folder dosen't exist, create it
        mkdir -p "$folder_path"
        echo "Folder created: $folder_path"
else
        echo "Folder already exists: $folder_path"
fi
#Make sshfs connection
sshfs fnav0118@research-data-ext.sydney.edu.au:/rds/PRJ-PRISM $folder_path

#Run YarraServer
cd /home/yarraserver/yarra/webgui/
./YarraWebGUI & /home/yarraserver/yarra/YarraServer 
