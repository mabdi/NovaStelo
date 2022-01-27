"
A SMicroWorldTest is a test class for testing the behavior of SMicroWorld
"
Class {
	#name : #SMicroWorldTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #private }
SMicroWorldTest >> newWorld [
	| w |
	w := SMicroWorld new.
	w addBreed: SObserver new.
	w addBreed: SPatches new.
	w newBreed.
	^ w
]

{ #category : #'tests-command' }
SMicroWorldTest >> testAimHighPatchVarBreedId [
	| w v ret |
	w := self newWorld.
	w createPatch: 5.
	w create: 3 turtles: 1.
	v := w patches addVariable: 'a'.
	"
	21 22 23 24 25
	16 17 18 19 20
	11 12 13 14 15
	 6  7  8  9 10
	 1  2  3  4  5
"
	w x: 3 at: 1 put: 0.
	w y: 3 at: 1 put: 0.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 45.
	w
		var: v
		breed: 2
		at: 18
		put: 1.
	w
		var: v
		breed: 2
		at: 19
		put: 2.
	w
		var: v
		breed: 2
		at: 14
		put: 3.
	ret := w aimHighPatchVar: v breed: 3 id: 1.
	self assert: ret equals: -45.
	w
		var: v
		breed: 2
		at: 18
		put: 4.
	w
		var: v
		breed: 2
		at: 19
		put: 3.
	w
		var: v
		breed: 2
		at: 14
		put: 2.
	ret := w aimHighPatchVar: v breed: 3 id: 1.
	self assert: ret equals: 45.
	w
		var: v
		breed: 2
		at: 18
		put: 4.
	w
		var: v
		breed: 2
		at: 19
		put: 5.
	w
		var: v
		breed: 2
		at: 14
		put: 2.
	ret := w aimHighPatchVar: v breed: 3 id: 1.
	self assert: ret equals: 0.

	"
	21 22 23 24 25
	16 17 18 19 20
	11 12 13 14 15
	 6  7  8  9 10
	 1  2  3  4  5
"
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 90.
	w
		var: v
		breed: 2
		at: 16
		put: 1.
	w
		var: v
		breed: 2
		at: 17
		put: 1.
	w
		var: v
		breed: 2
		at: 18
		put: 2.
	w
		var: v
		breed: 2
		at: 19
		put: 3.
	w
		var: v
		breed: 2
		at: 20
		put: 3.
	ret := w aimHighPatchVar: v breed: 3 id: 1.
	self assert: ret equals: -45
]

{ #category : #'tests-accessing' }
SMicroWorldTest >> testBreedsOf [
	| w |
	w := SMicroWorld new.
	w addBreed: (STurtles new breedNo: 3).
	self assert: (w breedOf: 3) class equals: STurtles.
]

{ #category : #test }
SMicroWorldTest >> testClearPlots [
	| w ret |
	w := self newWorld.
	self assert: w plotList isCollection.
	self assert: w plotList isEmpty.
	w clearPlots.
	ret := w plotList.
	self assert: ret size equals: 1.
	self assert: ret first isClearPlot.
	self assert: w plotList isCollection.
	self assert: w plotList isEmpty.
]

{ #category : #'tests-accessing' }
SMicroWorldTest >> testClearRaisedEvents [
	| w |
	w := SMicroWorld new.
	self assert: w privRaisedEvents isEmpty.
	w raiseEvent: #a.
	self assert: w privRaisedEvents notEmpty.
	w clearRaisedEvents.
	self assert: w privRaisedEvents isEmpty.
]

{ #category : #'tests-accessing' }
SMicroWorldTest >> testColors [
	| w |
	w := self newWorld.
	w createPatch: 3.
	self assertCollection: w colors equals: #[0 0 0 0 0 0 0 0 0].
	w create: 3 turtles: 1.
	(w breedOf: 3) colorAt: 1 put: 12.
	self assertCollection: w colors equals: #[0 0 0 0 12 0 0 0 0].
	w patches colorAt: 1 put: 23.
	self assertCollection: w colors equals: #[23 0 0 0 12 0 0 0 0]
]

{ #category : #'as yet unclassified' }
SMicroWorldTest >> testColors_amp_A100 [

	"SmallAmp has derived this test from `SMicroWorldTest>>#testColors` by applying some transformations and regenerating its assertions.
	This test can cover this part:
	*	In `SMicroWorld>> #y:at:put:` from 250 to 262:
		Operation: ReplaceMinusWithPlusMutantOperator
		Code snippet: `(aNumber - y)`
		Dynamic state: {#aNumber->50. #y->-49.099998474121094}
		Mutant id: ReplaceMinusWithPlusMutantOperator#SMicroWorld#y:at:put:#250#262
"

	<madeBySmallAmp>
	| w |
	w := self newWorld.
	(w
		 createPatch: 3;
		 create: 3 turtles: 1;
		 breedOf: 3) colorAt: 1 put: 12.
	w
		patches;
		worldName
]

{ #category : #'as yet unclassified' }
SMicroWorldTest >> testColors_amp_L36_L40 [

	"SmallAmp has derived this test from `SMicroWorldTest>>#testColors` by applying some transformations and regenerating its assertions.
	This test can cover this part:
	*	In `SMicroWorld>> #scaleVar:color:breed:from:to:id:` from 55 to 263:
		Operation: ReplaceIfTrueIfFalseReceiverWithTrueOperator
		Code snippet: `bid = SBreedId observerBreedNo
	ifTrue: [ 
		self patches
			scaleVarNo: v
			color: c
			from: f
			to: t ]
	ifFalse: [ 
		(breeds at: bid)
			scaleVarNo: v
			color: c
			from: f
			to: t
			index: id ]`
		Dynamic state: nil
		Mutant id: ReplaceIfTrueIfFalseReceiverWithTrueOperator#SMicroWorld#scaleVar:color:breed:from:to:id:#55#263
"

	<madeBySmallAmp>
	| w |
	w := self newWorld.
	(w
		 createPatch: 3;
		 create: 3 turtles: 1;
		 breedOf: 3) colorAt: 1 put: 12.
	w patches
]

{ #category : #'as yet unclassified' }
SMicroWorldTest >> testColors_amp_U3 [

	"SmallAmp has derived this test from `SMicroWorldTest>>#testColors` by applying some transformations and regenerating its assertions.
	This test can cover this part:
	*	In `SMicroWorld>> #var:breed:putAll:` from 45 to 74:
		Operation: ReplaceEqualWithNotEqualOperator
		Code snippet: `bid = SBreedId observerBreedNo`
		Dynamic state: nil
		Mutant id: ReplaceEqualWithNotEqualOperator#SMicroWorld#var:breed:putAll:#45#74
"

	<madeBySmallAmp>
	| w |
	w := self newWorld.
	(w
		 createPatch: 3;
		 create: 3 turtles: 3;
		 breedOf: 3) colorAt: 3 put: 3.
	w patches
]

{ #category : #tests }
SMicroWorldTest >> testCountAliveOfBreedNo [
	| w |
	w := self newWorld.
	w create: 3 turtles: 10.
	w newBreed.
	w create: 4 turtles: 15.
	self assert: (w countAliveOf: 3) equals: 10.
	self assert: (w countAliveOf: 4) equals: 15.
	w createPatch: 10.
	self assert: (w countAliveOf: 2) equals: 100.
]

{ #category : #'tests-accessing' }
SMicroWorldTest >> testExtent [
	| w |
	w := self newWorld.
	w createPatch: 10.
	self assert: w extent equals: 10 @ 10.
	w createPatch: 20.
	self assert: w extent equals: 20 @ 20.
]

{ #category : #'tests-command' }
SMicroWorldTest >> testForwardBreedId [
	| w |
	w := self newWorld.
	w createPatch: 100.
	w create: 3 turtles: 1.
	(w breedOf: 3) headingAt: 1 put: 0.
	w x: 3 at: 1 put: 49.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1)
		closeTo: -50.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) closeTo: 0.
	w x: 3 at: 1 put: 49.1.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1)
		closeTo: -49.9.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) closeTo: 0.
	w x: 3 at: 1 put: 49.9.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1)
		closeTo: -49.1.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) closeTo: 0.
	w x: 3 at: 1 put: 50.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1)
		closeTo: -49.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) closeTo: 0.
	(w breedOf: 3) headingAt: 1 put: 90.
	w x: 3 at: 1 put: 49.
	w y: 3 at: 1 put: 49.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1)
		closeTo: 49.
	self
		assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1)
		closeTo: -50.
	w y: 3 at: 1 put: 49.1.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1)
		closeTo: 49.
	self
		assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1)
		closeTo: -49.9.
	w y: 3 at: 1 put: 49.9.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1)
		closeTo: 49.
	self
		assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1)
		closeTo: -49.1.
	w y: 3 at: 1 put: 50.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1)
		closeTo: 49.
	self
		assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1)
		closeTo: -49
]

{ #category : #'as yet unclassified' }
SMicroWorldTest >> testForwardBreedId_amp_A509 [

	"SmallAmp has derived this test from `SMicroWorldTest>>#testForwardBreedId` by applying some transformations and regenerating its assertions.
	This test can cover these parts:
	*	In `SMicroWorld>> #x:at:put:` from 316 to 368:
		Operation: ReplaceIfTrueReceiverWithTrueOperator
		Code snippet: `penDown ifTrue: [ ps colorAtPoint: x @ y put: c ]`
		Dynamic state: {#penDown->false. #x->48.0. #y->0.0. #c->34}
		Mutant id: ReplaceIfTrueReceiverWithTrueOperator#SMicroWorld#x:at:put:#316#368
	*	In `SMicroWorld>> #turtle:x:y:exceptBreed:index:` from 185 to 196:
		Operation: ReplaceIsEmptyWithNotEmptyMutantOperator
		Code snippet: `list isEmpty`
		Dynamic state: nil
		Mutant id: ReplaceIsEmptyWithNotEmptyMutantOperator#SMicroWorld#turtle:x:y:exceptBreed:index:#185#196
"

	<madeBySmallAmp>
	| w |
	w := self newWorld.
	(w
		 createPatch: 100;
		 create: 3 turtles: 1;
		 breedOf: 3) headingAt: 1 put: 0.
	(w
		 x: 3 at: 1 put: 49;
		 forward: 1 breed: 3 id: 1;
		 x: 3 at: 1 put: 49.1;
		 forward: 1 breed: 3 id: 1;
		 x: 3 at: 1 put: 49.9;
		 forward: 1 breed: 3 id: 1;
		 x: 3 at: 1 put: 50;
		 forward: 1 breed: 3 id: 1;
		 breedOf: 3) headingAt: 1 put: 90.
	w
		x: 3 at: 1 put: 49;
		y: 3 at: 1 put: 49;
		forward: 1 breed: 3 id: 1;
		y: 3 at: 1 put: 49.1;
		forward: 1 breed: 3 id: 1;
		y: 3 at: 1 put: 49.9;
		forward: 1 breed: 3 id: 1;
		y: 3 at: 1 put: 50;
		forward: 1 breed: 3 id: 1;
		createPatch: 5
]

{ #category : #'as yet unclassified' }
SMicroWorldTest >> testForwardBreedId_amp_L447_L109_L317 [

	"SmallAmp has derived this test from `SMicroWorldTest>>#testForwardBreedId` by applying some transformations and regenerating its assertions.
	This test can cover this part:
	*	In `SMicroWorld>> #forward:breed:id:` from 403 to 455:
		Operation: ReplaceIfTrueReceiverWithTrueOperator
		Code snippet: `penDown ifTrue: [ ps colorAtPoint: x @ y put: c ]`
		Dynamic state: {#penDown->false. #x->49.0. #y->0.0. #c->46}
		Mutant id: ReplaceIfTrueReceiverWithTrueOperator#SMicroWorld#forward:breed:id:#403#455
"

	<madeBySmallAmp>
	| w |
	w := self newWorld.
	(w
		 createPatch: 100;
		 create: 3 turtles: 1;
		 breedOf: 3) headingAt: 1 put: 0.
	w
		x: 3 at: 1 put: 49;
		forward: 1 breed: 3 id: 1.
	self should: [ w x: 0 at: 1 put: 49.1 ] raise: SubscriptOutOfBounds
]

{ #category : #'tests-accessing' }
SMicroWorldTest >> testMaxBreedNo [
	| w |
	w := self newWorld.
	self assert: w maxBreedNo equals: 3.
	5 timesRepeat: [ w newBreed ].
	self assert: w maxBreedNo equals: 8
]

{ #category : #'tests-accessing' }
SMicroWorldTest >> testObserver [
	| w |
	w := self newWorld.
	self assert: w observer class equals: SObserver.
]

{ #category : #'as yet unclassified' }
SMicroWorldTest >> testObserver_amp [

	"SmallAmp has derived this test from `SMicroWorldTest>>#testObserver` by regenerating its assertions.
	This test can cover these parts:
	*	In `SMicroWorld>> #worldName` from 65 to 109:
		Operation: RemoveCaretOperator
		Code snippet: `^ 'MicroWorld - ' , self patches diffuserName`
		Dynamic state: nil
		Mutant id: RemoveCaretOperator#SMicroWorld#worldName#65#109
	*	In `SMicroWorld>> #worldName` from 12 to 111:
		Operation: ReplaceIfTrueWithIfFalseMutantOperator
		Code snippet: `self maxBreedNo >= SBreedId patchBreedNo ifTrue: [ 
	^ 'MicroWorld - ' , self patches diffuserName ]`
		Dynamic state: nil
		Mutant id: ReplaceIfTrueWithIfFalseMutantOperator#SMicroWorld#worldName#12#111
	*	In `SMicroWorld>> #worldName` from 12 to 111:
		Operation: ReplaceIfTrueReceiverWithFalseOperator
		Code snippet: `self maxBreedNo >= SBreedId patchBreedNo ifTrue: [ 
	^ 'MicroWorld - ' , self patches diffuserName ]`
		Dynamic state: nil
		Mutant id: ReplaceIfTrueReceiverWithFalseOperator#SMicroWorld#worldName#12#111
	*	In `SMicroWorld>> #worldName` from 12 to 51:
		Operation: ReplaceGreaterOrEqualWithEqualMutantOperator
		Code snippet: `self maxBreedNo >= SBreedId patchBreedNo`
		Dynamic state: nil
		Mutant id: ReplaceGreaterOrEqualWithEqualMutantOperator#SMicroWorld#worldName#12#51
"

	<madeBySmallAmp>
	| w |
	w := self newWorld
]

{ #category : #'tests-accessing' }
SMicroWorldTest >> testPatches [
	| w |
	w := self newWorld.
	self assert: w patches class equals: SPatches.
]

{ #category : #test }
SMicroWorldTest >> testPlotColor [
	| w ret |
	w := self newWorld.
	self assert: w plotList isCollection.
	self assert: w plotList isEmpty.
	w plot: 1 color: SColorList red.
	w plot: 3 color: SColorList blue.
	ret := w plotList.
	self assert: ret size equals: 2.
	self assertCollection: ret first channel equals: 1.
	self assertCollection: ret first color equals: Color red.
	self assertCollection: ret second channel equals: 3.
	self assertCollection: ret second color equals: Color blue.
	self assert: w plotList isCollection.
	self assert: w plotList isEmpty.
]

{ #category : #test }
SMicroWorldTest >> testPlotData [
	| w ret |
	w := self newWorld.
	self assert: w plotList isCollection.
	self assert: w plotList isEmpty.
	w plot: 1 data: 2.
	w plot: 3 data: 4.
	ret := w plotList.
	self assert: ret size equals: 2.
	self assertCollection: ret first channel equals: 1.
	self assertCollection: ret first data equals: 2.
	self assertCollection: ret second channel equals: 3.
	self assertCollection: ret second data equals: 4.
	self assert: w plotList isCollection.
	self assert: w plotList isEmpty
]

{ #category : #test }
SMicroWorldTest >> testPlotList [
	self testPrivPlotList
]

{ #category : #'tests-private' }
SMicroWorldTest >> testPrivBreeds [
	| w |
	w := self newWorld.
	self assert: w privBreeds isArray.
	self assert: (w privBreeds at: 1) class equals: SObserver.
	self assert: (w privBreeds at: 2) class equals: SPatches.
	self assert: (w privBreeds at: 3) class equals: STurtles.
]

{ #category : #test }
SMicroWorldTest >> testPrivPlotList [
	| w ret |
	w := self newWorld.
	ret := w plotList.
	self assert: ret isEmpty.
	w privPlotList: #(1 2 3).
	ret := w plotList.
	self assertCollection: ret equals: #(1 2 3).
	ret := w plotList.
	self assert: ret isEmpty
]

{ #category : #'tests-private' }
SMicroWorldTest >> testPrivRaisedEvents [
	| w |
	w := SMicroWorld new.
	self assert: w privRaisedEvents isEmpty.
	w privRaisedEvents: #(1 2 3).
	self assertCollection: w privRaisedEvents equals: #(1 2 3).
	w privRaisedEvents: #(4 5 6).
	self assertCollection: w privRaisedEvents equals: #(4 5 6).
]

{ #category : #'tests-accessing' }
SMicroWorldTest >> testRaiseEvent [
	| w |
	w := SMicroWorld new.
	self assert: w privRaisedEvents isEmpty.
	w raiseEvent: #a.
	self assertCollection: w privRaisedEvents asArray equals: #(a).
	w raiseEvent: #b.
	self assert: w privRaisedEvents size equals: 2.
	self assert: (w privRaisedEvents includes: #a).
	self assert: (w privRaisedEvents includes: #b).
]

{ #category : #'tests-accessing' }
SMicroWorldTest >> testRaisedEvents [
	| w |
	w := SMicroWorld new.
	self assert: w raisedEvents isEmpty.
	w raiseEvent: #a.
	self assertCollection: w raisedEvents asArray equals: #(a).
	w raiseEvent: #b.
	self assert: w raisedEvents size equals: 2.
	self assert: (w raisedEvents includes: #a).
	self assert: (w raisedEvents includes: #b).
]

{ #category : #test }
SMicroWorldTest >> testVarsBreedAt [
	| w ret |
	w := self newWorld.
	ret := w varsBreed: SBreedId turtleBreedNo at: 1.
	self assert: ret isArray.
	self assert: ret notEmpty.
	self assert: ret first isArray.
	self assert: ret first size equals: 2
]

{ #category : #'as yet unclassified' }
SMicroWorldTest >> testVarsBreedAt_amp [

	"SmallAmp has derived this test from `SMicroWorldTest>>#testVarsBreedAt` by regenerating its assertions.
	This test can cover this part:
	*	In `SMicroWorld>> #varsBreed:at:` from 152 to 300:
		Operation: ReplaceDoBlockWithEmptyBlockOperator
		Code snippet: `breed varNames do: [ :each | 
	vno := breed varNoFor: each.
	v := self var: vno breed: bno at: id.
	stream nextPut: { 
			each.
			v } ]`
		Dynamic state: nil
		Mutant id: ReplaceDoBlockWithEmptyBlockOperator#SMicroWorld#varsBreed:at:#152#300
"

	<madeBySmallAmp>
	| w ret |
	w := self newWorld.
	self assert: w worldName equals: 'MicroWorld - native diffuser'.
	ret := w varsBreed: SBreedId turtleBreedNo at: 1
]
