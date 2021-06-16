Class {
	#name : #RandomDie,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomDie class >> with: aNumberOfFaces [
	(aNumberOfFaces >= 3 ) ifFalse: [ self error: 'invalid number of faces' ].
	^ self new initializeWith: aNumberOfFaces.
]

{ #category : #initialize }
RandomDie >> initializeWith: aNumberOfFaces [
	faces := aNumberOfFaces.
	
]

{ #category : #actions }
RandomDie >> roll [
	^ faces atRandom.
]
