Class {
	#name : #AtomicBombCell,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
AtomicBombCell >> activateEffect: circularBoard and: playerName [
	circularBoard moveEveryoneToTheBeginningOfTheLap.
]
