Class {
	#name : #RandomSource,
	#superclass : #Object,
	#instVars : [
		'structure'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomSource class >> basedOn: aStructure [
	| percentage |
	percentage := aStructure sum: [ :aDistribution | aDistribution proportion  ].
	(percentage = 1) ifFalse: [ self error: 'invalid amounts of proportions, must sum 1' ]. 
	^self new initializeWith: aStructure .
]

{ #category : #initialize }
RandomSource >> initializeWith: aStructure [
	structure := aStructure .
]

{ #category : #action }
RandomSource >> produce: size [
	| collection amountOf |
	collection := OrderedCollection new.
	structure do: [ :aDistribution |  
		amountOf := ((aDistribution proportion)*size) asInteger .
		amountOf timesRepeat: [ collection add: (aDistribution elementType) ].
		].
	^ collection shuffle.
]
