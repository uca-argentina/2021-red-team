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
	^ board anyChipFinished.
]

{ #category : #initialize }
Game >> initializeWithBoard: aBoard andWithDice: aDieHandle [ 
	dieHandle := aDieHandle.
	board := aBoard.
]

{ #category : #'as yet unclassified' }
Game >> playATurn [
	board moveChip: (self rollDice).
	
]

{ #category : #'as yet unclassified' }
Game >> positionOfPlayer: aPlayer [
	^ board positionOfPlayer: aPlayer.
]

{ #category : #'as yet unclassified' }
Game >> rollDice [
	^ dieHandle roll.
]

{ #category : #'as yet unclassified' }
Game >> whosFirst [
	^ board whosFirst.
]
