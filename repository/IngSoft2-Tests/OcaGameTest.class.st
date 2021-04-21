Class {
	#name : #OcaGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
OcaGameTest >> testAskFinalPositionAfterTheGameEndedSuccessfully [
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
	self assert: (aGame finalPositionOf: 'barto') equals: 1.

]

{ #category : #tests }
OcaGameTest >> testAskFinalPositionBeforeTheGameEndedSuccessfully [
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
	self should: [aGame finalPositionOf: 'barto'] raise: Error.

]

{ #category : #tests }
OcaGameTest >> testAskWhosFirstDuringAGameSuccessfully [
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
OcaGameTest >> testCheckTheGameHasntEndedWithLoadedDiceSuccessfully [
	
	| aDieHandle aBoard aGame chips |
	
	chips := OrderedCollection new.
	chips add: (Chip ofPlayer: 'cande');
				add: (Chip ofPlayer: 'barto');
				add: (Chip ofPlayer: 'mateo').
				
	aDieHandle := DieHandle withDie: (LoadedDie withFaces: 6).
	
	aDieHandle addDie: (LoadedDie withFaces: 8);
				addDie: (LoadedDie withFaces: 4).
	
	aBoard := Board withCells: 10 andWithChips: chips.
	
	aGame := Game withBoard: aBoard  andWithDice: aDieHandle.
	
	aGame playATurn.
	
	self assert: (aGame ended) equals: true.
	self assert: (aGame whosFirst) equals: 'cande'.
]

{ #category : #tests }
OcaGameTest >> testCreateABoardWithChipsAndPlayATurnSuccessfully [
	
	| aDieHandle aBoard aGame chips |
	
	chips := OrderedCollection new.
	chips add: (Chip ofPlayer: 'cande');
				add: (Chip ofPlayer: 'barto');
				add: (Chip ofPlayer: 'mateo').
				
	aDieHandle := DieHandle withDie: (LoadedDie withFaces: 6).
	
	aDieHandle addDie: (LoadedDie withFaces: 8);
				addDie: (LoadedDie withFaces: 4).
	
	aBoard := Board withCells: 100 andWithChips: chips.
	
	aGame := Game withBoard: aBoard  andWithDice: aDieHandle.
	
	aGame playATurn.
	
	self assert: (aGame positionOfPlayer: 'cande') equals: 12.

]

{ #category : #tests }
OcaGameTest >> testCreateALoadedDieWithANumberOfFacesSuccessfully [
	| aDie |
	aDie := LoadedDie withFaces: 8.
	self assert: aDie faces equals: 8.
]

{ #category : #tests }
OcaGameTest >> testPlayAGameWithLoadedDiceSuccessfully [
	
	| aDieHandle aBoard aGame chips |
	
	chips := OrderedCollection new.
	chips add: (Chip ofPlayer: 'cande');
				add: (Chip ofPlayer: 'barto');
				add: (Chip ofPlayer: 'mateo').
				
	aDieHandle := DieHandle withDie: (LoadedDie withFaces: 6).
	
	aDieHandle addDie: (LoadedDie withFaces: 8);
				addDie: (LoadedDie withFaces: 4).
	
	aBoard := Board withCells: 50 andWithChips: chips.
	
	aGame := Game withBoard: aBoard  andWithDice: aDieHandle.
	
	aGame play.
	
	self assert: (aGame ended) equals: true.
	self assert: (aGame whosFirst) equals: 'cande'.
]

{ #category : #tests }
OcaGameTest >> testPlayAGameWithRealDiceSuccessfully [
	
	| aDieHandle aBoard aGame chips |
	
	chips := OrderedCollection new.
	chips add: (Chip ofPlayer: 'cande');
				add: (Chip ofPlayer: 'barto');
				add: (Chip ofPlayer: 'mateo').
				
	aDieHandle := DieHandle withDie: (RealDie withFaces: 6).
	
	aDieHandle addDie: (RealDie withFaces: 8);
				addDie: (RealDie withFaces: 4).
	
	aBoard := Board withCells: 50 andWithChips: chips.
	
	aGame := Game withBoard: aBoard  andWithDice: aDieHandle.
	
	aGame play.
	
	self assert: (aGame ended) equals: true.
]

{ #category : #tests }
OcaGameTest >> testRollALoadedDiceSuccessfully [
	
	| aDieHandle die1 die2 |
	aDieHandle := DieHandle withDie: (LoadedDie withFaces: 6).
	
	die1 := LoadedDie withFaces: 4.
	die2 := LoadedDie withFaces: 8.
	
	aDieHandle addDie: die1;
				addDie: die2.
	
	self assert: (aDieHandle roll) equals: 12.
]

{ #category : #tests }
OcaGameTest >> testRollALoadedDieSuccessfully [
	| aDie |
	aDie := LoadedDie withFaces: 8.
	self assert: aDie roll equals: 5.
]

{ #category : #tests }
OcaGameTest >> testRollALoadedDieUnsuccessfully [
	| aDie |
	aDie := LoadedDie withFaces: 3.
	self deny: aDie roll equals: 3.
]

{ #category : #tests }
OcaGameTest >> testRollARealDiceSuccessfully [
	
	| aDieHandle die1 die2 |
	aDieHandle := DieHandle withDie: (RealDie withFaces: 6).
	
	die1 := RealDie withFaces: 4.
	die2 := RealDie withFaces: 8.
	
	aDieHandle addDie: die1;
				addDie: die2.
	
	self assert: ((aDieHandle roll) between: 3 and: 18).
]

{ #category : #tests }
OcaGameTest >> testRollARealDieSuccessfully [
	| aDie |
	aDie := RealDie withFaces: 8.
	self assert: ((aDie roll) between: 1 and: 8).
]

{ #category : #tests }
OcaGameTest >> testThrowAnExceptionWhenCreatingABoardWithoutCellsSuccessfully [
	
	| chips |
	
	chips := OrderedCollection new.
	chips add: (Chip ofPlayer: 'cande');
				add: (Chip ofPlayer: 'barto');
				add: (Chip ofPlayer: 'mateo').
	
	self should: [Board withCells: 0 andWithChips: chips] raise: Error.
]

{ #category : #tests }
OcaGameTest >> testThrowAnExceptionWhenCreatingABoardWithoutChipsSuccessfully [
	
	| chips |
	
	chips := OrderedCollection new.
	
	self should: [Board withCells: 10 andWithChips: chips] raise: Error.
]

{ #category : #tests }
OcaGameTest >> testThrowAnExceptionWhenCreatingADieWithInvalidNumberOfFacesSuccessfully [

	self should: [RealDie withFaces: 0] raise: Error.
]

{ #category : #tests }
OcaGameTest >> testThrowAnExceptionWhenTryingToPlayAnEndedGameSuccessfully [
	
	| aDieHandle aBoard aGame chips |
	
	chips := OrderedCollection new.
	chips add: (Chip ofPlayer: 'cande');
				add: (Chip ofPlayer: 'barto');
				add: (Chip ofPlayer: 'mateo').
				
	aDieHandle := DieHandle withDie: (RealDie withFaces: 6).
	
	aDieHandle addDie: (RealDie withFaces: 8);
				addDie: (RealDie withFaces: 4).
	
	aBoard := Board withCells: 10 andWithChips: chips.
	
	aGame := Game withBoard: aBoard  andWithDice: aDieHandle.
	
	aGame play.
	
	self should: [aGame playATurn] raise: Error.
]
