Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Player class >> with: aName andWith: cards [
	cards ifEmpty: [ self error: 'invalid number of cards' ].
	^ self new initializeWith: aName andWith: cards.
]

{ #category : #actions }
Player >> addCard: aCard [
	cards add: aCard.
]

{ #category : #actions }
Player >> getCard: aCardClass [
	| card |
	card := cards
		detect: [ :aCard | aCard className = aCardClass ]
		ifNone: [ self error: 'cant use a card you dont have' ].
	^ card.
]

{ #category : #queries }
Player >> getCard: aCardClass  withTarget: objetive [ 
	| auxiliaryCards card |
	auxiliaryCards := cards select: [ :aCard | aCard className = aCardClass ].
	auxiliaryCards ifEmpty: [ self error: 'cant use a card you dont have' ].
	card := auxiliaryCards detect: [ :aCard | (aCard target) = objetive  ] 
		ifNone: [ self error: 'the player doesnt have a card of that class with that target' ]. 
	^ card.
]

{ #category : #queries }
Player >> hasCard: aCard [ 
	^ cards includes: aCard. 
]

{ #category : #initialize }
Player >> initializeWith: aName andWith: someCards [ 
	name := aName.
	cards := someCards.
]

{ #category : #queries }
Player >> name [
	^ name
]

{ #category : #queries }
Player >> numberOfCards [
	^ cards size.
]

{ #category : #actions }
Player >> removeCard: aCard [ 
	cards remove: aCard.
]

{ #category : #actions }
Player >> set: objetive asTargetOf: aCardClass [
	| card |
	card := cards
		detect: [ :aCard | aCard className = aCardClass ]
		ifNone: [ self error: 'cant use a card you dont have' ].
	cards remove: card.
	card setTargetAs: objetive.
	cards add: card.
]
