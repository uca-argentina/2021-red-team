Class {
	#name : #RedGame,
	#superclass : #Object,
	#instVars : [
		'dieHandle',
		'board',
		'laps',
		'playerSequence',
		'positionsBoard',
		'cardsHandler'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RedGame class >> with: aCircularBoard with: aDieHandle with: aDeck withLaps: aNumberOfLaps andWith: players [
	| aSequence aBoardOfPositions cardsHandler|
	players ifEmpty: [ self error: 'cannot create a RedGame without players' ].
	(aNumberOfLaps > 0) ifFalse: [ self error: 'invalid number of laps' ].
	aSequence := SequenceOfPlayers with: players.
	aBoardOfPositions := PositionsBoard with: players.
	cardsHandler := CardsHandler with: players andWith: aDeck.
	^ self new initializeWith: aCircularBoard with: aDieHandle withLaps: aNumberOfLaps with: aSequence with: cardsHandler andWith: aBoardOfPositions.
]

{ #category : #actions }
RedGame >> addToPermanentMoves: aMove [
	cardsHandler addToPermanentMoves: aMove.
]

{ #category : #queries }
RedGame >> amountOfMoves [
	^ cardsHandler amountOfMoves.
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
RedGame >> initializeWith: aCircularBoard with: aDieHandle withLaps: aNumberOfLaps with: aSequenceOfPlayers with: aCardsHandler andWith: aPositionsBoard [ 
	dieHandle := aDieHandle.
	board := aCircularBoard.
	laps := aNumberOfLaps.
	playerSequence := aSequenceOfPlayers.
	positionsBoard := aPositionsBoard.
	cardsHandler := aCardsHandler.
]

{ #category : #queries }
RedGame >> lapOf: playerName [
	^ board lapOf: playerName.
]

{ #category : #actions }
RedGame >> play: aMove [
	cardsHandler handle: aMove with: self.
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
	cardsHandler removePermanentMove: aMove.
]

{ #category : #actions }
RedGame >> rollDiceFor: playerName [
	| permanentCardsResult |
	(self hasEnded) ifTrue: [ self error: 'the game has ended' ].
	(playerName = playerSequence whosTurnIsIt) ifFalse: [ self error: 'cant play on anothers turn' ].
	permanentCardsResult := cardsHandler accumulatePermanentEffectsOn: playerName.
	board with: cardsHandler move: playerName with: (dieHandle roll + permanentCardsResult).
]

{ #category : #action }
RedGame >> useLastBoardEffectOn: playerName [
	board repeatLastEffectOn: playerName with: self.
]

{ #category : #actions }
RedGame >> useLastCardEffectWith: aMove [ 
	cardsHandler useLastCardEffectWith: aMove andWith: self. 
]

{ #category : #queries }
RedGame >> whoWon [
	(self hasEnded) ifFalse: [ self error: 'the game is still running' ].
	^board whoWon.
]

{ #category : #queries }
RedGame >> whosTurnIsIt [
	^ playerSequence whosTurnIsIt.
]
