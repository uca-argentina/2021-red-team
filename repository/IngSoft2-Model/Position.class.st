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

{ #category : #'instance creation' }
Position class >> from: playerName with: newValue [ 
	^ self new initializeWith: playerName andWith: newValue.
]

{ #category : #initialize }
Position >> initializeWith: name [
	player := name.
	value := 0.
]

{ #category : #initialize }
Position >> initializeWith: name andWith: newValue [
	player := name.
	value := newValue .
]

{ #category : #queries }
Position >> nameOfPlayer [
	^ player.
]

{ #category : #actions }
Position >> updatePosition: rollValue [
	| newValue newPosition |
	newValue := value + rollValue.
	(newValue < 0) ifTrue: [ newValue := 1 ].
	newPosition := self class from: player with: newValue.
	^newPosition.
	
	
]

{ #category : #queries }
Position >> valueOfPosition [
	^ value.
]
