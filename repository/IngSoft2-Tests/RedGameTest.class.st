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
RedGameTest >> dieHandleWithALoadedDieThatRollsSix [
	| aDieHandle dice die |
	die := LoadedDie with: 6.
	dice := Array with: die.
	aDieHandle := DieHandle with: dice.
	^ aDieHandle
]

{ #category : #tests }
RedGameTest >> effectsDistribution [
	| effectsDistribution |
	effectsDistribution := OrderedCollection new.
	effectsDistribution
		add: (DiscreteProbabilityEvent of: (RegularCell new) with: 0.38);
		add: (DiscreteProbabilityEvent of: (WormHoleCell new) with: 0.20);
		add: (DiscreteProbabilityEvent of: (SpeedUpCell new) with: 0.20);
		add: (DiscreteProbabilityEvent of: (CardCell new) with: 0.10);
		add: (DiscreteProbabilityEvent of: (MoonWalkCell with: 5) with: 0.10);
		add: (DiscreteProbabilityEvent of: (AtomicBombCell new) with: 0.02).
	^ effectsDistribution
]

{ #category : #tests }
RedGameTest >> playATurnWithoutMoves: game [
	| player |
	player := game currentPlayer.
	game rollDiceFor: player.
	game finishTurn.
]

{ #category : #actions }
RedGameTest >> playWithoutMoves: game [
	[ game hasEnded ] whileFalse: [ self playATurnWithoutMoves: game ].
]

{ #category : #tests }
RedGameTest >> randomBoardWith: players andWith: numberOfCells [
	| effectSource randomCells effectsDistribution aCircularBoard |
	effectsDistribution := self effectsDistribution.
	effectSource := RandomSource basedOn: effectsDistribution.
	randomCells := effectSource produce: numberOfCells.
	aCircularBoard := CircularBoard with: players andWithAll: randomCells.
	^ aCircularBoard
]

{ #category : #tests }
RedGameTest >> randomDeck [
	| deck  |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: (DiscreteProbabilityEvent of: (OverloadCard new) with: 0.17);
		add: (DiscreteProbabilityEvent of: (RedoCard  new) with: 0.17);
		add: (DiscreteProbabilityEvent of: (AccelerationCard  new) with: 0.17);
		add: (DiscreteProbabilityEvent of: (RepeatCard  new) with: 0.17);
		add: (DiscreteProbabilityEvent of: (CancellationCard new) with: 0.16);
		add: (DiscreteProbabilityEvent of: (SpeedCard  new) with: 0.16).
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
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move cards objectiveMove amountOfInitialCards|
	cards := OrderedCollection new.
	cards
		add: OverloadCard new;
		add: CancellationCard new;
		add: OverloadCard new;
		add: RepeatCard new.
	deck := LoadedDeck with: cards.
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	game rollDiceFor: 'martin'.
	move := TargetedMove
		with: (Move from: 'martin' with: OverloadCard new) against: 'juan'.
	game play: move.
	game finishTurn.
	move := TargetedMove
		with: (Move from: 'juan' with: OverloadCard new) against: 'martin'.
	game play: move.
	game rollDiceFor: 'juan'.
	game finishTurn.
	objectiveMove := TargetedMove
		with: (Move from: 'juan' with: OverloadCard new) against: 'martin'.
	move := TargetedMove
		with: (Move from: 'martin' with: CancellationCard new) against: objectiveMove .
	game play: move.
	game rollDiceFor: 'martin'.
	game finishTurn.
	game rollDiceFor: 'juan'.
	game finishTurn.
	self assert: (game positionOf: 'juan') equals: 8.
	self assert: (game positionOf: 'martin') equals: 12
]

{ #category : #tests }
RedGameTest >> testACardCell [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck amountOfInitialCards move |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: (DiscreteProbabilityEvent of: SpeedCard new with: 1).
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 5 to: fifteenRegularCells.
	self add: CardCell new times: 1 to: fifteenRegularCells.
	self add: RegularCell new times: 9 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 0.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	game rollDiceFor: 'martin'.
	game finishTurn.
	game rollDiceFor: 'juan'.
	game finishTurn.
	move := TargetedMove
		with: (Move from: 'martin' with: SpeedCard new) against: 'martin'.
	game play: move.
	game rollDiceFor: 'martin'.
	game finishTurn.
	self assert: (game positionOf: 'martin') equals: 13.
]

{ #category : #tests }
RedGameTest >> testARedoMove [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move cards amountOfInitialCards |
	cards := OrderedCollection new.
	cards
		add: OverloadCard new;
		add: RedoCard new;
		add: SpeedCard new;
		add: RepeatCard new.
	deck := LoadedDeck with: cards.
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	game rollDiceFor: 'martin'.
	move := TargetedMove
		with: (Move from: 'martin' with: OverloadCard  new) against: 'juan'.
	game play: move.
	game finishTurn.
	move := TargetedMove
		with: (Move from: 'juan' with: SpeedCard  new) against: 'juan'.
	game play: move.
	game rollDiceFor: 'juan'.
	game finishTurn.
	move := TargetedMove
		with: (Move from: 'martin' with: RedoCard new) against: 'martin'.
	game play: move.
	game rollDiceFor: 'martin'.
	game finishTurn.
	game rollDiceFor: 'juan'.
	game finishTurn.
	self assert: (game positionOf: 'juan') equals: 10.
	self assert: (game positionOf: 'martin') equals: 13
]

{ #category : #tests }
RedGameTest >> testARedoMoveAfterARedoMoveReusesTheSameCard [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move cards amountOfInitialCards |
	cards := OrderedCollection new.
	cards
		add: RedoCard new;
		add: OverloadCard new;
		add: SpeedCard new;
		add: RedoCard new.
	deck := LoadedDeck with: cards.
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	game rollDiceFor: 'martin'.
	game finishTurn.
	move := TargetedMove
		with: (Move from: 'juan' with: SpeedCard new) against: 'juan'.
	game play: move.
	game rollDiceFor: 'juan'.
	game finishTurn.
	move := TargetedMove
		with: (Move from: 'martin' with: RedoCard new) against: 'martin'.
	game play: move.
	game rollDiceFor: 'martin'.
	game finishTurn.
	move := TargetedMove
		with: (Move from: 'juan' with: RedoCard new) against: 'juan'.
	game play: move.
	game rollDiceFor: 'juan'.
	game finishTurn.
	self assert: (game positionOf: 'juan') equals: 15.
	self assert: (game positionOf: 'martin') equals: 13
]

{ #category : #tests }
RedGameTest >> testARepeatMove [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move amountOfInitialCards |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: (DiscreteProbabilityEvent of: RepeatCard new with: 1).
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 5 to: fifteenRegularCells.
	self add: SpeedUpCell new times: 1 to: fifteenRegularCells.
	self add: RegularCell new times: 9 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	game rollDiceFor: 'martin'.
	game finishTurn.
	move := TargetedMove with: (Move from: 'juan' with: RepeatCard new) against: 'juan'.
	game play: move.
	game rollDiceFor: 'juan'.
	game finishTurn.
	self assert: (game positionOf: 'juan') equals: 10.
	self assert: (game positionOf: 'martin') equals: 10
	
]

{ #category : #tests }
RedGameTest >> testASpeedMove [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move amountOfInitialCards |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: (DiscreteProbabilityEvent of: SpeedCard new with: 1).
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	game rollDiceFor: 'martin'.
	move := TargetedMove
		with: (Move from: 'martin' with: SpeedCard new) against: 'martin'.
	game play: move.
	game finishTurn.
	game rollDiceFor: 'juan'.
	game finishTurn.
	game rollDiceFor: 'martin'.
	game finishTurn.
	game rollDiceFor: 'juan'.
	game finishTurn.
	self assert: (game positionOf: 'juan') equals: 12.
	self assert: (game positionOf: 'martin') equals: 13
]

{ #category : #tests }
RedGameTest >> testAnAccelerationMove [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move amountOfInitialCards |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: (DiscreteProbabilityEvent of: AccelerationCard new with: 1).
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
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
	self assert: (game positionOf: 'martin') equals: 13
]

{ #category : #tests }
RedGameTest >> testAnOverloadMove [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move amountOfInitialCards |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: (DiscreteProbabilityEvent of: OverloadCard new with: 1).
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	game rollDiceFor: 'martin'.
	move := TargetedMove with: (Move from: 'martin' with: OverloadCard new) against: 'juan'.
	game play: move.
	game finishTurn.
	game rollDiceFor: 'juan'.
	game finishTurn.
	self assert: (game positionOf: 'juan') equals: 4
]

{ #category : #tests }
RedGameTest >> testAskInWhichLapIsThePlayer [
	| aCircularBoard aDieHandle players aGame tenRegularCells deck amountOfInitialCards |
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan' 'roman').
	tenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 10 to: tenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: tenRegularCells.
	deck := self randomDeck.
	amountOfInitialCards := 2.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 3
		with: players
		andWith: amountOfInitialCards.
	4 timesRepeat: [ self playATurnWithoutMoves: aGame ].
	self assert: (aGame lapOf: 'martin') equals: 2.
	self assert: (aGame lapOf: 'juan') equals: 1.
	self assert: (aGame lapOf: 'roman') equals: 1
]

{ #category : #tests }
RedGameTest >> testAskRankingOfPlayerAfterTheGameEnded [
	| aCircularBoard aDieHandle players aGame fifteenCells deck amountOfInitialCards |
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan' 'roman').
	fifteenCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenCells.
	deck := self randomDeck.
	amountOfInitialCards := 2.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 2
		with: players
		andWith: amountOfInitialCards.
	self playWithoutMoves: aGame.
	self assert: (aGame rankingOf: 'martin') equals: 1.
	self assert: (aGame rankingOf: 'juan') equals: 2.
	self assert: (aGame rankingOf: 'roman') equals: 3
]

{ #category : #tests }
RedGameTest >> testAskRankingOfPlayerDuringTheGame [
	| aCircularBoard aDieHandle players aGame fifteenCells deck amountOfInitialCards |
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan' 'roman').
	fifteenCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenCells.
	deck := self randomDeck.
	amountOfInitialCards := 2.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 2
		with: players
		andWith: amountOfInitialCards.
	4 timesRepeat: [ self playATurnWithoutMoves: aGame ].
	self assert: (aGame rankingOf: 'martin') equals: 1.
	self assert: (aGame rankingOf: 'juan') equals: 2.
	self assert: (aGame rankingOf: 'roman') equals: 3
]

{ #category : #tests }
RedGameTest >> testBreakeFreeByAFreedomCard [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck amountOfInitialCards die dice move |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: (DiscreteProbabilityEvent of: FreedomCard new with: 1).
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	die := HalfLoadedDie with: 6.
	dice := Array with: die.
	aDieHandle := DieHandle with: dice. 
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 2 to: fifteenRegularCells.
	self add: PrisionCell new times: 1 to: fifteenRegularCells.
	self add: RegularCell new times: 12 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	game rollDiceFor: 'martin'.
	game finishTurn.
	game rollDiceFor: 'juan'.
	game finishTurn.
	move := Move from: 'martin' with: FreedomCard new.
	game play: move.
	game rollDiceFor: 'martin'.
	game finishTurn.
	self assert: (game positionOf: 'martin') equals: 6.
]

{ #category : #tests }
RedGameTest >> testBreakeFreeByMaxRollValue [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck amountOfInitialCards |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: (DiscreteProbabilityEvent of: SpeedCard new with: 1).
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 5 to: fifteenRegularCells.
	self add: PrisionCell new times: 1 to: fifteenRegularCells.
	self add: RegularCell new times: 9 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 0.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	game rollDiceFor: 'martin'.
	game finishTurn.
	game rollDiceFor: 'juan'.
	game finishTurn.
	game rollDiceFor: 'martin'.
	game finishTurn.
	self assert: (game positionOf: 'martin') equals: 12.
]

{ #category : #tests }
RedGameTest >> testCannotAskARandomSourceToProduceAnInvalidNumberOfItems [
	| randomSource |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: (DiscreteProbabilityEvent of: AccelerationCard new with: 1).
	randomSource := RandomSource basedOn: cardsDistribution.
	self should: [ randomSource produce: -1 ] raise: Error withMessage: 'Cant produce an invalid number of items'.
]

{ #category : #tests }
RedGameTest >> testCannotAskPositionOfAnInvalidPlayer [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck amountOfInitialCards |
	deck := self randomDeck.
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	game rollDiceFor: 'martin'.
	self should: [game positionOf: 'Juan Roman Riquelme'] raise: Error withMessage: 'That player is not in the game'.
]

{ #category : #tests }
RedGameTest >> testCannotAskWhoWonBeforeTheGameEnded [
	| aCircularBoard aDieHandle players aGame fifteenRegularCells deck amountOfInitialCards |
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan' 'roman').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	deck := self randomDeck.
	amountOfInitialCards := 2.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 2
		with: players
		andWith: amountOfInitialCards.
	4 timesRepeat: [ self playATurnWithoutMoves: aGame ].
	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'the game is still running'
]

{ #category : #tests }
RedGameTest >> testCannotCancelACardIfNoPermanentCardsAreActive [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move amountOfInitialCards cards objectiveMove |
	cards := OrderedCollection new.
	cards
		add: SpeedCard new;
		add: RepeatCard new;
		add: OverloadCard new;
		add: CancellationCard new.
	deck := LoadedDeck with: cards.
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	game rollDiceFor: 'martin'.
	game finishTurn.
	game rollDiceFor: 'juan'.
	objectiveMove := TargetedMove with: (Move from: 'martin' with: OverloadCard new) against: 'juan'.
	move := TargetedMove with: (Move from: 'juan' with: CancellationCard new) against: objectiveMove .
	
	self
		should: [ game play: move ]
		raise: Error
		withMessage: 'there are no permanent cards'.
]

{ #category : #tests }
RedGameTest >> testCannotCancelACardThatHasntBeenPlayed [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move amountOfInitialCards cards objectiveMove |
	cards := OrderedCollection new.
	cards
		add: SpeedCard new;
		add: RepeatCard new;
		add: OverloadCard new;
		add: CancellationCard new.
	deck := LoadedDeck with: cards.
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	game rollDiceFor: 'martin'.
	move := TargetedMove
		with: (Move from: 'martin' with: SpeedCard new) against: 'martin'.
	game play: move.
	game finishTurn.
	game rollDiceFor: 'juan'.
	objectiveMove := TargetedMove
		with: (Move from: 'martin' with: OverloadCard new) against: 'juan'.
	move := TargetedMove
		with: (Move from: 'juan' with: CancellationCard new) against: objectiveMove .
	
	self
		should: [ game play: move ]
		raise: Error
		withMessage: 'Cant cancel a card that wasnt played'.
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
RedGameTest >> testCannotCreateADieWithLessThanThreeFaces [
	self
		should: [ RandomDie with: 2 ]
		raise: Error
		withMessage: 'invalid number of faces'
]

{ #category : #tests }
RedGameTest >> testCannotCreateADiscreteProbabilityEventWithAnInvalidProbability [
	self should: [DiscreteProbabilityEvent of: AccelerationCard new with: 2] raise: Error withMessage: 'Cant create a DiscreteProbabilityEvent with an invalid probabilty'.
	self should: [DiscreteProbabilityEvent of: AccelerationCard new with: -1] raise: Error withMessage: 'Cant create a DiscreteProbabilityEvent with an invalid probabilty'.
]

{ #category : #tests }
RedGameTest >> testCannotCreateAGameWithDiffetenPlayersThanBoard [
	| aCircularBoard aDieHandle fifteenCells deck amountOfInitialCards playersBoard playersGame |
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	playersBoard := #('martin' 'juan' 'roman').
	playersGame := #('mateo' 'juan' 'roman').
	fifteenCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenCells.
	aCircularBoard := CircularBoard
		with: playersBoard
		andWithAll: fifteenCells.
	deck := self randomDeck.
	amountOfInitialCards := -1.
	self
		should: [ RedGame
				with: aCircularBoard
				with: aDieHandle
				with: deck
				withLaps: 2
				with: playersGame
				andWith: amountOfInitialCards ]
		raise: Error
		withMessage: 'game and board must have the same players'
]

{ #category : #tests }
RedGameTest >> testCannotCreateAGameWithInvalidNumberOfInitialCards [
	| aCircularBoard aDieHandle players fifteenCells deck amountOfInitialCards |
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan' 'roman').
	fifteenCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenCells.
	deck := self randomDeck.
	amountOfInitialCards := -1.
	self
		should: [ RedGame
				with: aCircularBoard
				with: aDieHandle
				with: deck
				withLaps: 2
				with: players
				andWith: amountOfInitialCards ]
		raise: Error
		withMessage: 'invalid number of initial cards'
]

{ #category : #tests }
RedGameTest >> testCannotCreateAGameWithInvalidNumberOfLaps [
	| aCircularBoard aDieHandle players fifteenCells deck amountOfInitialCards |
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan' 'roman').
	fifteenCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenCells.
	deck := self randomDeck.
	amountOfInitialCards := 2.
	self
		should: [ RedGame
				with: aCircularBoard
				with: aDieHandle
				with: deck
				withLaps: 0
				with: players
				andWith: amountOfInitialCards ]
		raise: Error
		withMessage: 'invalid number of laps'
]

{ #category : #tests }
RedGameTest >> testCannotCreateAGameWithoutPlayers [
	| aCircularBoard die dice aDieHandle players fifteenCells deck amountOfInitialCards |
	die := LoadedDie with: 6.
	dice := Array with: die.
	aDieHandle := DieHandle with: dice.
	players := #('martin' 'juan' 'roman').
	fifteenCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenCells.
	deck := self randomDeck.
	players := #().
	amountOfInitialCards := 2.
	self
		should: [ RedGame
				with: aCircularBoard
				with: aDieHandle
				with: deck
				withLaps: 2
				with: players
				andWith: amountOfInitialCards ]
		raise: Error
		withMessage: 'cannot create a RedGame without players'
]

{ #category : #tests }
RedGameTest >> testCannotCreateALoadedDeckWithoutCards [
	self should: [LoadedDeck with: OrderedCollection new] raise: Error withMessage: 'Cannot create a LoadedDeck without cards'.
]

{ #category : #tests }
RedGameTest >> testCannotCreateAPositionWithoutName [
	self
		should: [ Position from: '' ]
		raise: Error
		withMessage: 'cant create a Position without a name'
]

{ #category : #tests }
RedGameTest >> testCannotCreateARandomSourceWithEventsProbabilitiesWhichDontSum1 [
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: (DiscreteProbabilityEvent of: RepeatCard new with: 0.6);
		add: (DiscreteProbabilityEvent of: AccelerationCard new with: 0.6).
	self should: [Deck with: (RandomSource basedOn: cardsDistribution)] raise: Error withMessage: 'The sum of all events probabilities must sum 1'.
	
]

{ #category : #tests }
RedGameTest >> testCannotCreateARandomSourceWithoutAEventsDistribution [
	self
		should: [ RandomSource basedOn: OrderedCollection new ]
		raise: Error
		withMessage: 'cant create a RandomSource without a events distribution'.
]

{ #category : #tests }
RedGameTest >> testCannotPlayACardYouDontHave [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move amountOfInitialCards |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: (DiscreteProbabilityEvent of: OverloadCard new with: 1).
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	move := Move
		from: 'martin'
		with: AccelerationCard new.
	self
		should: [ game play: move ]
		raise: Error
		withMessage: 'cant use a card thats not yours'
]

{ #category : #tests }
RedGameTest >> testCannotPlayAMoveWithTargetedCard [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck amountOfInitialCards move |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: (DiscreteProbabilityEvent of: OverloadCard new with: 1).
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	game rollDiceFor: 'martin'.
	move := Move from: 'martin' with: OverloadCard new .
	self
		should: [ game play: move]
		raise: Error
		withMessage: 'OverloadCard must be played on a Targeted Move'
]

{ #category : #tests }
RedGameTest >> testCannotPlayAPermanentCardWhenItsNotYourTurn [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move amountOfInitialCards |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: (DiscreteProbabilityEvent of: OverloadCard new with: 1).
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	move := TargetedMove with: (Move from: 'juan' with: OverloadCard new) against: 'martin'.
	self
		should: [ game play: move ]
		raise: Error
		withMessage: 'cant use a permanent card on anothers turn'
]

{ #category : #tests }
RedGameTest >> testCannotPlayARedoMoveWithoutAnyPreviewsMoves [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move amountOfInitialCards |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: (DiscreteProbabilityEvent of: RedoCard new with: 1).
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	move := TargetedMove with: (Move from: 'martin' with: RedoCard new) against: 'martin'.
	self
		should: [ game play: move ]
		raise: Error
		withMessage: 'Cant use a Redo Card without previews moves'
]

{ #category : #tests }
RedGameTest >> testCannotPlayATargetMoveWithAnAccelerationCard [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck amountOfInitialCards |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: (DiscreteProbabilityEvent of: AccelerationCard new with: 1).
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	game rollDiceFor: 'martin'.
	self
		should: [ TargetedMove with: (Move from: 'martin' with: AccelerationCard new) against: 'martin'.]
		raise: Error
		withMessage: 'Cant create a Target Move with an AccelerationCard'
]

{ #category : #tests }
RedGameTest >> testCannotPlayAfterTheGameHasEnded [
	| aCircularBoard aDieHandle players aGame fifteenCells deck amountOfInitialCards |
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan' 'roman').
	fifteenCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenCells.
	cardsDistribution := OrderedCollection new.
	deck := self randomDeck.
	amountOfInitialCards := 2.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 2
		with: players
		andWith: amountOfInitialCards.
	self playWithoutMoves: aGame.
	self
		should: [ self playATurnWithoutMoves: aGame ]
		raise: Error
		withMessage: 'the game has ended'
]

{ #category : #tests }
RedGameTest >> testCannotRollDiceForAnInvalidPlayer [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck amountOfInitialCards |
	deck := self randomDeck.
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	self should: [game rollDiceFor: 'Juan Roman Riquelme'] raise: Error withMessage: 'Cannot roll for a player that is not playing'.
]

{ #category : #tests }
RedGameTest >> testCannotRollTheDiceTwiceOnTheSameTurn [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck amountOfInitialCards |
	deck := self randomDeck.
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	game rollDiceFor: 'martin'.
	self should: [game rollDiceFor: 'martin'] raise: Error withMessage: 'can only roll the dice once on your turn'.
]

{ #category : #tests }
RedGameTest >> testCannotUseACardAfterTheGameHasEnded [
	| aCircularBoard aDieHandle players aGame fifteenCells deck move amountOfInitialCards |
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan' 'roman').
	fifteenCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenCells.
	cardsDistribution := OrderedCollection new.
	deck := self randomDeck.
	amountOfInitialCards := 2.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 2
		with: players
		andWith: amountOfInitialCards .
	self playWithoutMoves: aGame.
	move := Move from: 'martin' with: AccelerationCard new.
	self
		should: [ aGame play: move ]
		raise: Error
		withMessage: 'the game has ended'
]

{ #category : #tests }
RedGameTest >> testGoBackwardsIfAccumulatedEffectsGiveANegativeResult [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move amountOfInitialCards die dice |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: (DiscreteProbabilityEvent of: OverloadCard new with: 1).
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	die := LoadedDie with: 3.
	dice := Array with: die.
	aDieHandle := DieHandle with: dice.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	game rollDiceFor: 'martin'.
	game finishTurn.
	game rollDiceFor: 'juan'.
	game finishTurn.
	game rollDiceFor: 'martin'.
	move := TargetedMove
		with: (Move from: 'martin' with: OverloadCard new) against: 'juan'.
	game play: move.
	game finishTurn.
	move := TargetedMove
		with: (Move from: 'juan' with: OverloadCard new) against: 'juan'.
	game play: move.
	game rollDiceFor: 'juan'.
	game finishTurn.
	self assert: (game positionOf: 'juan') equals: 2
]

{ #category : #tests }
RedGameTest >> testLandOnAPrisionCell [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck amountOfInitialCards die dice |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: (DiscreteProbabilityEvent of: SpeedCard new with: 1).
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	die := HalfLoadedDie with: 6.
	dice := Array with: die.
	aDieHandle := DieHandle with: dice. 
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 5 to: fifteenRegularCells.
	self add: PrisionCell new times: 1 to: fifteenRegularCells.
	self add: RegularCell new times: 9 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 0.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	game rollDiceFor: 'martin'.
	game finishTurn.
	game rollDiceFor: 'juan'.
	game finishTurn.
	game rollDiceFor: 'martin'.
	game finishTurn.
	self assert: (game positionOf: 'martin') equals: 6.
]

{ #category : #tests }
RedGameTest >> testPlayAGameAndAskWhoWon [
	| aCircularBoard aDieHandle players aGame fifteenRegularCells deck amountOfInitialCards |
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan' 'roman').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	deck := self randomDeck.
	amountOfInitialCards := 2.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 2
		with: players
		andWith: amountOfInitialCards .
	self playWithoutMoves: aGame.
	self assert: aGame winner equals: 'martin'
]

{ #category : #tests }
RedGameTest >> testPlayAGameWithARandomBoardAndRandomDice [
	| aCircularBoard dice aDieHandle players aGame die1 die2 die3 numberOfCells deck amountOfInitialCards |
	die1 := RandomDie with: 10.
	die2 := RandomDie with: 8.
	die3 := RandomDie with: 6.
	dice := Array with: die1 with: die2 with: die3.
	aDieHandle := DieHandle with: dice.
	players := #('martin' 'juan' 'roman').
	numberOfCells := 50.
	aCircularBoard := self
		randomBoardWith: players
		andWith: numberOfCells.
	deck := self randomDeck.
	amountOfInitialCards := 2.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 3
		with: players
		andWith: amountOfInitialCards .
	self playWithoutMoves: aGame.
	self assert: aGame hasEnded
]

{ #category : #tests }
RedGameTest >> testPlayAGameWithRegularCells [
	| aCircularBoard aDieHandle players aGame fifteenRegularCells deck amountOfInitialCards |
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan' 'roman').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	deck := self randomDeck.
	amountOfInitialCards := 2.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 2
		with: players
		andWith: amountOfInitialCards.
	self playWithoutMoves: aGame.
	self assert: aGame hasEnded
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnAMoonWalkCell [
	| aCircularBoard aDieHandle players aGame twelveCells deck amountOfInitialCards |
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan' 'roman').
	twelveCells := OrderedCollection new.
	self add: RegularCell new times: 11 to: twelveCells.
	self add: (MoonWalkCell with: 4) times: 1 to: twelveCells.
	aCircularBoard := CircularBoard with: players andWithAll: twelveCells.
	deck := self randomDeck.
	amountOfInitialCards := 2.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards .
	4 timesRepeat: [ self playATurnWithoutMoves: aGame ].
	self assert: (aGame positionOf: 'martin') equals: 12.
	self assert: (aGame positionOf: 'juan') equals: 2.
	self assert: (aGame positionOf: 'roman') equals: 2
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnARegularCell [
	| aCircularBoard aDieHandle players aGame tenRegularCells deck amountOfInitialCards |
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan' 'roman').
	tenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 10 to: tenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: tenRegularCells.
	deck := self randomDeck.
	amountOfInitialCards := 2.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards .
	self playATurnWithoutMoves: aGame.
	self assert: (aGame positionOf: 'martin') equals: 6
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnASpeedUpCell [
	| aCircularBoard aDieHandle players aGame sixCells deck amountOfInitialCards |
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan' 'roman').
	sixCells := OrderedCollection new.
	self add: RegularCell new times: 5 to: sixCells.
	self add: SpeedUpCell new times: 1 to: sixCells.
	aCircularBoard := CircularBoard with: players andWithAll: sixCells.
	deck := self randomDeck.
	amountOfInitialCards := 2.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 2
		with: players
		andWith: amountOfInitialCards.
	self playATurnWithoutMoves: aGame.
	self assert: (aGame positionOf: 'martin') equals: 4
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnAWormHoleCell [
	| aCircularBoard aDieHandle players aGame sixCells deck amountOfInitialCards |
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan' 'roman').
	sixCells := OrderedCollection new.
	self add: RegularCell new times: 5 to: sixCells.
	self add: WormHoleCell new times: 1 to: sixCells.
	aCircularBoard := CircularBoard with: players andWithAll: sixCells.
	deck := self randomDeck.
	amountOfInitialCards := 2.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards .
	self playATurnWithoutMoves: aGame.
	self assert: (aGame positionOf: 'martin') equals: 2
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnAnAtomicBombCell [
	| aCircularBoard aDieHandle players aGame twelveCells deck amountOfInitialCards |
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan' 'roman').
	twelveCells := OrderedCollection new.
	self add: RegularCell new times: 11 to: twelveCells.
	self add: AtomicBombCell new times: 1 to: twelveCells.
	aCircularBoard := CircularBoard with: players andWithAll: twelveCells.
	deck := self randomDeck.
	amountOfInitialCards := 2.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	4 timesRepeat: [ self playATurnWithoutMoves: aGame ].
	self assert: (aGame positionOf: 'martin') equals: 1.
	self assert: (aGame positionOf: 'juan') equals: 1.
	self assert: (aGame positionOf: 'roman') equals: 1
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnAnAtomicBombCellAndStayOnCurrentLap [
	| aCircularBoard aDieHandle players aGame tenCells deck amountOfInitialCards |
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan' 'roman').
	tenCells := OrderedCollection new.
	self add: RegularCell new times: 1 to: tenCells.
	self add: AtomicBombCell new times: 1 to: tenCells.
	self add: RegularCell new times: 8 to: tenCells.
	aCircularBoard := CircularBoard with: players andWithAll: tenCells.
	deck := self randomDeck.
	amountOfInitialCards := 2.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 2
		with: players
		andWith: amountOfInitialCards.
	4 timesRepeat: [ self playATurnWithoutMoves: aGame ].
	self assert: (aGame positionOf: 'martin') equals: 1.
	self assert: (aGame lapOf: 'martin') equals: 2.
	self assert: (aGame positionOf: 'juan') equals: 1.
	self assert: (aGame lapOf: 'juan') equals: 1.
	self assert: (aGame positionOf: 'roman') equals: 1.
	self assert: (aGame lapOf: 'roman') equals: 1
]

{ #category : #tests }
RedGameTest >> testPlayAnInstantCardWhenItsNotYourTurn [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move amountOfInitialCards |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: (DiscreteProbabilityEvent of: RepeatCard new with: 1).
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 5 to: fifteenRegularCells.
	self add: SpeedUpCell new times: 1 to: fifteenRegularCells.
	self add: RegularCell new times: 9 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards.
	game rollDiceFor: 'martin'.
	move := TargetedMove
		with: (Move from: 'juan' with: RepeatCard new) against: 'juan'.
	game play: move.
	game finishTurn.

	self assert: (game positionOf: 'juan') equals: 4.
	self assert: (game positionOf: 'martin') equals: 10.
]

{ #category : #tests }
RedGameTest >> testPlayingARepeatCardHasNoEffectIfAnyoneRollsTheDice [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move amountOfInitialCards |
	cardsDistribution := OrderedCollection new.
	cardsDistribution
		add: (DiscreteProbabilityEvent of: RepeatCard new with: 1).
	deck := Deck with: (RandomSource basedOn: cardsDistribution).
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards .
	move := TargetedMove
		with: (Move from: 'juan' with: RepeatCard new) against: 'juan'.
	game play: move.
	self assert: (game positionOf: 'juan') equals: 0
]

{ #category : #tests }
RedGameTest >> testRedoAnAccelerationMove [
	| aDieHandle players fifteenRegularCells aCircularBoard game deck move cards amountOfInitialCards |
	cards := OrderedCollection new.
	cards
		add: AccelerationCard new;
		add: RedoCard new;
		add: AccelerationCard new;
		add: AccelerationCard new.
	deck := LoadedDeck with: cards.
	aDieHandle := self dieHandleWithALoadedDieThatRollsSix.
	players := #('martin' 'juan').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	amountOfInitialCards := 2.
	game := RedGame
		with: aCircularBoard
		with: aDieHandle
		with: deck
		withLaps: 1
		with: players
		andWith: amountOfInitialCards .
	game rollDiceFor: 'martin'.
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
	self assert: (game positionOf: 'martin') equals: 14.
	self assert: (game positionOf: 'juan') equals: 15
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
