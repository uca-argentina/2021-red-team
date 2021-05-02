Class {
	#name : #RandomDie,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomDie class >> withFaces: aNumberOfFaces [
	(aNumberOfFaces > 3 ) ifFalse: [ self error: 'invalid number of faces' ].
	^ self new initializeWithFaces: aNumberOfFaces.
]

{ #category : #queries }
RandomDie >> faces [
	^ faces.
]

{ #category : #initialize }
RandomDie >> initializeWithFaces: aNumberOfFaces [
	faces := aNumberOfFaces.
	
]

{ #category : #actions }
RandomDie >> roll [
	^ faces atRandom.
]
