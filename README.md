FlexBison
=========


1. lex.l - laxical file.
2. com.y - Parser file.
3. lex.yy.c - This file is created after command flex lex.l
           flex lex.l
4. com.tab.c - This file is created after command bison com.y
           bison com.y 
 Before compiling the com.y file the file lex.yy.c is included in this 
file
5. compiler- This is our targer program.
            gcc -o compiler com.tab.c -lfl
Feed your input program to the compiler
           compiler in.txt ou.txt  
6. in.txt- This is input file, where the compiler read.
7. ou.txt - Here, compiler save its output.
8. Readme.txt- Help file 

Note: in.txt and ou.txt is attached as the sample input and output.
