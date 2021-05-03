Class {
	#name : #CircularBoard,
	#superclass : #Object,
	#instVars : [
		'cells'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CircularBoard class >> withCells: aNumberOfCells [  
	^self new initializeWithCells: aNumberOfCells .
]

{ #category : #initialize }
CircularBoard >> initializeWithCells: aNumberOfCells [ 
	| numberOfRegularCells numberOfWormHoleCells numberOfSpeedUpCells numberOfMoonWalkCells numberOfAtomicBombCells auxiliarCells |
	numberOfRegularCells := 0.48 * aNumberOfCells .
	numberOfWormHoleCells := 0.20 * aNumberOfCells .
	numberOfSpeedUpCells := 0.20 * aNumberOfCells .
	numberOfMoonWalkCells := 0.10 * aNumberOfCells .
	numberOfAtomicBombCells := 0.02 * aNumberOfCells .
	auxiliarCells := OrderedCollection new.
	1 to: numberOfRegularCells do: [ :i | auxiliarCells add: (RegularCell new)].
	1 to: numberOfWormHoleCells do: [ :i | auxiliarCells add: (WormHoleCell new)].
	1 to: numberOfSpeedUpCells do: [ :i | auxiliarCells add: (SpeedUpCell new)].
	1 to: numberOfMoonWalkCells do: [ :i | auxiliarCells add: (MoonWalkCell new)].
	1 to: numberOfAtomicBombCells do: [ :i | auxiliarCells add: (AtomicBombCell new)].
	cells:= auxiliarCells.
	
]

{ #category : #query }
CircularBoard >> numberOfCells [
	^cells size.
]
