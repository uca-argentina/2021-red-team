Class {
	#name : #RedoCard,
	#superclass : #Object,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RedoCard >> from: player activateEffect: aRedGame [ 
	aRedGame useLastCardEffectOn: target from: player.
]

{ #category : #actions }
RedoCard >> setTargetAs: objetive [
	target := objetive.
]

{ #category : #queries }
RedoCard >> target [
	^ target
]
