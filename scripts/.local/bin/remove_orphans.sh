#!/usr/bin/env bash

# Remove packages that were installed as dependecy
# but are not longer required by any installed package.

function echo_bold {
    # arg $1: string that is printed in bold
    echo -e "\033[1m\033[32m:: \033[0m\033[1m$1\033[0m"
}

TO_REMOVE=()
mapfile -t ORPHANS < <(pacman -Qdt | cut -d' ' -f1)
TOTAL="${#ORPHANS[@]}"

if [ "$TOTAL" -eq 0 ]
    then
    echo_bold "No orphans found."
    exit 0
fi


COUNTER=1
for pkg in "${ORPHANS[@]}"; do
    clear
    echo_bold "Orphan $COUNTER/$TOTAL:"
    pacman -Qi "$pkg" \
        | sed -E 's/(^Name.*$)/\x1b[31m\1\x1b[0m/' \
        | sed -E 's/(^Provides.*$)/\x1b[31m\1\x1b[0m/' \
        | sed -E 's/(^Required By.*$)/\x1b[31m\1\x1b[0m/' \
        | sed -E 's/(^Optional For.*$)/\x1b[31m\1\x1b[0m/'

    # DO_REMOVE=$(read -n 1 -P "Remove? [Y|n]: ")
    read -p "Remove? [Y|n]: " DO_REMOVE

    if [ -z "$DO_REMOVE" ] || [[ "$DO_REMOVE" =~ [Yy] ]]
        then
        TO_REMOVE+=("$pkg")
    else
        read -p "Mark package '$pkg' as explicitly installed? [y|N]: " MARK
        if [[ "$MARK" =~ [Yy] ]]
            then
            echo_bold "Handing over to pacman"
            sudo pacman -D --asexplicit "$pkg"
            read -p "[Press Enter to continue]"
        fi
    fi
    # else pacman -D --asexplicit package
    # e.g. ldns

    (( COUNTER+=1 ))
done

if [ "${#TO_REMOVE[@]}" -eq 0 ]
    then
    echo_bold "No packages marked for removal."
    exit 0
fi

clear
echo_bold "Packages marked for removal [${#TO_REMOVE[@]} out of $TOTAL]:"
printf "%s\n" "${TO_REMOVE[@]}"
echo
read -p "Remove packages now? [Y|n]: " UNINSTALL

if [ -z "$UNINSTALL" ] || [[ "$UNINSTALL" =~ [Yy] ]]
    then
    echo_bold "Handing over to pacman"
    sudo pacman -Runs "${TO_REMOVE[@]}"
fi
