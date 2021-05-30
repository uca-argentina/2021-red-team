Class {
	#name : #RedGame,
	#superclass : #Object,
	#instVars : [
		'dieHandle',
		'board',
		'laps',
		'playerSequence',
		'boardOfPositions',
		'permanentCards'
	],
	#category : #'IngSoft2-Model'
}

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
	^ permanentCards ifEmpty: [ 0 ] ifNotEmpty: [permanentCards sum: [ :card | card effectOn: player]].
]

{ #category : #actions }
RedGame >> addToPermanentCards: permanentCard [
	permanentCards add: permanentCard. 
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
RedGame >> initializeWith: aCircularBoard with: aDieHandle withLaps: aNumberOfLaps with: aSequenceOfPlayers andWith: aBoardOfPositions [ 
	dieHandle := aDieHandle.
	board := aCircularBoard.
	laps := aNumberOfLaps.
	playerSequence := aSequenceOfPlayers.
	boardOfPositions := aBoardOfPositions.
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
RedGame >> rollDice [
	^ dieHandle roll.
]

{ #category : #actions }
RedGame >> rollDiceFor: player [ 
	"(self hasEnded) ifTrue: [ self error: 'the game has ended' ]."
	| playerName permanentCardsResult |
	playerName := player name.
	(playerName = playerSequence whosTurnIsIt) ifFalse: [ self error: 'cant play on anothers turn' ].
	permanentCardsResult := self accumulatePermanentEffectsOn: playerName.
	board move: playerName with: (self rollDice + permanentCardsResult).
	^ player.
]

{ #category : #actions }
RedGame >> use: card from: player [
	( player hasCard: card ) ifFalse: [ self error: 'cant use a card thats not yours' ].
	card from: player name activateEffect: self.
	player removeCard: card.
	^ player.
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
