Class {
	#name : #DieHandle,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DieHandle class >> withDie: aDie [
	^ self new initializeWithDie: aDie.
]

{ #category : #'as yet unclassified' }
DieHandle >> addDie: aDie [ 
	dice add: aDie.
]

{ #category : #initialize }
DieHandle >> initializeWithDie: aDie [ 
	dice := OrderedCollection new.
	dice add: aDie.
]

{ #category : #'as yet unclassified' }
DieHandle >> numberOfDice [
	^ dice size.
]

{ #category : #'as yet unclassified' }
DieHandle >> roll [
	^ dice sum: [ :aDie | aDie roll ].
]
