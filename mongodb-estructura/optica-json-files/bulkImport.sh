#!/bin/bash

for file in ./*.json; do
	fileName=$(basename "$file" .json)
	filePath="$file"
	mongoimport --db optica --collection "$fileName" --file "$filePath" --jsonArray
done;
