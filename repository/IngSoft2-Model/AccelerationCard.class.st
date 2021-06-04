Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
AccelerationCard >> activateEffectWith: game and: aMove [ 
	( game whosTurnIsIt = aMove source ) ifFalse: [ self error: 'cant use a permanent card on anothers turn' ].
	game addToPermanentMoves: self.
]

{ #category : #actions }
AccelerationCard >> effectOn: playerName [
	^ 1.
]
