#!/bin/bash

# Scraping CSV para crear maquiena virtual

main(){
clear
echo "   Auto deploy VM    "
echo " [1] Auto deploy     "
echo " [2] Manual deploy   "
echo " [3] Via CSV deploy  "
read selection

# Convertir en IF ELSE

if [ "$selection" = "1" ]; then
        generateID

elif [ "$selection" = "2" ]; then
        manualDeploy

elif [ "$selection" = "3" ]; then
        csvDeploy

else

        echo "!!!Write one number please!!!"
        main

fi

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
csvDeploy(){
        echo "Write the name of the CSV"
        read csvName
# con sed remplazamos un texto por otro. en este caso \(.*) el "." es cualquier caracter y "*" es cualquier tipo de logitud.
# los "()" son para agruparlos con "\" defines un caracter especial para que no lo interprete como un caracter normal.
# "/" es donde termina. La " \ " despues de iso indica indica que la siguiente "/" es una barra normal 
                createVM=$(sed 's/\(.*\),\(.*\),\(.*\),\(.*\),\(.*\)/qm create \1 --name \2 --memory \3 --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-pci -cdrom local:iso\/\5 --scsi0 local-lvm:\4/g' $csvName | tail -n +2)
                bash -c "$creatVM"
}


main
