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

{ #category : #queries }
OverloadCard >> = anotherObject [ 
	^ ((self class = anotherObject class) and: [target = anotherObject target]).
]

{ #category : #actions }
OverloadCard >> effectOn: playerName [
	^ target = playerName
		ifTrue: [ -2 ]
		ifFalse: [ 0 ]
]

{ #category : #queries }
OverloadCard >> equalsCard: aCard [
	^ ((self className = aCard className) & (target = aCard target)).
]

{ #category : #actions }
OverloadCard >> from: player activateEffect: game [
	( game whosTurnIsIt = player name) ifFalse: [ self error: 'cant use a permanent card on anothers turn' ].
	game addToPermanentCards: self.
]

{ #category : #queries }
OverloadCard >> hash [ 
	^ self target hash.
]

{ #category : #initialize }
OverloadCard >> initializeWithTarget: player [
	target := player.
]

{ #category : #queries }
OverloadCard >> setTargetAs: playerName [
	target := playerName.
]

{ #category : #queries }
OverloadCard >> target [
	^ target
]
