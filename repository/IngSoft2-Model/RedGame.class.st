Class {
	#name : #RedGame,
	#superclass : #Object,
	#instVars : [
		'dieHandle',
		'board',
		'laps',
		'playerSequence',
		'deck',
		'positionsBoard',
		'lastMove',
		'permanentMoves',
		'assignatedCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RedGame class >> with: aCircularBoard with: aDieHandle with: aDeck withLaps: aNumberOfLaps andWith: players [
	| aSequence aBoardOfPositions auxCards |
	players ifEmpty: [ self error: 'cannot create a RedGame without players' ].
	(aNumberOfLaps > 0) ifFalse: [ self error: 'invalid number of laps' ].
	aSequence := SequenceOfPlayers with: players.
	aBoardOfPositions := PositionsBoard with: players.
	auxCards := OrderedCollection new.
	players do: [ :playerName | 2 timesRepeat: [auxCards add: (AssignatedCard from: playerName with: (aDeck takeACard))]].
	^ self new initializeWith: aCircularBoard with: aDieHandle with: aDeck withLaps: aNumberOfLaps with: aSequence with: auxCards andWith: aBoardOfPositions.
]

{ #category : #actions }
RedGame >> accumulatePermanentEffectsOn: player [
	^ permanentMoves ifEmpty: [ 0 ] ifNotEmpty: [permanentMoves sum: [ :move | move effectOn: player]].
]

{ #category : #actions }
RedGame >> addCardTo: aPlayerName [
	assignatedCards add: (AssignatedCard from: aPlayerName with: deck takeACard).
]

{ #category : #actions }
RedGame >> addToPermanentMoves: aMove [
	permanentMoves add: aMove copy.
]

{ #category : #queries }
RedGame >> amountOfMoves [
	^ assignatedCards size.
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
RedGame >> initializeWith: aCircularBoard with: aDieHandle with: aDeck withLaps: aNumberOfLaps with: aSequenceOfPlayers with: auxMoves andWith: aPositionsBoard [ 
	dieHandle := aDieHandle.
	board := aCircularBoard.
	deck := aDeck.
	laps := aNumberOfLaps.
	playerSequence := aSequenceOfPlayers.
	positionsBoard := aPositionsBoard.
	permanentMoves := OrderedCollection new.
	assignatedCards := auxMoves.
]

{ #category : #queries }
RedGame >> lapOf: playerName [
	^ board lapOf: playerName.
]

{ #category : #actions }
RedGame >> play: aMove [
	assignatedCards
		detect: [ :assignatedCard | assignatedCard player = aMove source and: [ assignatedCard card equals: aMove card ] ]
		ifFound: [ :assignatedCard | assignatedCards remove: assignatedCard ]
		ifNone: [ self error: 'cant use a card thats not yours' ].
	aMove activateEffect: self.
	(aMove card equals: RedoCard new)
		ifFalse: [ lastMove := aMove copy ]
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
	permanentMoves ifEmpty: [ self error: 'there are no permanent cards' ].
	permanentMoves := permanentMoves reject: [ :move | move equalsMove: aMove ].
]

{ #category : #actions }
RedGame >> rollDice [
	^ dieHandle roll.
]

{ #category : #actions }
RedGame >> rollDiceFor: playerName [
	"(self hasEnded) ifTrue: [ self error: 'the game has ended' ]."
	| permanentCardsResult |
	(playerName = playerSequence whosTurnIsIt) ifFalse: [ self error: 'cant play on anothers turn' ].
	permanentCardsResult := self accumulatePermanentEffectsOn: playerName.
	board with: self move: playerName with: (self rollDice + permanentCardsResult).
]

{ #category : #action }
RedGame >> useLastBoardEffectOn: playerName [
	board repeatLastEffectOn: playerName with: self.
]

{ #category : #actions }
RedGame >> useLastCardEffectWith: aMove [ 
	| newCard newMove |
	lastMove ifNil: [ self error: 'Cant use a Redo Card without previews moves' ].
	newCard := lastMove card copy.
	newMove := aMove changeCard: newCard.
	assignatedCards add: (AssignatedCard from: newMove source with: newMove card).
	self play: newMove.
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
