Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cardsSource',
		'discardedDeck',
		'drawDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> with: aRandomSource andSize: amountOfCards [
	(amountOfCards = 0) ifTrue: [ self error: 'Cant create a Deck without cards' ].
	^ self new initializeWith: aRandomSource andWith: amountOfCards.
]

{ #category : #actions }
Deck >> addCardToDiscardedDeck: card [
	discardedDeck add: card.
]

{ #category : #queries }
Deck >> discardedDeckIsEmpty [
	discardedDeck ifEmpty: [ self error: 'cant take a card when both decks are empty' ].
	
]

{ #category : #initialize }
Deck >> initializeWith: aRandomSource andWith: amountOfCards [
	cardsSource:= aRandomSource.
	drawDeck := cardsSource produce: amountOfCards.
	discardedDeck := OrderedCollection new.
]

{ #category : #actions }
Deck >> remakeDrawDeckIfEmpty [
	| auxDeck |
	drawDeck ifEmpty: [ self discardedDeckIsEmpty. 
		auxDeck := discardedDeck shuffled.
		drawDeck := auxDeck.
		discardedDeck removeAll]
]

{ #category : #queries }
Deck >> sizeOfDiscardedDeck [
	^ discardedDeck size.
]

{ #category : #queries }
Deck >> sizeOfDrawDeck [
	^ drawDeck size.
]

{ #category : #actions }
Deck >> takeACard [
	self remakeDrawDeckIfEmpty.
	^ drawDeck removeFirst.
]
