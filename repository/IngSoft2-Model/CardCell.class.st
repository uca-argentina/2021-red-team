Class {
	#name : #CardCell,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
CardCell >> activateEffect: aCircularBoard and: aString [ 
	self shouldBeImplemented.
]

{ #category : #actions }
CardCell >> activateEffect: board from: aPlayerName with: game [ 
	game addMoveTo: aPlayerName.
]
