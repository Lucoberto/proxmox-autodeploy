#!/bin/bash

main(){
clear
echo "   Auto deploy VM    "
echo " [1] Auto deploy     "
echo " [2] Manual deploy   "

read selection

case $selection in
        1)
                generateID;;
        2)
                manualDeploy;;
esac

}

manualDeploy(){
        echo "Write ID NAME MEMORY-CAPACITY DICS-CAPACITY IMAGE ~>"
        read id name memory disc iso
                qm create $id --name $name --memory $memory --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-pci -cdrom local:iso/$iso --scsi0 local-lvm:$disc
}

# $id tiene que salir de una funcion que genere y comprube la existencia del ID.
autoDeploy(){
        echo "Write IMAGE-NAME"
        read iso
                qm create $id --name testVMT --memory 2048 --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-pci -cdrom local:iso/$iso --scsi0 local-lvm:10
}
# comprueba si existe el numero generado $id mediante grep a la lista de maquinas 
generateID(){
        id=$(shuf -i 1-9999 -n 1)
        listId=$(qm list | grep $id)
        if [ "$listId" = "" ]; then
                autoDeploy
        else
                generateID
        fi
}


main