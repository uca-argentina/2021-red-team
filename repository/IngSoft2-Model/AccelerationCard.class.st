Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
AccelerationCard >> effectOn: playerName [
	^ 1.
]

{ #category : #actions }
AccelerationCard >> from: playerName activateEffect: game [ 
	( game whosTurnIsIt = playerName ) ifFalse: [ self error: 'cant use a permanent card on anothers turn' ].
	game addToPermanentCards: self.
]
