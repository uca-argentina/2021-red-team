Class {
	#name : #LoadedDeck,
	#superclass : #Object,
	#instVars : [
		'cards',
		'discardedDeck',
		'drawDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LoadedDeck class >> with: cards [
	cards ifEmpty: [ self error: 'Cannot create a LoadedDeck without cards' ].
	^ self new intializeWith: cards .
]

{ #category : #actions }
LoadedDeck >> addCardToDiscardedDeck: card [
	discardedDeck add: card.
]

{ #category : #queries }
LoadedDeck >> discardedDeckIsEmpty [
	discardedDeck ifEmpty: [ self error: 'cant take a card when both decks are empty' ].
	
	
]

{ #category : #initialize }
LoadedDeck >> intializeWith: someCards [ 
	drawDeck := someCards.
	discardedDeck := OrderedCollection new.
]

{ #category : #actions }
LoadedDeck >> remakeDrawDeckIfEmpty [
	| auxDeck |
	drawDeck ifEmpty: [ self discardedDeckIsEmpty.
		auxDeck := discardedDeck shuffled.
		drawDeck := auxDeck.
		discardedDeck removeAll]
	
	
]

{ #category : #queries }
LoadedDeck >> sizeOfDiscardedDeck [
	^ discardedDeck size.
]

{ #category : #queries }
LoadedDeck >> sizeOfDrawDeck [
	^ drawDeck size.
]

{ #category : #actions }
LoadedDeck >> takeACard [
	self remakeDrawDeckIfEmpty.
	^ drawDeck removeFirst.
]
