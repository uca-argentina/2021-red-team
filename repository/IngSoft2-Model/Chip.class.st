Class {
	#name : #Chip,
	#superclass : #Object,
	#instVars : [
		'nameOfPlayer',
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Chip class >> ofPlayer: aName [
	^ self new initializeWithName: aName.
]

{ #category : #initialize }
Chip >> initializeWithName: aName [
	nameOfPlayer := aName.
	position := 0.
]

{ #category : #actions }
Chip >> move: aNumberOfCells [
	position := position + aNumberOfCells.
]

{ #category : #access }
Chip >> nameOfPlayer [
	^ nameOfPlayer.
]

{ #category : #access }
Chip >> position [
	^ position
]
