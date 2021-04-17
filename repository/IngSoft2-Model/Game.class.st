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

{ #category : #queries }
Game >> ended [
	^ board anyChipFinished.
]

{ #category : #initialize }
Game >> initializeWithBoard: aBoard andWithDice: aDieHandle [ 
	dieHandle := aDieHandle.
	board := aBoard.
]

{ #category : #actions }
Game >> play [
	self playATurn.
	( self ended ) ifFalse: [self play].
]

{ #category : #actions }
Game >> playATurn [
	(self ended) ifTrue: [ self error: 'the game has ended' ].
	board moveChip: (self rollDice).
]

{ #category : #queries }
Game >> positionOfPlayer: aPlayer [
	^ board positionOfPlayer: aPlayer.
]

{ #category : #actions }
Game >> rollDice [
	^ dieHandle roll.
]

{ #category : #queries }
Game >> whosFirst [
	^ board whosFirst.
]
