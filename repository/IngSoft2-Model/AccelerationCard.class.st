Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
AccelerationCard >> activateEffectWith: game and: aMove [ 
	( game whosTurnIsIt = aMove source ) ifFalse: [ self error: 'cant use a permanent card on anothers turn' ].
	game addToPermanentMoves: aMove.
]

{ #category : #actions }
AccelerationCard >> effect [
	^ 1.
]

{ #category : #actions }
AccelerationCard >> equals: anotherCard [
	^ self class = anotherCard class.
]
