Class {
	#name : #MoonWalkCell,
	#superclass : #Object,
	#instVars : [
		'moveBackwards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalkCell class >> with: n [
	^ self new initializeWith: n.
]

{ #category : #actions }
MoonWalkCell >> activateEffect: circularBoard and: playerName [
	circularBoard moveEveryone: moveBackwards except: playerName.
]

{ #category : #initialize }
MoonWalkCell >> initializeWith: n [
	moveBackwards := n*(-1).
]
