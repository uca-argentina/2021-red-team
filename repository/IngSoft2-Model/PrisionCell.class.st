Class {
	#name : #PrisionCell,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
PrisionCell >> activateEffect: aCircularBoard from: playerName  with: aCardDealer [ 
	aCircularBoard takeToPrision: playerName.
]
