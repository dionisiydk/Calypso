Class {
	#name : #ClySuperclassAndInheritedTraitScopeTest,
	#superclass : #ClyMultipleClassRelationScopeTest,
	#category : #'Calypso-SystemPlugins-Traits-Queries-Tests'
}

{ #category : #tests }
ClySuperclassAndInheritedTraitScopeTest >> testClassEnumerationWhenClassAndSuperclassHaveTraits [

	| expected |
	scope := ClyMultipleClassRelationScope 
		of: { ClySubclassWithTraitsOfClassWithTraits }
		merging: {ClySuperclassScope. ClyInheritedTraitScope }.
	
	scope classesDo: [ :each | result add: each].
	
	expected := { Object. ProtoObject. ClyClassWithTraits }
		, ClyClassWithTraits traitComposition allTraits
		, ClySubclassWithTraitsOfClassWithTraits traitComposition allTraits.
	self assert: result asArray equals: (expected asSortedCollection: #name ascending) asArray
]

{ #category : #tests }
ClySuperclassAndInheritedTraitScopeTest >> testClassEnumerationWhenNoTraitsExist [

	scope := ClyMultipleClassRelationScope 
		of: { ClyClassWithoutTraits } merging: {ClySuperclassScope. ClyInheritedTraitScope }.
	
	scope classesDo: [ :each | result add: each].
	
	self assert: result asSet equals: {Object. ProtoObject} asSet
]

{ #category : #tests }
ClySuperclassAndInheritedTraitScopeTest >> testClassEnumerationWhenRootClassHasTraits [

	| expected |
	scope := ClyMultipleClassRelationScope 
		of: { ClyClassWithTraits } merging: {ClySuperclassScope. ClyInheritedTraitScope }.
	
	scope classesDo: [ :each | result add: each].
	
	expected := { Object. ProtoObject }, ClyClassWithTraits traitComposition allTraits.
	self assert: result asSet equals: expected asSet
]
