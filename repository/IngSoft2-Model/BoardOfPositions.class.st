Class {
	#name : #BoardOfPositions,
	#superclass : #Object,
	#instVars : [
		'positions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoardOfPositions class >> with: players [
	^ self new initializeWith: players.
]

{ #category : #initialize }
BoardOfPositions >> initializeWith: players [
	| auxiliarPositions playerName |
	auxiliarPositions := OrderedCollection new.
	1 to: players size do: [ :i | 
		playerName := players at: i.
		auxiliarPositions add: (Position from: playerName) ].
	positions := auxiliarPositions
]
