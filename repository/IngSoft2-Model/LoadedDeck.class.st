Class {
	#name : #LoadedDeck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LoadedDeck class >> with: cards [
	cards ifEmpty: [ self error: 'Cannot create a LoadedDeck without cards' ].
	^ self new intializeWith: cards .
]

{ #category : #initialize }
LoadedDeck >> intializeWith: someCards [ 
	cards := someCards.
]

{ #category : #actions }
LoadedDeck >> takeACard [
	^ cards removeFirst.
]
