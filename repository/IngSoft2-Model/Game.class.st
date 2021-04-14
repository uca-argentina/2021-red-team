Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'dieHandle',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> withBoard: aBoard andWithDice: aDieHandle [ 
	^ self new initializeWithBoard: aBoard andWithDice: aDieHandle.
]

{ #category : #'as yet unclassified' }
Game >> ended [
	^false.
]

{ #category : #initialize }
Game >> initializeWithBoard: aBoard andWithDice: aDieHandle [ 
	dieHandle := aDieHandle.
	board := aBoard.
]

{ #category : #'as yet unclassified' }
Game >> playARound [
	board nextTurn: (self rollDice).
]

{ #category : #'as yet unclassified' }
Game >> rollDice [
	^ dieHandle roll.
]
