Class {
	#name : #SpeedUpCell,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedUpCell >> activateEffect: circularBoard from: playerName with: cardDealer [ 
	circularBoard updatePositionOf: playerName with: 4.
]
