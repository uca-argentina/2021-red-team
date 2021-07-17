Class {
	#name : #WormHoleCell,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHoleCell >> activateEffect: circularBoard from: playerName with: cardDealer [
	circularBoard updatePositionOf: playerName with: -4.
]
