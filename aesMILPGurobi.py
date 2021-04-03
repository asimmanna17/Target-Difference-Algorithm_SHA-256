import gurobipy as gp
from gurobipy import GRB

rounds = 2

def getInitialState(model):
	listOfState = []
				
	state = []
	for stateVar in range(16):				# for 1st round 16 binary variables
		state.append(model.addVar(vtype=GRB.BINARY, name="{:d}".format(stateVar)))
	listOfState.append(state)

	state = []
	for stateVar in range(16):				# for 1st round another 16 integer variables
		state.append(model.addVar(vtype=GRB.INTEGER, name="{:d}".format(stateVar)))
	listOfState.append(state)

	return listOfState	
		
def getNewState(model, startPosition):			# new state will return 16 variable list
	state = []
	for stateVar in range(16):
		state.append(model.addVar(vtype=GRB.INTEGER, name="{:d}".format(startPosition + stateVar)))
	return state	

def getNewDummyVarState(model, startPosition):		# it returns one list containing 4 dummy vars for 4 columns
	dummyVarList = []
	for dummyVar in range(4):
		dummyVarList.append(model.addVar(vtype=GRB.BINARY, name="{:d}".format(startPosition + dummyVar)))
	return dummyVarList	



def getObjectiveFunction(model, listOfState):			# returns the objective function
	obj = gp.LinExpr()	
	for state in listOfState[0:rounds]:
		for var in state:
			obj += var
	return obj		

def printSolution(listOfState):
	for state in listOfState:
		for var in state:
			print(var.x)





#------------------------------------------------(main function)---------------------------------------------------------		

# Create a new model
model = gp.Model("aes")

listOfState = []
listOfDummyVar = []

listOfState = getInitialState(model)
dummyVarStartPosition = 0
listOfDummyVar.append(getNewDummyVarState(model, dummyVarStartPosition))

for roundNumber in range(rounds-1):
	stateStartPosition = 32 + 16*roundNumber		# mentioning start positions of variables for new state
	dummyVarStartPosition = 4 + 4*roundNumber
		
	listOfState.append(getNewState(model, stateStartPosition))
	listOfDummyVar.append(getNewDummyVarState(model, dummyVarStartPosition))


model.setObjective(getObjectiveFunction(model, listOfState), GRB.MINIMIZE)

for roundNumber in range(rounds):
	inputStateOfMC = listOfState[roundNumber]
	outputStateOfMC = listOfState[roundNumber+1]
	
	for columnNumber in range(4):				# adding the constraints
		constr = gp.LinExpr()
		
		for varNumber in [0,5,10,15]:
			constr += inputStateOfMC[(varNumber + 4*columnNumber)%16]

		for varNumber in [16,17,18,19]:
			constr += outputStateOfMC[(varNumber + 4*columnNumber)%16]

		model.addConstr(constr >= 5*listOfDummyVar[roundNumber][columnNumber] )

	for columnNumber in range(4):
		constr = gp.LinExpr()
		for varNumber in [0,5,10,15]:
			model.addConstr(listOfDummyVar[roundNumber][columnNumber] >= inputStateOfMC[(varNumber + 4*columnNumber)%16])

		for varNumber in [16,17,18,19]:
			model.addConstr(listOfDummyVar[roundNumber][columnNumber] >= outputStateOfMC[(varNumber + 4*columnNumber)%16])	
			
				
model.addConstr(getObjectiveFunction(model, listOfState) >= 1)

model.optimize()

printSolution(listOfState)
