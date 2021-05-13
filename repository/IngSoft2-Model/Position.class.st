Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'player',
		'value'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Position class >> from: playerName [
	^ self new initializeWith: playerName.
]

{ #category : #initialize }
Position >> initializeWith: name [
	player := name.
	value := 0.
]

{ #category : #queries }
Position >> nameOfPlayer [
	^ player.
]

{ #category : #actions }
Position >> updatePosition: rollValue [
	value := value + rollValue.
	(value < 0) ifTrue: [ value := 1 ].
]

{ #category : #queries }
Position >> valueOfPosition [
	^ value.
]
