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
	| probability |
	eventsDistribution ifEmpty: [ self error: 'cant create a RandomSource without a events distribution' ].
	probability := eventsDistribution sum: [ :event | event probability].
	(probability < 0.99 or: [probability > 1.01]) ifTrue: [ self error: 'The sum of all events probabilities must be 1' ].
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
	(size < 1) ifTrue: [ self error: 'Cant produce an invalid number of items' ].
	collection := OrderedCollection new.
	size timesRepeat: [ collection add: (pool atRandom: randomness) copy  ].
	^collection.
]
