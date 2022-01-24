Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cardsSource',
		'activeDeck',
		'discardedDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> with: aRandomSource andSize: amountOfCards [
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
	activeDeck := cardsSource produce: amountOfCards.
	discardedDeck := OrderedCollection new.
]

{ #category : #actions }
Deck >> remakeActiveDeckIfEmpty [
	| auxDeck |
	activeDeck ifEmpty: [ self discardedDeckIsEmpty. 
		auxDeck := discardedDeck shuffled.
		activeDeck := auxDeck.
		discardedDeck removeAll]
]

{ #category : #queries }
Deck >> sizeOfActiveDeck [
	^ activeDeck size.
]

{ #category : #queries }
Deck >> sizeOfDiscardedDeck [
	^ discardedDeck size.
]

{ #category : #actions }
Deck >> takeACard [
	self remakeActiveDeckIfEmpty.
	^ activeDeck removeFirst.
]
