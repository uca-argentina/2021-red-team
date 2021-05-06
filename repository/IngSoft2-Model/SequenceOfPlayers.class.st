Class {
	#name : #SequenceOfPlayers,
	#superclass : #Object,
	#instVars : [
		'orderOfPlayers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SequenceOfPlayers class >> with: players [
	^ self new initializeWith: players.
]

{ #category : #initialize }
SequenceOfPlayers >> initializeWith: players [
	orderOfPlayers := players asOrderedCollection.
]
