Trait {
	#name : #ClyTraitChild3,
	#traits : 'ClyTraitRoot1 + ClyTraitRoot2',
	#classTraits : 'ClyTraitRoot1 classTrait + ClyTraitRoot2 classTrait',
	#category : #'Calypso-SystemPlugins-Traits-Queries-Tests-PWithTraits'
}

{ #category : #'as yet unclassified' }
ClyTraitChild3 >> methodFromRoot1 [
	^#overriddenTraitMethodInTrait
]

{ #category : #'as yet unclassified' }
ClyTraitChild3 >> methodFromTraitChild3 [
]
