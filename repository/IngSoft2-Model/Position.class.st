Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'player',
		'station'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Position class >> from: playerName [
	^ self from: playerName with: 0.
]

{ #category : #'instance creation' }
Position class >> from: playerName with: newValue [
	playerName ifEmpty: [ self error: 'cant create a Position without a name' ].
	^ self new initializeWith: playerName andWith: newValue.
]

{ #category : #queries }
Position >> >= aPosition [ 
	^ (station >= aPosition valueOfPosition).
]

{ #category : #initialize }
Position >> initializeWith: name andWith: newValue [
	player := name.
	station := newValue .
]

{ #category : #queries }
Position >> nameOfPlayer [
	^ player.
]

{ #category : #actions }
Position >> updateWith: distance [
	| newValue newPosition |
	newValue := (station + distance) max: 1.
	newPosition := self class from: player with: newValue.
	^newPosition.
	
	
]

{ #category : #queries }
Position >> valueOfPosition [
	^ station.
]
