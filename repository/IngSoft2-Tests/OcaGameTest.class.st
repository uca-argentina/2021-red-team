Class {
	#name : #OcaGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
OcaGameTest >> testCreateADiceWithANumberOfFacesSuccessfully [
	| aDice |
	aDice := Dice withFaces: 8.
	self assert: aDice faces equals: 8.
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
	| aDice |
	aDice := Dice withFaces: 8.
	self assert: aDice roll equals: 5.
]

{ #category : #tests }
OcaGameTest >> testRollTheDiceUnsuccessfully [
	| aDice |
	aDice := Dice withFaces: 3.
	self deny: aDice roll equals: 3.
]
