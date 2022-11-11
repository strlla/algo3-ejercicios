!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'parentPortfolio childPortfolio portfolio account deposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'setUp' stamp: 'EP 11/10/2022 20:49:08'!
setUp

	parentPortfolio := Portfolio new.
	childPortfolio 	:= Portfolio new.
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	deposit := Deposit for: 100 * peso.
	
 ! !


!PortfolioTest methodsFor: 'tests' stamp: 'EP 11/10/2022 21:10:32'!
test01APortfolioWithAccountsCanCalculateItsBalance
	Deposit register: 100 * peso on: account.
	portfolio register: account.
	
	self assertThisPortfolioHasABalanceOf100pesos: portfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'EP 11/10/2022 21:10:48'!
test02APortfolioWithOtherPortfoliosCalculatesItsBalanceCorrectly

	Deposit register: 100 * peso on: account.
	childPortfolio register: account.
	parentPortfolio register: childPortfolio.
	self assertThisPortfolioHasABalanceOf100pesos: parentPortfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'EP 11/10/2022 20:49:08'!
test03APortfolioKnowsIfItHasRegisteredATransaction
	account register: deposit.
	portfolio register: account.
	self assert: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'EP 11/10/2022 21:22:02'!
test04APortfolioWithOtherPortfoliosKnowsIfItHasRegisteredATransaction
	
	account register: deposit.
	childPortfolio register: account.
	parentPortfolio register: childPortfolio .
	self assertThisPortfolioTransactionsIncludeADeposit: parentPortfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'EP 11/10/2022 21:22:12'!
test05PortfolioKnowsTransactionsOfOneOfItsAccounts

	account register: deposit.
	
	portfolio register: account.
	
	self assertThisPortfolioTransactionsIncludeADeposit: portfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'EP 11/10/2022 21:22:17'!
test06PortfolioWithOtherPortfoliosCanStillFindItsTransactions

	account register: deposit.
	
	childPortfolio register: account.
	
	parentPortfolio register: childPortfolio.
	self assertThisPortfolioTransactionsIncludeADeposit: parentPortfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'EP 11/10/2022 20:57:34'!
test07CannotRegisterAnAccountInAPortfolioTwice
       portfolio register: account.

	self should: [portfolio register: account]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: portfolio class accountAlreadyRegisteredErrorDescription].! !

!PortfolioTest methodsFor: 'tests' stamp: 'EP 11/10/2022 20:58:03'!
test08CannotRegisterAnAccountInAPortfolioThatsAlreadyRegistered

	childPortfolio register: account.
	parentPortfolio register: childPortfolio.
	 
	self should: [parentPortfolio register: account]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: portfolio class accountAlreadyRegisteredErrorDescription].! !

!PortfolioTest methodsFor: 'tests' stamp: 'EP 11/10/2022 20:59:13'!
test09APortfolioCannotRegisterItself

	self should: [portfolio register: portfolio]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: portfolio class cannotRegisterItselfErrorDescription].! !

!PortfolioTest methodsFor: 'tests' stamp: 'EP 11/10/2022 21:00:58'!
test10CannotAddAccountWhenItIsRegisteredInAFatherPortfolio
	parentPortfolio register: account.
	
	parentPortfolio register: childPortfolio.
	
	self should: [childPortfolio register: account]	
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: portfolio class accountAlreadyRegisteredInParentErrorDescription].! !

!PortfolioTest methodsFor: 'tests' stamp: 'EP 11/10/2022 21:22:53'!
test11CannotRegisterAPortfolioIfItIncludesAnAlreadyRegisteredAccount

	childPortfolio register: account.
	
	parentPortfolio register: account.
	
	self should: [parentPortfolio register: childPortfolio.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: portfolio class portfoliosWithAccountsInCommonErrorDescription].! !


!PortfolioTest methodsFor: 'asserts' stamp: 'EP 11/10/2022 21:09:56'!
assertThisPortfolioHasABalanceOf100pesos: aPortfolio
	self assert: aPortfolio balance equals: 100 * peso.! !

!PortfolioTest methodsFor: 'asserts' stamp: 'EP 11/10/2022 21:40:57'!
assertThisPortfolioTransactionsIncludeADeposit: aPortfolio

	self assert: aPortfolio transactions includes: deposit.! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'test' stamp: 'EP 11/7/2022 22:02:57'!
test01AccountsBalanceUpdatesWhenATransferOccurs
	| transfer depositAccount  withdrawalAccount |
	
	depositAccount := ReceptiveAccount new.
	withdrawalAccount := ReceptiveAccount new.
	
	transfer := Transfer forValue: 100 * peso from: withdrawalAccount to: depositAccount.
	
	
	
	self assert: -100 * peso equals: (withdrawalAccount balance).
	self assert: 100 * peso equals: (depositAccount balance).

	
	! !

!TransferTest methodsFor: 'test' stamp: 'A 11/8/2022 17:26:59'!
test02ATransferLegCanAccessItsOppositeLeg

	| depositAccount  withdrawalAccount transfer |
	
	depositAccount := ReceptiveAccount new.
	withdrawalAccount := ReceptiveAccount new.
	
	transfer := Transfer forValue: 100 * peso from: withdrawalAccount to: depositAccount.
	self assert: transfer depositLeg oppositeLeg equals: transfer witdrawLeg 

	! !

!TransferTest methodsFor: 'test' stamp: 'EP 11/8/2022 00:21:42'!
test03CannotTransfer0Pesos
	| depositAccount  withdrawalAccount |
	
	depositAccount := ReceptiveAccount new.
	withdrawalAccount := ReceptiveAccount new.

	self should: [Transfer forValue: 0 * peso from: withdrawalAccount to: depositAccount.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: 'Cannot transfer an empty amount.']! !

!TransferTest methodsFor: 'test' stamp: 'EP 11/8/2022 00:24:00'!
test04CannotTransferNegativePesos
	| depositAccount  withdrawalAccount |
	
	depositAccount := ReceptiveAccount new.
	withdrawalAccount := ReceptiveAccount new.

	self should: [Transfer forValue: -100 * peso from: withdrawalAccount to: depositAccount.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: 'Cannot transfer a negative amount.']! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'EP 11/7/2022 21:37:18'!
valueForBalance
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

!Deposit methodsFor: 'value' stamp: 'EP 11/7/2022 21:37:33'!
valueForBalance
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

!Withdraw methodsFor: 'value' stamp: 'EP 11/7/2022 21:39:27'!
valueForBalance
	^value * -1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'members parent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'public' stamp: 'EP 11/10/2022 00:16:21'!
addParent: aPortfolio
	parent := aPortfolio.! !

!Portfolio methodsFor: 'public' stamp: 'A 11/8/2022 17:49:01'!
balance

	^members sum: [ :aMember | aMember balance  ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'public' stamp: 'EP 11/10/2022 21:36:31'!
checkMemberCanBeRegistered: aMember 

	(aMember = self) ifTrue: [self error: self class cannotRegisterItselfErrorDescription].
	
	(self hasRegistered: aMember) ifTrue: [self error: self class accountAlreadyRegisteredErrorDescription].
	
	(parent hasRegistered: aMember) ifTrue: [self error: self class accountAlreadyRegisteredInParentErrorDescription].
		
	(members anySatisfy: [:aRegisteredMember | aMember hasRegistered: aRegisteredMember])
	ifTrue: [self error: self class portfoliosWithAccountsInCommonErrorDescription].
! !

!Portfolio methodsFor: 'public' stamp: 'EP 11/10/2022 21:13:18'!
hasRegistered: aData

	^(members includes: aData) or: [members anySatisfy: [:aMember | aMember hasRegistered: aData]].! !

!Portfolio methodsFor: 'public' stamp: 'EP 11/10/2022 21:36:11'!
register: aMember 

	self checkMemberCanBeRegistered: aMember.
		
	aMember getRegisteredByThePortfolio: self.! !

!Portfolio methodsFor: 'public' stamp: 'EP 11/9/2022 22:25:42'!
transactions
	| membersTransactions |
	
	membersTransactions := OrderedCollection new.
	
	members do: [:aMember | membersTransactions addAll: aMember transactions ] .
	
	^membersTransactions.! !


!Portfolio methodsFor: 'intialization' stamp: 'EP 11/10/2022 21:37:19'!
initialize
	members := OrderedCollection new.
	parent := EmptyPortfolio new.  ! !


!Portfolio methodsFor: 'dd' stamp: 'EP 11/10/2022 20:34:13'!
getRegisteredByThePortfolio: aPortfolio 
	parent := aPortfolio.
	aPortfolio registerAPortfolio: self.! !

!Portfolio methodsFor: 'dd' stamp: 'EP 11/10/2022 20:33:50'!
registerAPortfolio: aPortfolio
	members add: aPortfolio.! !

!Portfolio methodsFor: 'dd' stamp: 'EP 11/10/2022 20:31:01'!
registerAReceptiveAccount: aReceptiveAccount 
	members add: aReceptiveAccount. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'EP 11/10/2022 20:57:34'!
accountAlreadyRegisteredErrorDescription
	^'This account is already registered in the portfolio.'.! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'EP 11/10/2022 21:00:24'!
accountAlreadyRegisteredInParentErrorDescription
	^'This account is already registered in a parent portfolio.'.! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'EP 11/10/2022 20:58:58'!
cannotRegisterItselfErrorDescription
	^'A portfolio cannot register itself.'.! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'EP 11/10/2022 21:05:12'!
portfoliosWithAccountsInCommonErrorDescription
	^'The portfolios have registered accounts in common.'.! !


!classDefinition: #EmptyPortfolio category: 'ServiciosFinancieros-Ejercicio'!
Portfolio subclass: #EmptyPortfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!EmptyPortfolio methodsFor: 'public' stamp: 'EP 11/10/2022 20:19:07'!
addParent: aPortfolio
	^self.! !

!EmptyPortfolio methodsFor: 'public' stamp: 'EP 11/10/2022 20:19:26'!
balance
	^self.! !

!EmptyPortfolio methodsFor: 'public' stamp: 'EP 11/10/2022 20:19:47'!
hasRegistered: aData
	^false.! !

!EmptyPortfolio methodsFor: 'public' stamp: 'EP 11/10/2022 20:20:12'!
register: aMember 
	^self.! !

!EmptyPortfolio methodsFor: 'public' stamp: 'EP 11/10/2022 20:20:34'!
transactions 
	^self.! !


!EmptyPortfolio methodsFor: 'intialization' stamp: 'EP 11/10/2022 20:23:28'!
initialize
	^self! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'EP 11/7/2022 21:34:55'!
balance

	^transactions sum: [ :aTransaction | aTransaction valueForBalance  ] ifEmpty: [ 0 ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'EP 11/10/2022 20:30:20'!
getRegisteredByThePortfolio: aPortfolio 
	aPortfolio registerAReceptiveAccount: self.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value depositLeg withdrawLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'A 11/8/2022 17:22:19'!
initializeFor: aValue from: aWithdrawalAccount to: aDepositAccount
	 	
	depositLeg := TransferLeg withTransaction: (Deposit for: aValue)		.
	withdrawLeg := TransferLeg withTransaction: (Withdraw for: aValue).
	
	withdrawLeg setOppositeLeg: depositLeg.
	depositLeg setOppositeLeg: withdrawLeg.	
	
	aWithdrawalAccount register: withdrawLeg.
	aDepositAccount register: depositLeg.
	
		
	! !


!Transfer methodsFor: 'value' stamp: 'A 11/8/2022 17:24:13'!
depositLeg
	^depositLeg! !

!Transfer methodsFor: 'value' stamp: 'EP 11/7/2022 21:30:05'!
value

	^ value! !

!Transfer methodsFor: 'value' stamp: 'A 11/8/2022 17:24:50'!
witdrawLeg
	^withdrawLeg! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'EP 11/8/2022 00:25:12'!
forValue: aValue from: aWithdrawalAccount to: aDepositAccount
	
	aValue = 0 ifTrue: [self error:  'Cannot transfer an empty amount.'].
	aValue < 0 ifTrue: [self error:  'Cannot transfer a negative amount.'].
	
	^self new initializeFor: aValue  from: aWithdrawalAccount to: aDepositAccount.! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #TransferLeg
	instanceVariableNames: 'transaction oppositeLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferLeg methodsFor: 'initialization' stamp: 'EP 11/8/2022 00:08:09'!
initializeWithTransaction: aTransaction
	transaction := aTransaction.! !


!TransferLeg methodsFor: 'getters' stamp: 'EP 11/8/2022 00:02:46'!
oppositeLeg
	^oppositeLeg! !


!TransferLeg methodsFor: 'value' stamp: 'EP 11/8/2022 00:11:13'!
valueForBalance
	^transaction valueForBalance. ! !


!TransferLeg methodsFor: 'setters' stamp: 'EP 11/8/2022 00:02:57'!
setOppositeLeg: aTransferLeg
	oppositeLeg := aTransferLeg.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Ejercicio'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'EP 11/8/2022 00:08:09'!
withTransaction: aTransaction
	^self new initializeWithTransaction: aTransaction.! !
