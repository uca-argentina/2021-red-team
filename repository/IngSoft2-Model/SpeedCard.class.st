Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedCard >> activateEffect: playerName [
	^ target = playerName
		ifTrue: [ 1 ]
		ifFalse: [ 0 ]
]

{ #category : #actions }
SpeedCard >> setTargetAs: playerName [
	target := playerName.
]
