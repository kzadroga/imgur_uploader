#!/bin/bash

file=$1
client_id=$2

get_abs_filename() {
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

file_name=$(get_abs_filename $file)

if [ $# -ne 2 ]; then
	echo "You have to pass two arguments"
else
	if [[ $file == *.jpg || $file == *.png || $file == *.tiff ]]; then
		link=$(curl --request POST --url https://api.imgur.com/3/image \
		--header 'authorization: Client-ID '$client_id'' \
		--header 'content-type: multipart/form-data;' \
		 -F "image=@$file_name" --silent | jq -r '.data.link')
		echo $link
	else
		echo "File must be an image!"
	fi
fi
