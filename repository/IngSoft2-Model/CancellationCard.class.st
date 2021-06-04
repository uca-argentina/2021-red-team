Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#instVars : [
		'cardTarget'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
CancellationCard >> activateEffectWith: game and: aMove [ 
	game removePermanentMove: (aMove target).
]

{ #category : #actions }
CancellationCard >> from: playerName activateEffect: game [ 
	game removePermanentCard: cardTarget.
]

{ #category : #actions }
CancellationCard >> setTargetAs: aPermanentCard [ 
	cardTarget := aPermanentCard.
]

{ #category : #queries }
CancellationCard >> target [
	^cardTarget.
]
