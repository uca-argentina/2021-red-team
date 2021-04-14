Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'cells',
		'playerHandle',
		'players'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> withCells: aNumberOfCells [ 
	^ self new initializeWithCells: aNumberOfCells.
]

{ #category : #'instance creation' }
Board class >> withCells: aNumberOfCells  andWithPlayers: players [ 
	^self new initializeWithCells: aNumberOfCells  andWithPlayers: players.
]

{ #category : #initialize }
Board >> initializeWithCells: aNumberOfCells [ 
	cells := aNumberOfCells.
	
]

{ #category : #initialize }
Board >> initializeWithCells: aNumberOfCells andWithPlayers: playersNames [
	cells := aNumberOfCells.
	players := playersNames. 
]

{ #category : #'as yet unclassified' }
Board >> nextTurn: anInteger [ 
	^true.
]
