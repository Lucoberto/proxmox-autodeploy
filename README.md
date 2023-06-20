# proxmox-autodeploy
Un pequeño script escrito en bash para hacer deploys de maquinas virtuales en proxmox.

## ¿Cómo usarlo?

+ Lo primero que debes hacer es clonarlo en tu Proxomox.
```c
      git clone https://github.com/Lucoberto/proxmox-autodeploy.git
```
+ Ahora para ejecutarlo recomiendo usar el siguiente comando.
```c
      bash script.sh
```
+ Ahora solo queda elejir el modo de deploy. Esto se hace elijiendo uno de los numeros.

+ Auto: Con el modo auto simplemente le daremos un nombre a la maquina y elegiremos una ISO que tengamos.

+ Manual: Tenemos que asignar la cantidad de disco, ram, ISO, nombre y ID.

+ Auto deploy CSV: Usando un CSV o TXT Simplemente separaremos por comas los valores anteriormente mencionados y decimos cual es el CSV.

