This document was created as documentation of the implementation of YarraFramework on Ronin.
-----General Ronin Specs:-----
To properly run GRASP on a Ronin machine at least 16 Gb of RAM are required, if this is not met the reconstruction will crash due to lack of memory.
A Hot-Drive was used for storage. 

Yarra was intalled using Ubuntu 20.04 as the OS.

-----Yarra/Ronin-----
To create a YarraFramework server on Ronin follow the instructions presented on the github provided by Nathaniel Butterworth: https://github.com/FidelNavarro/yarra

The instructions include both the YarraServer and Client setups.
For setup of the Client the package must be manually downloaded from the following link:
https://yarra-framework.org/download/

-----QT4----
Since Ubuntu 20.04 comes installed with Qt5 instead of Qt4, it is necessary to install Qt4 since it is required by some packages of Yarra and GRASP, .
To do so, the "ubuntu" user is required due to its admin permisions.
To install use the following:

$ sudo apt-add-repository ppa:rock-core/qt4
$ sudo apt update
$ sudo apt install qt4-default
$ sudo apt install qt5-default

Note: Given that the installation of Qt4 removes Qt5, the library is added back, meaning that the machine has now both libraries. This hasn't produce any conflicts while normally runing YarraServer and GRASP reconstructions. However, special care should be taken for future issues.

-----User-----
To have access to YarraServer, WebGUI, and Reconstruction modes (GRASP) it is required to change to the "yarraserver" user.

-----WebGUI-----
YarraFramework comes with a usefull web interface.
To access it change to folder /home/yarraserver/yarra/webgui 
TO run WebGUI execute ./YarraWebGUI

Note: To add users and modify their level it is necessary to edit the YarraWebGUI.ini document. This information is located at the end of he document.

-----Yarra Server-----
Running WebGUI first will display a Server Activity with "DOWN" status, since the Yarra Server hasn't been turn on (executed).
To initialise Yarra run ./YarraServer located at /home/yarraserver/yarra/

-----GRASP (C++)-----
The installation of Yarra on Ronin dosen't contain any reconstruction modes or modules. It is required by the user to manually create/install modules. 

GRASP C++ can be downloaded from:
https://nyulangone-my.sharepoint.com/:f:/g/personal/kaitobias_block_nyulangone_org/Eo9LI9a-yjVPjxz83b4RZaYBXXZtNdFjn9MYI3u1No_s4Q?e=a4pP7e

From the folder download and install /Gent/GRASP_375 using the WebGUI.
The folder contains an example of the reconstruction mode file.

-----Mode Files-----
When creating different reconstruction .mode files it is required to manually modify the YarraModes.cfg with the information to be displayed to the Client of each reconstruction mode.
The YarraModes.cfg file can be edited from the WebGUI, and different .mode files can be created through the WebGUI.

-----RDS-----
Ronin/Yarra can connect to both RDS and HPC for data transfer.
For this project a local mount of RDS was created on Yarra.
The mount can be created through the following commands:

$ sudo apt install sshfs
$ mkdir /home/yarraserver/yarra/myRDS
$ sshfs <username>@research-data-ext.sydney.edu.au:/rds/PRJ-<project> /home/yarraserver/yarra/myRDS

The RDS mount on /myRDS is temporal, once the machine is shutdown the conection will be lost. To reconnect run the last line (sshfs ...) again to reconnect.

Note: It is recommended to change the transfer path to /myRDS (on .mode file). This will automatically save reconstructions on RDS, while deleting any reconstruction files from Ronin/Yarra. The only files saved on Ronin/Yarra are the log files, which contain the parameters used for reconstruction and no patient information.
Furthermore, the download speed using the /queue folder for transfer is low, so its worth to avoid this option for cost efficiency.

-----Client and Local Machine-----
The set up of the client is described on: 
https://github.com/Sydney-Informatics-Hub/yarra/blob/main/YarraClient.md

Once the SAC program is run it will automatically create a YarraServer mount on the local computer.
This mount will have access to the /home/yarraserver/yarra/queue folder from the Yarra/Ronin machine.
This folder can be use for quick data transfers between the local and Ronin machine.

Note: If multiple Ronin/Yarra machines are created the SAC can only connect to one at a time.

-----Recommendations-----
Ronin allows to create backups of the hard drive and root drive. This backups can be used to create new drives and attach them to knew computers for ease of setup.

Given that each time Ronin/Yarra is launched the executables and RDS mount are required to be manually executed, it is recommended to create a bash script (.sh) to run YarraServer, YarraWebGUI, and RDS. 
The file needs to be created, compiled and run:
$ nano <exe name>.sh
$ chmod +x <exe name>.sh 
$ ./<exe name>.sh
The executable needs to be created within the "yarraserver" user to have access to all the Yarra executables.

-----Additional Files-----
For ease of use and installation the appropiate mode files are supplied (GraspMode.mode & YarraModes.cfg) and bash script (YarraExe.sh).
GraspMode.mode should be placed within the /home/yarraserver/yarra/modes/ folder.
YarraModes.cfg should be placed within the /home/yarraserver/yarra/queue/ folder.
YarraExe.sh can be placed on any folder within the "yarraserver" user. It is recommended to place it within the /home/yarraserver/ folder


 