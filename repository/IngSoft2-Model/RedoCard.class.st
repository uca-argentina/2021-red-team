Class {
	#name : #RedoCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RedoCard >> activateEffectWith: game and: aTargetMove [ 
	game useLastCardEffectWith: aTargetMove.
]
