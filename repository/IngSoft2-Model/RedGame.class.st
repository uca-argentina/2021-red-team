Class {
	#name : #RedGame,
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
RedGame class >> with: aCircularBoard with: aDieHandle withLaps: aNumberOfLaps andWith: players [
	| aSequence aBoardOfPositions |
	players ifEmpty: [ self error: 'cannot create a RedGame without players' ].
	(aNumberOfLaps > 0) ifFalse: [ self error: 'invalid number of laps' ].
	aSequence := SequenceOfPlayers with: players.
	aBoardOfPositions := BoardOfPositions with: players.
	^ self new initializeWith: aCircularBoard with: aDieHandle withLaps: aNumberOfLaps with: aSequence andWith: aBoardOfPositions.
]

{ #category : #queries }
RedGame >> hasEnded [
	^ board anyPlayerFinished: laps.
]

{ #category : #initialize }
RedGame >> initializeWith: aCircularBoard with: aDieHandle withLaps: aNumberOfLaps with: aSequenceOfPlayers andWith: aBoardOfPositions [ 
	dieHandle := aDieHandle.
	board := aCircularBoard.
	laps := aNumberOfLaps.
	playerSequence := aSequenceOfPlayers.
	boardOfPositions := aBoardOfPositions.
]

{ #category : #queries }
RedGame >> lapOf: playerName [
	^ board lapOf: playerName.
]

{ #category : #actions }
RedGame >> play [
	"self playATurn.
	(self hasEnded) ifFalse: [ self play ]."
	[ self hasEnded ] whileFalse: [ self playATurn ].
]

{ #category : #actions }
RedGame >> playATurn [
	| player |
	(self hasEnded) ifTrue: [ self error: 'the game has ended' ].
	player := playerSequence whosNext.
	board move: player with: (self rollDice).
]

{ #category : #queries }
RedGame >> podiumOf: name [
	^ board podiumOf: name.
]

{ #category : #queries }
RedGame >> positionOf: nameOfPlayer [
	^ board positionOf: nameOfPlayer.
]

{ #category : #actions }
RedGame >> rollDice [
	^ dieHandle roll.
]

{ #category : #queries }
RedGame >> whoWon [
	(self hasEnded) ifFalse: [ self error: 'the game is still running' ].
	^board whoWon.
]
