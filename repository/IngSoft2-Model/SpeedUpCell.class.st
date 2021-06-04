Class {
	#name : #SpeedUpCell,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedUpCell >> activateEffect: circularBoard from: playerName with: aRedGame [ 
	circularBoard updatePositionOf: playerName with: 4.
]
