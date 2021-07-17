Class {
	#name : #TargetedMove,
	#superclass : #Object,
	#instVars : [
		'target',
		'move'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TargetedMove class >> with: aMove against: objetive [
	(aMove card equals: AccelerationCard new) ifTrue: [ self error: 'Cant create a Target Move with an AccelerationCard' ].
	^ self new initializeWith: aMove against: objetive.
]

{ #category : #actions }
TargetedMove >> activateEffect: aRedGame [ 
	move activateEffect: aRedGame with: self .
]

{ #category : #queries }
TargetedMove >> card [
	^ move card
]

{ #category : #actions }
TargetedMove >> changeCard: aCard [ 
	^ self class with: (move changeCard: aCard) against: target.
]

{ #category : #actions }
TargetedMove >> effectOn: aPlayer [
	^ target = aPlayer
		ifTrue: [ move effectOn: aPlayer ]
		ifFalse: [ 0 ]
]

{ #category : #queries }
TargetedMove >> equalsMove: anotherMove [ 
	^ (self class = anotherMove class) and: [ (move equalsMove: anotherMove move) and: [ target = anotherMove target ]].
]

{ #category : #initialize }
TargetedMove >> initializeWith: aMove against: objetive [
	move := aMove .
	target := objetive.
]

{ #category : #queries }
TargetedMove >> move [
	^ move
]

{ #category : #actions }
TargetedMove >> source [
	^ move source.
]

{ #category : #queries }
TargetedMove >> target [
	^ target
]
