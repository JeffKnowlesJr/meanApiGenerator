echo ' * Creating MEAN Project Folder..'
mkdir $1
echo ' * Nagivating into MEAN Project Folder..'
cd $1
echo ' * Creating Project>Client Folder..'
mkdir client
echo ' * Nagivating into Project>Client Folder..'
cd client
echo ' * Creating MODEL1 service'
ng g s $3
echo ' * Creating MODEL2 service'
ng g s $5
echo ' * Creating Project>Client>Static Folder..'
mkdir static
echo ' * Creating Project>Client>Views Folder..'
mkdir views
echo ' * Navigating into Project Folder from Project>Client..'
cd ..
echo ' * Creating Project>Server Folder..'
mkdir server
echo ' * Nagivating into Project>Server Folder..'
cd server
echo ' * Creating Project>Server>Config Folder..'
mkdir config
echo ' * Navigating into Project>Server>Config Folder..'
cd config
echo ' * Calling ../../../meanpackage/mean-server.sh..'
. ../../../meanpackage/mean-server.sh
