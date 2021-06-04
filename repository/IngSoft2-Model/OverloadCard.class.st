Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
OverloadCard >> activateEffectWith: game and: aMove [ 
	( game whosTurnIsIt = aMove source) ifFalse: [ self error: 'cant use a permanent card on anothers turn' ].
	game addToPermanentMoves: aMove.
]

{ #category : #queries }
OverloadCard >> effect [
	^ -2
]
