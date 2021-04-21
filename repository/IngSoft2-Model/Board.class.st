Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'cells',
		'chips'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> withCells: aNumberOfCells andWithChips: chips [
	(aNumberOfCells > 0 ) ifFalse: [ self error: 'invalid number of cells' ].
	(chips isEmpty ) ifTrue: [ self error: 'invalid number of players' ].
	^ self new initializeWithCells: aNumberOfCells andWithChips: chips.
]

{ #category : #queries }
Board >> anyChipFinished [
	^ chips anySatisfy: [ :aChip | aChip position >= cells ].
]

{ #category : #queries }
Board >> finalPositionOf: aPlayer [
	| chipFromPlayer |
	chipFromPlayer := chips detect: [ :aChip | aChip nameOfPlayer == aPlayer ].
	^ chips indexOf: chipFromPlayer.
]

{ #category : #initialize }
Board >> initializeWithCells: aNumberOfCells andWithChips: chipsFromPlayers [
	cells := aNumberOfCells.
	chips := chipsFromPlayers.
]

{ #category : #actions }
Board >> moveChip: aNumberOfCells [
	| currentChip |
	currentChip := chips removeFirst.
	currentChip move: aNumberOfCells.
	chips addLast: currentChip.
	
]

{ #category : #actions }
Board >> orderChipsByFinalPosition [
	( self anyChipFinished ) ifFalse: [ self error: 'the game hasnt ended' ].
	chips := chips asSortedCollection: [ :chipA :chipB | chipA position >= chipB position].
]

{ #category : #queries }
Board >> positionOfPlayer: aName [
	| chip |
	chip := chips detect: [ :aChip | aChip nameOfPlayer == aName ].
	^ chip position.
]

{ #category : #queries }
Board >> whosFirst [
	| positions indexOfFirstChip |
	positions := chips collect: [ :aChip | aChip position ].
	indexOfFirstChip := positions indexOf: (positions max).
	^ (chips at: indexOfFirstChip) nameOfPlayer.
]
