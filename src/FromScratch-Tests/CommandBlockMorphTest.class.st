"
A CommandBlockMorphTest is a test class for testing the behavior of CommandBlockMorph
"
Class {
	#name : #CommandBlockMorphTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
CommandBlockMorphTest >> newBlock [
	^ CommandBlockMorph new
]

{ #category : #private }
CommandBlockMorphTest >> newScript [
	^ ScratchScript new
		setupArgBuilder;
		yourself
]

{ #category : #private }
CommandBlockMorphTest >> newTestScript [
	^ ScTestScript new
		setupArgBuilder;
		yourself
]

{ #category : #test }
CommandBlockMorphTest >> testArgSpecs [
	| b |
	b := self newBlock
		receiver: self newScript;
		yourself.
	b commandSpec: 'abc %s def %n ghi %m'.
	self assertCollection: b argSpecs equals: #('%s' '%n' '%m')
]

{ #category : #test }
CommandBlockMorphTest >> testAsBlockTuple [
	| b ret |
	b := self newBlock
		receiver: self newScript;
		yourself.
	b selector: #abc:def:.
	b commandSpec: 'abc %n def %s ghi'.
	ret := b asBlockTuple.
	self assertCollection: ret equals: #(#abc:def: 10 '').
	b argPermutation: #(1 2).
	(b argumentAt: 1) numExpression: 5.
	(b argumentAt: 2) stringExpression: 'a'.
	ret := b asBlockTuple.
	self assertCollection: ret equals: #(#abc:def: 5 'a')
]

{ #category : #test }
CommandBlockMorphTest >> testCoerceArgs [
	| b ret |
	b := self newBlock
		receiver: self newScript;
		yourself.
	b selector: #abc:def:.
	b commandSpec: 'abc %n def %s ghi %n'.
	ret := b coerceArgs: #('20.0' 'abc' 30).
	self assertCollection: ret equals: #(20 'abc' 30).
	b selector: #setVar:to:.
	ret := b coerceArgs: #('20.0' 'abc' 30).
	self assertCollection: ret equals: #('20.0' 'abc' 30)
]

{ #category : #test }
CommandBlockMorphTest >> testDefaultArgs [
	| b |
	b := self newBlock
		receiver: self newScript;
		yourself.
	b selector: #abc:def:.
	b commandSpec: 'abc %n def %s ghi'.
	b argPermutation: #(2 1).
	self assert: (b argumentAt: 1) evaluate equals: ''.
	self assert: (b argumentAt: 2) evaluate equals: 10.
	b defaultArgs: #('def').
	self assert: (b argumentAt: 1) evaluate equals: 'def'.
	self assert: (b argumentAt: 2) evaluate equals: 10.
	b defaultArgs: #('abc' 1).
	self assert: (b argumentAt: 1) evaluate equals: 'abc'.
	self assert: (b argumentAt: 2) evaluate equals: 1
]

{ #category : #test }
CommandBlockMorphTest >> testEvaluate [
	| b |
	b := self newBlock
		receiver: self newTestScript;
		yourself.
	b commandSpec: 'abs %n'.
	b selector: #abs:.
	b argPermutation: #(1).
	b defaultArgs: #(-5).
	self assert: b evaluate equals: 5.
	b commandSpec: 'plus %n and %n'.
	b selector: #plus:and:.
	b argPermutation: #(1 2).
	b defaultArgs: #(3 4).
	self assert: b evaluate equals: 7
]

{ #category : #test }
CommandBlockMorphTest >> testEvaluateFunctionWithArgs [
	| b |
	b := self newBlock
		receiver: self newTestScript;
		yourself.
	b commandSpec: 'abs %n'.
	b selector: #abs:.
	self assert: (b evaluateFunctionWithArgs: #(-5)) equals: 5.
	b commandSpec: 'plus %n and %n'.
	b selector: #plus:and:.
	self
		assert: (b evaluateFunctionWithArgs: #(1 2))
		equals: 3
]

{ #category : #'as yet unclassified' }
CommandBlockMorphTest >> testEvaluateFunctionWithArgs_amp_U2_N0 [

	"SmallAmp has derived this test from `CommandBlockMorphTest>>#testEvaluateFunctionWithArgs` by applying some transformations and regenerating its assertions.
	This test can cover these parts:
	*	In `CommandBlockMorph>> #receiver` from 12 to 21:
		Operation: RemoveCaretOperator
		Code snippet: `^ receiver`
		Dynamic state: {#receiver->nil}
		Mutant id: RemoveCaretOperator#CommandBlockMorph#receiver#12#21
	*	In `CommandBlockMorph>> #labelId` from 10 to 18:
		Operation: RemoveCaretOperator
		Code snippet: `^ labelId`
		Dynamic state: {#labelId->nil}
		Mutant id: RemoveCaretOperator#CommandBlockMorph#labelId#10#18
	*	In `CommandBlockMorph>> #isForever` from 15 to 37:
		Operation: ReplaceEqualWithNotEqualOperator
		Code snippet: `(selector = #doForever)`
		Dynamic state: {#selector->nil}
		Mutant id: ReplaceEqualWithNotEqualOperator#CommandBlockMorph#isForever#15#37
	*	In `CommandBlockMorph>> #isForever` from 41 to 65:
		Operation: ReplaceEqualWithNotEqualOperator
		Code snippet: `(selector = #doForeverIf)`
		Dynamic state: {#selector->nil}
		Mutant id: ReplaceEqualWithNotEqualOperator#CommandBlockMorph#isForever#41#65
	*	In `CommandBlockMorph>> #argMorphs` from 13 to 23:
		Operation: RemoveCaretOperator
		Code snippet: `^ argMorphs`
		Dynamic state: nil
		Mutant id: RemoveCaretOperator#CommandBlockMorph#argMorphs#13#23
	*	In `CommandBlockMorph>> #selector` from 12 to 21:
		Operation: RemoveCaretOperator
		Code snippet: `^ selector`
		Dynamic state: {#selector->nil}
		Mutant id: RemoveCaretOperator#CommandBlockMorph#selector#12#21
	*	In `CommandBlockMorph>> #commandSpec` from 15 to 27:
		Operation: RemoveCaretOperator
		Code snippet: `^ commandSpec`
		Dynamic state: {#commandSpec->''}
		Mutant id: RemoveCaretOperator#CommandBlockMorph#commandSpec#15#27
"

	<madeBySmallAmp>
	| b aCommandBlockMorph |
	aCommandBlockMorph := self newBlock.
	self
		assert: aCommandBlockMorph selector isNil;
		assert: aCommandBlockMorph isCommandBlock;
		assert: aCommandBlockMorph commandSpec equals: '';
		deny: aCommandBlockMorph isForever;
		deny: aCommandBlockMorph isStopOrForever;
		assert: aCommandBlockMorph argMorphs class
		equals: OrderedCollection;
		deny: aCommandBlockMorph isTimed;
		assert: aCommandBlockMorph receiver isNil;
		assert: aCommandBlockMorph labelId isNil.
	b := aCommandBlockMorph
		     receiver: nil;
		     yourself.
	self should: [ b commandSpec: 'abs %n' ] raise: MessageNotUnderstood
]

{ #category : #test }
CommandBlockMorphTest >> testEvaluateInfixWithArgs [
	| b |
	b := self newBlock
		receiver: self newTestScript;
		yourself.
	b selector: #=.
	self assert: (b evaluateInfixWithArgs: #('true' true)).
	self assert: (b evaluateInfixWithArgs: #('false' false)).
	self assert: (b evaluateInfixWithArgs: #(true 'true')).
	self assert: (b evaluateInfixWithArgs: #(false 'false')).
	self deny: (b evaluateInfixWithArgs: #('true' false)).
	self deny: (b evaluateInfixWithArgs: #('false' true)).
	self deny: (b evaluateInfixWithArgs: #(false 'true')).
	self deny: (b evaluateInfixWithArgs: #(true 'false')).
	b selector: #<.
	self assert: (b evaluateInfixWithArgs: #(1 2)).
	self deny: (b evaluateInfixWithArgs: #(1 1)).
	self assert: (b evaluateInfixWithArgs: #('3' '12')).
	self deny: (b evaluateInfixWithArgs: #('12' '12')).
	self assert: (b evaluateInfixWithArgs: #('a' 'b')).
	self deny: (b evaluateInfixWithArgs: #('a' 'a')).
]

{ #category : #test }
CommandBlockMorphTest >> testEvaluateWithArgs [
	| b |
	b := self newBlock
		receiver: self newTestScript;
		yourself.
	b commandSpec: 'abs %n'.
	b selector: #abs:.
	self assert: (b evaluateWithArgs: #(-5)) equals: 5.
	b commandSpec: 'plus %n and %n'.
	b selector: #plus:and:.
	self assert: (b evaluateWithArgs: #(1 2)) equals: 3
]

{ #category : #test }
CommandBlockMorphTest >> testIsArgSpec [
	self assert: (CommandBlockMorph isArgSpec: '%a').
	self assert: (CommandBlockMorph isArgSpec: '%b').
	self deny: (CommandBlockMorph isArgSpec: '%').
	self deny: (CommandBlockMorph isArgSpec: 'x')
]

{ #category : #test }
CommandBlockMorphTest >> testNumberArgFlags [
	| b |
	b := self newBlock.
	b receiver: self newScript.
	b commandSpec: 'abc %s def %n ghi %e'.
	self assertCollection: b numberArgFlags equals: #(false true false)
]

{ #category : #test }
CommandBlockMorphTest >> testOrganizeArgs [
	| b |
	b := self newBlock
		receiver: self newTestScript;
		yourself.
	b commandSpec: 'abs %n'.
	b selector: #abs.
	self assertCollection: (b organizeArgs: #(1)) equals: #(1).
	b commandSpec: 'plus %n and %n'.
	b selector: #plus:and:.
	self assertCollection: (b organizeArgs: #(2 3)) equals: #(2 3).
	b commandSpec: 'plus %n and %n'.
	b selector: #plus:and:.
	b argPermutation: #(2 1).
	self assertCollection: (b organizeArgs: #(2 3)) equals: #(3 2).
	b commandSpec: '%n = %n'.
	b selector: #=.
	b argPermutation: #(2 1).
	self assertCollection: (b organizeArgs: #(2 3)) equals: #(2 3)
]

{ #category : #test }
CommandBlockMorphTest >> testParseCommandSpec [
	self
		assertCollection: (CommandBlockMorph parseCommandSpec: 'abc %n')
		equals: #(abc '%n').
	self
		assertCollection: (CommandBlockMorph parseCommandSpec: 'abc %n    def %s')
		equals: #(abc '%n' def '%s').
	self
		assertCollection: (CommandBlockMorph parseCommandSpec: 'abc%n1def%s23gh')
		equals: #(abc '%n1' def '%s23' gh).
	self
		assertCollection: (CommandBlockMorph parseCommandSpec: 'abc% def%')
		equals: #(abc '%' def '%')
]
