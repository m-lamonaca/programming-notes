# Jupyter Notebooks Cheat Sheet

## MAGIC COMMANDS

`%quickref` Display the IPython Quick Reference Card  
`%magic` Display detailed documentation for all of the available magic commands  
`%debug` Enter the interactive debugger at the bottom of the last exception traceback  
`%hist` Print command input (and optionally output) history  
`%pdb` Automatically enter debugger after any exception  
`%paste` Execute pre-formatted Python code from clipboard  
`%cpaste` Open a special prompt for manually pasting Python code to be executed  
`%reset` Delete all variables / names defined in interactive namespace  
`%page` OBJECT Pretty print the object and display it through a pager  
`%run` script.py Run a Python script inside IPython  
`%prun` statement Execute statement with cProfile and report the profiler output  
`%time` statement Report the execution time of single statement  
`%timeit` statement Run a statement multiple times to compute an emsemble average execution time. Useful for timing code with very short execution time  
`%who`, `%who_ls`, `%whos` Display variables defined in interactive namespace, with varying levels of information / verbosity  
`%xdel` variable Delete a variable and attempt to clear any references to the object in the IPython internals  

## INTERACTING WITH THE OPERATING SYSTEM

`!cmd` Execute cmd in the system shell  
`output = !cmd args` Run cmd and store the stdout in output  
`%alias alias_name cmd` Define an alias for a system (shell) command  
`%bookmark` Utilize IPython’s directory bookmarking system  
`%cd` directory Change system working directory to passed directory  
`%pwd` Return the current system working directory  
`%pushd` directory Place current directory on stack and change to target directory  
`%popd` Change to directory popped off the top of the stack  
`%dirs` Return a list containing the current directory stack  
`%dhist` Print the history of visited directories  
`%env` Return the system environment variables as a dict  

Input variables are stored in variables named like `iX`, where `X` is the input line number  

IPython is capable of logging the entire console session including input and output  
Logging is turned on by typing `%logstart`  

Starting a line in IPython with an exclamation point `!`, or bang, tells IPython to execute everything after the bang in the system shell  
The console output of a shell command can be stored in a variable by assigning the !-escaped expression to a variable  

## TIMING CODE

`%time` runs a statement once, reporting the total execution time  
`%timeit` given an arbitrary statement, it has a heuristic to run a statement multiple times to produce a fairly accurate average runtime
