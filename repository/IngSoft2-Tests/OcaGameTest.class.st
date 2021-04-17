Class {
	#name : #OcaGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
OcaGameTest >> testCheckTheGameHasntEndedSuccessfully [
	
	| aDieHandle aBoard aGame chips |
	
	chips := OrderedCollection new.
	chips add: (Chip ofPlayer: 'cande');
				add: (Chip ofPlayer: 'barto');
				add: (Chip ofPlayer: 'mateo').
				
	aDieHandle := DieHandle withDie: (Die withFaces: 6).
	
	aDieHandle addDie: (Die withFaces: 8);
				addDie: (Die withFaces: 4).
	
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
				
	aDieHandle := DieHandle withDie: (Die withFaces: 6).
	
	aDieHandle addDie: (Die withFaces: 8);
				addDie: (Die withFaces: 4).
	
	aBoard := Board withCells: 100 andWithChips: chips.
	
	aGame := Game withBoard: aBoard  andWithDice: aDieHandle.
	
	aGame playATurn.
	
	self assert: (aGame positionOfPlayer: 'cande') equals: 12.

]

{ #category : #tests }
OcaGameTest >> testCreateADieWithANumberOfFacesSuccessfully [
	| aDice |
	aDice := Die withFaces: 8.
	self assert: aDice faces equals: 8.
]

{ #category : #tests }
OcaGameTest >> testRollTheDiceSuccessfully [
	
	| aDieHandle die1 die2 |
	aDieHandle := DieHandle withDie: (Die withFaces: 6).
	
	die1 := Die withFaces: 4.
	die2 := Die withFaces: 8.
	
	aDieHandle addDie: die1;
				addDie: die2.
	
	self assert: (aDieHandle roll) equals: 12.
]

{ #category : #tests }
OcaGameTest >> testRollTheDieSuccessfully [
	| aDice |
	aDice := Die withFaces: 8.
	self assert: aDice roll equals: 5.
]

{ #category : #tests }
OcaGameTest >> testRollTheDieUnsuccessfully [
	| aDice |
	aDice := Die withFaces: 3.
	self deny: aDice roll equals: 3.
]
