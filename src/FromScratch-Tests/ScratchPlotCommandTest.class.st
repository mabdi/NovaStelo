"
A ScratchPlotCommandTest is a test class for testing the behavior of ScratchPlotCommand
"
Class {
	#name : #ScratchPlotCommandTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #'instance creation' }
ScratchPlotCommandTest >> newPlotCommand [
	^ ScratchPlotCommand new
]

{ #category : #test }
ScratchPlotCommandTest >> testCommand [
	| p |
	p := self newPlotCommand.
	self assert: p command isNil.
	p command: 1.
	self assert: p command equals: 1.
	p command: 2.
	self assert: p command equals: 2
]

{ #category : #test }
ScratchPlotCommandTest >> testIsClearPlot [
	| p |
	p := self newPlotCommand.
	self deny: p isClearPlot.
	p command: p class clearPlotNo.
	self assert: p isClearPlot
]

{ #category : #'as yet unclassified' }
ScratchPlotCommandTest >> testIsClearPlot_amp [

	"SmallAmp has derived this test from `ScratchPlotCommandTest>>#testIsClearPlot` by regenerating its assertions.
	This test can cover these parts:
	*	In `ScratchPlotCommand class>> #clearPlotNo` from 14 to 16:
		Operation: RemoveCaretOperator
		Code snippet: `^ 1`
		Dynamic state: nil
		Mutant id: RemoveCaretOperator#ScratchPlotCommand class#clearPlotNo#14#16
	*	In `ScratchPlotCommand>> #isSetPlotYMax` from 18 to 54:
		Operation: ReplaceEqualWithNotEqualOperator
		Code snippet: `self command = self class setPlotYMax`
		Dynamic state: nil
		Mutant id: ReplaceEqualWithNotEqualOperator#ScratchPlotCommand#isSetPlotYMax#18#54
	*	In `ScratchPlotCommand>> #isSetPlotYMin` from 18 to 54:
		Operation: ReplaceEqualWithNotEqualOperator
		Code snippet: `self command = self class setPlotYMin`
		Dynamic state: nil
		Mutant id: ReplaceEqualWithNotEqualOperator#ScratchPlotCommand#isSetPlotYMin#18#54
	*	In `ScratchPlotCommand>> #args` from 7 to 12:
		Operation: RemoveCaretOperator
		Code snippet: `^ args`
		Dynamic state: {#args->nil}
		Mutant id: RemoveCaretOperator#ScratchPlotCommand#args#7#12
"

	<madeBySmallAmp>
	| p |
	p := self newPlotCommand.
	self
		assert: p args isNil;
		deny: p isSetPlotYMax;
		deny: p isSetPlotYMin.
	p command: p class clearPlotNo.
	self assert: p command equals: 1
]

{ #category : #'as yet unclassified' }
ScratchPlotCommandTest >> testIsClearPlot_amp_A3_L0 [

	"SmallAmp has derived this test from `ScratchPlotCommandTest>>#testIsClearPlot` by applying some transformations and regenerating its assertions.
	This test can cover this part:
	*	In `ScratchPlotCommand class>> #setPlotYMin` from 14 to 16:
		Operation: RemoveCaretOperator
		Code snippet: `^ 2`
		Dynamic state: nil
		Mutant id: RemoveCaretOperator#ScratchPlotCommand class#setPlotYMin#14#16
"

	<madeBySmallAmp>
	| p |
	p := self newPlotCommand.
	p
		command: p class clearPlotNo;
		command: 2.
	self assert: p isSetPlotYMin
]
