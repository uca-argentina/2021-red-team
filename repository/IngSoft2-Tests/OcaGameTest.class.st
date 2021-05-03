Class {
	#name : #OcaGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
OcaGameTest >> should: block raise: kindOfError withMessage: expectedMessage [
	self
		should: block
		raise: kindOfError
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedMessage ]
]

{ #category : #tests }
OcaGameTest >> testABoardCannotBeCreatedWithoutCells [
	| chips |
	chips := OrderedCollection new.
	chips
		add: (Chip ofPlayer: 'cande');
		add: (Chip ofPlayer: 'barto');
		add: (Chip ofPlayer: 'mateo').
	self should: [ Board withCells: 0 andWithChips: chips ] raise: Error
]

{ #category : #tests }
OcaGameTest >> testABoardCannotBeCreatedWithoutChips [
	| chips |
	chips := OrderedCollection new.
	self should: [ Board withCells: 10 andWithChips: chips ] raise: Error
]

{ #category : #tests }
OcaGameTest >> testADieCannotBeCreatedWithLessThanFourFaces [
	self should: [ RandomDie withFaces: 3 ] raise: Error withMessage: 'invalid number of faces'.
]

{ #category : #tests }
OcaGameTest >> testADieHandleCannotBeCreatedWithoutDice [
	| dice |
	dice := Array new.
	self should: [ DieHandle with: dice ] raise: Error withMessage: 'cannot create an empty die handle'
]

{ #category : #tests }
OcaGameTest >> testAskFinalPositionAfterTheGameEnded [
	| aDieHandle aBoard aGame chips die1 die2 die3 dice |
	chips := OrderedCollection new.
	chips
		add: (Chip ofPlayer: 'barto');
		add: (Chip ofPlayer: 'cande');
		add: (Chip ofPlayer: 'mateo');
		add: (Chip ofPlayer: 'roman').
	die1 := LoadedDie withFaces: 4.
	die2 := LoadedDie withFaces: 8.
	die3 := LoadedDie withFaces: 6.
	dice := Array with: die1 with: die2 with: die3.
	aDieHandle := DieHandle with: dice.
	aBoard := Board withCells: 50 andWithChips: chips.
	aGame := Game withBoard: aBoard andWithDice: aDieHandle.
	aGame play.
	self assert: (aGame placeOnThePodiumOf: 'barto') equals: 1.

]

{ #category : #tests }
OcaGameTest >> testAskWhosFirstDuringAGame [
	| aDieHandle aBoard aGame chips die1 die2 die3 dice |
	chips := OrderedCollection new.
	chips
		add: (Chip ofPlayer: 'barto');
		add: (Chip ofPlayer: 'cande');
		add: (Chip ofPlayer: 'mateo');
		add: (Chip ofPlayer: 'roman').
	die1 := LoadedDie withFaces: 4.
	die2 := LoadedDie withFaces: 8.
	die3 := LoadedDie withFaces: 6.
	dice := Array with: die1 with: die2 with: die3.
	aDieHandle := DieHandle with: dice.
	aBoard := Board withCells: 50 andWithChips: chips.
	aGame := Game withBoard: aBoard andWithDice: aDieHandle.
	aGame
		playATurn;
		playATurn;
		playATurn;
		playATurn;
		playATurn.
	self assert: aGame whosFirst equals: 'barto'
]

{ #category : #tests }
OcaGameTest >> testCheckTheGameHasntEnded [
	| aDieHandle aBoard aGame chips die1 die2 die3 dice |
	chips := OrderedCollection new.
	chips
		add: (Chip ofPlayer: 'cande');
		add: (Chip ofPlayer: 'barto');
		add: (Chip ofPlayer: 'mateo').
	die1 := LoadedDie withFaces: 4.
	die2 := LoadedDie withFaces: 8.
	die3 := LoadedDie withFaces: 6.
	dice := Array with: die1 with: die2 with: die3.
	aDieHandle := DieHandle with: dice.
	aBoard := Board withCells: 10 andWithChips: chips.
	aGame := Game withBoard: aBoard andWithDice: aDieHandle.
	aGame playATurn.
	self assert: aGame ended.
	self assert: aGame whosFirst equals: 'cande'
]

{ #category : #tests }
OcaGameTest >> testCreateACircularBoardWithCells [
	| aCircularBoard |

	aCircularBoard := CircularBoard withCells: 100.
	
	self assert: aCircularBoard numberOfCells equals: 100. 
	
]

{ #category : #tests }
OcaGameTest >> testFinalPositionCannotBeAskedBeforeGameEnded [
	| aDieHandle aBoard aGame chips die1 die2 die3 dice |
	chips := OrderedCollection new.
	chips
		add: (Chip ofPlayer: 'barto');
		add: (Chip ofPlayer: 'cande');
		add: (Chip ofPlayer: 'mateo');
		add: (Chip ofPlayer: 'roman').
	die1 := LoadedDie withFaces: 4.
	die2 := LoadedDie withFaces: 8.
	die3 := LoadedDie withFaces: 6.
	dice := Array with: die1 with: die2 with: die3.
	aDieHandle := DieHandle with: dice.
	aBoard := Board withCells: 50 andWithChips: chips.
	aGame := Game withBoard: aBoard andWithDice: aDieHandle.
	aGame playATurn;
			playATurn. 
	self should: [aGame placeOnThePodiumOf: 'barto'] raise: Error.

]

{ #category : #tests }
OcaGameTest >> testGameCannotBePlayedIfItHasAlreadyEnded [
	| aDieHandle aBoard aGame chips die1 die2 die3 dice |
	chips := OrderedCollection new.
	chips
		add: (Chip ofPlayer: 'cande');
		add: (Chip ofPlayer: 'barto');
		add: (Chip ofPlayer: 'mateo').
	die1 := RandomDie withFaces: 4.
	die2 := RandomDie withFaces: 8.
	die3 := RandomDie withFaces: 6.
	dice := Array with: die1 with: die2 with: die3.
	aDieHandle := DieHandle with: dice.
	aBoard := Board withCells: 10 andWithChips: chips.
	aGame := Game withBoard: aBoard andWithDice: aDieHandle.
	aGame play.
	self should: [ aGame playATurn ] raise: Error
]

{ #category : #tests }
OcaGameTest >> testPlayAGameWithLoadedDice [
	| aDieHandle aBoard aGame chips die1 die2 die3 dice |
	chips := OrderedCollection new.
	chips
		add: (Chip ofPlayer: 'cande');
		add: (Chip ofPlayer: 'barto');
		add: (Chip ofPlayer: 'mateo').
	die1 := LoadedDie withFaces: 4.
	die2 := LoadedDie withFaces: 8.
	die3 := LoadedDie withFaces: 6.
	dice := Array with: die1 with: die2 with: die3.
	aDieHandle := DieHandle with: dice.
	aBoard := Board withCells: 50 andWithChips: chips.
	aGame := Game withBoard: aBoard andWithDice: aDieHandle.
	aGame play.
	self assert: aGame ended.
	self assert: aGame whosFirst equals: 'cande'
]

{ #category : #tests }
OcaGameTest >> testPlayAGameWithRandomDice [
	| aDieHandle aBoard aGame chips die1 die2 die3 dice |
	chips := OrderedCollection new.
	chips
		add: (Chip ofPlayer: 'cande');
		add: (Chip ofPlayer: 'barto');
		add: (Chip ofPlayer: 'mateo').
	die1 := RandomDie withFaces: 4.
	die2 := RandomDie withFaces: 8.
	die3 := RandomDie withFaces: 6.
	dice := Array with: die1 with: die2 with: die3.
	aDieHandle := DieHandle with: dice.
	aBoard := Board withCells: 50 andWithChips: chips.
	aGame := Game withBoard: aBoard andWithDice: aDieHandle.
	aGame play.
	self assert: aGame ended
]

{ #category : #tests }
OcaGameTest >> testPlayATurn [
	| aDieHandle aBoard aGame chips die1 die2 die3 dice |
	chips := OrderedCollection new.
	chips
		add: (Chip ofPlayer: 'cande');
		add: (Chip ofPlayer: 'barto');
		add: (Chip ofPlayer: 'mateo').
	die1 := LoadedDie withFaces: 4.
	die2 := LoadedDie withFaces: 8.
	die3 := LoadedDie withFaces: 6.
	dice := Array with: die1 with: die2 with: die3.
	aDieHandle := DieHandle with: dice.
	aBoard := Board withCells: 100 andWithChips: chips.
	aGame := Game withBoard: aBoard andWithDice: aDieHandle.
	aGame playATurn.
	self assert: (aGame positionOfPlayer: 'cande') equals: 18
]

{ #category : #tests }
OcaGameTest >> testRollALoadedDie [
	| aDie |
	aDie := LoadedDie withFaces: 8.
	self assert: aDie roll equals: 8.
]

{ #category : #tests }
OcaGameTest >> testRollARandomDie [
	| aDie |
	aDie := RandomDie withFaces: 8.
	self assert: ((aDie roll) between: 1 and: 8).
]

{ #category : #tests }
OcaGameTest >> testRollingADieHandleGivesTheSumOfItsDiceFaces [
	| aDieHandle die1 die2 die3 dice |
	die1 := LoadedDie withFaces: 4.
	die2 := LoadedDie withFaces: 8.
	die3 := LoadedDie withFaces: 6.
	dice := Array with: die1 with: die2 with: die3.
	aDieHandle := DieHandle with: dice.
	self assert: aDieHandle roll equals: 18.
]
