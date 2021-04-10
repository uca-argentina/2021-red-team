Class {
	#name : #OcaGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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
OcaGameTest >> testCreateAGameWithANumberOfCellsAndADieSuccessfully [
	| aGame |
	aGame := Game withCells: 10.
	self assert: aGame cells equals: 10.
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
