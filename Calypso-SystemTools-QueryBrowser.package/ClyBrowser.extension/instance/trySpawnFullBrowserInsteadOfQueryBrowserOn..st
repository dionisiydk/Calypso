*Calypso-SystemTools-QueryBrowser
trySpawnFullBrowserInsteadOfQueryBrowserOn: aQuery
	| result itemCount item |
	result := aQuery semiAsync execute.
	result isBuilt ifFalse: [ ^false]. "Can't do it with long queries"
	itemCount := result size.
	itemCount > 1 ifTrue: [ ^false ].
	itemCount = 0 ifTrue: [ 
		self inform: 'There are no ', aQuery description. 
		^true "because we avoided query browser" ].	
	self spawnBrowser: ClyFullBrowser withState: [ :browser | 
		item := result itemAt: 1. 
		item calypsoEnvironmentType selectItem: item inFullBrowser: browser].
	^true