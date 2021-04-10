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
	^ self new initializeWithFaces: aNumberOfFaces.
]

{ #category : #'as yet unclassified' }
Die >> faces [
	^ faces.
]

{ #category : #initialize }
Die >> initializeWithFaces: aNumberOfFaces [

	faces := aNumberOfFaces.
	
]

{ #category : #'as yet unclassified' }
Die >> roll [
	^ (faces//2)+1.
]
