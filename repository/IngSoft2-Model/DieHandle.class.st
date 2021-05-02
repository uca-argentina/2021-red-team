Class {
	#name : #DieHandle,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DieHandle class >> with: dice [
	dice ifEmpty: [ self error: 'cannot create an empty die handle' ].
	^ self new initializeWith: dice.
]

{ #category : #actions }
DieHandle >> addDie: aDie [ 
	dice add: aDie.
]

{ #category : #initialize }
DieHandle >> initializeWith: anArrayOfDie [
	dice := anArrayOfDie.
]

{ #category : #actions }
DieHandle >> roll [
	^ dice sum: [ :aDie | aDie roll ].
]
