Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LoadedDie class >> withFaces: aNumberOfFaces [
	(aNumberOfFaces > 3 ) ifFalse: [ self error: 'invalid number of faces' ].
	^ self new initializeWithFaces: aNumberOfFaces.
]

{ #category : #initialize }
LoadedDie >> initializeWithFaces: aNumberOfFaces [
	faces := aNumberOfFaces.
	
]

{ #category : #actions }
LoadedDie >> roll [
	^ faces.
]
