Class {
	#name : #TargetMove,
	#superclass : #Object,
	#instVars : [
		'player',
		'card',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TargetMove class >> from: aPlayer with: aCard against: objetive [
	^ self new initializeWith: aPlayer with: aCard against: objetive.
]

{ #category : #'instance creation' }
TargetMove class >> from: aString with: anOverloadCard to: aString3 [ 
	self shouldBeImplemented.
]

{ #category : #actions }
TargetMove >> activateEffect: aRedGame [ 
	card activateEffectWith: aRedGame and: self.
]

{ #category : #queries }
TargetMove >> card [
	^ card
]

{ #category : #actions }
TargetMove >> changeCard: aCard [ 
	^ TargetMove from: player with: aCard against: target.
]

{ #category : #actions }
TargetMove >> effectOn: aPlayer [
	^ target = aPlayer
		ifTrue: [ card effect ]
		ifFalse: [ 0 ]
]

{ #category : #queries }
TargetMove >> equalsMove: anotherMove [ 
	^ (self class = anotherMove class) and: [(player = anotherMove source) and: [ target = anotherMove target ]]
]

{ #category : #initialize }
TargetMove >> initializeWith: aPlayer with: aCard against: objetive [
	player := aPlayer.
	card := aCard.
	target := objetive.
]

{ #category : #actions }
TargetMove >> source [
	^ player.
]

{ #category : #queries }
TargetMove >> target [
	^ target
]
