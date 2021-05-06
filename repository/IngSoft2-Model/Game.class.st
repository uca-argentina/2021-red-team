Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'dieHandle',
		'board',
		'laps',
		'playerSequence',
		'boardOfPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> with: aCircularBoard with: aDieHandle withLaps: aNumberOfLaps andWith: players [
	| aSequence aBoardOfPositions |
	aSequence := SequenceOfPlayers with: players.
	aBoardOfPositions := BoardOfPositions with: players.
	^ self new initializeWith: aCircularBoard with: aDieHandle withLaps: aNumberOfLaps with: aSequence andWith: aBoardOfPositions.
]

{ #category : #'instance creation' }
Game class >> withBoard: aBoard andWithDice: aDieHandle [ 
	^ self new initializeWithBoard: aBoard andWithDice: aDieHandle.
]

{ #category : #queries }
Game >> ended [
	^ board anyChipFinished.
]

{ #category : #initialize }
Game >> initializeWith: aCircularBoard with: aDieHandle withLaps: aNumberOfLaps with: aSequenceOfPlayers andWith: aBoardOfPositions [ 
	dieHandle := aDieHandle.
	board := aCircularBoard.
	laps := aNumberOfLaps.
	playerSequence := aSequenceOfPlayers.
	boardOfPositions := aBoardOfPositions.
]

{ #category : #initialize }
Game >> initializeWithBoard: aBoard andWithDice: aDieHandle [ 
	dieHandle := aDieHandle.
	board := aBoard.
]

{ #category : #queries }
Game >> placeOnThePodiumOf: nameOfPlayer [ 
	board orderChipsByFinalPosition.
	^ board placeOnThePodiumOf: nameOfPlayer.
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
Game >> positionOfPlayer: nameOfPlayer [
	^ board positionOfPlayer: nameOfPlayer.
]

{ #category : #actions }
Game >> rollDice [
	^ dieHandle roll.
]

{ #category : #queries }
Game >> whosFirst [
	^ board whosFirst.
]
