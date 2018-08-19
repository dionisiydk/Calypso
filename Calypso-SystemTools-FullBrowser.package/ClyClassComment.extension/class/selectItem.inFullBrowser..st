*Calypso-SystemTools-FullBrowser
selectItem: aClassComment inFullBrowser: aFullBrowser

	aFullBrowser tabManager 
		swapPrioritiesBetween: ClyClassCommentEditorTool new and: ClyClassDefinitionEditorTool new;
		desiredSelection: {ClyClassCommentEditorTool}.
	aFullBrowser selectClass: aClassComment definingClass