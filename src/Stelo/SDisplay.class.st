Class {
	#name : #SDisplay,
	#superclass : #Morph,
	#instVars : [
		'modelExtent',
		'cell',
		'offset',
		'forceModelChanged',
		'sworld',
		'info',
		'stepTime',
		'whenStepsDo',
		'whenDoubleClickDo'
	],
	#category : #'Stelo-Morphic'
}

{ #category : #'instance creation' }
SDisplay class >> sworld: aWorld [
	^ self basicNew
		initialize;
		sworld: aWorld;
		yourself.
]

{ #category : #private }
SDisplay >> cell [
	^ cell
]

{ #category : #private }
SDisplay >> cell: aPoint [
	cell := aPoint
]

{ #category : #'event handling' }
SDisplay >> click: evt [
	| p |
	p := evt cursorPoint - self topLeft.
	p := self pointOf: p.
	self showBalloon: p asString
]

{ #category : #private }
SDisplay >> defaultExtent [
	^ 220 @ 220
]

{ #category : #private }
SDisplay >> doDoubleClickAt: aPoint [
	| pos |
	aPoint >= offset
		ifFalse: [ ^ self ].
	aPoint < (offset + (cell * modelExtent))
		ifFalse: [ ^ self ].
	pos := self pointOf: aPoint.
	whenDoubleClickDo ifNotNil: [ whenDoubleClickDo cull: pos ]
]

{ #category : #'event handling' }
SDisplay >> doubleClick: evt [
	| p |
	p := evt cursorPoint - self topLeft.
	self doDoubleClickAt: p
]

{ #category : #drawing }
SDisplay >> drawInfoOn: aCanvas [
	info ifNil: [ ^ self ].
	aCanvas
		drawString: info
		at: self topLeft + offset + (5 @ 5)
		font: nil
		color: Color white
]

{ #category : #drawing }
SDisplay >> drawOn: aCanvas [
	super drawOn: aCanvas.
	sworld ifNil: [ ^ aCanvas frameRectangle: self bounds color: Color red ].
	self modelChanged
		ifTrue: [ self updateCache ].
	self extent < modelExtent
		ifTrue: [ ^ self ].
	self drawWorldOn: aCanvas.
	self drawInfoOn: aCanvas.
]

{ #category : #drawing }
SDisplay >> drawWorldOn: aCanvas [
	| x0 x y colors index tc |
	colors := sworld colors.
	x0 := self left + offset x.
	y := self top + offset y + (cell y * (modelExtent y - 1)).
	index := 1.
	modelExtent y
		timesRepeat: [ x := x0.
			modelExtent x
				timesRepeat: [ tc := SColorList colorAt: (colors at: index).
					aCanvas fillRectangle: (x @ y extent: cell) color: tc.
					index := index + 1.
					x := x + cell x ].
			y := y - cell y ].
]

{ #category : #geometry }
SDisplay >> extent: aPoint [
	super extent: aPoint.
	forceModelChanged := true.
]

{ #category : #testing }
SDisplay >> forceModelChanged [
	^ forceModelChanged
]

{ #category : #'event handling' }
SDisplay >> handlesMouseDown: evt [
	^ true
]

{ #category : #accessing }
SDisplay >> info [
	^ info
]

{ #category : #accessing }
SDisplay >> info: aString [
	info := aString.
]

{ #category : #initialization }
SDisplay >> initialize [
	super initialize.
	self extent: self defaultExtent.
	self color: Color darkGray.
	forceModelChanged := true.
	info := ''.
	self stepTime: 1000
]

{ #category : #accessing }
SDisplay >> modelBounds [
	offset ifNil: [ ^ self bounds ].
	^ self topLeft + offset extent: modelExtent * cell
]

{ #category : #testing }
SDisplay >> modelChanged [
	^ forceModelChanged or: [ modelExtent ~= sworld extent ]
]

{ #category : #accessing }
SDisplay >> modelExtent [
	^ modelExtent
]

{ #category : #accessing }
SDisplay >> modelExtent: aPoint [
	modelExtent := aPoint
]

{ #category : #'event handling' }
SDisplay >> mouseDown: evt [
	evt hand newKeyboardFocus: nil.
	evt hand waitForClicksOrDrag: self event: evt
]

{ #category : #private }
SDisplay >> offset [
	^ offset
]

{ #category : #private }
SDisplay >> offset: aPoint [
	offset := aPoint
]

{ #category : #private }
SDisplay >> pointOf: aPoint [
	| p |
	p := (aPoint - offset) // cell - (modelExtent // 2) + (0 @ 1).
	^ p x @ p y negated
]

{ #category : #'stepping and presenter' }
SDisplay >> step [
	whenStepsDo ifNotNil: [ whenStepsDo value ]
]

{ #category : #accessing }
SDisplay >> stepTime [
	^ stepTime
]

{ #category : #accessing }
SDisplay >> stepTime: anInteger [
	stepTime := anInteger
]

{ #category : #accessing }
SDisplay >> sworld [
	^ sworld
]

{ #category : #accessing }
SDisplay >> sworld: aWorld [
	sworld := aWorld.
]

{ #category : #private }
SDisplay >> updateCache [
	forceModelChanged := false.
	modelExtent := sworld extent.
	cell := self extent // modelExtent.
	cell := 1 @ 1 * cell min.
	offset := (self extent - (modelExtent * cell)) // 2
]

{ #category : #'stepping and presenter' }
SDisplay >> wantsSteps [
	^ true
]

{ #category : #accessing }
SDisplay >> whenDoubleClickDo [
	^ whenDoubleClickDo
]

{ #category : #accessing }
SDisplay >> whenDoubleClickDo: aBlock [
	whenDoubleClickDo := aBlock
]

{ #category : #accessing }
SDisplay >> whenStepsDo [
	^ whenStepsDo
]

{ #category : #accessing }
SDisplay >> whenStepsDo: aBlock [
	whenStepsDo := aBlock
]
