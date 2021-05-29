Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
OverloadCard class >> withTarget: player [
	^ self new initializeWithTarget: player.
]

{ #category : #actions }
OverloadCard >> activateEffect: playerName [
	^ target = playerName
		ifTrue: [ -2 ]
		ifFalse: [ 0 ]
]

{ #category : #initialize }
OverloadCard >> initializeWithTarget: player [
	target := player.
]

{ #category : #queries }
OverloadCard >> setTargetAs: playerName [
	target := playerName.
]
