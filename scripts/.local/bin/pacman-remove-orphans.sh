#!/bin/bash

pkg_keep=()
pkg_delete=()

clear

for pkg in $(pacman -Qdt | cut -d' ' -f1)
do
    pacman -Qi "$pkg" | grep -E '^(Name|Description|Required By|Optional For|Install Reason)'
    read -p "Delete? [Y|n] " keep
    if [[ -z "$keep" || "$keep" == "y" || "$keep" == "Y" ]]
    then
        pkg_delete+=("$pkg")
    else
        pkg_keep+=("$pkg")
    fi
    clear
done

clear
echo "Packages to keep: ${pkg_keep[*]}"
echo "Packages to delete: ${pkg_delete[*]}"

read -p "Delete packages? [Y|n] " delete

if [[ -z "$delete" || "$delete" == "y" || "$delete" == "Y" ]]
then
    # echo "would delete now: ${pkg_delete[*]}"
    sudo pacman -Runs "${pkg_delete[@]}"
fi





