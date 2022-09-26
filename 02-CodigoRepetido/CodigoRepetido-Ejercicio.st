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
	instanceVariableNames: 'customerBook paulMcCartney johnLennon'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 23:49:48'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	self should: [customerBook addCustomerNamed: johnLennon ] notTakeMoreThan: 50 milliSeconds .! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 23:49:59'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	customerBook addCustomerNamed: paulMcCartney .
	
	self should: [customerBook removeCustomerNamed: paulMcCartney .] notTakeMoreThan: 100 milliSeconds.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 23:56:34'!
test03CanNotAddACustomerWithEmptyName 

	self should:[ customerBook addCustomerNamed: ''.]
		raise: Error
		withExceptionDo: [ :anError | 	self assertThisBook: customerBook 
								isEmptyAndErrorMessageEqualsCustomerNameCanNotBeEmpty: anError ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 23:53:06'!
test04CanNotRemoveAnInvalidCustomer

	customerBook := customerBook addCustomerNamed: johnLennon .

	self should:[ customerBook removeCustomerNamed: paulMcCartney. ]
		raise: NotFound 
		withExceptionDo: [ :anError | 	self assertThisBookHasOneCustomerAndIncludesJohnLennon: customerBook]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 23:57:21'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	self setUpSuspendCustomerNamedPaulMcCartney. 
	
	self assertThisBook: customerBook hasCustomers: 1 hasActive: 0 hasSuspended:1. 
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 23:57:29'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	self setUpDeleteSuspendedCustomerNamedPaulMcCartney . 
	
	self assertThisBook: customerBook hasCustomers: 0 hasActive: 0 hasSuspended: 0. 
	self deny: (customerBook includesCustomerNamed: paulMcCartney ).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 23:53:14'!
test07CanNotSuspendAnInvalidCustomer

	customerBook addCustomerNamed: johnLennon.
	
	self should: [ customerBook suspendCustomerNamed: 'Ringo Starr'. ] 
		raise: CantSuspend
	 	withExceptionDo:[ :anError | 			self assertThisBookHasOneCustomerAndIncludesJohnLennon: customerBook ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 23:53:24'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	self setUpSuspendCustomerNamedJohnLennon.
	
	self should:[ customerBook suspendCustomerNamed: johnLennon.]
		raise: CantSuspend 
		withExceptionDo: [ :anError | 			self assertThisBookHasOneCustomerAndIncludesJohnLennon: customerBook ]
! !


!CustomerBookTest methodsFor: 'testSetUps' stamp: 'MN 9/25/2022 23:49:37'!
setUp
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	johnLennon := 'John Lennon'! !

!CustomerBookTest methodsFor: 'testSetUps' stamp: 'MN 9/25/2022 23:48:57'!
setUpDeleteSuspendedCustomerNamedPaulMcCartney
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.! !

!CustomerBookTest methodsFor: 'testSetUps' stamp: 'MN 9/25/2022 23:48:47'!
setUpSuspendCustomerNamedJohnLennon
	customerBook addCustomerNamed: johnLennon .
	customerBook suspendCustomerNamed: johnLennon .! !

!CustomerBookTest methodsFor: 'testSetUps' stamp: 'MN 9/25/2022 23:48:57'!
setUpSuspendCustomerNamedPaulMcCartney
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.! !


!CustomerBookTest methodsFor: 'commonAsserts' stamp: 'MN 9/25/2022 23:57:06'!
assertThisBook: aBook hasCustomers: numberOfCustomers hasActive: numberOfActiveCustomers hasSuspended: numberOfSuspendedCustomers
    self assert: numberOfCustomers equals: aBook numberOfCustomers.
    self assert: numberOfActiveCustomers equals: aBook numberOfActiveCustomers.
    self assert: numberOfSuspendedCustomers equals: aBook numberOfSuspendedCustomers.! !

!CustomerBookTest methodsFor: 'commonAsserts' stamp: 'MN 9/25/2022 23:54:44'!
assertThisBook: aBook isEmptyAndErrorMessageEqualsCustomerNameCanNotBeEmpty: anError
    self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
    self assert: aBook  isEmpty.! !

!CustomerBookTest methodsFor: 'commonAsserts' stamp: 'MN 9/25/2022 23:52:09'!
assertThisBookHasOneCustomerAndIncludesJohnLennon: aBook 
        self assert: aBook numberOfCustomers = 1 .
        self assert: (aBook includesCustomerNamed: johnLennon )! !


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

