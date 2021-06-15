Class {
	#name : #CardDealer,
	#superclass : #Object,
	#instVars : [
		'assignatedCards',
		'deck',
		'permanentMoves',
		'lastMove'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardDealer class >> with: players with: aNumberOfAssignatedCards andWith: deck [ 
	| auxCards |
	(aNumberOfAssignatedCards >= 0) ifFalse: [ self error: 'invalid number of initial cards' ].
	auxCards := OrderedCollection new.
	players do: [ :playerName | aNumberOfAssignatedCards timesRepeat: [auxCards add: (AssignatedCard from: playerName with: (deck takeACard))]].
	^ self new initializeWith: auxCards andWith: deck.
]

{ #category : #initialize }
CardDealer >> accumulatePermanentEffectsOn: player [
	^ permanentMoves ifEmpty: [ 0 ] ifNotEmpty: [permanentMoves sum: [ :move | move effectOn: player]].
]

{ #category : #initialize }
CardDealer >> addCardTo: aPlayerName [
	assignatedCards add: (AssignatedCard from: aPlayerName with: deck takeACard).
]

{ #category : #initialize }
CardDealer >> addToPermanentMoves: aMove [
	permanentMoves add: aMove copy.
]

{ #category : #initialize }
CardDealer >> amountOfMoves [
	^ assignatedCards size.
]

{ #category : #initialize }
CardDealer >> handle: aMove with: aGame [
	self verifyIfCardIsAssignated: aMove.
	aMove activateEffect: aGame.
	self updateLastMove: aMove
]

{ #category : #initialize }
CardDealer >> initializeWith: auxAssignatedCards andWith: aDeck [
	assignatedCards := auxAssignatedCards.
	deck := aDeck.
	permanentMoves := OrderedCollection new.
]

{ #category : #initialize }
CardDealer >> removePermanentMove: aMove [ 
	permanentMoves ifEmpty: [ self error: 'there are no permanent cards' ].
	(permanentMoves anySatisfy: [ :move | move equalsMove: aMove ]) ifFalse: [self error: 'Cant cancel a card that wasnt played' ].
	permanentMoves := permanentMoves reject: [ :move | move equalsMove: aMove ].
]

{ #category : #initialize }
CardDealer >> updateLastMove: aMove [
	(aMove card equals: RedoCard new)
		ifFalse: [ lastMove := aMove copy ]
]

{ #category : #initialize }
CardDealer >> useLastCardEffectWith: aMove andWith: aGame [
	| newCard newMove |
	lastMove ifNil: [ self error: 'Cant use a Redo Card without previews moves' ].
	newCard := lastMove card copy.
	newMove := aMove changeCard: newCard.
	assignatedCards add: (AssignatedCard from: newMove source with: newMove card).
	self handle: newMove with: aGame.
]

{ #category : #initialize }
CardDealer >> verifyIfCardIsAssignated: aMove [
	assignatedCards
		detect: [ :assignatedCard | 
			assignatedCard player = aMove source
				and: [ assignatedCard card equals: aMove card ] ]
		ifFound: [ :assignatedCard | assignatedCards remove: assignatedCard ]
		ifNone: [ self error: 'cant use a card thats not yours' ]
]
