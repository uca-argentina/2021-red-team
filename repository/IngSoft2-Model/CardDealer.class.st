Class {
	#name : #CardDealer,
	#superclass : #Object,
	#instVars : [
		'assignatedCards',
		'deck',
		'lastMove',
		'permanentEffects'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardDealer class >> with: players with: aNumberOfAssignatedCards andWith: deck [ 
	(aNumberOfAssignatedCards >= 0) ifFalse: [ self error: 'invalid number of initial cards' ].
	^ self new initializeWith: aNumberOfAssignatedCards with: players andWith: deck.
]

{ #category : #actions }
CardDealer >> accumulatePermanentEffectsOn: player [
	^ permanentEffects ifEmpty: [ 0 ] ifNotEmpty: [permanentEffects sum: [ :move | move effectOn: player]].
]

{ #category : #actions }
CardDealer >> addCardTo: aPlayerName [
	assignatedCards add: (AssignatedCard from: aPlayerName with: deck takeACard).
]

{ #category : #actions }
CardDealer >> addPermanentEffect: aMove [
	permanentEffects add: aMove copy.
]

{ #category : #actions }
CardDealer >> assertIfCardIsAssignated: aMove [
	assignatedCards
		detect: [ :assignatedCard | 
			assignatedCard isAssignated: aMove card to: aMove source ]
		ifFound: [ :assignatedCard | assignatedCards remove: assignatedCard ]
		ifNone: [ self error: 'cant use a card thats not yours' ]
]

{ #category : #actions }
CardDealer >> handle: aMove with: aGame [ 
	self assertIfCardIsAssignated: aMove.
	aMove activateEffect: aGame .
	self updateLastMove: aMove.
	deck addCardToDiscardedDeck: aMove card.
]

{ #category : #initialize }
CardDealer >> initializeWith: aNumberOfAssignatedCards with: players andWith: aDeck [
	| auxCards |
	auxCards := OrderedCollection new.
	players do: [ :playerName | aNumberOfAssignatedCards timesRepeat: [auxCards add: (AssignatedCard from: playerName with: (aDeck takeACard))]].
	assignatedCards := auxCards.
	deck := aDeck.
	permanentEffects := OrderedCollection new.
]

{ #category : #actions }
CardDealer >> removePermanentEffect: aMove [
	permanentEffects ifEmpty: [ self error: 'there are no permanent cards' ].
	(permanentEffects anySatisfy: [ :move | move equalsMove: aMove ]) ifFalse: [ self error: 'Cant cancel a card that wasnt played' ].
	permanentEffects := permanentEffects reject: [ :move | move equalsMove: aMove ].
]

{ #category : #actions }
CardDealer >> updateLastMove: aMove [
	(aMove card equals: RedoCard new)
		ifFalse: [ lastMove := aMove copy ]
]

{ #category : #actions }
CardDealer >> useLastCardEffectWith: aMove andWith: aGame [
	| newCard newMove |
	lastMove ifNil: [ self error: 'Cant use a Redo Card without previews moves' ].
	newCard := lastMove card copy.
	newMove := aMove changeCard: newCard.
	newMove activateEffect: aGame .
]
