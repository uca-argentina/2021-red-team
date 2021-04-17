Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'cells',
		'playerHandle',
		'players',
		'chips'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> withCells: aNumberOfCells andWithChips: chips [
	^ self new initializeWithCells: aNumberOfCells andWithChips: chips.
]

{ #category : #'as yet unclassified' }
Board >> anyChipFinished [
	^ chips anySatisfy: [ :aChip | aChip position >= cells ].
]

{ #category : #initialize }
Board >> initializeWithCells: aNumberOfCells andWithChips: chipsFromPlayers [
	cells := aNumberOfCells.
	chips := chipsFromPlayers.
]

{ #category : #'as yet unclassified' }
Board >> moveChip: aNumberOfCells [
	| currentChip |
	currentChip := chips removeFirst.
	currentChip move: aNumberOfCells.
	chips addLast: currentChip.
	
]

{ #category : #'as yet unclassified' }
Board >> positionOfPlayer: aName [
	| chip |
	chip := chips detect: [ :aChip | aChip nameOfPlayer == aName ].
	^ chip position.
]

{ #category : #'as yet unclassified' }
Board >> whosFirst [
	| positions indexOfFirstChip |
	positions := chips collect: [ :aChip | aChip position ].
	indexOfFirstChip := positions indexOf: (positions max).
	^ (chips at: indexOfFirstChip) nameOfPlayer.
]
