#!/bin/bash

init(){

	#handle inputs
	list=$1
	order=$2
		# echo "input order: $order"

	#init variables for inventory
	applesInList=0
	pineapplesInList=0

	#init variables for recipe requirement
	applesinOrder=0
	pineapplesInOrder=0

	#init variable for validOrder
	validOrder=""


	#init array with all options for recipes
	recipes=("APPLE PIE" "PINEAPPLE PIE" "FRUIT PARFAIT")


				#NOTE TO SELF: IMPT SYNTAX
	#loop through recipe array, compare order against recipe
	for recipe in "${recipes[@]}"
	do
		#prepare strings for comparison - recipe and uppercaseOrder
			# echo "loop start"
			# echo "recipe: $recipe"
		uppercaseOrder=${order^^}
			# echo "uppercased order: $uppercaseOrder"
		# echo $recipe | tr '[:upper:]' '[:lower:]'

		#if order matches recipe, validate order
		if [ "$uppercaseOrder" == "$recipe" ]
			then
					# echo "match found"
				validOrder="$uppercaseOrder"
		fi
			# echo "loop end"
			# echo
	done

	#check if order has been validated. If not validated, exit the code
	if [ "$validOrder" == "" ]
	then
		echo "We do not have that on the menu"
		exit 1
	#now we know order has been validated, count required fruits for the order
	elif [ "$validOrder" == "${recipes[0]}" ]
	then
		applesinOrder=3
	elif [ "$validOrder" == "${recipes[1]}" ]
	then
		pineapplesInOrder=3
	elif [ "$validOrder" == "${recipes[2]}" ]
	then
		applesinOrder=2
		pineapplesInOrder=2
	fi



	#now we know how many fruits we need, count the fruits we have in inventory list
		#loops through inventory list $list
	while read inventoryItem; do
			# echo "inventoryItem: $inventoryItem" | tr '[:upper:]' '[:lower:]'
		length=${#inventoryItem}
			# echo "length: $length"

		#remove the comma by sub-stringing everything but the last
		inventoryItemNoComma=${inventoryItem:0:$length-1}
			# echo $inventoryItemNoComma
		formattedInventoryItem=${inventoryItemNoComma,,}
			# echo $formattedInventoryItem

		#now that we have the inventory item lowercased and without comma, do straight comparison
		if [ "$formattedInventoryItem" == "apple" ]
		then
			applesInList=$((applesInList+=1))
		elif [ "$formattedInventoryItem" == "pineapple" ]
		then
			pineapplesInList=$((pineapplesInList+=1))
		fi

			# echo "apples in list: $applesInList"
			# echo "pineapples in list: $pineapplesInList"
	done <$list

	#now we know how many fruits we need, and how many fruits we have
	#check to see if BOTH are enough
	if [ $applesInList -gt $applesinOrder ] && [ $pineapplesInList -gt $pineapplesInOrder ]
	then
		echo "You shall have $validOrder!"
	else
		echo "You shall not have $validOrder"
	fi

}

init "$@"