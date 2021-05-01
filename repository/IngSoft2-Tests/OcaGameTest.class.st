Class {
	#name : #OcaGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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
	self should: [ RandomDie withFaces: 3 ] raise: Error
]

{ #category : #tests }
OcaGameTest >> testAskFinalPositionAfterTheGameEnded [
	| aDieHandle aBoard aGame chips |
	chips := OrderedCollection new.
	chips
		add: (Chip ofPlayer: 'barto');
		add: (Chip ofPlayer: 'cande');
		add: (Chip ofPlayer: 'mateo');
		add: (Chip ofPlayer: 'roman').
	aDieHandle := DieHandle withDie: (LoadedDie withFaces: 6).
	aDieHandle addDie: (LoadedDie withFaces: 8).
	aBoard := Board withCells: 50 andWithChips: chips.
	aGame := Game withBoard: aBoard andWithDice: aDieHandle.
	aGame play.
	self assert: (aGame placeOnThePodiumOf: 'barto') equals: 1.

]

{ #category : #tests }
OcaGameTest >> testAskWhosFirstDuringAGame [
	| aDieHandle aBoard aGame chips |
	chips := OrderedCollection new.
	chips
		add: (Chip ofPlayer: 'barto');
		add: (Chip ofPlayer: 'cande');
		add: (Chip ofPlayer: 'mateo');
		add: (Chip ofPlayer: 'roman').
	aDieHandle := DieHandle withDie: (LoadedDie withFaces: 6).
	aDieHandle addDie: (LoadedDie withFaces: 8).
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
	| aDieHandle aBoard aGame chips |
	chips := OrderedCollection new.
	chips
		add: (Chip ofPlayer: 'cande');
		add: (Chip ofPlayer: 'barto');
		add: (Chip ofPlayer: 'mateo').
	aDieHandle := DieHandle withDie: (LoadedDie withFaces: 6).
	aDieHandle
		addDie: (LoadedDie withFaces: 8);
		addDie: (LoadedDie withFaces: 4).
	aBoard := Board withCells: 10 andWithChips: chips.
	aGame := Game withBoard: aBoard andWithDice: aDieHandle.
	aGame playATurn.
	self assert: aGame ended equals: true.
	self assert: aGame whosFirst equals: 'cande'
]

{ #category : #tests }
OcaGameTest >> testCreateALoadedDieWithANumberOfFaces [
	| aDie |
	aDie := LoadedDie withFaces: 8.
	self assert: aDie faces equals: 8.
]

{ #category : #tests }
OcaGameTest >> testFinalPositionCannotBeAskedBeforeGameEnded [
	| aDieHandle aBoard aGame chips |
	chips := OrderedCollection new.
	chips
		add: (Chip ofPlayer: 'barto');
		add: (Chip ofPlayer: 'cande');
		add: (Chip ofPlayer: 'mateo');
		add: (Chip ofPlayer: 'roman').
	aDieHandle := DieHandle withDie: (LoadedDie withFaces: 6).
	aDieHandle addDie: (LoadedDie withFaces: 8).
	aBoard := Board withCells: 50 andWithChips: chips.
	aGame := Game withBoard: aBoard andWithDice: aDieHandle.
	aGame playATurn;
			playATurn. 
	self should: [aGame placeOnThePodiumOf: 'barto'] raise: Error.

]

{ #category : #tests }
OcaGameTest >> testGameCannotBePlayedIfItHasAlreadyEnded [
	
	| aDieHandle aBoard aGame chips |
	
	chips := OrderedCollection new.
	chips add: (Chip ofPlayer: 'cande');
				add: (Chip ofPlayer: 'barto');
				add: (Chip ofPlayer: 'mateo').
				
	aDieHandle := DieHandle withDie: (RandomDie withFaces: 6).
	
	aDieHandle addDie: (RandomDie withFaces: 8);
				addDie: (RandomDie withFaces: 4).
	
	aBoard := Board withCells: 10 andWithChips: chips.
	
	aGame := Game withBoard: aBoard  andWithDice: aDieHandle.
	
	aGame play.
	
	self should: [aGame playATurn] raise: Error.
]

{ #category : #tests }
OcaGameTest >> testPlayAGameWithLoadedDice [
	| aDieHandle aBoard aGame chips |
	chips := OrderedCollection new.
	chips
		add: (Chip ofPlayer: 'cande');
		add: (Chip ofPlayer: 'barto');
		add: (Chip ofPlayer: 'mateo').
	aDieHandle := DieHandle withDie: (LoadedDie withFaces: 6).
	aDieHandle
		addDie: (LoadedDie withFaces: 8);
		addDie: (LoadedDie withFaces: 4).
	aBoard := Board withCells: 50 andWithChips: chips.
	aGame := Game withBoard: aBoard andWithDice: aDieHandle.
	aGame play.
	self assert: aGame ended equals: true.
	self assert: aGame whosFirst equals: 'cande'
]

{ #category : #tests }
OcaGameTest >> testPlayAGameWithRandomDice [
	| aDieHandle aBoard aGame chips |
	chips := OrderedCollection new.
	chips
		add: (Chip ofPlayer: 'cande');
		add: (Chip ofPlayer: 'barto');
		add: (Chip ofPlayer: 'mateo').
	aDieHandle := DieHandle withDie: (RandomDie withFaces: 6).
	aDieHandle
		addDie: (RandomDie withFaces: 8);
		addDie: (RandomDie withFaces: 4).
	aBoard := Board withCells: 50 andWithChips: chips.
	aGame := Game withBoard: aBoard andWithDice: aDieHandle.
	aGame play.
	self assert: aGame ended equals: true
]

{ #category : #tests }
OcaGameTest >> testPlayATurn [
	| aDieHandle aBoard aGame chips |
	chips := OrderedCollection new.
	chips
		add: (Chip ofPlayer: 'cande');
		add: (Chip ofPlayer: 'barto');
		add: (Chip ofPlayer: 'mateo').
	aDieHandle := DieHandle withDie: (LoadedDie withFaces: 6).
	aDieHandle
		addDie: (LoadedDie withFaces: 8);
		addDie: (LoadedDie withFaces: 4).
	aBoard := Board withCells: 100 andWithChips: chips.
	aGame := Game withBoard: aBoard andWithDice: aDieHandle.
	aGame playATurn.
	self assert: (aGame positionOfPlayer: 'cande') equals: 12
]

{ #category : #tests }
OcaGameTest >> testRollALoadedDice [
	| aDieHandle die1 die2 |
	aDieHandle := DieHandle withDie: (LoadedDie withFaces: 6).
	die1 := LoadedDie withFaces: 4.
	die2 := LoadedDie withFaces: 8.
	aDieHandle
		addDie: die1;
		addDie: die2.
	self assert: aDieHandle roll equals: 12
]

{ #category : #tests }
OcaGameTest >> testRollALoadedDie [
	| aDie |
	aDie := LoadedDie withFaces: 8.
	self assert: aDie roll equals: 5.
]

{ #category : #tests }
OcaGameTest >> testRollARealDice [
	| aDieHandle die1 die2 |
	aDieHandle := DieHandle withDie: (RandomDie withFaces: 6).
	die1 := RandomDie withFaces: 4.
	die2 := RandomDie withFaces: 8.
	aDieHandle
		addDie: die1;
		addDie: die2.
	self assert: (aDieHandle roll between: 3 and: 18)
]

{ #category : #tests }
OcaGameTest >> testRollARealDie [
	| aDie |
	aDie := RandomDie withFaces: 8.
	self assert: ((aDie roll) between: 1 and: 8).
]
