Class {
	#name : #RedGame,
	#superclass : #Object,
	#instVars : [
		'dieHandle',
		'board',
		'laps',
		'playerSequence',
		'permanentCards',
		'lastCard',
		'deck',
		'moves',
		'positionsBoard',
		'lastMove',
		'permanentMoves'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RedGame class >> with: aCircularBoard with: aDieHandle with: aDeck withLaps: aNumberOfLaps andWith: players [
	| aSequence aBoardOfPositions auxMoves |
	players ifEmpty: [ self error: 'cannot create a RedGame without players' ].
	(aNumberOfLaps > 0) ifFalse: [ self error: 'invalid number of laps' ].
	aSequence := SequenceOfPlayers with: players.
	aBoardOfPositions := PositionsBoard with: players.
	auxMoves := OrderedCollection new.
	players do: [ :playerName | 2 timesRepeat: [auxMoves add: (Move from: playerName with: (aDeck takeACard))]].
	^ self new initializeWith: aCircularBoard with: aDieHandle with: aDeck withLaps: aNumberOfLaps with: aSequence with: auxMoves andWith: aBoardOfPositions.
]

{ #category : #'instance creation' }
RedGame class >> with: aCircularBoard with: aDieHandle withLaps: aNumberOfLaps andWith: players [
	| aSequence aBoardOfPositions |
	players ifEmpty: [ self error: 'cannot create a RedGame without players' ].
	(aNumberOfLaps > 0) ifFalse: [ self error: 'invalid number of laps' ].
	aSequence := SequenceOfPlayers with: players.
	aBoardOfPositions := PositionsBoard with: players.
	^ self new initializeWith: aCircularBoard with: aDieHandle withLaps: aNumberOfLaps with: aSequence andWith: aBoardOfPositions.
]

{ #category : #actions }
RedGame >> accumulatePermanentEffectsOn: player [
	^ permanentMoves ifEmpty: [ 0 ] ifNotEmpty: [permanentMoves sum: [ :move | move effectOn: player]].
]

{ #category : #actions }
RedGame >> addMoveTo: aPlayerName [
	moves add: (Move from: aPlayerName with: deck takeACard).
]

{ #category : #actions }
RedGame >> addToPermanentCards: permanentCard [
	permanentCards add: permanentCard copy. 
]

{ #category : #actions }
RedGame >> addToPermanentMoves: aMove [
	permanentMoves add: aMove copy.
]

{ #category : #queries }
RedGame >> amountOfMoves [
	^ moves size.
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
RedGame >> initializeWith: aCircularBoard with: aDieHandle with: aDeck withLaps: aNumberOfLaps with: aSequenceOfPlayers andWith: aBoardOfPositions [ 
	dieHandle := aDieHandle.
	board := aCircularBoard.
	deck := aDeck.
	laps := aNumberOfLaps.
	playerSequence := aSequenceOfPlayers.
	positionsBoard := aBoardOfPositions.
	permanentCards := OrderedCollection new.
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
	moves := auxMoves.
]

{ #category : #initialize }
RedGame >> initializeWith: aCircularBoard with: aDieHandle withLaps: aNumberOfLaps with: aSequenceOfPlayers andWith: aBoardOfPositions [ 
	dieHandle := aDieHandle.
	board := aCircularBoard.
	laps := aNumberOfLaps.
	playerSequence := aSequenceOfPlayers.
	positionsBoard := aBoardOfPositions.
	permanentCards := OrderedCollection new.
]

{ #category : #queries }
RedGame >> lapOf: playerName [
	^ board lapOf: playerName.
]

{ #category : #queries }
RedGame >> numberOfPermanentCards [
	^ permanentCards size.
]

{ #category : #actions }
RedGame >> play [
	[ self hasEnded ] whileFalse: [ self playATurn ].
]

{ #category : #actions }
RedGame >> play: aMove [
	moves
		detect: [:move | (move source = aMove source) and: [(move card) class = (aMove card) class]]
		ifFound: [ :move | moves remove: move ]
		ifNone: [ self error: 'cant use a card thats not yours' ].
	aMove activateEffect: self.
	lastMove := aMove copy.
]

{ #category : #actions }
RedGame >> playATurn [
	| player |
	(self hasEnded) ifTrue: [ self error: 'the game has ended' ].
	player := playerSequence whosNextBanana.
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
RedGame >> removePermanentCard: card [ 
	permanentCards ifEmpty: [ self error: 'there are no permanent cards' ].
	permanentCards := permanentCards reject: [ :aCard | aCard equalsCard: card ].
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

{ #category : #actions }
RedGame >> use: card from: player [
	( player hasCard: card ) ifFalse: [ self error: 'cant use a card thats not yours' ].
	card from: player activateEffect: self.
	lastCard := card copy.
	player removeCard: card.
	^ player.
]

{ #category : #action }
RedGame >> useLastBoardEffectOn: playerName [
	board repeatLastEffectOn: playerName .
]

{ #category : #actions }
RedGame >> useLastCardEffectOn: objetive from: player [
	| card auxCard |
	auxCard := lastCard copy.
	player addCard: auxCard.
	(auxCard className = 'AccelerationCard') 
	ifTrue: [card := player getCard: auxCard]
	ifFalse: [player set: objetive asTargetOf: auxCard className.
				card := player getCard: auxCard className withTarget: objetive.] .
	
	self use: card from: player.
	
]

{ #category : #actions }
RedGame >> useLastCardEffectWith: aMove [ 
	| newCard newMove |
	lastMove ifNil: [ self error: 'Cant use a Redo Card without previews moves' ].
	newCard := lastMove card copy.
	newMove := aMove changeCard: newCard.
	moves add: newMove.
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
