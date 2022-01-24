Class {
	#name : #SpeedBoostCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedBoostCard >> activateEffectWith: game and: aMove [ 
	self assertTargeted: aMove.
	game duplicateMoveEffect: (aMove target)
]

{ #category : #queries }
SpeedBoostCard >> assertTargeted: aMove [ 
	(aMove class = TargetedMove ) ifFalse: [ self error: self className , ' must be played on a Targeted Move' ].
]

{ #category : #queries }
SpeedBoostCard >> equals: anotherCard [
	^ self class = anotherCard class.
]
