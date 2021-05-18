Class {
	#name : #RandomSource,
	#superclass : #Object,
	#instVars : [
		'pool'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomSource class >> basedOn: aPool [
	aPool ifEmpty: [ self error: 'cant create a RandomSource without a pool' ].
	^self new initializeWith: aPool .
]

{ #category : #initialize }
RandomSource >> initializeWith: aPool [
	pool := aPool .
]

{ #category : #action }
RandomSource >> produce: size [
	| collection |
	collection := OrderedCollection new.
	size timesRepeat: [ collection add: (pool atRandom) ].
	^collection.
]
