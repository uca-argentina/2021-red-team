Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RepeatCard >> activateEffectWith: redGame and: aMove [ 
	redGame useLastBoardEffectOn: aMove target.
]

{ #category : #action }
RepeatCard >> from: player activateEffect: redGame [ 
	redGame useLastBoardEffectOn: target.
]

{ #category : #action }
RepeatCard >> setTargetAs: objetive [ 
	target := objetive.
]

{ #category : #queries }
RepeatCard >> target [
	^ target
]
