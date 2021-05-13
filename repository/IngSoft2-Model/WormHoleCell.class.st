Class {
	#name : #WormHoleCell,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHoleCell >> activateEffect: circularBoard and: playerName [
	 circularBoard updatePositionOf: playerName with: -4.
]
