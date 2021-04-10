Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'cells'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> withCells: aNumberOfCells [ 
	^ self new initializeWithCells: aNumberOfCells.
]

{ #category : #'as yet unclassified' }
Game >> cells [
	^ cells.
]

{ #category : #initialize }
Game >> initializeWithCells: aNumberOfCells [
	cells := aNumberOfCells.
]
