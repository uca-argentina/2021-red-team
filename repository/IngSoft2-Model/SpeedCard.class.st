Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedCard >> effectOn: playerName [
	^ target = playerName
		ifTrue: [ 1 ]
		ifFalse: [ 0 ]
]

{ #category : #queries }
SpeedCard >> equalsCard: aCard [
	^ ((self className = aCard className) & (target = aCard target)).
]

{ #category : #actions }
SpeedCard >> from: playerName activateEffect: game [ 
	( game whosTurnIsIt = playerName ) ifFalse: [ self error: 'cant use a permanent card on anothers turn' ].
	game addToPermanentCards: self.
]

{ #category : #actions }
SpeedCard >> setTargetAs: playerName [
	target := playerName.
]

{ #category : #'as yet unclassified' }
SpeedCard >> target [
	^ target.
]
