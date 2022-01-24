Class {
	#name : #LoadedDeck,
	#superclass : #Object,
	#instVars : [
		'cards',
		'activeDeck',
		'discardedDeck'
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
	activeDeck := someCards.
	discardedDeck := OrderedCollection new.
]

{ #category : #actions }
LoadedDeck >> remakeActiveDeckIfEmpty [
	| auxDeck |
	activeDeck ifEmpty: [ self discardedDeckIsEmpty.
		auxDeck := discardedDeck shuffled.
		activeDeck := auxDeck.
		discardedDeck removeAll]
	
	
]

{ #category : #queries }
LoadedDeck >> sizeOfActiveDeck [
	^ activeDeck size.
]

{ #category : #queries }
LoadedDeck >> sizeOfDiscardedDeck [
	^ discardedDeck size.
]

{ #category : #actions }
LoadedDeck >> takeACard [
	self remakeActiveDeckIfEmpty.
	^ activeDeck removeFirst.
]
