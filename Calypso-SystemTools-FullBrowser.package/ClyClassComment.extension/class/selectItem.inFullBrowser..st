*Calypso-SystemTools-FullBrowser
selectItem: aClassComment inFullBrowser: aFullBrowser

	aFullBrowser selectClass: aClassComment definingClass.
	aFullBrowser tabManager desiredSelection: {ClyClassCommentEditorTool}.