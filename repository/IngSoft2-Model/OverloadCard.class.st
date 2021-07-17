Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
OverloadCard >> activateEffectWith: game and: aMove [ 
	( game currentPlayer = aMove source) ifFalse: [ self error: 'cant use a permanent card on anothers turn' ].
	self assertTargeted: aMove.
	game addPermanentEffect: aMove.
]

{ #category : #queries }
OverloadCard >> assertTargeted: aMove [.
	(aMove class = TargetedMove ) ifFalse: [ self error: self className , ' must be played on a Targeted Move' ].
]

{ #category : #queries }
OverloadCard >> effect [
	^ -2
]

{ #category : #queries }
OverloadCard >> equals: anotherCard [
	^ self class = anotherCard class.
]
