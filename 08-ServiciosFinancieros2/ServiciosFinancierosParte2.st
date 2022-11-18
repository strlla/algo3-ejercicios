!classDefinition: #AccountSummaryTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummaryTest methodsFor: 'test' stamp: 'MN 11/17/2022 11:01:20'!
test01AccountWithNoTransactionsKnowsItsSummary
    | anAccount summary |

	anAccount := ReceptiveAccount new.
	summary := AccountSummaryReport for: anAccount. 
	
    self assert: summary reportText equals: ('Balance = ', anAccount balance asString).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'EP 11/17/2022 21:22:12'!
test02AccountWithADepositKnowsItsSummary
    | anAccount aDeposit summary|

	anAccount := ReceptiveAccount new.
	aDeposit := Deposit register: 100 * peso on: anAccount.
	summary := AccountSummaryReport for: anAccount. 

    self assert: summary reportText equals: ('Depósito por ', aDeposit value asString, '
Balance = ', anAccount balance asString).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'EP 11/17/2022 21:22:06'!
test03AccountWithAWithdrawKnowsItsSummary
    | anAccount aWithdraw summary|

	anAccount := ReceptiveAccount new.
	aWithdraw := Withdraw register: 50 * peso on: anAccount.
	summary := AccountSummaryReport for: anAccount. 

    self assert: summary reportText equals: ('Extracción por ', aWithdraw value asString,'
Balance = ', anAccount balance asString).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'EP 11/17/2022 21:21:57'!
test04AccountWithAWithdrawFromTransferKnowsItsSummary
    | senderAccount receiverAccount transfer aDeposit summary|
 
	senderAccount := ReceptiveAccount new.	
	receiverAccount := ReceptiveAccount new.
	
	aDeposit := Deposit register: 100 * peso on: senderAccount.
	
	transfer := Transfer amount: 20 * peso from: senderAccount to: receiverAccount.

	summary := AccountSummaryReport for: senderAccount. 

    self assert: summary reportText equals: ('Depósito por ', aDeposit value asString, '
Salida por transferencia de ', transfer value asString,'
Balance = ', senderAccount balance asString).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'EP 11/17/2022 21:21:30'!
test05AccountWIthADepositFromTransferKnowsItsSummary
    | senderAccount receiverAccount transfer summary|
 
	senderAccount := ReceptiveAccount new.	
	receiverAccount := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: senderAccount.
	
	transfer := Transfer amount: 20 * peso from: senderAccount to: receiverAccount.

	summary := AccountSummaryReport for: receiverAccount . 

    self assert: summary reportText equals: ('Entrada por transferencia de ', transfer value asString,'
Balance = ', receiverAccount balance asString).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'EP 11/17/2022 21:21:09'!
test06AccountWIthSeveralTransactionsKnowsItsSummary
    | anAccount anotherAccount transfer anotherTransfer aDeposit aWithdraw summary |
 
	anAccount := ReceptiveAccount new.	
	anotherAccount := ReceptiveAccount new.
	
	aDeposit := Deposit register: 100 * peso on: anAccount.

	aWithdraw := Withdraw register: 10 * peso on: anAccount.

	transfer := Transfer amount: 20 * peso from: anAccount to: anotherAccount.
		
	anotherTransfer := Transfer amount: 20 * peso from: anotherAccount to: anAccount.

	summary := AccountSummaryReport for: anAccount.


    self assert: summary reportText equals: 
    ('Depósito por ', aDeposit value asString, '
Extracción por ', aWithdraw value asString, '
Salida por transferencia de ', transfer value asString, '
Entrada por transferencia de ', anotherTransfer value asString,'
Balance = ', anAccount balance asString).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'EP 11/17/2022 21:20:51'!
test07PortfolioWithSeveralTransactionsKnowsItsSummary
    | anAccount anotherAccount transfer anotherTransfer aDeposit aWithdraw summary portfolio|
 
	anAccount := ReceptiveAccount new.	
	anotherAccount := ReceptiveAccount new.
	
	aDeposit := Deposit register: 100 * peso on: anAccount.

	aWithdraw := Withdraw register: 10 * peso on: anAccount.

	transfer := Transfer amount: 20 * peso from: anAccount to: anotherAccount.
		
	anotherTransfer := Transfer amount: 20 * peso from: anotherAccount to: anAccount.
	
	portfolio := Portfolio with: anAccount with: anotherAccount. 

	summary := AccountSummaryReport for: portfolio.


    self assert: summary reportText equals: 
    ('Depósito por ', aDeposit value asString, '
Extracción por ', aWithdraw value asString, '
Salida por transferencia de ', transfer value asString, '
Entrada por transferencia de ', anotherTransfer value asString,'
Entrada por transferencia de ', transfer value asString , '
Salida por transferencia de ', anotherTransfer value asString ,'
Balance = ', anAccount balance asString).! !


!classDefinition: #PortfolioDetailedTreePrinterTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioDetailedTreePrinterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'EP 11/17/2022 21:30:13'!
test01PortfolioWithoutAccountsPrintsItself
	| portfolio tree |
	
	portfolio := Portfolio named: 'Portfolio aislado'.
	tree := PortfolioTreeDetailedPrinter for: portfolio. 
	
	
	self assert: tree reportText equals: 'Portfolio aislado
	Balance = ', (portfolio balance) asString. 
	
	! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'EP 11/17/2022 21:29:02'!
test02PortfolioWithTransactionsPrintsCorrectly
	| portfolio tree account deposit |
	
	account := ReceptiveAccount named: 'Cuenta de Alan'.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio named: 'Portfolio con hijo' with: account.
	tree := PortfolioTreeDetailedPrinter for: portfolio. 

	self assert: tree reportText equals: 'Portfolio con hijo
	Cuenta de Alan
		Depósito por ', (deposit value) asString,'
		Balance = ', (account balance) asString,'
	Balance = ', (portfolio balance) asString. 
	
	! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'EP 11/17/2022 21:37:21'!
test03PortfolioWithManyAccountsPrintsCorrectly
	| portfolio  johnsAccount angiesAccount aDeposit anotherDeposit tree |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'. 
	
	portfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount. 	
	aDeposit := Deposit register: 100 * peso on: johnsAccount.
	anotherDeposit := Deposit register: 100 * peso on: angiesAccount.

	tree := PortfolioTreeDetailedPrinter for: portfolio. 

	self assert: tree reportText equals: 'Portfolio de hijos
	Cuenta de Juan
		Depósito por ', (aDeposit value) asString,'
		Balance = ', (johnsAccount balance) asString,'
	Cuenta de Angeles
		Depósito por ', (anotherDeposit value) asString, '
		Balance = ', (angiesAccount balance) asString, '
	Balance = ', (portfolio balance) asString. ! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'EP 11/17/2022 21:45:58'!
test04PortfolioWithManyPortfoliosPrintsCorrectly
	| familyPortfolio childrenPortfolio  johnsAccount angiesAccount myAccount aDeposit anotherDeposit tree |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'. 
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount. 
	myAccount := ReceptiveAccount named: 'Cuenta mia'. 
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	aDeposit := Deposit register: 100 * peso on: johnsAccount.
	anotherDeposit := Deposit register: 100 * peso on: angiesAccount.

	tree := PortfolioTreeDetailedPrinter for: familyPortfolio. 

	self assert: tree reportText equals: 'Portfolio de la familia
	Cuenta mia
		Balance = ', (myAccount balance) asString, '
	Portfolio de hijos
		Cuenta de Juan
			Depósito por ', (aDeposit value) asString,'
			Balance = ', (johnsAccount balance) asString,'
		Cuenta de Angeles
			Depósito por ', (anotherDeposit value) asString, '
			Balance = ', (angiesAccount balance) asString,'
		Balance = ', (childrenPortfolio balance) asString, '
	Balance = ', (familyPortfolio balance) asString. ! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #PortfolioTreePrinterTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTreePrinterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'EP 11/17/2022 17:37:50'!
test01PortfolioWithNoMembersIsAloneInTree
	| portfolio tree |
	
	portfolio := Portfolio named: 'Portfolio aislado'.
	tree := PortfolioTreePrinter for: portfolio. 
	
	
	self assert: tree reportText equals: 'Portfolio aislado'. ! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'EP 11/17/2022 17:57:31'!
test02PortfolioWithAnAccountPrintsCorrectly
	| portfolio tree account |
	
	account := ReceptiveAccount named: 'Cuenta de Alan'. 
	portfolio := Portfolio named: 'Portfolio con hijos' with: account. 
	tree := PortfolioTreePrinter for: portfolio. 

	self assert: tree reportText equals: 'Portfolio con hijos
	Cuenta de Alan'. ! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'EP 11/17/2022 20:08:39'!
test03FamilyPortfolioPrintsCorrectly
	| tree johnsAccount angiesAccount  childrenPortfolio myAccount familyPortfolio |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'. 
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount. 
	myAccount := ReceptiveAccount named: 'Cuenta mia'. 
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
		
	tree := PortfolioTreePrinter for: familyPortfolio. 
	
	self assert: tree reportText equals: 'Portfolio de la familia
	Cuenta mia
	Portfolio de hijos
		Cuenta de Juan
		Cuenta de Angeles'. ! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'EP 11/17/2022 20:09:40'!
test04FamilyPortfolioWithManyGenerationsPrintsCorrectly
	| tree johnsAccount angiesAccount  childrenPortfolio myAccount familyPortfolio anotherPortfolio |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'. 
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount. 
	myAccount := ReceptiveAccount named: 'Cuenta mia'. 
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	anotherPortfolio := Portfolio named: 'Otro portfolio' with: familyPortfolio.
	
	tree := PortfolioTreePrinter for: anotherPortfolio. 
	
	self assert: tree reportText equals: 'Otro portfolio
	Portfolio de la familia
		Cuenta mia
		Portfolio de hijos
			Cuenta de Juan
			Cuenta de Angeles'. ! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'EP 11/17/2022 20:20:10'!
test05FamilyPortfolioPrintsCorrectly
	| tree johnsAccount angiesAccount  childrenPortfolio myAccount familyPortfolio secondChildrenPortfolio |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	secondChildrenPortfolio := Portfolio named: 'Segundo portfolio de hijos' with: angiesAccount . 
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount.
	myAccount := ReceptiveAccount named: 'Cuenta mia'. 
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	familyPortfolio add: secondChildrenPortfolio.
	tree := PortfolioTreePrinter for: familyPortfolio. 
	
	self assert: tree reportText equals: 'Portfolio de la familia
	Cuenta mia
	Portfolio de hijos
		Cuenta de Juan
	Segundo portfolio de hijos
		Cuenta de Angeles'. ! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

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


!classDefinition: #TransferNetTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNetTest methodsFor: 'tests' stamp: 'EP 11/15/2022 22:13:44'!
test01TheNetIsZeroWhenTheAccountHasNoTransfers
     | anAccount aTransferNetReport |
 
    anAccount := ReceptiveAccount new.
    aTransferNetReport := TransferNetReport for: anAccount.
 
    self assert: aTransferNetReport result equals: 0 * peso.! !

!TransferNetTest methodsFor: 'tests' stamp: 'EP 11/15/2022 22:13:44'!
test02TransfersAffectTheTransferNet
    | senderAccount receiverAccount aTransferNetReport |
 
    senderAccount := ReceptiveAccount new.	
    receiverAccount := ReceptiveAccount new.
	
    Deposit register: 100 * peso on: senderAccount.

    Transfer amount: 20 * peso from: senderAccount to: receiverAccount.

    aTransferNetReport := TransferNetReport for: receiverAccount. 

    self assert: aTransferNetReport result equals: 20 * peso.

! !

!TransferNetTest methodsFor: 'tests' stamp: 'EP 11/15/2022 22:13:44'!
test03OnlyTransfersAffectTheTransferNet
    | senderAccount receiverAccount aTransferNetReport |
 
    senderAccount := ReceptiveAccount new.	
    receiverAccount := ReceptiveAccount new.
	
    Deposit register: 100 * peso on: senderAccount.

    Transfer amount: 20 * peso from: senderAccount to: receiverAccount.

    aTransferNetReport := TransferNetReport for: senderAccount. 

    self assert: aTransferNetReport result equals: -20 * peso.

! !

!TransferNetTest methodsFor: 'tests' stamp: 'EP 11/15/2022 22:13:44'!
test04SeveralTransfersAffectTheTransferNet
    | anAccount anotherAccount aTransferNetReport |
 
    anAccount := ReceptiveAccount new.	
    anotherAccount := ReceptiveAccount new.
	
    Deposit register: 100 * peso on: anAccount.
    Deposit register: 100 * peso on: anotherAccount.

    Transfer amount: 20 * peso from: anAccount to: anotherAccount.
    Transfer amount: 30 * peso from: anotherAccount to: anAccount.

    aTransferNetReport := TransferNetReport for: anAccount. 

    self assert: aTransferNetReport result equals: 10 * peso.

! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'EP 11/17/2022 18:22:10'!
initializeWithName: aName
	parents := OrderedCollection new.	
	name := aName.
! !


!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'EP 11/17/2022 17:44:05'!
name
	^name.! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'composition' stamp: 'EP 11/17/2022 18:08:04'!
accounts
	^accounts copy.! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'EP 11/17/2022 17:40:32'!
named: aString 
	^self new initializeWithName: aString ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'EP 11/17/2022 18:21:11'!
named: aName with: anAccount
         ^self new
	  add: anAccount;
	  initializeWithName: aName;
	  yourself.! !

!Portfolio class methodsFor: 'instance creation' stamp: 'EP 11/17/2022 17:55:03'!
named: aName with: anAccount  with: anotherAccount
	^self new 
		add: anAccount;
		add: anotherAccount;
		initializeWithName: aName;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'EP 11/17/2022 17:32:31'!
initializeName: aName
	super initialize.
	name := aName.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'EP 11/17/2022 18:24:03'!
name
	^name.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
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


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'EP 11/17/2022 17:56:38'!
named: aName
	^self new initializeName: aName. ! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'dd' stamp: 'EP 11/15/2022 22:11:53'!
beAddedToAReport: aReport
	self subclassResponsibility. ! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'dd' stamp: 'EP 11/17/2022 21:22:38'!
beAddedToAReport: aReport
	^ aReport addADeposit: self. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferLeg methodsFor: 'dd' stamp: 'EP 11/15/2022 22:12:03'!
beAddedToAReport: aReport
	self subclassResponsibility. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'value' stamp: 'EP 11/17/2022 21:23:14'!
beAddedToAReport: aReport
	^aReport addATransferDepositLeg: self.! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !

!TransferWithdrawLeg methodsFor: 'balance' stamp: 'EP 11/17/2022 21:23:19'!
beAddedToAReport: aReport
	^aReport addATransferWithdrawLeg: self.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'dd' stamp: 'EP 11/17/2022 21:23:25'!
beAddedToAReport: aReport
	^aReport addAWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #PortfolioTreeDetailedPrinter category: 'ServiciosFinancieros-Solucion'!
Object subclass: #PortfolioTreeDetailedPrinter
	instanceVariableNames: 'portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreeDetailedPrinter methodsFor: 'dd' stamp: 'EP 11/17/2022 21:13:32'!
addADeposit: aDeposit
	^'Depósito por ', (aDeposit value) asString, Character newLineCharacter asString.! !

!PortfolioTreeDetailedPrinter methodsFor: 'dd' stamp: 'EP 11/17/2022 21:12:32'!
addATransferDepositLeg: aTransferLeg
	^'Entrada por transferencia de ', (aTransferLeg value) asString, Character newLineCharacter asString.! !

!PortfolioTreeDetailedPrinter methodsFor: 'dd' stamp: 'EP 11/17/2022 21:12:39'!
addATransferWithdrawLeg: aTransferLeg
	^'Salida por transferencia de ', (aTransferLeg value) asString, Character newLineCharacter asString.! !

!PortfolioTreeDetailedPrinter methodsFor: 'dd' stamp: 'EP 11/17/2022 21:12:45'!
addAWithdraw: aWithdraw
	^'Extracción por ', (aWithdraw value) asString, Character newLineCharacter asString.! !


!PortfolioTreeDetailedPrinter methodsFor: 'as yet unclassified' stamp: 'EP 11/17/2022 21:28:42'!
accountSummaryOf: anAccount withIndentations: aQuantity
	| text |
	
	text := ''.
				
	anAccount transactions do: [:aTransaction | 
			aQuantity - 1 timesRepeat: [text := text, '	'].
			text := text, (aTransaction beAddedToAReport: self) .
		]. 
	aQuantity timesRepeat: [text := text, '	'].
	text := text, 'Balance = ', anAccount balance asString, Character newLineCharacter asString.
	^text.! !

!PortfolioTreeDetailedPrinter methodsFor: 'as yet unclassified' stamp: 'EP 11/17/2022 20:23:09'!
initializeWith: aPortfolio
	portfolio := aPortfolio. ! !

!PortfolioTreeDetailedPrinter methodsFor: 'as yet unclassified' stamp: 'EP 11/17/2022 21:52:26'!
printChildrenOfPortfolio: aPortfolio withIndentations: aQuantity
	| text |
	
	text := aPortfolio name, Character newLineCharacter asString. 

	aPortfolio accounts do: [:anAccount | 
		text := text, '	', anAccount name.
		text := text, Character newLineCharacter asString, '	'.
		(anAccount isKindOf: ReceptiveAccount) ifTrue: [text := text, (self accountSummaryOf: anAccount withIndentations: aQuantity + 1)].
	 
		(anAccount isKindOf: Portfolio) ifTrue: [text := text, (self printChildrenOfPortfolio: aPortfolio withIndentations: aQuantity + 1)]].
	
	text := text, '	Balance = ', (aPortfolio balance) asString.
	
	^text.! !

!PortfolioTreeDetailedPrinter methodsFor: 'as yet unclassified' stamp: 'EP 11/17/2022 21:53:57'!
reportText
	| text |
	
	text := portfolio name, Character newLineCharacter asString. 
	text := text, (self printChildrenOfPortfolio: portfolio withIndentations: 1). 

	text := text, '	Balance = ', (portfolio balance) asString.
	
	^text.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreeDetailedPrinter class' category: 'ServiciosFinancieros-Solucion'!
PortfolioTreeDetailedPrinter class
	instanceVariableNames: ''!

!PortfolioTreeDetailedPrinter class methodsFor: 'as yet unclassified' stamp: 'EP 11/17/2022 20:22:34'!
for: aPortfolio 
	^self new initializeWith: aPortfolio.! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros-Solucion'!
Object subclass: #PortfolioTreePrinter
	instanceVariableNames: 'portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinter methodsFor: 'public' stamp: 'EP 11/17/2022 20:05:27'!
printChildrenOfPortfolio: aPortfolio WithIndentations: aQuantity
	| text |
	
	text := ''.
	
	aPortfolio accounts do: [:anAccount | 
		text := text, Character newLineCharacter asString.
		aQuantity timesRepeat: [text := text, '	'].
		text := text, anAccount name.
		
		(anAccount isKindOf: Portfolio) ifTrue: [text := text, (self printChildrenOfPortfolio: anAccount WithIndentations: aQuantity + 1)].

	].
	
	^text.! !

!PortfolioTreePrinter methodsFor: 'public' stamp: 'EP 11/17/2022 20:04:20'!
reportText
	| text |
	
	text := portfolio name.

	text := text, (self printChildrenOfPortfolio: portfolio WithIndentations: 1).
	
	^text.! !


!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'EP 11/17/2022 17:43:05'!
initializeWith: aPortfolio
	portfolio := aPortfolio. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: 'ServiciosFinancieros-Solucion'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'instance creation' stamp: 'EP 11/17/2022 17:41:48'!
for: aPortfolio 
	^self new initializeWith: aPortfolio ! !


!classDefinition: #Report category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Report methodsFor: 'initialization' stamp: 'EP 11/14/2022 21:43:25'!
initializeWith: anAccount
	self subclassResponsibility.! !


!Report methodsFor: 'public' stamp: 'EP 11/14/2022 21:47:49'!
reportText
	^self subclassResponsibility.! !


!classDefinition: #AccountSummaryReport category: 'ServiciosFinancieros-Solucion'!
Report subclass: #AccountSummaryReport
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummaryReport methodsFor: 'initialization' stamp: 'EP 11/14/2022 21:09:01'!
initializeWith: anAccount
	account := anAccount.
	summary := ''.
	 
	self createSummary.! !


!AccountSummaryReport methodsFor: 'private' stamp: 'EP 11/14/2022 21:36:17'!
addATransaction: aTransaction
	aTransaction beAddedToAReport: self.! !

!AccountSummaryReport methodsFor: 'private' stamp: 'EP 11/14/2022 21:06:55'!
createSummary
	account transactions do: [:aTransaction |		 self addATransaction: aTransaction.		].
	
	summary := summary, 'Balance = ', account balance asString. 	
! !


!AccountSummaryReport methodsFor: 'public' stamp: 'EP 11/14/2022 21:47:49'!
reportText
	^summary.! !


!AccountSummaryReport methodsFor: 'dd' stamp: 'EP 11/17/2022 21:19:43'!
addADeposit: aDeposit
	summary := summary, 'Depósito por ', aDeposit value asString, Character newLineCharacter asString.! !

!AccountSummaryReport methodsFor: 'dd' stamp: 'MN 11/17/2022 11:40:07'!
addATransferDepositLeg: aTransferLeg
	summary := summary, 'Entrada por transferencia de ', aTransferLeg value asString, Character newLineCharacter asString.! !

!AccountSummaryReport methodsFor: 'dd' stamp: 'MN 11/17/2022 11:40:13'!
addATransferWithdrawLeg: aTransferLeg
	summary := summary, 'Salida por transferencia de ', aTransferLeg value asString, Character newLineCharacter asString.! !

!AccountSummaryReport methodsFor: 'dd' stamp: 'EP 11/17/2022 21:19:53'!
addAWithdraw: aWithdraw
	summary := summary, 'Extracción por ', aWithdraw value asString, Character newLineCharacter asString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryReport class' category: 'ServiciosFinancieros-Solucion'!
AccountSummaryReport class
	instanceVariableNames: ''!

!AccountSummaryReport class methodsFor: 'instance creation' stamp: 'EP 11/14/2022 21:12:26'!
for: anAccount
	^self new initializeWith: anAccount. ! !


!classDefinition: #TransferNetReport category: 'ServiciosFinancieros-Solucion'!
Report subclass: #TransferNetReport
	instanceVariableNames: 'netBalance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'EP 11/15/2022 21:58:20'!
initializeWith: anAccount
	account := anAccount.
	netBalance := 0 * peso.! !


!TransferNetReport methodsFor: 'dd' stamp: 'EP 11/15/2022 22:07:02'!
addADeposit: aDeposit
	^netBalance.! !

!TransferNetReport methodsFor: 'dd' stamp: 'EP 11/15/2022 22:09:45'!
addATransferDepositLeg: aTransferDepositLeg
	netBalance := aTransferDepositLeg affectBalance: netBalance.! !

!TransferNetReport methodsFor: 'dd' stamp: 'EP 11/15/2022 22:09:49'!
addATransferWithdrawLeg: aTransferWithdrawLeg
	netBalance := aTransferWithdrawLeg affectBalance: netBalance.! !

!TransferNetReport methodsFor: 'dd' stamp: 'EP 11/15/2022 22:07:07'!
addAWithdraw: aWithdraw
	^netBalance.! !


!TransferNetReport methodsFor: 'public' stamp: 'EP 11/15/2022 22:10:07'!
result

	account transactions do: [:aTransaction | aTransaction  beAddedToAReport: self ].
	
	^netBalance. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetReport class' category: 'ServiciosFinancieros-Solucion'!
TransferNetReport class
	instanceVariableNames: ''!

!TransferNetReport class methodsFor: 'instance creation' stamp: 'EP 11/15/2022 21:14:40'!
for: anAccount
	^self new initializeWith: anAccount. ! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
