Class {
	#name : #RandomSource,
	#superclass : #Object,
	#instVars : [
		'pool',
		'randomness'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomSource class >> basedOn: eventsDistribution [
	eventsDistribution ifEmpty: [ self error: 'cant create a RandomSource without a events distribution' ].
	^self new initializeWith: eventsDistribution .
]

{ #category : #initialize }
RandomSource >> initializeWith: eventsDistribution [
	randomness := Random new.
	pool := OrderedCollection new.
	eventsDistribution
		do: [ :probabilityEvent | 
			pool
				add: probabilityEvent event
				withOccurrences: (probabilityEvent probability * 100) asInteger ].
]

{ #category : #actions }
RandomSource >> produce: size [
	| collection |
	collection := OrderedCollection new.
	size timesRepeat: [ collection add: (pool atRandom: randomness) copy  ].
	^collection.
]
