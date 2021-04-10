Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Dice class >> withFaces: aNumberOfFaces [ 
	^ self new initializeWithFaces: aNumberOfFaces.
]

{ #category : #'as yet unclassified' }
Dice >> faces [
	^ faces.
]

{ #category : #initialize }
Dice >> initializeWithFaces: aNumberOfFaces [

	faces := aNumberOfFaces.
	
]

{ #category : #'as yet unclassified' }
Dice >> roll [
	^ (faces//2)+1.
]
