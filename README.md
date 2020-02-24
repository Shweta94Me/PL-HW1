Project in group

1.) Siddhesh Vilas Kolhapure
    B00815336
    Email: skolhap1@binghamton.edu

    Shweta Sharad Mestry
    B00815342
    Email: smestry1@binghamton.edu


2.) Code was tested on remote.cs with all the provided use cases

3.) How to execute the program

	* Untar pl-skolhap1smestry1.tar file in folder using command  "tar -xvf pl-smestry1skolhap1.tar".
	* cd into that folder where calc.l ,calc.y and Makefile is avialable. 
	* type command "make".
	* After running "make" command "calc" named executable will be generated.
	* Run Command "./calc < input.txt" to run program with input file having 		  extension .txt.
	  or 
	  Run Command "./calc < input" to run program with input file having 		  	  no extension.
	  or
	  Run Command "./calc" Enter
		 then "main() { x =3; print x; }
	* Use make clean

4.) Algorithm
	* Implemented Linked List data structure to create symbol table.
	* Used insertFirst , find and update_link methods to insert a new entry, 	  	  search existing indentifier and Update existing identifier.
	* Initially indentifier and its value is passed to update_link function if the 	  linked list is not created then a new entry of this indentifier and value is 	  added to the list. If linked list is created search for that identifier. If 	  	  identifier is found then update its value else insert a new key value to the 	  list.


	 