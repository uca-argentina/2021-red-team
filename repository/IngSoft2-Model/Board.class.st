Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'cells',
		'playerHandle'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> withCells: aNumberOfCells andWithNumberOfPlayers: aNumberOfPlayers [
	^ self new initializeWithCells: aNumberOfCells andWithPlayers: aNumberOfPlayers.
]

{ #category : #initialize }
Board >> initializeWithCells: aNumberOfCells andWithPlayers: aNumberOfPlayers [
	cells := aNumberOfCells.
	playerHandle := PlayerHandle withPlayers: aNumberOfPlayers.
]

{ #category : #'as yet unclassified' }
Board >> positionOfPlayer: aPlayer [
	^ playerHandle positionOfPlayer: aPlayer.
]
