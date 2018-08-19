*Calypso-SystemTools-QueryBrowser
trySpawnFullBrowserInsteadOfQueryBrowserOn: aQuery
	| result itemCount item |
	result := aQuery semiAsync execute.
	result isBuilt ifFalse: [ ^false]. "Can't do it with long queries"
	itemCount := result size.
	itemCount > 1 ifTrue: [ ^false ].
	itemCount = 0 ifTrue: [ 
		self inform: 'No result found'. 
		^true "because we avoided query browser" ].
	
	^self spawnBrowser: ClyFullBrowser withState: [ :browser | 
		item := result itemAt: 1.
		item calypsoEnvironmentType selectItem: item inFullBrowser: browser]