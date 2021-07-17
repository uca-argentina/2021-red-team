Class {
	#name : #AtomicBombCell,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
AtomicBombCell >> activateEffect: circularBoard from: playerName with: cardDealer [
	circularBoard moveEveryoneToTheBeginningOfTheLap.
]
