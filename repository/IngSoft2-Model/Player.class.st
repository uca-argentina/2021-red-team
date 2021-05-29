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
Player >> getCard: aCardClass [
	| card |
	card := cards
		detect: [ :aCard | aCard className = aCardClass ]
		ifNone: [ self error: 'cant use a card you dont have' ].
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
Player >> set: playerName asTargetOf: aCardClass [
	| card |
	card := cards
		detect: [ :aCard | aCard className = aCardClass ]
		ifFound: [ :aCard | aCard setTargetAs: playerName ] 
		ifNone: [ self error: 'cant use a card you dont have' ].
	^ card.
		
]

{ #category : #actions }
Player >> setCancellationCardToRemove: aCardClass withTarget: aPlayer [ 
	| card |
	card := cards
		detect: [ :aCard | aCard className = 'CancellationCard' ]
		ifFound: [ :aCard | aCard setTargetAs: (aCardClass withTarget: aPlayer)]
		ifNone: [ self error: 'cant use a card you dont have' ].
	^ card.
]
