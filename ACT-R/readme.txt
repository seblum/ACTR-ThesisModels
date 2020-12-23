To run the ACT-R Standalone extract the "ACT-R" folder from the
zip archive and place it anywhere on your machine.  

Then you just need to double click the "run-act-r.command" 
script to start ACT-R and the ACT-R environment.  That script
must be located in the same directory as the rest of the ACT-R
files, but you may create an alias to it and put that 
elsewhere if that is more convenient.

If you get a warning that the file is damaged or cannot be
opened then you will need to Control-click the file and pick
Open to run it.

If you get a window with an error message that says "Error 
occurred trying to connect to ACT-R Error: couldn't open
socket: host is unreachable" you will likely need to adjust
the firewall security settings on your machine to allow
the connection.

When you run that script it will open a terminal window titled
"ACT-R" and start the ACT-R Environment "Control Panel".

To close the ACT-R Standalone you need to close the "ACT-R"
window.  That will quit the terminal and the Environment
will ask to verify that it should quit.

This distribution is built using Clozure Common Lisp (CCL)
which is available at <http://clozure.com/>.  Clozure Common 
Lisp is distributed under the LGPL and the license is included
in the docs folder.

By default the software will use the localhost address for the
ACT-R interface, but if you need to make external connections
delete the force-local.lisp file from the patches directory 
before starting the software.

If you have any questions or problems with this please let me
know.

Dan (db30@andrew.cmu.edu)
