Extension { #name : #Behavior }

{ #category : #'*Calypso-SystemQueries' }
Behavior >> calypsoEnvironmentType [
	^ClyClass
]

{ #category : #'*Calypso-SystemQueries' }
Behavior >> canOverrideMethod: aMethod [
	(self inheritsFrom: aMethod origin) ifTrue: [ ^true ].
	
	"Following ugly check is to not break in case when no traits exists.
	Normal solution would be to delegate logic to metaclass 
	where traited classes will have own behavior but this mechanizm exists only in Pharo7.
	For compatibility with pharo6 trait analysis is hardcoded just here"
	(self respondsTo: #traits) ifFalse: [ ^false ].
	
	(self traits anySatisfy: [ :eachTrait | 
		eachTrait = aMethod origin or: [eachTrait canOverrideMethod: aMethod ]])
			ifTrue: [ ^true ].
	
	self isRootInEnvironment ifTrue: [ ^false ].
	^superclass canOverrideMethod: aMethod
]

{ #category : #'*Calypso-SystemQueries' }
Behavior >> includesMethodsAffectedBy: aSystemAnnouncement [
	^aSystemAnnouncement affectsMethodsDefinedInClass: self 

]

{ #category : #'*Calypso-SystemQueries' }
Behavior >> metaLevelScope [
	^self isInstanceSide ifTrue: [ ClyInstanceSideScope ] ifFalse: [ ClyClassSideScope ]
]

{ #category : #'*Calypso-SystemQueries' }
Behavior >> overridesMethod: aMethod [

	^(self canOverrideMethod: aMethod)
			and: [ (self lookupSelector: aMethod selector) originMethod ~~ aMethod]
]

{ #category : #'*Calypso-SystemQueries' }
Behavior >> relationStatusOfMethod: aMethod [

	(self inheritsFrom: aMethod origin) ifTrue: [ ^self statusOfInheritedMethod: aMethod ].
	
	"Following ugly check is to not break in case when no traits exists.
	Normal solution would be to delegate logic to metaclass 
	where traited classes will have own behavior but this mechanizm exists only in Pharo7.
	For compatibility with pharo6 trait analysis is hardcoded just here"
	(self respondsTo: #traits) ifFalse: [ ^ClyMethodWasNotInheritedStatus ].

	self traits do: [ :eachTrait | 
		eachTrait = aMethod origin ifTrue: [ ^self statusOfInheritedTraitMethod: aMethod ]].
	self traits do: [ :eachTrait | | status |
		status := eachTrait relationStatusOfMethod: aMethod.
		status isMethodInherited ifTrue: [ ^status ] ].
	
	self isRootInEnvironment ifTrue: [ ^ClyMethodWasNotInheritedStatus ].
	^superclass relationStatusOfMethod: aMethod
]

{ #category : #'*Calypso-SystemQueries' }
Behavior >> statusOfInheritedMethod: aMethod [

	^(self lookupSelector: aMethod selector)
		ifNil: [ ClyInheritedMethodWasRemovedStatus ]
		ifNotNil: [ :actualMethod | 
			actualMethod originMethod == aMethod
				ifTrue: [ClyInheritedMethodIsActiveStatus]
				ifFalse: [ClyInheritedMethodIsOverriddenStatus]]
]
