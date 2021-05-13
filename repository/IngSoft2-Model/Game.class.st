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

{ #category : #queries }
Game >> ended [
	^ board anyPlayerFinished: laps.
]

{ #category : #initialize }
Game >> initializeWith: aCircularBoard with: aDieHandle withLaps: aNumberOfLaps with: aSequenceOfPlayers andWith: aBoardOfPositions [ 
	dieHandle := aDieHandle.
	board := aCircularBoard.
	laps := aNumberOfLaps.
	playerSequence := aSequenceOfPlayers.
	boardOfPositions := aBoardOfPositions.
]

{ #category : #queries }
Game >> lapOfPlayer: playerName [
	^ board lapOfPlayer: playerName.
]

{ #category : #actions }
Game >> playATurn [
	| player |
	(self ended) ifTrue: [ self error: 'the game has ended' ].
	player := playerSequence whosNext.
	board move: player with: (self rollDice).
]

{ #category : #queries }
Game >> positionOfPlayer: nameOfPlayer [
	^ board positionOfPlayer: nameOfPlayer.
]

{ #category : #actions }
Game >> rollDice [
	^ dieHandle roll.
]
