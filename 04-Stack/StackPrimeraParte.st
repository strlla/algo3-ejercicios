!classDefinition: #OperationNotValidOnEmptyStack category: 'StackPrimeraParte'!
Error subclass: #OperationNotValidOnEmptyStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!


!classDefinition: #StackTest category: 'StackPrimeraParte'!
TestCase subclass: #StackTest
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!StackTest methodsFor: 'testing' stamp: 'EP 10/7/2022 19:25:40'!
test01StackShouldBeEmptyWhenCreated
	
	self assert: stack isEmpty.! !

!StackTest methodsFor: 'testing' stamp: 'EP 10/7/2022 20:04:37'!
test02StackCantPopWhenEmpty
	self should:[ stack pop. ]
              raise: OperationNotValidOnEmptyStack.! !

!StackTest methodsFor: 'testing' stamp: 'EP 10/7/2022 20:11:58'!
test03StackCantCheckTopWhenEmpty
	self should: [stack pop. ]
              raise: OperationNotValidOnEmptyStack.! !

!StackTest methodsFor: 'testing' stamp: 'EP 10/7/2022 20:09:18'!
test04TopReturnsLastElementAdded
	stack push: 1.
	stack push: 2.	
	stack push: 3.
	
	self assert: [stack top = 3].! !

!StackTest methodsFor: 'testing' stamp: 'EP 10/7/2022 20:09:37'!
test05PopRemovesLastElementAdded
	stack push: 1.
	stack push: 2.
	stack push: 3.
	
	self assert: [stack pop = 3].! !

!StackTest methodsFor: 'testing' stamp: 'EP 10/7/2022 20:02:18'!
test06TopShouldNotRemoveLastElement
	stack push: 1.
	
	self assert: [stack top = 1].
	
	self deny: stack isEmpty.! !

!StackTest methodsFor: 'testing' stamp: 'EP 10/7/2022 20:10:47'!
test07StackShouldNotBeEmptyAfterPushing
	stack push: 1.
	
	self deny: stack isEmpty.! !


!StackTest methodsFor: 'setUp' stamp: 'EP 10/7/2022 19:25:31'!
setUp
	stack := Stack new.
! !


!classDefinition: #Stack category: 'StackPrimeraParte'!
Object subclass: #Stack
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!Stack methodsFor: 'primitives' stamp: 'EP 10/7/2022 19:21:57'!
isEmpty
	^stack isEmpty. ! !

!Stack methodsFor: 'primitives' stamp: 'EP 10/7/2022 19:52:06'!
pop
	self emptyCheck.
	
	^stack removeLast.! !

!Stack methodsFor: 'primitives' stamp: 'EP 10/7/2022 19:21:25'!
push: anElement
	stack addLast: anElement.! !

!Stack methodsFor: 'primitives' stamp: 'EP 10/7/2022 20:02:41'!
top
	self emptyCheck.
	
	^stack at: stack size.! !


!Stack methodsFor: 'initialization' stamp: 'EP 10/10/2022 14:29:14'!
initialize

	stack := OrderedCollection new! !


!Stack methodsFor: 'private' stamp: 'EP 10/7/2022 20:04:47'!
emptyCheck
	self isEmpty ifTrue: [OperationNotValidOnEmptyStack signal].! !

!Stack methodsFor: 'private' stamp: 'EP 10/7/2022 19:43:15'!
errorEmptyStack
    self error: self class emptyStackDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Stack class' category: 'StackPrimeraParte'!
Stack class
	instanceVariableNames: ''!

!Stack class methodsFor: 'errorDescriptions' stamp: 'EP 10/7/2022 19:42:03'!
emptyStackDescription
    ^ 'This stack is empty'! !
