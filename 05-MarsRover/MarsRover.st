!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'testing' stamp: 'EP 10/30/2022 16:30:25'!
test01MarsRoverDoesNotMoveIfReceivesEmptyCommand
	| marsRover |
	
	marsRover := MarsRover withCoordinates: 0@0 andOrientation: 'N'.
	 
	marsRover receiveInstructions: ''	.
	
	self assert: (marsRover isAtPosition: 0@0).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EP 10/30/2022 16:30:28'!
test02MarsRoverMovesForwardWhenReceivesCommand
	| marsRover |
	
	marsRover := MarsRover withCoordinates: 0@0 andOrientation: 'N'.
	 
	marsRover receiveInstructions: 'f'	.
	
	self assert: (marsRover isAtPosition: 0@1).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EP 11/2/2022 22:04:46'!
test03MarsRoverRotatesLeftCorrectly
	| marsRover |
	
	marsRover := MarsRover withCoordinates: 0@0 andOrientation: 'N'.
	 
	marsRover receiveInstructions: 'lf'	.
	
	self assert: (marsRover isAtPosition: -1@0).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EP 11/2/2022 22:06:52'!
test04MarsRoverRotatesRightCorrectly
	| marsRover |
	
	marsRover := MarsRover withCoordinates: 0@0 andOrientation: 'N'.
	
	marsRover receiveInstructions: 'rf'	.
	
	self assert: (marsRover isAtPosition: 1@0).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EP 11/2/2022 22:06:58'!
test05MarsRoverReturnsToItsInitialPositionAfterMovingForwardAndBackwards
	| marsRover |
	
	marsRover := MarsRover withCoordinates: 0@0 andOrientation: 'N'.
	 
	marsRover receiveInstructions: 'ffbb'	.
	
	self assert: (marsRover isAtPosition: 0@0).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EP 11/2/2022 22:05:37'!
test06MarsRoverReceivesInvalidCommandAndFails
	| marsRover |
	
	marsRover := MarsRover withCoordinates: 0@0 andOrientation: 'N'.
	 
	
	self should: [ marsRover receiveInstructions: 'ffñbb'	 ]
		raise: Error 
		withExceptionDo: [ :anError | self assert: anError messageText equals: 'Instruction not valid.'].! !


!classDefinition: #CardinalPoints category: 'MarsRover'!
Object subclass: #CardinalPoints
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalPoints methodsFor: 'public' stamp: 'EP 10/30/2022 17:41:27'!
rotateLeft
	self subclassResponsibility.! !

!CardinalPoints methodsFor: 'public' stamp: 'EP 10/30/2022 17:41:23'!
rotateRight
	self subclassResponsibility.! !

!CardinalPoints methodsFor: 'public' stamp: 'EP 11/2/2022 23:40:37'!
whereToMoveBackwards: marsRover
	self subclassResponsibility.! !

!CardinalPoints methodsFor: 'public' stamp: 'EP 11/2/2022 23:40:44'!
whereToMoveForward: marsRover
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalPoints class' category: 'MarsRover'!
CardinalPoints class
	instanceVariableNames: ''!

!CardinalPoints class methodsFor: 'identification' stamp: 'EP 10/30/2022 18:17:02'!
identifier
	self subclassResponsibility.! !


!CardinalPoints class methodsFor: 'instance creation' stamp: 'EP 10/30/2022 18:02:47'!
at: anOrientation
	self subclasses detect: [:aSubclass | aSubclass identifier = anOrientation]
	ifFound: [:aSubclass | ^aSubclass new]
        ifNone:[ self error: 'La orientación no existe'].! !


!classDefinition: #East category: 'MarsRover'!
CardinalPoints subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'public' stamp: 'EP 10/30/2022 17:52:34'!
rotateLeft
	^North new.! !

!East methodsFor: 'public' stamp: 'EP 10/30/2022 17:42:34'!
rotateRight
	^South new.! !

!East methodsFor: 'public' stamp: 'EP 11/2/2022 23:37:44'!
whereToMoveBackwards: marsRover
	marsRover moveBackwardsFacingEast.	! !

!East methodsFor: 'public' stamp: 'EP 11/2/2022 23:36:07'!
whereToMoveForward: marsRover
	marsRover moveForwardFacingEast.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: 'MarsRover'!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'identification' stamp: 'EP 10/30/2022 18:05:52'!
identifier
	^'E'.! !


!classDefinition: #North category: 'MarsRover'!
CardinalPoints subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'public' stamp: 'EP 10/30/2022 17:52:46'!
rotateLeft
	^West new.! !

!North methodsFor: 'public' stamp: 'EP 10/30/2022 17:42:04'!
rotateRight
	^East new.! !

!North methodsFor: 'public' stamp: 'EP 11/2/2022 23:37:59'!
whereToMoveBackwards: marsRover
	marsRover moveBackwardsFacingNorth.	! !

!North methodsFor: 'public' stamp: 'EP 11/2/2022 23:36:35'!
whereToMoveForward: marsRover
	marsRover moveForwardFacingNorth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: 'MarsRover'!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'identification' stamp: 'EP 10/30/2022 18:06:10'!
identifier
	^'N'.! !


!classDefinition: #South category: 'MarsRover'!
CardinalPoints subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'public' stamp: 'EP 10/30/2022 17:51:53'!
rotateLeft
	^East new.! !

!South methodsFor: 'public' stamp: 'EP 10/30/2022 17:42:46'!
rotateRight
	^West new.! !

!South methodsFor: 'public' stamp: 'EP 11/2/2022 23:38:09'!
whereToMoveBackwards: marsRover
	marsRover moveBackwardsFacingSouth. 	! !

!South methodsFor: 'public' stamp: 'EP 11/2/2022 23:36:47'!
whereToMoveForward: marsRover
	marsRover moveForwardFacingSouth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: 'MarsRover'!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'identification' stamp: 'EP 10/30/2022 18:06:34'!
identifier
	^'S'.! !


!classDefinition: #West category: 'MarsRover'!
CardinalPoints subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'public' stamp: 'EP 10/30/2022 17:52:19'!
rotateLeft
	^South new.! !

!West methodsFor: 'public' stamp: 'EP 10/30/2022 17:43:01'!
rotateRight
	^North new.! !

!West methodsFor: 'public' stamp: 'EP 11/2/2022 23:38:16'!
whereToMoveBackwards: marsRover
	marsRover moveBackwardsFacingWest.	! !

!West methodsFor: 'public' stamp: 'EP 11/2/2022 23:37:03'!
whereToMoveForward: marsRover
	marsRover moveForwardFacingWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: 'MarsRover'!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'identification' stamp: 'EP 10/30/2022 18:06:52'!
identifier
	^'W'.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'coordinates orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'private' stamp: 'EP 11/2/2022 22:02:14'!
executeCommand: aCommand
     (aCommand asString = 'f') ifTrue: [^self moveForward].
     (aCommand asString = 'b') ifTrue: [^self moveBackwards].
     (aCommand asString = 'l')  ifTrue: [^self rotateLeft].
     (aCommand asString = 'r') ifTrue: [^self rotateRight].
 
     self error: 'Instruction not valid.'.! !

!MarsRover methodsFor: 'private' stamp: 'EP 11/2/2022 23:38:41'!
moveBackwards
	orientation whereToMoveBackwards: self.! !

!MarsRover methodsFor: 'private' stamp: 'EP 11/2/2022 23:35:53'!
moveForward
	orientation whereToMoveForward: self.	! !

!MarsRover methodsFor: 'private' stamp: 'EP 10/30/2022 17:49:34'!
rotateLeft
	orientation := orientation rotateLeft.! !

!MarsRover methodsFor: 'private' stamp: 'EP 10/30/2022 17:49:22'!
rotateRight
	orientation := orientation rotateRight.! !


!MarsRover methodsFor: 'public' stamp: 'EP 10/30/2022 16:18:35'!
isAtPosition: aCoordinate
	^coordinates = aCoordinate.! !

!MarsRover methodsFor: 'public' stamp: 'EP 10/30/2022 17:31:24'!
receiveInstructions: aSetOfInstructions
     
     aSetOfInstructions isEmpty ifTrue: [ ^self ].
     aSetOfInstructions do: [:aCommand | self executeCommand: aCommand].! !


!MarsRover methodsFor: 'dd' stamp: 'EP 11/2/2022 23:31:31'!
moveBackwardsFacingEast
	coordinates := coordinates + (-1@0).
	! !

!MarsRover methodsFor: 'dd' stamp: 'EP 11/2/2022 23:31:50'!
moveBackwardsFacingNorth
	coordinates := coordinates + (0@-1).
	! !

!MarsRover methodsFor: 'dd' stamp: 'EP 11/2/2022 23:31:55'!
moveBackwardsFacingSouth
	coordinates := coordinates + (0@1).
	! !

!MarsRover methodsFor: 'dd' stamp: 'EP 11/2/2022 23:31:36'!
moveBackwardsFacingWest
	coordinates := coordinates + (1@0).
	! !

!MarsRover methodsFor: 'dd' stamp: 'EP 11/2/2022 23:31:15'!
moveForwardFacingEast
	coordinates := coordinates + (1@0).
	! !

!MarsRover methodsFor: 'dd' stamp: 'EP 11/2/2022 23:30:15'!
moveForwardFacingNorth
	coordinates := coordinates + (0@1).
	! !

!MarsRover methodsFor: 'dd' stamp: 'EP 11/2/2022 23:30:27'!
moveForwardFacingSouth
	coordinates := coordinates + (0@-1).
	! !

!MarsRover methodsFor: 'dd' stamp: 'EP 11/2/2022 23:30:49'!
moveForwardFacingWest
	coordinates := coordinates + (-1@0).
	! !


!MarsRover methodsFor: 'initialization' stamp: 'EP 10/30/2022 17:57:59'!
initializeWithCoordinates: someCoordinates andOrientation: anOrientation
	coordinates := someCoordinates.
	orientation := CardinalPoints at: anOrientation.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'EP 10/30/2022 16:25:57'!
withCoordinates: someCoordinates andOrientation: anOrientation
	^self new initializeWithCoordinates: someCoordinates andOrientation: anOrientation.! !
