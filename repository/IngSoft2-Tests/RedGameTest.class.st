Class {
	#name : #RedGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
RedGameTest >> randomCellsGenerator [
	| moonWalkDistribution regularDistribution wormHoleDistribution effectsDistribution randomCells effectSource atomicDistribution speedUpDistribution numberOfCells |
	numberOfCells := 100.
	regularDistribution := EffectDistribution
		of: RegularCell new
		with: 0.48.
	wormHoleDistribution := EffectDistribution
		of: WormHoleCell new
		with: 0.20.
	speedUpDistribution := EffectDistribution
		of: SpeedUpCell new
		with: 0.20.
	moonWalkDistribution := EffectDistribution
		of: (MoonWalkCell with: 5)
		with: 0.10.
	atomicDistribution := EffectDistribution
		of: AtomicBombCell new
		with: 0.02.
	effectsDistribution := OrderedCollection new.
	effectsDistribution
		add: regularDistribution;
		add: wormHoleDistribution;
		add: speedUpDistribution;
		add: moonWalkDistribution;
		add: atomicDistribution.
	effectSource := RandomSource basedOn: effectsDistribution.
	randomCells := effectSource produce: numberOfCells.
	^ randomCells
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
    | aCircularBoard die dice aDieHandle players aGame tenRegularCells |

    die := LoadedDie with: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	tenRegularCells := OrderedCollection new.
	10 timesRepeat: [ tenRegularCells add: RegularCell new ].
	
    aCircularBoard := CircularBoard with: players andWithAll: tenRegularCells.

    aGame := RedGame with: aCircularBoard with: aDieHandle withLaps: 3 andWith: players.

    4 timesRepeat: [aGame playATurn].

    self assert: (aGame lapOf: 'martin') equals: 2.
	 self assert: (aGame lapOf: 'juan') equals: 1.
	 self assert: (aGame lapOf: 'roman') equals: 1.
]

{ #category : #tests }
RedGameTest >> testAskPodiumOfPlayerAfterTheGameEnded [
    | aCircularBoard die dice aDieHandle players aGame fifteenCells |

    die := LoadedDie with: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	fifteenCells := OrderedCollection new.
	10 timesRepeat: [ fifteenCells add: RegularCell new ].
	2 timesRepeat: [ fifteenCells add: WormHoleCell new ].
	2 timesRepeat: [ fifteenCells add: SpeedUpCell new ].
	1 timesRepeat: [ fifteenCells add: (MoonWalkCell with: 5) ].
	
    aCircularBoard := CircularBoard with: players andWithAll: fifteenCells.

    aGame := RedGame with: aCircularBoard with: aDieHandle withLaps: 2 andWith: players.

    aGame play.

   self assert: (aGame podiumOf:'martin') equals: 1.
	self assert: (aGame podiumOf:'juan') equals: 2.
	self assert: (aGame podiumOf:'roman') equals: 3.
]

{ #category : #tests }
RedGameTest >> testAskPodiumOfPlayerDuringTheGame [
    | aCircularBoard die dice aDieHandle players aGame fifteenCells |

    die := LoadedDie with: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	fifteenCells := OrderedCollection new.
	10 timesRepeat: [ fifteenCells add: RegularCell new ].
	2 timesRepeat: [ fifteenCells add: WormHoleCell new ].
	2 timesRepeat: [ fifteenCells add: SpeedUpCell new ].
	1 timesRepeat: [ fifteenCells add: (MoonWalkCell with: 5) ].
	
    aCircularBoard := CircularBoard with: players andWithAll: fifteenCells.

    aGame := RedGame with: aCircularBoard with: aDieHandle withLaps: 2 andWith: players.

	5 timesRepeat: [aGame playATurn].

   self assert: (aGame podiumOf:'martin') equals: 1.
	self assert: (aGame podiumOf:'juan') equals: 2.
	self assert: (aGame podiumOf:'roman') equals: 3.
]

{ #category : #tests }
RedGameTest >> testCannotAskWhoWonBeforeTheGameEnded [
    | aCircularBoard die dice aDieHandle players aGame fifteenRegularCells |

    die := LoadedDie with: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	fifteenRegularCells := OrderedCollection new.
	15 timesRepeat: [ fifteenRegularCells add: RegularCell new ].
	
    aCircularBoard := CircularBoard with: players andWithAll: fifteenRegularCells.

    aGame := RedGame with: aCircularBoard with: aDieHandle withLaps: 2 andWith: players.

    4 timesRepeat: [aGame playATurn].

    self should: [aGame whoWon] raise: Error withMessage: 'the game is still running'.
]

{ #category : #tests }
RedGameTest >> testCannotCreateABoardWithoutCells [
	| players cells |
	players := #('martin' 'juan' 'roman').
	cells := OrderedCollection new.
	self should: [ CircularBoard with: players andWithAll: cells ] raise: Error withMessage: 'cant create a board without cells'.
]

{ #category : #tests }
RedGameTest >> testCannotCreateABoardWithoutPlayers [
	| players tenRegularCells |
	players := Array new.
	tenRegularCells := OrderedCollection new.
	10 timesRepeat: [ tenRegularCells add: RegularCell new ].
	self should: [ CircularBoard with: players andWithAll: tenRegularCells ] raise: Error withMessage: 'cant create a board without players'.
]

{ #category : #tests }
RedGameTest >> testCannotCreateADieHandleWithoutDice [
	| dice |
	dice := Array new.
	self should: [ DieHandle with: dice ] raise: Error withMessage: 'cannot create an empty die handle'
]

{ #category : #tests }
RedGameTest >> testCannotCreateADieWithLessThanFourFaces [
	self should: [ RandomDie with: 3 ] raise: Error withMessage: 'invalid number of faces'.
]

{ #category : #tests }
RedGameTest >> testCannotCreateAGameWithInvalidNumberOfLaps [
    | aCircularBoard die dice aDieHandle players fifteenCells |

    die := LoadedDie with: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	fifteenCells := OrderedCollection new.
	10 timesRepeat: [ fifteenCells add: RegularCell new ].
	2 timesRepeat: [ fifteenCells add: WormHoleCell new ].
	2 timesRepeat: [ fifteenCells add: SpeedUpCell new ].
	1 timesRepeat: [ fifteenCells add: (MoonWalkCell with: 5) ].
	
    aCircularBoard := CircularBoard with: players andWithAll: fifteenCells.

    self should: [RedGame with: aCircularBoard with: aDieHandle withLaps: 0 andWith: players] raise: Error withMessage: 'invalid number of laps'.

]

{ #category : #tests }
RedGameTest >> testCannotCreateAGameWithoutPlayers [
    | aCircularBoard die dice aDieHandle players fifteenCells |

    die := LoadedDie with: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	fifteenCells := OrderedCollection new.
	10 timesRepeat: [ fifteenCells add: RegularCell new ].
	2 timesRepeat: [ fifteenCells add: WormHoleCell new ].
	2 timesRepeat: [ fifteenCells add: SpeedUpCell new ].
	1 timesRepeat: [ fifteenCells add: (MoonWalkCell with: 5) ].
	
    aCircularBoard := CircularBoard with: players andWithAll: fifteenCells.

	players := #().

    self should: [RedGame with: aCircularBoard with: aDieHandle withLaps: 2 andWith: players] raise: Error withMessage: 'cannot create a RedGame without players'.

]

{ #category : #tests }
RedGameTest >> testCannotCreateAPositionWithoutName [
	self should: [ Position from:'' ] raise: Error withMessage: 'cant create a Position without a name'.
]

{ #category : #tests }
RedGameTest >> testCannotCreateARandomSourcewithInvalidProportions [
	| regularDistribution wormHoleDistribution speedUpDistribution moonWalkDistribution atomicDistribution effectsDistribution |
	regularDistribution := EffectDistribution
		of: RegularCell new
		with: 0.48.
	wormHoleDistribution := EffectDistribution
		of: WormHoleCell new
		with: 0.20.
	speedUpDistribution := EffectDistribution
		of: SpeedUpCell new
		with: 0.10.
	moonWalkDistribution := EffectDistribution
		of: (MoonWalkCell with: 5)
		with: 0.10.
	atomicDistribution := EffectDistribution
		of: AtomicBombCell new
		with: 0.02.
	effectsDistribution := OrderedCollection new.
	effectsDistribution
		add: regularDistribution;
		add: wormHoleDistribution;
		add: speedUpDistribution;
		add: moonWalkDistribution;
		add: atomicDistribution.
	
	self should: [ RandomSource basedOn: effectsDistribution ] raise: Error withMessage: 'invalid amounts of proportions, must sum 1'.
]

{ #category : #tests }
RedGameTest >> testCannotCreateAnEffectDistributionwithInvalidProportion [
	self should: [ EffectDistribution of: (RegularCell new) with: 2. ] raise: Error withMessage: 'invalid proportion'.
]

{ #category : #tests }
RedGameTest >> testCannotPlayAfterTheGameHasEnded [
    | aCircularBoard die dice aDieHandle players aGame fifteenCells |

    die := LoadedDie with: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	fifteenCells := OrderedCollection new.
	10 timesRepeat: [ fifteenCells add: RegularCell new ].
	2 timesRepeat: [ fifteenCells add: WormHoleCell new ].
	2 timesRepeat: [ fifteenCells add: SpeedUpCell new ].
	1 timesRepeat: [ fifteenCells add: (MoonWalkCell with: 5) ].
	
    aCircularBoard := CircularBoard with: players andWithAll: fifteenCells.

    aGame := RedGame with: aCircularBoard with: aDieHandle withLaps: 2 andWith: players.

    aGame play.

    self should: [aGame playATurn] raise: Error withMessage: 'the game has ended'.
]

{ #category : #tests }
RedGameTest >> testPlayAGameAndAskWhoWon [
    | aCircularBoard die dice aDieHandle players aGame fifteenRegularCells |

    die := LoadedDie with: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	fifteenRegularCells := OrderedCollection new.
	15 timesRepeat: [ fifteenRegularCells add: RegularCell new ].
	
    aCircularBoard := CircularBoard with: players andWithAll: fifteenRegularCells.

    aGame := RedGame with: aCircularBoard with: aDieHandle withLaps: 2 andWith: players.

    aGame play.

    self assert: aGame whoWon equals: 'martin'.
]

{ #category : #tests }
RedGameTest >> testPlayAGameWithRandomDiceAndRandomOrderOfCells [
	| aCircularBoard dice aDieHandle players aGame randomCells die1 die2 die3 |
	die1 := RandomDie with: 10.
	die2 := RandomDie with: 8.
	die3 := RandomDie with: 6.
	dice := Array with: die1 with: die2 with: die3.
	aDieHandle := DieHandle with: dice.
	players := #('martin' 'juan' 'roman').
	randomCells := self randomCellsGenerator.
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
    | aCircularBoard die dice aDieHandle players aGame fifteenRegularCells |

    die := LoadedDie with: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	fifteenRegularCells := OrderedCollection new.
	15 timesRepeat: [ fifteenRegularCells add: RegularCell new ].
	
    aCircularBoard := CircularBoard with: players andWithAll: fifteenRegularCells.

    aGame := RedGame with: aCircularBoard with: aDieHandle withLaps: 2 andWith: players.

    aGame play.

    self assert: (aGame hasEnded).
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnAMoonWalkCell [
    | aCircularBoard die dice aDieHandle players aGame tenMoonWalkCells |

    die := LoadedDie with: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	tenMoonWalkCells := OrderedCollection new.
	10 timesRepeat: [ tenMoonWalkCells add: (MoonWalkCell with: 4) ].
	
    aCircularBoard := CircularBoard with: players andWithAll: tenMoonWalkCells.

    aGame := RedGame with: aCircularBoard with: aDieHandle withLaps: 1 andWith: players.

    aGame playATurn.

    self assert: (aGame positionOf: 'martin') equals: 6.
	 self assert: (aGame positionOf: 'juan') equals: 1.
	 self assert: (aGame positionOf: 'roman') equals: 1.
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnARegularCell [
    | aCircularBoard die dice aDieHandle players aGame tenRegularCells |

    die := LoadedDie with: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	tenRegularCells := OrderedCollection new.
	10 timesRepeat: [ tenRegularCells add: RegularCell new ].
	
    aCircularBoard := CircularBoard with: players andWithAll: tenRegularCells.

    aGame := RedGame with: aCircularBoard with: aDieHandle withLaps: 1 andWith: players.

    aGame playATurn.

    self assert: (aGame positionOf: 'martin') equals: 6.
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnASpeedUpCell [
    | aCircularBoard die dice aDieHandle players aGame tenSpeedUpCells |

    die := LoadedDie with: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	tenSpeedUpCells := OrderedCollection new.
	10 timesRepeat: [ tenSpeedUpCells add: SpeedUpCell new ].
	
    aCircularBoard := CircularBoard with: players andWithAll: tenSpeedUpCells.

    aGame := RedGame with: aCircularBoard with: aDieHandle withLaps: 1 andWith: players.

    aGame playATurn.

    self assert: (aGame positionOf: 'martin') equals: 10.
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnAWormHoleCell [
    | aCircularBoard die dice aDieHandle players aGame tenWormHoleCells |

    die := LoadedDie with: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	tenWormHoleCells := OrderedCollection new.
	10 timesRepeat: [ tenWormHoleCells add: WormHoleCell new ].
	
    aCircularBoard := CircularBoard with: players andWithAll: tenWormHoleCells.

    aGame := RedGame with: aCircularBoard with: aDieHandle withLaps: 1 andWith: players.

    aGame playATurn.

    self assert: (aGame positionOf: 'martin') equals: 2.
]

{ #category : #tests }
RedGameTest >> testPlayATurnAndLandOnAnAtomicBombCell [
    | aCircularBoard die dice aDieHandle players aGame twentyCells |

    die := LoadedDie with: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	twentyCells := OrderedCollection new.
	10 timesRepeat: [ twentyCells add: RegularCell new ].
	10 timesRepeat: [ twentyCells add: AtomicBombCell new ].
	
    aCircularBoard := CircularBoard with: players andWithAll: twentyCells.

    aGame := RedGame with: aCircularBoard with: aDieHandle withLaps: 1 andWith: players.

    4 timesRepeat: [aGame playATurn].

    self assert: (aGame positionOf: 'martin') equals: 1.
	 self assert: (aGame positionOf: 'juan') equals: 1.
	 self assert: (aGame positionOf: 'roman') equals: 1.
]

{ #category : #tests }
RedGameTest >> testRollALoadedDie [
	| aDie |
	aDie := LoadedDie with: 8.
	self assert: aDie roll equals: 8.
]

{ #category : #tests }
RedGameTest >> testRollARandomDie [
	| aDie |
	aDie := RandomDie with: 8.
	self assert: ((aDie roll) between: 1 and: 8).
]

{ #category : #tests }
RedGameTest >> testRollingADieHandleGivesTheSumOfItsDiceFaces [
	| aDieHandle die1 die2 die3 dice |
	die1 := LoadedDie with: 4.
	die2 := LoadedDie with: 8.
	die3 := LoadedDie with: 6.
	dice := Array with: die1 with: die2 with: die3.
	aDieHandle := DieHandle with: dice.
	self assert: aDieHandle roll equals: 18.
]
