Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RepeatCard >> activateEffectWith: redGame and: aMove [
	self assertTargeted: aMove .
	redGame useLastBoardEffectOn: aMove target.
]

{ #category : #actions }
RepeatCard >> assertTargeted: aMove [.
	(aMove class = TargetedMove ) ifFalse: [ self error: self className , ' must be played on a Targeted Move' ].
]

{ #category : #actions }
RepeatCard >> equals: anotherCard [
	^ self class = anotherCard class.
]
