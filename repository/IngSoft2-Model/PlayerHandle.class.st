Class {
	#name : #PlayerHandle,
	#superclass : #Object,
	#instVars : [
		'players'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PlayerHandle class >> withPlayers: aNumberOfPlayers [ 
	^ self new initializeWithPlayers: aNumberOfPlayers.
]

{ #category : #initialize }
PlayerHandle >> initializeWithPlayers: aNumberOfPlayers [ 
	players := Array new: aNumberOfPlayers.
	players := players do: [ :playerPosition | playerPosition put: 0 ].
]

{ #category : #'as yet unclassified' }
PlayerHandle >> positionOfPlayer: aPlayer [
	^ players at: aPlayer.
]
