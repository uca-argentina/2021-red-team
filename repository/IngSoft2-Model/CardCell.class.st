Class {
	#name : #CardCell,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
CardCell >> activateEffect: board from: aPlayerName with: cardsHandler [
	cardsHandler addCardTo: aPlayerName.
]
