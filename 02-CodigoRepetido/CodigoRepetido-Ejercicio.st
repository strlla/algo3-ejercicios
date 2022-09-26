!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: 'customerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 20:13:47'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	self should: [customerBook addCustomerNamed: 'John Lennon'] notTakeMoreThan: 50 milliSeconds .! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 20:13:47'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	customerBook addCustomerNamed: 'Paul McCartney'.
	
	self should: [customerBook removeCustomerNamed: 'Paul McCartney'.] notTakeMoreThan: 100 milliSeconds.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 21:04:18'!
test03CanNotAddACustomerWithEmptyName 

	self should:[ customerBook addCustomerNamed: ''.]
		raise: Error
		withExceptionDo: [ :anError | 	self assertCustomerBookIsEmptyAndErrorMessageEqualsCustomerNameCanNotBeEmpty: anError ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 20:56:07'!
test04CanNotRemoveAnInvalidCustomer

	customerBook := customerBook addCustomerNamed: 'John Lennon' .

	self should:[ customerBook removeCustomerNamed: 'Paul McCartney'. ]
		raise: NotFound 
		withExceptionDo: [ :anError | 	self assertBookHasOneCustomerAndIncludesJohnLennon]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 20:49:00'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	self setUpSuspendCustomerNamedPaulMcCartney. 
	
	self assertThisBookhasCustomers: 1 hasActive: 0 hasSuspended:1. 
	self assert: (customerBook includesCustomerNamed: 'Paul McCartney').
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 20:49:09'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	self setUpDeleteSuspendedCustomerNamedPaulMcCartney . 
	
	self assertThisBookhasCustomers: 0 hasActive: 0 hasSuspended: 0. 
	self deny: (customerBook includesCustomerNamed: 'Paul McCartney').


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 20:54:58'!
test07CanNotSuspendAnInvalidCustomer

	customerBook addCustomerNamed: 'John Lennon'.
	
	self should: [ customerBook suspendCustomerNamed: 'Ringo Starr'. ] 
		raise: CantSuspend
	 	withExceptionDo:[ :anError | 			self assertBookHasOneCustomerAndIncludesJohnLennon ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 20:54:11'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	self setUpSuspendCustomerNamedJohnLennon.
	
	self should:[ customerBook suspendCustomerNamed: 'John Lennon'.]
		raise: CantSuspend 
		withExceptionDo: [ :anError | 			self assertBookHasOneCustomerAndIncludesJohnLennon ]
! !


!CustomerBookTest methodsFor: 'testSetUps' stamp: 'MN 9/25/2022 20:13:47'!
setUp
	customerBook := CustomerBook new.! !

!CustomerBookTest methodsFor: 'testSetUps' stamp: 'MN 9/25/2022 20:33:03'!
setUpDeleteSuspendedCustomerNamedPaulMcCartney
	|paulMcCartney|
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.! !

!CustomerBookTest methodsFor: 'testSetUps' stamp: 'MN 9/25/2022 20:52:32'!
setUpSuspendCustomerNamedJohnLennon
	|johnLennon|
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon .
	customerBook suspendCustomerNamed: johnLennon .! !

!CustomerBookTest methodsFor: 'testSetUps' stamp: 'MN 9/25/2022 20:46:20'!
setUpSuspendCustomerNamedPaulMcCartney
	|paulMcCartney|
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.! !


!CustomerBookTest methodsFor: 'commonAsserts' stamp: 'MN 9/25/2022 20:48:00'!
assertBookHasOneCustomerAndIncludesJohnLennon
		self assert: customerBook numberOfCustomers = 1 .
		self assert: (customerBook includesCustomerNamed: 'John Lennon')! !

!CustomerBookTest methodsFor: 'commonAsserts' stamp: 'MN 9/25/2022 21:03:57'!
assertCustomerBookIsEmptyAndErrorMessageEqualsCustomerNameCanNotBeEmpty: anError
	self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
	self assert: customerBook isEmpty. ! !

!CustomerBookTest methodsFor: 'commonAsserts' stamp: 'MN 9/25/2022 20:48:47'!
assertThisBookhasCustomers: numberOfCustomers hasActive: numberOfActiveCustomers hasSuspended: numberOfSuspendedCustomers
	self assert: numberOfCustomers equals: customerBook numberOfCustomers.
	self assert: numberOfActiveCustomers equals: customerBook numberOfActiveCustomers.
	self assert: numberOfSuspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'MN 9/25/2022 17:35:53'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ] ifFalse: [active add: aName ].
	
	! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MN 9/25/2022 17:28:27'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers. ! !

!CustomerBook methodsFor: 'customer management' stamp: 'MN 9/25/2022 17:29:21'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MN 9/25/2022 17:35:49'!
removeCustomerNamed: aName 

 	active remove: aName  ifAbsent: [ suspended remove: aName ifAbsent: [ ^NotFound signal ]. ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !

