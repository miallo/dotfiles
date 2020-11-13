#!/usr/bin/env bash
# requires jq
IFS='=========='

DISPLAY_CONFIG=($(i3-msg -t get_outputs | jq -r '.[]|"\(.name)'$IFS'\(.current_workspace)"'))

for ROW in "${DISPLAY_CONFIG[@]}"
do
		read -ra CONFIG <<< "${ROW}"
	if [ "${CONFIG[0]}" != "null" ] && [ "${CONFIG[1]}" != "null" ]; then
		echo "moving ${CONFIG[1]} right..."
		i3-msg -- workspace --no-auto-back-and-forth "${CONFIG[1]}"
		i3-msg -- move workspace to output right	
	fi
done


######## Doesn't seem to like container names with : #########







##!/usr/bin/env bash
## requires jq

#IFS=:
#INITIAL_WORKSPACE=$(i3-msg -t get_workspaces \
#  | jq '.[] | select(.focused==true).name' \
#  | cut -d"\"" -f2)

#i3-msg -t get_outputs | jq -r '.[]|"\(.name):\(.current_workspace)"' | grep -v '^null:null$' | \
#while read -r name current_workspace; do
#    echo "moving ${current_workspace} right..."
#    i3-msg workspace "${current_workspace}"
#    i3-msg move workspace to output right   
#done
#i3-msg workspace $INITIAL_WORKSPACE
