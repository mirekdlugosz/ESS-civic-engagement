# Known issues

* All computations ignore weighting variables. We are concerned about getting graps of general trends, which are unlikely to change after including weights, but we should probably fix this anyway
* Only country select input can be specified in URL; visible tab and year radio somehow escapes javascript code
* There is no user-visible way that form can be changed from URL level (each form change should probably generate new URL, which can be simply copy-pasted?)
* We depend on Shiny and R for user input validation
* WISH: I would like to have app title changed according to input value, so it reads "Civic engagement in Poland" etc.
