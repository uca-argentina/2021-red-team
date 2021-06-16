Class {
	#name : #RedGame,
	#superclass : #Object,
	#instVars : [
		'dieHandle',
		'board',
		'laps',
		'playerSequence',
		'cardDealer'
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
RedGame >> addToPermanentMoves: aMove [
	cardDealer addToPermanentMoves: aMove.
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
	self verifyIfGameHasEnded.
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
RedGame >> removePermanentMove: aMove [ 
	cardDealer removePermanentMove: aMove.
]

{ #category : #actions }
RedGame >> rollDiceFor: playerName [
	| permanentCardsResult |
	self verifyIfGameHasEnded.
	self verifyIfItsPlaying: playerName.
	self verifyCorrespondentTurn: playerName.
	permanentCardsResult := cardDealer
		accumulatePermanentEffectsOn: playerName.
	board
		with: cardDealer
		move: playerName
		with: dieHandle roll + permanentCardsResult
]

{ #category : #actions }
RedGame >> useLastBoardEffectOn: playerName [
	board repeatLastEffectOn: playerName with: self.
]

{ #category : #actions }
RedGame >> useLastCardEffectWith: aMove [ 
	cardDealer useLastCardEffectWith: aMove andWith: self. 
]

{ #category : #actions }
RedGame >> verifyCorrespondentTurn: playerName [
	playerName = playerSequence whosTurnIsIt
		ifFalse: [ self error: 'cant play on anothers turn' ]
]

{ #category : #actions }
RedGame >> verifyIfGameHasEnded [
	self hasEnded
		ifTrue: [ self error: 'the game has ended' ]
]

{ #category : #actions }
RedGame >> verifyIfItsPlaying: playerName [
	(playerSequence verifyIfItsPlaying: playerName)
		ifFalse: [ self error: 'Cannot roll for a player that is not playing' ]
]

{ #category : #queries }
RedGame >> whoWon [
	self hasEnded
		ifFalse: [ self error: 'the game is still running' ].
	^board whoWon.
]

{ #category : #queries }
RedGame >> whosTurnIsIt [
	^ playerSequence whosTurnIsIt.
]
