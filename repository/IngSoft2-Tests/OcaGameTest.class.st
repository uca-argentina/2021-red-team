Class {
	#name : #OcaGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
OcaGameTest >> testAddDiceToADieHandleSuccessfully [
	
	| aDieHandle die1 die2 |
	aDieHandle := DieHandle withDie: (Die withFaces: 6).
	
	die1 := Die withFaces: 4.
	die2 := Die withFaces: 8.
	
	aDieHandle addDie: die1;
				addDie: die2.
	
	self assert: (aDieHandle numberOfDice) equals: 3.
]

{ #category : #tests }
OcaGameTest >> testCreateADieHandleSuccessfully [
	
	| aDieHandle |
	aDieHandle := DieHandle withDie: (Die withFaces: 6).
	
	self assert: (aDieHandle numberOfDice) equals: 1.
]

{ #category : #tests }
OcaGameTest >> testCreateADieWithANumberOfFacesSuccessfully [
	| aDice |
	aDice := Die withFaces: 8.
	self assert: aDice faces equals: 8.
]

{ #category : #tests }
OcaGameTest >> testCreateAGameWithANumberOfCellsAndADieHandleSuccessfully [
	| aGame aDieHandle aBoard |
	
	aDieHandle := DieHandle withDie: (Die withFaces: 6).
	aDieHandle addDie: (Die withFaces: 4);
				addDie: (Die withFaces: 8).
	aBoard := Board withCells: 10 andWithNumberOfPlayers: 3.
				
	aGame := Game withBoard: aBoard andWithDice: aDieHandle.
	
	self assert: (aGame positionOfPlayer: 2) equals: 0.
]

{ #category : #tests }
OcaGameTest >> testCreateAGameWithANumberOfCellsSuccessfully [
	| aGame |
	aGame := Game withCells: 10.
	self assert: aGame cells equals: 10
]

{ #category : #tests }
OcaGameTest >> testCreateAPlayerWithNameSuccessfully [
	| aPlayer |
	aPlayer := Player withName: 'Jorge'.
	self assert: aPlayer name equals: 'Jorge'
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
