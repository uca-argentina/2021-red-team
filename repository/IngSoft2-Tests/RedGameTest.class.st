Class {
	#name : #RedGameTest,
	#superclass : #TestCase,
	#instVars : [
		'cardsDistribution'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
RedGameTest >> add: type times: n to: effectsDistribution [
	n timesRepeat: [ effectsDistribution add: type ]
]

{ #category : #tests }
RedGameTest >> createADieHandleWithALoadedDie [
	| aDieHandle dice die |
	die := LoadedDie with: 6.
	dice := Array with: die.
	aDieHandle := DieHandle with: dice.
	^ aDieHandle
]

{ #category : #tests }
RedGameTest >> effectsDistributionGenerator [
	| effectsDistribution |
	effectsDistribution := OrderedCollection new.
	self add: RegularCell new times: 38 to: effectsDistribution.
	self add: WormHoleCell new times: 20 to: effectsDistribution.
	self add: SpeedUpCell new times: 20 to: effectsDistribution.
	self add: CardCell new times: 10 to: effectsDistribution.
	self add: (MoonWalkCell with: 5) times: 10 to: effectsDistribution.
	self add: AtomicBombCell new times: 2 to: effectsDistribution.
	^ effectsDistribution
]

{ #category : #tests }
RedGameTest >> randomDeck [
	| deck |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: OverloadCard new;
		add: RedoCard new;
		add: AccelerationCard new;
		add: RepeatCard new.
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	^ deck
]

{ #category : #tests }
RedGameTest >> should: block raise: kindOfError withMessage: expectedMessage [
	self
		should: block
		raise: kindOfError
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedMessage ]
]

{ #category : #tests }
RedGameTest >> testACancellationMove [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move cards objectiveMove |
	cards := OrderedCollection new.
	cards	add: OverloadCard new;
			add: CancellationCard new;
			add: OverloadCard new;
			add: RepeatCard new.
	deck := LoadedDeck with: cards.
	
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		andWith: players.
	game rollDiceFor: 'martin'.
	move := TargetMove from: 'martin' with: OverloadCard new against: 'juan'.
	game play: move.
	game finishTurn.

	move := TargetMove from: 'juan' with: OverloadCard new against: 'martin'.
	game play: move.
	game rollDiceFor: 'juan'.
	game finishTurn.

	objectiveMove := TargetMove from: 'juan' with: OverloadCard new against: 'martin'.
	move := TargetMove from: 'martin' with: CancellationCard new against: objectiveMove.
	game play: move.
	game rollDiceFor: 'martin'.
	game finishTurn.
	
	game rollDiceFor: 'juan'.
	game finishTurn.

	self assert: (game positionOf: 'juan') equals: 8.
	self assert: (game positionOf: 'martin') equals: 12.
]

{ #category : #tests }
RedGameTest >> testACardCell [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: OverloadCard new;
		add: SpeedCard new;
		add: CancellationCard new;
		add: RedoCard new;
		add: RepeatCard new.
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 5 to: fifteenRegularCells.
	self add: CardCell new times: 1 to: fifteenRegularCells.
	self add: RegularCell new times: 9 to: fifteenRegularCells.
	
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		andWith: players.
		
	game rollDiceFor: 'martin'.
	game finishTurn.

	self assert: (game amountOfMoves) equals: 5.
]

{ #category : #tests }
RedGameTest >> testARedoMove [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move cards |
	cards := OrderedCollection new.
	cards	add: OverloadCard new;
			add: RedoCard new;
			add: SpeedCard new;
			add: RepeatCard new.
	deck := LoadedDeck with: cards.
	
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		andWith: players.
	game rollDiceFor: 'martin'.
	move := TargetMove from: 'martin' with: OverloadCard new against: 'juan'.
	game play: move.
	game finishTurn.

	move := TargetMove from: 'juan' with: SpeedCard new against: 'juan'.
	game play: move.
	game rollDiceFor: 'juan'.
	game finishTurn.

	move := TargetMove from: 'martin' with: RedoCard new against: 'martin'.
	game play: move.
	game rollDiceFor: 'martin'.
	game finishTurn.
	
	game rollDiceFor: 'juan'.
	game finishTurn.

	self assert: (game positionOf: 'juan') equals: 10.
	self assert: (game positionOf: 'martin') equals: 13.
]

{ #category : #tests }
RedGameTest >> testARepeatMove [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: RepeatCard new.
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 5 to: fifteenRegularCells.
	self add: SpeedUpCell new times: 1 to: fifteenRegularCells.
	self add: RegularCell new times: 9 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		andWith: players.
	game rollDiceFor: 'martin'.
	game finishTurn.
	move := TargetMove from: 'juan' with: RepeatCard new against: 'juan'.
	game play: move.
	game rollDiceFor: 'juan'.
	game finishTurn.

	self assert: (game positionOf: 'juan') equals: 10.
	self assert: (game positionOf: 'martin') equals: 10.
]

{ #category : #tests }
RedGameTest >> testASpeedMove [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: SpeedCard new.
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		andWith: players.
	game rollDiceFor: 'martin'.
	move := TargetMove from: 'martin' with: SpeedCard new against: 'martin'.
	game play: move.
	game finishTurn.
	game rollDiceFor: 'juan'.
	game finishTurn.
	game rollDiceFor: 'martin'.
	game finishTurn.
	game rollDiceFor: 'juan'.
	game finishTurn.
	self assert: (game positionOf: 'juan') equals: 12.
	self assert: (game positionOf: 'martin') equals: 13.
]

{ #category : #tests }
RedGameTest >> testAnAccelerationMove [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: AccelerationCard new.
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		andWith: players.
	game rollDiceFor: 'martin'.
	move := Move from: 'martin' with: AccelerationCard new.
	game play: move.
	game finishTurn.
	game rollDiceFor: 'juan'.
	game finishTurn.
	game rollDiceFor: 'martin'.
	game finishTurn.
	game rollDiceFor: 'juan'.
	game finishTurn.
	self assert: (game positionOf: 'juan') equals: 14.
	self assert: (game positionOf: 'martin') equals: 13.
]

{ #category : #tests }
RedGameTest >> testAnOverloadMove [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: OverloadCard new.
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		andWith: players.
	game rollDiceFor: 'martin'.
	move := TargetMove from: 'martin' with: OverloadCard new against: 'juan'.
	game play: move.
	game finishTurn.
	game rollDiceFor: 'juan'.
	game finishTurn.
	self assert: (game positionOf: 'juan') equals: 4.
]

{ #category : #tests }
RedGameTest >> testAskInWhichLapIsThePlayer [
	| aCircularBoard aDieHandle players aGame tenRegularCells deck |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	tenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 10 to: tenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: tenRegularCells.
	deck := self randomDeck.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 3
		andWith: players.
	4 timesRepeat: [ aGame playATurnWithoutMoves ].
	self assert: (aGame lapOf: 'martin') equals: 2.
	self assert: (aGame lapOf: 'juan') equals: 1.
	self assert: (aGame lapOf: 'roman') equals: 1
]

{ #category : #tests }
RedGameTest >> testAskPodiumOfPlayerAfterTheGameEnded [
	| aCircularBoard aDieHandle players aGame fifteenCells deck |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	fifteenCells := OrderedCollection new.
	self add: RegularCell new times: 10 to: fifteenCells.
	self add: WormHoleCell new times: 2 to: fifteenCells.
	self add: SpeedUpCell new times: 2 to: fifteenCells.
	self add: (MoonWalkCell with: 5) times: 1 to: fifteenCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenCells.
	deck := self randomDeck.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 2
		andWith: players.
	aGame playWithoutMoves.
	self assert: (aGame podiumOf: 'martin') equals: 1.
	self assert: (aGame podiumOf: 'juan') equals: 2.
	self assert: (aGame podiumOf: 'roman') equals: 3
]

{ #category : #tests }
RedGameTest >> testAskPodiumOfPlayerDuringTheGame [
	| aCircularBoard aDieHandle players aGame fifteenCells deck |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	fifteenCells := OrderedCollection new.
	self add: RegularCell new times: 10 to: fifteenCells.
	self add: WormHoleCell new times: 2 to: fifteenCells.
	self add: SpeedUpCell new times: 2 to: fifteenCells.
	self add: (MoonWalkCell with: 5) times: 1 to: fifteenCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenCells.
	deck := self randomDeck.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 2
		andWith: players.
	5 timesRepeat: [ aGame playATurnWithoutMoves ].
	self assert: (aGame podiumOf: 'martin') equals: 1.
	self assert: (aGame podiumOf: 'juan') equals: 2.
	self assert: (aGame podiumOf: 'roman') equals: 3
]

{ #category : #tests }
RedGameTest >> testCannotAskWhoWonBeforeTheGameEnded [
	| aCircularBoard aDieHandle players aGame fifteenRegularCells deck |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	deck := self randomDeck.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 2
		andWith: players.
	4 timesRepeat: [ aGame playATurnWithoutMoves ].
	self
		should: [ aGame whoWon ]
		raise: Error
		withMessage: 'the game is still running'
]

{ #category : #tests }
RedGameTest >> testCannotCreateABoardWithoutCells [
	| players cells |
	players := #('martin' 'juan' 'roman').
	cells := OrderedCollection new.
	self
		should: [ CircularBoard with: players andWithAll: cells ]
		raise: Error
		withMessage: 'cant create a board without cells'
]

{ #category : #tests }
RedGameTest >> testCannotCreateABoardWithoutPlayers [
	| players tenRegularCells |
	players := Array new.
	tenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 10 to: tenRegularCells.
	self
		should: [ CircularBoard with: players andWithAll: tenRegularCells ]
		raise: Error
		withMessage: 'cant create a board without players'
]

{ #category : #tests }
RedGameTest >> testCannotCreateADieHandleWithoutDice [
	| dice |
	dice := Array new.
	self
		should: [ DieHandle with: dice ]
		raise: Error
		withMessage: 'cannot create an empty die handle'
]

{ #category : #tests }
RedGameTest >> testCannotCreateADieWithLessThanFourFaces [
	self
		should: [ RandomDie with: 3 ]
		raise: Error
		withMessage: 'invalid number of faces'
]

{ #category : #tests }
RedGameTest >> testCannotCreateAGameWithInvalidNumberOfLaps [
	| aCircularBoard aDieHandle players fifteenCells deck |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	fifteenCells := OrderedCollection new.
	self add: RegularCell new times: 10 to: fifteenCells.
	self add: WormHoleCell new times: 2 to: fifteenCells.
	self add: SpeedUpCell new times: 2 to: fifteenCells.
	self add: (MoonWalkCell with: 5) times: 1 to: fifteenCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenCells.
	deck := self randomDeck.
	self
		should: [ RedGame
				with: aCircularBoard
				with: aDieHandle
				with: deck
				withLaps: 0
				andWith: players ]
		raise: Error
		withMessage: 'invalid number of laps'
]

{ #category : #tests }
RedGameTest >> testCannotCreateAGameWithoutPlayers [
	| aCircularBoard die dice aDieHandle players fifteenCells deck |
	die := LoadedDie with: 6.
	dice := Array with: die.
	aDieHandle := DieHandle with: dice.
	players := #('martin' 'juan' 'roman').
	fifteenCells := OrderedCollection new.
	self add: RegularCell new times: 10 to: fifteenCells.
	self add: WormHoleCell new times: 2 to: fifteenCells.
	self add: SpeedUpCell new times: 2 to: fifteenCells.
	self add: (MoonWalkCell with: 5) times: 1 to: fifteenCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenCells.
	deck := self randomDeck.
	players := #().
	self
		should: [ RedGame
				with: aCircularBoard
				with: aDieHandle
				with: deck
				withLaps: 2
				andWith: players ]
		raise: Error
		withMessage: 'cannot create a RedGame without players'
]

{ #category : #tests }
RedGameTest >> testCannotCreateAPositionWithoutName [
	self
		should: [ Position from: '' ]
		raise: Error
		withMessage: 'cant create a Position without a name'
]

{ #category : #tests }
RedGameTest >> testCannotCreateARandomSourceWithoutAPool [
	self
		should: [ RandomSource basedOn: OrderedCollection new ]
		raise: Error
		withMessage: 'cant create a RandomSource without a pool'
]

{ #category : #tests }
RedGameTest >> testCannotPlayAfterTheGameHasEnded [
	| aCircularBoard aDieHandle players aGame fifteenCells deck |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	fifteenCells := OrderedCollection new.
	self add: RegularCell new times: 10 to: fifteenCells.
	self add: WormHoleCell new times: 2 to: fifteenCells.
	self add: SpeedUpCell new times: 2 to: fifteenCells.
	self add: (MoonWalkCell with: 5) times: 1 to: fifteenCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenCells.
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: AccelerationCard new.
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 2
		andWith: players.
	aGame playWithoutMoves.
	self
		should: [ aGame playATurnWithoutMoves ]
		raise: Error
		withMessage: 'the game has ended'
]

{ #category : #tests }
RedGameTest >> testPlayAGameAndAskWhoWon [
	| aCircularBoard aDieHandle players aGame fifteenRegularCells deck |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 10 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	deck := self randomDeck.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 2
		andWith: players.
	aGame playWithoutMoves.
	self assert: aGame whoWon equals: 'martin'
]

{ #category : #tests }
RedGameTest >> testPlayAGameWithARandomBoardAndRandomDice [
	| aCircularBoard dice aDieHandle players aGame randomCells die1 die2 die3 effectsDistribution effectSource numberOfCells deck |
	die1 := RandomDie with: 10.
	die2 := RandomDie with: 8.
	die3 := RandomDie with: 6.
	dice := Array with: die1 with: die2 with: die3.
	aDieHandle := DieHandle with: dice.
	players := #('martin' 'juan' 'roman').
	numberOfCells := 50.
	effectsDistribution := self effectsDistributionGenerator.
	effectSource := RandomSource basedOn: effectsDistribution.
	randomCells := effectSource produce: numberOfCells.
	aCircularBoard := CircularBoard with: players andWithAll: randomCells.
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: AccelerationCard new.
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 3
		andWith: players.
	aGame playWithoutMoves.
	self assert: aGame hasEnded
]

{ #category : #tests }
RedGameTest >> testPlayAGameWithRegularCells [
	| aCircularBoard aDieHandle players aGame fifteenRegularCells deck |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	deck := self randomDeck.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 2
		andWith: players.
	aGame playWithoutMoves.
	self assert: aGame hasEnded
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnAMoonWalkCell [
	| aCircularBoard aDieHandle players aGame twelveCells deck |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	twelveCells := OrderedCollection new.
	self add: RegularCell new times: 11 to: twelveCells.
	self add: (MoonWalkCell with: 4) times: 1 to: twelveCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: twelveCells.
	deck := self randomDeck.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		andWith: players.
	aGame playATurnWithoutMoves;
			playATurnWithoutMoves;
			playATurnWithoutMoves;
			playATurnWithoutMoves.
	self assert: (aGame positionOf: 'martin') equals: 12.
	self assert: (aGame positionOf: 'juan') equals: 2.
	self assert: (aGame positionOf: 'roman') equals: 2.
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnARegularCell [
	| aCircularBoard aDieHandle players aGame tenRegularCells deck |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	tenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 10 to: tenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: tenRegularCells.
	deck := self randomDeck.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		andWith: players.
	aGame playATurnWithoutMoves.
	self assert: (aGame positionOf: 'martin') equals: 6
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnASpeedUpCell [
	| aCircularBoard aDieHandle players aGame sixCells deck |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	sixCells := OrderedCollection new.
	self add: RegularCell new times: 5 to: sixCells.
	self add: SpeedUpCell new times: 1 to: sixCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: sixCells.
	deck := self randomDeck.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 2
		andWith: players.
	aGame playATurnWithoutMoves.
	self assert: (aGame positionOf: 'martin') equals: 4
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnAWormHoleCell [
	| aCircularBoard aDieHandle players aGame sixCells deck |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	sixCells := OrderedCollection new.
	self add: RegularCell new times: 5 to: sixCells.
	self add: WormHoleCell new times: 1 to: sixCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: sixCells.
	deck := self randomDeck.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		andWith: players.
	aGame playATurnWithoutMoves.
	self assert: (aGame positionOf: 'martin') equals: 2
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnAnAtomicBombCell [
	| aCircularBoard aDieHandle players aGame twentyCells deck |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	twentyCells := OrderedCollection new.
	self add: RegularCell new times: 10 to: twentyCells.
	self add: AtomicBombCell new times: 10 to: twentyCells.
	aCircularBoard := CircularBoard with: players andWithAll: twentyCells.
	deck := self randomDeck.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		andWith: players.
	4 timesRepeat: [ aGame playATurnWithoutMoves ].
	self assert: (aGame positionOf: 'martin') equals: 1.
	self assert: (aGame positionOf: 'juan') equals: 1.
	self assert: (aGame positionOf: 'roman') equals: 1.
]

{ #category : #tests }
RedGameTest >> testRedoAnAccelerationMove [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move cards |
	cards := OrderedCollection new.
	cards	add: OverloadCard new;
			add: RedoCard new;
			add: AccelerationCard new;
			add: RepeatCard new.
	deck := LoadedDeck with: cards.
	
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		andWith: players.
	game rollDiceFor: 'martin'.
	move := TargetMove from: 'martin' with: OverloadCard new against: 'juan'.
	game play: move.
	game finishTurn.

	move := Move from: 'juan' with: AccelerationCard new.
	game play: move.
	game rollDiceFor: 'juan'.
	game finishTurn.

	move := Move from: 'martin' with: RedoCard new.
	game play: move.
	game rollDiceFor: 'martin'.
	game finishTurn.
	
	game rollDiceFor: 'juan'.
	game finishTurn.

	self assert: (game positionOf: 'juan') equals: 11.
	self assert: (game positionOf: 'martin') equals: 14.
]

{ #category : #tests }
RedGameTest >> testRollALoadedDie [
	| aDie |
	aDie := LoadedDie with: 8.
	self assert: aDie roll equals: 8
]

{ #category : #tests }
RedGameTest >> testRollARandomDie [
	| aDie |
	aDie := RandomDie with: 8.
	self assert: (aDie roll between: 1 and: 8)
]

{ #category : #tests }
RedGameTest >> testRollingADieHandleGivesTheSumOfItsDiceFaces [
	| aDieHandle die1 die2 die3 dice |
	die1 := LoadedDie with: 4.
	die2 := LoadedDie with: 8.
	die3 := LoadedDie with: 6.
	dice := Array with: die1 with: die2 with: die3.
	aDieHandle := DieHandle with: dice.
	self assert: aDieHandle roll equals: 18
]
