Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cardsSource'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> with: aRandomSource [ 
	^ self new initializeWith: aRandomSource.
]

{ #category : #initialize }
Deck >> initializeWith: aRandomSource [ 
	cardsSource:= aRandomSource.
]

{ #category : #actions }
Deck >> takeACard [
	^ (cardsSource produce: 1) first.
]
