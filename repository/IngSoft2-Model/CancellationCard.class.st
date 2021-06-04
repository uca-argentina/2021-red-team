Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
CancellationCard >> activateEffectWith: game and: aMove [ 
	game removePermanentMove: (aMove target).
]
