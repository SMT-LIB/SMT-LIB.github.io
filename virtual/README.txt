The files here are the ones to modify, so that html files without includes can be generated.

Workflow:
0. git pull
1. modify files in "virtual", "Theories", and "Logics" directories as necessary
2. run SSI-free.sh in "virtual" directory
   This creates shtml files in the "new" directory.
   Those files are include-free.
   Theories and logics files are embedded in shtml files for syntax highlighting on the web site.
3. in the root directory
3.1 compare the root directory (.) and the "new" directory (e.g. meld new .) as a sanity check
3.2 port the changes from "new" to root (either using a comparison tool manually or copying all shtml files from the "new" directory to the root directory)
