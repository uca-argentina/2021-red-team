Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
CancellationCard >> activateEffectWith: game and: aMove [ 
	self assertTargeted: aMove.
	game removePermanentEffect: (aMove target).
]

{ #category : #actions }
CancellationCard >> assertTargeted: aMove [.
	(aMove class = TargetedMove ) ifFalse: [ self error: self className , ' must be played on a Targeted Move' ].
]

{ #category : #actions }
CancellationCard >> equals: anotherCard [
	^ self class = anotherCard class.
]
