1-Copy the file into new folder called dist 
2-Compresse this Folder into MyPharm-X.Y.Z.zip
3-Create the Hash Code by this Get-FileHash -Path "MyPharm-X.Y.Z.zip" -Algorithm SHA256 | Format-List
4-Copy the Hash Code into latest.js , latest.json
5-Change the Version in those JS and JSON files 
6-Change the changelog 
7-Comit and Push into GitHub