#!/bin/bash
. ./.env

clear

fn_wait() {
    read -p 'Press any key to continue...' VARIABLE

    if [ $VARIABLE ! '' ]
    then
        clear
        menu
    else
        echo 'this should never be seen. inefficient'
    fi
}

##  --------------------------------------------
##  MAIN MENU
##  --------------------------------------------
menu() {

##  --------------------------------------------
BANNER='
   _   _______________ 
  | | / / __/  _/ __  |
  | |/ / _/_/ // /_/ /
  |___/_/ /___/\____/ 
  '

DESCRIPTION="$RESET $FORMATTING_BOLD $COLOR_LIGHTGREEN
  VFIO$RESET: Virtual Function Input Output
  "
    echo -e "$RESET $COLOR_LIGHTGREEN $BOLD 
  $BANNER $RESET 
------------------------------------------------
  $FORMATTING_DIM $DESCRIPTION $RESET
------------------------------------------------"


    echo -ne "
$COLOR_LIGHTCYAN  1.$RESET $FORMATTING_DIM Enable IOMMU $RESET
$COLOR_LIGHTCYAN  2.$RESET $FORMATTING_DIM Add VFIO Kernel modules $RESET
$COLOR_LIGHTCYAN  3.$RESET $FORMATTING_DIM Prepare GPU for passthrough $RESET
$FORMATTING_DIM  -------------- $RESET
$COLOR_LIGHTRED  0.$RESET $FORMATTING_DIM Exit $RESET
Choose an option:  "
    read -r ans
    case $ans in
    1)  
        clear
        iommumenu
        ;;
    2)  
        clear
        kernelmenu
        ;;
    3)
        clear
        passthroughmenu
        ;;
    0)
        echo "Ending session."
        exit 0
        ;;
    *)
        echo "Invalid option."
        exit 1
        ;;
    esac
}

##  --------------------------------------------
##  BOOTLOADER MENU
##  --------------------------------------------
iommumenu() {
    . ./$SCRIPT_DIRECTORY/bootloader/banner.sh
    echo -ne "
Enable IOMMU
  1)  GRUB
  2)  Systemd-boot
  3)  Home
  0)  Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        echo 'Grub'
        fn_wait
        ;;
    2)
        echo 'Systemd-boot'
        echo 'reading file                  done'
        echo 'applying changes              done'

        fn_wait
        ;;
    3)  
        clear
        menu
        ;;
    0)
        echo "Bye bye."
        exit 0
        ;;
    *)
        echo "Wrong option."
        exit 1
        ;;
    esac
}
##  --------------------------------------------
##  KERNEL MENU
##  --------------------------------------------
kernelmenu() {
    . ./$SCRIPT_DIRECTORY/kernel/banner.sh
    echo -ne "
SUBMENU
1) SUBCMD1
2) Home
0) Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        clear
        kernelmenu
        ;;
    2)  
        clear
        menu
        ;;
    0)
        echo "Bye bye."
        exit 0
        ;;
    *)
        echo "Wrong option."
        exit 1
        ;;
    esac
}
##  --------------------------------------------
##  PASSTHROUGH MENU
##  --------------------------------------------
passthroughmenu() {
    . ./$SCRIPT_DIRECTORY/passthrough/banner.sh
    echo -ne "
SUBMENU
1) SUBCMD1
2) Home
0) Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        clear
        passthroughmenu
        ;;
    2)
        clear
        menu
        ;;
    0)
        echo "Bye bye."
        exit 0
        ;;
    *)
        echo "Wrong option."
        exit 1
        ;;
    esac
}

menu