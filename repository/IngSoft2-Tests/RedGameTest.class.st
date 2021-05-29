Class {
	#name : #RedGameTest,
	#superclass : #TestCase,
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
	self add: RegularCell new times: 48 to: effectsDistribution.
	self add: WormHoleCell new times: 20 to: effectsDistribution.
	self add: SpeedUpCell new times: 20 to: effectsDistribution.
	self add: (MoonWalkCell with: 5) times: 10 to: effectsDistribution.
	self add: AtomicBombCell new times: 2 to: effectsDistribution.
	^ effectsDistribution
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
RedGameTest >> testAskInWhichLapIsThePlayer [
	| aCircularBoard aDieHandle players aGame tenRegularCells |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	tenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 10 to: tenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: tenRegularCells.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		withLaps: 3
		andWith: players.
	4 timesRepeat: [ aGame playATurn ].
	self assert: (aGame lapOf: 'martin') equals: 2.
	self assert: (aGame lapOf: 'juan') equals: 1.
	self assert: (aGame lapOf: 'roman') equals: 1
]

{ #category : #tests }
RedGameTest >> testAskPodiumOfPlayerAfterTheGameEnded [
	| aCircularBoard aDieHandle players aGame fifteenCells |
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
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		withLaps: 2
		andWith: players.
	aGame play.
	self assert: (aGame podiumOf: 'martin') equals: 1.
	self assert: (aGame podiumOf: 'juan') equals: 2.
	self assert: (aGame podiumOf: 'roman') equals: 3
]

{ #category : #tests }
RedGameTest >> testAskPodiumOfPlayerDuringTheGame [
	| aCircularBoard aDieHandle players aGame fifteenCells |
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
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		withLaps: 2
		andWith: players.
	5 timesRepeat: [ aGame playATurn ].
	self assert: (aGame podiumOf: 'martin') equals: 1.
	self assert: (aGame podiumOf: 'juan') equals: 2.
	self assert: (aGame podiumOf: 'roman') equals: 3
]

{ #category : #tests }
RedGameTest >> testCannotAskWhoWonBeforeTheGameEnded [
	| aCircularBoard aDieHandle players aGame fifteenRegularCells |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		withLaps: 2
		andWith: players.
	4 timesRepeat: [ aGame playATurn ].
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
	| aCircularBoard aDieHandle players fifteenCells |
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
	self
		should: [ RedGame
				with: aCircularBoard
				with: aDieHandle
				withLaps: 0
				andWith: players ]
		raise: Error
		withMessage: 'invalid number of laps'
]

{ #category : #tests }
RedGameTest >> testCannotCreateAGameWithoutPlayers [
	| aCircularBoard die dice aDieHandle players fifteenCells |
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
	players := #().
	self
		should: [ RedGame
				with: aCircularBoard
				with: aDieHandle
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
	| aCircularBoard aDieHandle players aGame fifteenCells |
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
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		withLaps: 2
		andWith: players.
	aGame play.
	self
		should: [ aGame playATurn ]
		raise: Error
		withMessage: 'the game has ended'
]

{ #category : #tests }
RedGameTest >> testPlayAGameAndAskWhoWon [
	| aCircularBoard aDieHandle players aGame fifteenRegularCells |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 10 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		withLaps: 2
		andWith: players.
	aGame play.
	self assert: aGame whoWon equals: 'martin'
]

{ #category : #tests }
RedGameTest >> testPlayAGameWithARandomBoardAndRandomDice [
	| aCircularBoard dice aDieHandle players aGame randomCells die1 die2 die3 effectsDistribution effectSource numberOfCells |
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
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		withLaps: 3
		andWith: players.
	aGame play.
	self assert: aGame hasEnded
]

{ #category : #tests }
RedGameTest >> testPlayAGameWithRegularCells [
	| aCircularBoard aDieHandle players aGame fifteenRegularCells |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	fifteenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 15 to: fifteenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: fifteenRegularCells.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		withLaps: 2
		andWith: players.
	aGame play.
	self assert: aGame hasEnded
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnAMoonWalkCell [
	| aCircularBoard aDieHandle players aGame twelveCells |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	twelveCells := OrderedCollection new.
	self add: RegularCell new times: 11 to: twelveCells.
	self add: (MoonWalkCell with: 4) times: 1 to: twelveCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: twelveCells.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		withLaps: 1
		andWith: players.
	aGame playATurn;
			playATurn;
			playATurn;
			playATurn.
	self assert: (aGame positionOf: 'martin') equals: 12.
	self assert: (aGame positionOf: 'juan') equals: 2.
	self assert: (aGame positionOf: 'roman') equals: 2.
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnARegularCell [
	| aCircularBoard aDieHandle players aGame tenRegularCells |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	tenRegularCells := OrderedCollection new.
	self add: RegularCell new times: 10 to: tenRegularCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: tenRegularCells.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		withLaps: 1
		andWith: players.
	aGame playATurn.
	self assert: (aGame positionOf: 'martin') equals: 6
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnASpeedUpCell [
	| aCircularBoard aDieHandle players aGame sixCells |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	sixCells := OrderedCollection new.
	self add: RegularCell new times: 5 to: sixCells.
	self add: SpeedUpCell new times: 1 to: sixCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: sixCells.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		withLaps: 2
		andWith: players.
	aGame playATurn.
	self assert: (aGame positionOf: 'martin') equals: 4
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnAWormHoleCell [
	| aCircularBoard aDieHandle players aGame sixCells |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	sixCells := OrderedCollection new.
	self add: RegularCell new times: 5 to: sixCells.
	self add: WormHoleCell new times: 1 to: sixCells.
	aCircularBoard := CircularBoard
		with: players
		andWithAll: sixCells.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		withLaps: 1
		andWith: players.
	aGame playATurn.
	self assert: (aGame positionOf: 'martin') equals: 2
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnAnAtomicBombCell [
	| aCircularBoard aDieHandle players aGame twentyCells |
	aDieHandle := self createADieHandleWithALoadedDie.
	players := #('martin' 'juan' 'roman').
	twentyCells := OrderedCollection new.
	self add: RegularCell new times: 10 to: twentyCells.
	self add: AtomicBombCell new times: 10 to: twentyCells.
	aCircularBoard := CircularBoard with: players andWithAll: twentyCells.
	aGame := RedGame
		with: aCircularBoard
		with: aDieHandle
		withLaps: 1
		andWith: players.
	4 timesRepeat: [ aGame playATurn ].
	self assert: (aGame positionOf: 'martin') equals: 1.
	self assert: (aGame positionOf: 'juan') equals: 1.
	self assert: (aGame positionOf: 'roman') equals: 1.
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
