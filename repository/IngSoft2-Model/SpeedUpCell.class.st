Class {
	#name : #SpeedUpCell,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedUpCell >> activateEffect: circularBoard and: playerName [
	 circularBoard updatePositionOf: playerName with: 4.
]
