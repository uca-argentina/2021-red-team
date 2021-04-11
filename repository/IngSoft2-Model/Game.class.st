Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'cells',
		'dieHandle',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> withBoard: aBoard andWithDice: aDieHandle [ 
	^ self new initializeWithBoard: aBoard andWithDice: aDieHandle.
]

{ #category : #'instance creation' }
Game class >> withCells: aNumberOfCells [ 
	^ self new initializeWithCells: aNumberOfCells.
]

{ #category : #'instance creation' }
Game class >> withCells: aNumberOfCells andDice: aDieHandle [ 
	^ self new initializeWithCells: aNumberOfCells andDice: aDieHandle.
]

{ #category : #'instance creation' }
Game class >> withCells: aNumberOfCells withDice: aDieHandle andWithNumberOfPlayers: aNumberOfPlayers [
	^ self new initializeWithCells: aNumberOfCells withDice: aDieHandle andWithNumberOfPlayers: aNumberOfPlayers.
]

{ #category : #'as yet unclassified' }
Game >> cells [
	^ cells.
]

{ #category : #initialize }
Game >> initializeWithBoard: aBoard andWithDice: aDieHandle [ 
	dieHandle := aDieHandle.
	board := aBoard.
]

{ #category : #initialize }
Game >> initializeWithCells: aNumberOfCells [
	cells := aNumberOfCells.
]

{ #category : #initialize }
Game >> initializeWithCells: aNumberOfCells andDice: aDieHandle [ 
	cells := aNumberOfCells.
	dieHandle := aDieHandle.
]

{ #category : #initialize }
Game >> initializeWithCells: anInteger withDice: aDieHandle andWithNumberOfPlayers: anInteger3 [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
Game >> positionOfPlayer: aPlayer [
	^ board positionOfPlayer: aPlayer.
]

{ #category : #'as yet unclassified' }
Game >> rollDice [
	^ dieHandle roll.
]
