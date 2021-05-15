Class {
	#name : #OcaGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
OcaGameTest >> should: block raise: kindOfError withMessage: expectedMessage [
	self
		should: block
		raise: kindOfError
		withExceptionDo:
			[ :error | self assert: error messageText equals: expectedMessage ]
]

{ #category : #tests }
OcaGameTest >> testABoardCannotBeCreatedWithoutCells [
	| players cells |
	players := #('martin' 'juan' 'roman').
	cells := OrderedCollection new.
	self should: [ CircularBoard with: players andWithAll: cells ] raise: Error withMessage: 'cant create a board without cells'.
]

{ #category : #tests }
OcaGameTest >> testABoardCannotBeCreatedWithoutPlayers [
	| players tenRegularCells |
	players := Array new.
	tenRegularCells := OrderedCollection new.
	10 timesRepeat: [ tenRegularCells add: RegularCell new ].
	self should: [ CircularBoard with: players andWithAll: tenRegularCells ] raise: Error withMessage: 'invalid number of players'.
]

{ #category : #tests }
OcaGameTest >> testADieCannotBeCreatedWithLessThanFourFaces [
	self should: [ RandomDie withFaces: 3 ] raise: Error withMessage: 'invalid number of faces'.
]

{ #category : #tests }
OcaGameTest >> testADieHandleCannotBeCreatedWithoutDice [
	| dice |
	dice := Array new.
	self should: [ DieHandle with: dice ] raise: Error withMessage: 'cannot create an empty die handle'
]

{ #category : #tests }
OcaGameTest >> testAskInWhichLapIsThePlayer [
    | aCircularBoard die dice aDieHandle players aGame tenRegularCells |

    die := LoadedDie withFaces: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	tenRegularCells := OrderedCollection new.
	10 timesRepeat: [ tenRegularCells add: RegularCell new ].
	
    aCircularBoard := CircularBoard with: players andWithAll: tenRegularCells.

    aGame := Game with: aCircularBoard with: aDieHandle withLaps: 3 andWith: players.

    4 timesRepeat: [aGame playATurn].

    self assert: (aGame lapOfPlayer: 'martin') equals: 2.
	 self assert: (aGame lapOfPlayer: 'juan') equals: 1.
	 self assert: (aGame lapOfPlayer: 'roman') equals: 1.
]

{ #category : #tests }
OcaGameTest >> testAskPodiumOfPlayerAfterTheGameEnded [
    | aCircularBoard die dice aDieHandle players aGame fifteenCells |

    die := LoadedDie withFaces: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	fifteenCells := OrderedCollection new.
	10 timesRepeat: [ fifteenCells add: RegularCell new ].
	2 timesRepeat: [ fifteenCells add: WormHoleCell new ].
	2 timesRepeat: [ fifteenCells add: SpeedUpCell new ].
	1 timesRepeat: [ fifteenCells add: (MoonWalkCell with: 5) ].
	
    aCircularBoard := CircularBoard with: players andWithAll: fifteenCells.

    aGame := Game with: aCircularBoard with: aDieHandle withLaps: 2 andWith: players.

    aGame play.

   self assert: (aGame podiumOfPlayer:'martin') equals: 1.
	self assert: (aGame podiumOfPlayer:'juan') equals: 2.
	self assert: (aGame podiumOfPlayer:'roman') equals: 3.
]

{ #category : #tests }
OcaGameTest >> testAskPodiumOfPlayerDuringTheGame [
    | aCircularBoard die dice aDieHandle players aGame fifteenCells |

    die := LoadedDie withFaces: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	fifteenCells := OrderedCollection new.
	10 timesRepeat: [ fifteenCells add: RegularCell new ].
	2 timesRepeat: [ fifteenCells add: WormHoleCell new ].
	2 timesRepeat: [ fifteenCells add: SpeedUpCell new ].
	1 timesRepeat: [ fifteenCells add: (MoonWalkCell with: 5) ].
	
    aCircularBoard := CircularBoard with: players andWithAll: fifteenCells.

    aGame := Game with: aCircularBoard with: aDieHandle withLaps: 2 andWith: players.

	5 timesRepeat: [aGame playATurn].

   self assert: (aGame podiumOfPlayer:'martin') equals: 1.
	self assert: (aGame podiumOfPlayer:'juan') equals: 2.
	self assert: (aGame podiumOfPlayer:'roman') equals: 3.
]

{ #category : #tests }
OcaGameTest >> testCannotAskWhoWonBeforeTheGameEnded [
    | aCircularBoard die dice aDieHandle players aGame fifteenRegularCells |

    die := LoadedDie withFaces: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	fifteenRegularCells := OrderedCollection new.
	15 timesRepeat: [ fifteenRegularCells add: RegularCell new ].
	
    aCircularBoard := CircularBoard with: players andWithAll: fifteenRegularCells.

    aGame := Game with: aCircularBoard with: aDieHandle withLaps: 2 andWith: players.

    4 timesRepeat: [aGame playATurn].

    self should: [aGame whoWon] raise: Error withMessage: 'the game is still running'.
]

{ #category : #tests }
OcaGameTest >> testCannotPlayAfterTheGameHasEnded [
    | aCircularBoard die dice aDieHandle players aGame fifteenCells |

    die := LoadedDie withFaces: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	fifteenCells := OrderedCollection new.
	10 timesRepeat: [ fifteenCells add: RegularCell new ].
	2 timesRepeat: [ fifteenCells add: WormHoleCell new ].
	2 timesRepeat: [ fifteenCells add: SpeedUpCell new ].
	1 timesRepeat: [ fifteenCells add: (MoonWalkCell with: 5) ].
	
    aCircularBoard := CircularBoard with: players andWithAll: fifteenCells.

    aGame := Game with: aCircularBoard with: aDieHandle withLaps: 2 andWith: players.

    aGame play.

    self should: [aGame playATurn] raise: Error withMessage: 'the game has ended'.
]

{ #category : #tests }
OcaGameTest >> testPlayAGameAndAskWhoWon [
    | aCircularBoard die dice aDieHandle players aGame fifteenRegularCells |

    die := LoadedDie withFaces: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	fifteenRegularCells := OrderedCollection new.
	15 timesRepeat: [ fifteenRegularCells add: RegularCell new ].
	
    aCircularBoard := CircularBoard with: players andWithAll: fifteenRegularCells.

    aGame := Game with: aCircularBoard with: aDieHandle withLaps: 2 andWith: players.

    aGame play.

    self assert: aGame whoWon equals: 'martin'.
]

{ #category : #tests }
OcaGameTest >> testPlayAGameWithARandomOrderOfCells [
	| aCircularBoard die dice aDieHandle players aGame fifteenCells randomGenerator randomCells |
	die := LoadedDie withFaces: 6.
	dice := Array with: die.
	aDieHandle := DieHandle with: dice.
	players := #('martin' 'juan' 'roman').
	fifteenCells := OrderedCollection new.
	30 timesRepeat: [ fifteenCells add: RegularCell new ].
	10 timesRepeat: [ fifteenCells add: WormHoleCell new ].
	10 timesRepeat: [ fifteenCells add: SpeedUpCell new ].
	3 timesRepeat: [ fifteenCells add: (MoonWalkCell with: 5) ].
	2 timesRepeat: [ fifteenCells add: (MoonWalkCell with: 3) ].
	1 timesRepeat: [ fifteenCells add: AtomicBombCell new ].
	randomGenerator := RandomGenerator new.
	randomCells := randomGenerator randomize: fifteenCells.
	aCircularBoard := CircularBoard with: players andWithAll: randomCells.
	aGame := Game
		with: aCircularBoard
		with: aDieHandle
		withLaps: 2
		andWith: players.
	aGame play.
	self assert: (aGame hasEnded).
]

{ #category : #tests }
OcaGameTest >> testPlayAGameWithDifferentCells [
    | aCircularBoard die dice aDieHandle players aGame fifteenCells |

    die := LoadedDie withFaces: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	fifteenCells := OrderedCollection new.
	10 timesRepeat: [ fifteenCells add: RegularCell new ].
	2 timesRepeat: [ fifteenCells add: WormHoleCell new ].
	2 timesRepeat: [ fifteenCells add: SpeedUpCell new ].
	1 timesRepeat: [ fifteenCells add: (MoonWalkCell with: 5) ].
	
    aCircularBoard := CircularBoard with: players andWithAll: fifteenCells.

    aGame := Game with: aCircularBoard with: aDieHandle withLaps: 2 andWith: players.

    aGame play.

    self assert: (aGame hasEnded).
]

{ #category : #tests }
OcaGameTest >> testPlayAGameWithRegularCells [
    | aCircularBoard die dice aDieHandle players aGame fifteenRegularCells |

    die := LoadedDie withFaces: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	fifteenRegularCells := OrderedCollection new.
	15 timesRepeat: [ fifteenRegularCells add: RegularCell new ].
	
    aCircularBoard := CircularBoard with: players andWithAll: fifteenRegularCells.

    aGame := Game with: aCircularBoard with: aDieHandle withLaps: 2 andWith: players.

    aGame play.

    self assert: (aGame hasEnded).
]

{ #category : #tests }
OcaGameTest >> testPlayATurnAndLandOnAMoonWalkCell [
    | aCircularBoard die dice aDieHandle players aGame tenMoonWalkCells |

    die := LoadedDie withFaces: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	tenMoonWalkCells := OrderedCollection new.
	10 timesRepeat: [ tenMoonWalkCells add: (MoonWalkCell with: 4) ].
	
    aCircularBoard := CircularBoard with: players andWithAll: tenMoonWalkCells.

    aGame := Game with: aCircularBoard with: aDieHandle withLaps: 1 andWith: players.

    aGame playATurn.

    self assert: (aGame positionOfPlayer: 'martin') equals: 6.
	 self assert: (aGame positionOfPlayer: 'juan') equals: 1.
	 self assert: (aGame positionOfPlayer: 'roman') equals: 1.
]

{ #category : #tests }
OcaGameTest >> testPlayATurnAndLandOnARegularCell [
    | aCircularBoard die dice aDieHandle players aGame tenRegularCells |

    die := LoadedDie withFaces: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	tenRegularCells := OrderedCollection new.
	10 timesRepeat: [ tenRegularCells add: RegularCell new ].
	
    aCircularBoard := CircularBoard with: players andWithAll: tenRegularCells.

    aGame := Game with: aCircularBoard with: aDieHandle withLaps: 1 andWith: players.

    aGame playATurn.

    self assert: (aGame positionOfPlayer: 'martin') equals: 6.
]

{ #category : #tests }
OcaGameTest >> testPlayATurnAndLandOnASpeedUpCell [
    | aCircularBoard die dice aDieHandle players aGame tenSpeedUpCells |

    die := LoadedDie withFaces: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	tenSpeedUpCells := OrderedCollection new.
	10 timesRepeat: [ tenSpeedUpCells add: SpeedUpCell new ].
	
    aCircularBoard := CircularBoard with: players andWithAll: tenSpeedUpCells.

    aGame := Game with: aCircularBoard with: aDieHandle withLaps: 1 andWith: players.

    aGame playATurn.

    self assert: (aGame positionOfPlayer: 'martin') equals: 10.
]

{ #category : #tests }
OcaGameTest >> testPlayATurnAndLandOnAWormHoleCell [
    | aCircularBoard die dice aDieHandle players aGame tenWormHoleCells |

    die := LoadedDie withFaces: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	tenWormHoleCells := OrderedCollection new.
	10 timesRepeat: [ tenWormHoleCells add: WormHoleCell new ].
	
    aCircularBoard := CircularBoard with: players andWithAll: tenWormHoleCells.

    aGame := Game with: aCircularBoard with: aDieHandle withLaps: 1 andWith: players.

    aGame playATurn.

    self assert: (aGame positionOfPlayer: 'martin') equals: 2.
]

{ #category : #tests }
OcaGameTest >> testPlayATurnAndLandOnAnAtomicBombCell [
    | aCircularBoard die dice aDieHandle players aGame twentyCells |

    die := LoadedDie withFaces: 6.
    dice := Array with: die.
    aDieHandle := DieHandle with: dice.

    players := #('martin' 'juan' 'roman').

	twentyCells := OrderedCollection new.
	10 timesRepeat: [ twentyCells add: RegularCell new ].
	10 timesRepeat: [ twentyCells add: AtomicBombCell new ].
	
    aCircularBoard := CircularBoard with: players andWithAll: twentyCells.

    aGame := Game with: aCircularBoard with: aDieHandle withLaps: 1 andWith: players.

    4 timesRepeat: [aGame playATurn].

    self assert: (aGame positionOfPlayer: 'martin') equals: 0.
	 self assert: (aGame positionOfPlayer: 'juan') equals: 0.
	 self assert: (aGame positionOfPlayer: 'roman') equals: 0.
]

{ #category : #tests }
OcaGameTest >> testRollALoadedDie [
	| aDie |
	aDie := LoadedDie withFaces: 8.
	self assert: aDie roll equals: 8.
]

{ #category : #tests }
OcaGameTest >> testRollARandomDie [
	| aDie |
	aDie := RandomDie withFaces: 8.
	self assert: ((aDie roll) between: 1 and: 8).
]

{ #category : #tests }
OcaGameTest >> testRollingADieHandleGivesTheSumOfItsDiceFaces [
	| aDieHandle die1 die2 die3 dice |
	die1 := LoadedDie withFaces: 4.
	die2 := LoadedDie withFaces: 8.
	die3 := LoadedDie withFaces: 6.
	dice := Array with: die1 with: die2 with: die3.
	aDieHandle := DieHandle with: dice.
	self assert: aDieHandle roll equals: 18.
]
