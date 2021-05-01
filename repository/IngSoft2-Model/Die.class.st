Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Die class >> withFaces: aNumberOfFaces [
	(aNumberOfFaces > 3 ) ifFalse: [ self error: 'invalid number of faces' ].
	^ self new initializeWithFaces: aNumberOfFaces.
]

{ #category : #queries }
Die >> faces [
	^ faces.
]

{ #category : #initialize }
Die >> initializeWithFaces: aNumberOfFaces [
	faces := aNumberOfFaces.
	
]

{ #category : #actions }
Die >> roll [
	self subclassResponsibility.
]
