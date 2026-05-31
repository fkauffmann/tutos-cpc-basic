# Développer en Locomotive Basic 1.1 sous Ubuntu 25.x et plus

Ce repo est dédié à tous les rétrocodeurs Amstrad CPC qui veulent apprendre le langage basic de cette fabuleuse machine des années 80!

Voici une petite contribution personnelle qui j'espère pourra aider ceux qui comme moi ont décidé de sauter le pas et d'abandonner Windows au profit de Linux.

## Installer Caprice32

Il vous faut bien évidemment un émulateur pour travailler.

Caprice32 est directement disponible sous forme d'un package SNAP que vous pouvez installer via l'App Center de Ubuntu.

## Installer VSCode et Amstrad Basic Helper

L'éditeur VSCode de Microsoft est également disponible via l'App Center.

Une fois installé, ajoutez l'extension __Amstrad Basic Helper__. Elle ajoutera deux commandes dans la palette (appuyez sur ```F1```) :

* __Amstrad Basic Renum__, pour renuméroter les lignes de code
* __Amstrad Basic Run__, pour prévisualiser l'exécution du code

> Attention, l'émulation dans cette extension n'est pas parfaite et est plus rapide que la véritable machine. Je vais donc vous expliquer comment faire un déploiement automatique sur une disquette virtuelle qui sera exécuté sous l'émulateur.

## Compiler iDSK sous Ubuntu 25.10

iDSK est un outil permettant de modifier des fichiers DSK (images de disquette Amstrad CPC) depuis la ligne de commande. Vous pouvez ajouter et supprimer des fichiers de votre image, mais aussi lister les fichiers source BASIC et DAMS (qui sont généralement au format tokenisé, et non au format ASCII brut).

iDSK peut ajouter et supprimer des en-têtes AMSDOS selon les besoins.

Le projet utilise CMake et du C++ (standard C++98). Voici comment le compiler sur Ubuntu 25.10. Mais ces instructions devraient fonctionner sans problème pour toute distro basée sur Debian.

### Installer les dépendances

```
sudo apt update
sudo apt install -y git cmake g++ make
```

### Cloner le dépôt source GIT
```
git clone https://github.com/jeromelesaux/idsk.git
cd idsk
```

### Compiler avec CMake

```
mkdir build
cd build
cmake ..
make
```

Le binaire iDSK sera généré dans le dossier build.

### Installer le binaire

Pour pouvoir appeler la commande iDSK depuis n'importe quel répertoire, il suffit de copier l'exécutable au bon endroit:

```
sudo cp iDSK /usr/local/bin/
```

### Lancer iDSK

Tapez tout simple iDSK dans votre terminal pour lancer l'outil et voir ses options:

```
################################################################################
iDSK version 0.18 (by Demoniak, Sid, PulkoMandy), http://github.com/cpcsdk
################################################################################
Usage :

iDSK  [OPTIONS] [files to process]

OPTIONS :                              EXAMPLE

-l : List disk catalog                 iDSK floppy.dsk -l (default option is no option is set)
-g : export ('Get') file               iDSK floppy.dsk -g myprog.bas
-r : Remove file                       iDSK floppy.dsk -r myprog.bas
-n : create New dsk file               iDSK floppy2.dsk -n
-z : disassemble a binary file         iDSK floppy.dsk -z myprog.bin
-b : list a Basic file                 iDSK floppy.dsk -b myprog.bas
-p : split lines after 80 char             ... -p
-a : list a Ascii file                 iDSK floppy.dsk -a myprog.txt
-d : list a Dams file                  iDSK floppy.dsk -d myprog.dms
-h : list a binary file as Hexadecimal iDSK floppy.dsk -h myprog.bin
-i : Import file                       iDSK floppy.dsk -i myprog.bas
-t : fileType (0=ASCII/1=BINARY)           ... -t 1
-e : hex Execute address of file           ... -e C000 -t 1
-c : hex loading address of file           ... -e C000 -c 4000 -t 1
-f : Force overwriting if file exists      ... -f
-o : insert a read-Only file               ... -o
-s : insert a System file                  ... -s
-u : insert file with User number          ... -u 3
Please report bugs ! - Demoniak/Sid/PulkoMandy
```

## Automatiser le déploiement et l'exécution du fichier basic sous Caprice32

Dans le répertoire de votre projet, créez un dossier ```.vscode```

Dans ce répertoire créez un fichier ```tasks.json```

Copiez-collez le contenu suivant à l'intérieur du fichier json:

```
{
  // Build a Locomotive Basic file and run it on Caprice32 (snap) on Ubuntu 25.x
  "version": "2.0.0",
  "tasks": [
    {
      "label": "make dsk",
      "type": "process",
      "command": "iDSK",
      "args": ["${workspaceFolderBasename}.dsk", "-n"]
    },
    {
      "label": "insert basic file",
      "type": "process",
      "command": "iDSK",
      "args": [
        "${workspaceFolderBasename}.dsk",
        "-t",
        "0",
        "-i",
        "${fileBasename}",
        "-f"
      ]
    },
    {
      "label": "run caprice32",
      "type": "process",
      "command": "caprice32.launcher",
      "args": ["${workspaceFolderBasename}.dsk", "--autocmd=run\"${fileBasename}\""]
    },
    {
      "label": "build",
      "dependsOn": ["make dsk", "insert basic file", "run caprice32"],
      "dependsOrder": "sequence",
      "problemMatcher": []
    }
  ]
}
```

Comme vous pouvez le constater en parcourant le fichier json, le build va exécuter les tâches suivantes:

* Création d'une disquette vierge virtuelle
* Copie du fichier basic sur la disquette
* Montage de la disquette dans Caprice32
* Lancement du programme basic

> __IMPORTANT__ Dans votre script, vous devez toujours laisser une ligne vide à la fin du code. Vous devez également choisir CR/LF comme séparateur de ligne dans la barre de statut de VSCode.

Pour lancer le build faites ```CTRL```-```SHIFT```-```B``` puis ```ENTER```

Si tout est bien configuré, l'émulateur devrait se lancer et taper l'instruction RUN suivie du nom de votre script.