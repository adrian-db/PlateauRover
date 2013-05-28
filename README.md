PlateauRover
============

A simple solution to a coding problem - moving robots around a plateau.

You can run the unit tests by selecting the tests target, and hitting cmd-U.

To run the app, archive the (main) project, and store the resulting folder somewhere safe. You will find a usr/local/bin folder within, which contains the PlateauRovers app, which you can run from the terminal.

Things to do:
- remove all the command parsing out of the main loop, and add some tests for it. (this parsing is here as it ties together the plateau size checks with command interpretation)
- make the parser errors more helpful.
- put something visual on top of the app, to make it more friendly to use.
- parse the input as a stream, and react to each line, to make error reporting more immediate.
