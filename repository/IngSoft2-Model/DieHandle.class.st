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

{ #category : #actions }
DieHandle >> addDie: aDie [ 
	dice add: aDie.
]

{ #category : #initialize }
DieHandle >> initializeWithDie: aDie [ 
	dice := OrderedCollection new.
	dice add: aDie.
]

{ #category : #actions }
DieHandle >> roll [
	^ dice sum: [ :aDie | aDie roll ].
]
