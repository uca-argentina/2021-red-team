Class {
	#name : #RedGame,
	#superclass : #Object,
	#instVars : [
		'dieHandle',
		'board',
		'laps',
		'playerSequence',
		'cardDealer',
		'lastToRoll'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RedGame class >> with: aCircularBoard with: aDieHandle with: aDeck withLaps: aNumberOfLaps with: players andWith: aNumberOfAssignatedCards [
	| aSequence cardDealer|
	players ifEmpty: [ self error: 'cannot create a RedGame without players' ].
	(aNumberOfLaps > 0) ifFalse: [ self error: 'invalid number of laps' ].
	(aCircularBoard arePlaying: players) ifFalse: [ self error: 'game and board must have the same players' ].
	aSequence := SequenceOfPlayers with: players.
	cardDealer := CardDealer with: players with: aNumberOfAssignatedCards andWith: aDeck.
	^ self new initializeWith: aCircularBoard with: aDieHandle withLaps: aNumberOfLaps with: aSequence andWith: cardDealer.
]

{ #category : #actions }
RedGame >> addPermanentEffect: aMove [
	cardDealer addPermanentEffect: aMove.
]

{ #category : #actions }
RedGame >> assertCorrespondentTurn: playerName [
	playerName = playerSequence currentPlayer
		ifFalse: [ self error: 'cant play on anothers turn' ]
]

{ #category : #actions }
RedGame >> assertIfGameHasEnded [
	self hasEnded
		ifTrue: [ self error: 'the game has ended' ]
]

{ #category : #actions }
RedGame >> assertIfItsPlaying: playerName [
	(playerSequence assertIfItsPlaying: playerName)
		ifFalse: [ self error: 'Cannot roll for a player that is not playing' ]
]

{ #category : #actions }
RedGame >> assertLastToRoll: playerName [
	playerName = lastToRoll 
		ifTrue: [ self error: 'can only roll the dice once on your turn' ]
]

{ #category : #actions }
RedGame >> breakFree: playerName [ 
	board breakFree: playerName .
]

{ #category : #queries }
RedGame >> currentPlayer [
	^ playerSequence currentPlayer.
]

{ #category : #actions }
RedGame >> finishTurn [
	^ playerSequence finishTurn.
]

{ #category : #queries }
RedGame >> hasEnded [
	^ board anyPlayerFinished: laps.
]

{ #category : #initialize }
RedGame >> initializeWith: aCircularBoard with: aDieHandle withLaps: aNumberOfLaps with: aSequenceOfPlayers andWith: aCardDealer [
	dieHandle := aDieHandle.
	board := aCircularBoard.
	laps := aNumberOfLaps.
	playerSequence := aSequenceOfPlayers.
	cardDealer := aCardDealer.
]

{ #category : #queries }
RedGame >> lapOf: playerName [
	^ board lapOf: playerName.
]

{ #category : #actions }
RedGame >> play: aMove [
	self assertIfGameHasEnded.
	cardDealer handle: aMove with: self.
]

{ #category : #queries }
RedGame >> positionOf: nameOfPlayer [
	^ board positionOf: nameOfPlayer.
]

{ #category : #queries }
RedGame >> rankingOf: name [
	^ board rankingOf: name.
]

{ #category : #actions }
RedGame >> removePermanentEffect: aMove [ 
	cardDealer removePermanentEffect: aMove.
]

{ #category : #actions }
RedGame >> rollDiceFor: playerName [
	| permanentCardsResult rollValue |
	self assertIfGameHasEnded.
	self assertIfItsPlaying: playerName.
	self assertCorrespondentTurn: playerName.
	self assertLastToRoll: playerName. 
	rollValue := dieHandle roll .
	board assertFreedom: playerName with: dieHandle and: rollValue .
	permanentCardsResult := cardDealer
		accumulatePermanentEffectsOn: playerName.
	board
		with: cardDealer
		move: playerName
		with: rollValue + permanentCardsResult.
	lastToRoll := playerName. 
]

{ #category : #actions }
RedGame >> useLastBoardEffectOn: playerName [
	board repeatLastEffectOn: playerName with: self.
]

{ #category : #actions }
RedGame >> useLastCardEffectWith: aMove [ 
	cardDealer useLastCardEffectWith: aMove andWith: self. 
]

{ #category : #queries }
RedGame >> winner [
	self hasEnded
		ifFalse: [ self error: 'the game is still running' ].
	^board winner.
]
