Class {
	#name : #OcaGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
OcaGameTest >> testCreateADieWithANumberOfFacesSuccessfully [
	| aDice |
	aDice := Die withFaces: 8.
	self assert: aDice faces equals: 8.
]

{ #category : #tests }
OcaGameTest >> testCreateAGameAndPlayARound [
	
	| aDieHandle players aBoard aGame |
	
	players := OrderedCollection new.
	players add: 'Cande';
				add: 'Mateo';
				 add: 'Barto'.
		
	aDieHandle := DieHandle withDie: (Die withFaces: 6).
	
	aDieHandle addDie: (Die withFaces: 8);
				addDie: (Die withFaces: 4).
	
	aBoard := Board withCells: 100 andWithPlayers: players.
	
	aGame := Game withBoard: aBoard  andWithDice: aDieHandle.
	
	aGame playARound.
	
	self assert: (aGame ended) equals: false.

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
