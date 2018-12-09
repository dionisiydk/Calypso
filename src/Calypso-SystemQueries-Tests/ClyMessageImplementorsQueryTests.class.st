Class {
	#name : #ClyMessageImplementorsQueryTests,
	#superclass : #ClyMethodQueryTestCase,
	#category : #'Calypso-SystemQueries-Tests-Queries'
}

{ #category : #'methods for tests' }
ClyMessageImplementorsQueryTests class >> clyMessageImplementor1 [
]

{ #category : #'methods for tests' }
ClyMessageImplementorsQueryTests >> clyMessageImplementor1 [
]

{ #category : #running }
ClyMessageImplementorsQueryTests >> createQuery [
	^ ClyMessageImplementorsQuery
		of: self targetSelector
		from: (ClyClassScope of: Object in: environment)
]

{ #category : #'methods for tests' }
ClyMessageImplementorsQueryTests >> messageImplementor2 [
]

{ #category : #running }
ClyMessageImplementorsQueryTests >> targetSelector [
	^#clyMessageImplementor1
]

{ #category : #tests }
ClyMessageImplementorsQueryTests >> testCheckIfEmpty [
	query scope: (ClyMethodScope of: (self class >> self targetSelector) in: environment).
	self deny: query checkEmptyResult.
	
	query scope: (ClyMethodScope of: (self class >> #messageImplementor2) in: environment).
	self assert: query checkEmptyResult
]

{ #category : #tests }
ClyMessageImplementorsQueryTests >> testComparison [

	self 
		assert: (ClyMessageImplementorsQuery of: #message1) 
		equals: (ClyMessageImplementorsQuery of: #message1).
	
	self 
		assert: (ClyMessageImplementorsQuery of: #message1) hash 
		equals: (ClyMessageImplementorsQuery of: #message1) hash.
		
	self deny: (ClyMessageImplementorsQuery of: #message1) = (ClyMessageImplementorsQuery of: #message2)
]

{ #category : #tests }
ClyMessageImplementorsQueryTests >> testFromClassScope [
	
	self queryFromScope: ClyBothMetaLevelClassScope of: self class.
	
	self assert: resultItems size equals: 2.	
	self assert: (resultItems identityIncludes: (self class >> self targetSelector)).
	self assert: (resultItems identityIncludes: (self class classSide >> self targetSelector)).
]

{ #category : #tests }
ClyMessageImplementorsQueryTests >> testFromMethodScope [
	
	self 
		queryFromScope: ClyMethodScope 
		ofAll: { self class >> self targetSelector. self class >> #messageImplementor2 }.
	
	self assert: resultItems size equals: 1.
	self assert: resultItems first == (self class >> self targetSelector)
]

{ #category : #tests }
ClyMessageImplementorsQueryTests >> testFromPackageScope [
	
	self queryFromScope: ClyPackageScope of: self class package.
	
	self assert: resultItems size equals: 3.	
	self assert: (resultItems identityIncludes: self class >> self targetSelector).
	self assert: (resultItems identityIncludes: self class classSide >> self targetSelector).
	self assert: (resultItems identityIncludes: self class superclass >> self targetSelector).
]

{ #category : #tests }
ClyMessageImplementorsQueryTests >> testFromSystemScope [

	self queryFromScope: ClySystemEnvironmentScope of: ClySystemEnvironment currentImage.
	
	self assert: resultItems size equals: 3.	
	self assert: (resultItems identityIncludes: self class >> self targetSelector).
	self assert: (resultItems identityIncludes: self class classSide >> self targetSelector).
	self assert: (resultItems identityIncludes: self class superclass >> self targetSelector).
]