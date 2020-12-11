Extension { #name : #ByteString }

{ #category : #'*AdventOfCode2020' }
ByteString >> day02a [
	^ (self lines select:[:line | line isAOCValidPassword] ) size.
]

{ #category : #'*AdventOfCode2020' }
ByteString >> day02b [
	^ (self lines select:[:line | line isAOCValidPassword2] ) size.
]

{ #category : #'*AdventOfCode2020' }
ByteString >> day03SlopeXDelta: xDelta yDelta: yDelta [
	| hill trees xPos yPos |
	hill := self lines.
	trees := 0.
	xPos := 1.
	yPos := 1.
	[ yPos <= hill size ] whileTrue: [
		((hill at: yPos) wrapAt: xPos) = $# ifTrue: [ trees := trees + 1 ].
		xPos := xPos + xDelta.
		yPos := yPos + yDelta.
	].
	^ trees
]

{ #category : #'*AdventOfCode2020' }
ByteString >> day03a [
	^ self day03SlopeXDelta: 3 yDelta: 1
]

{ #category : #'*AdventOfCode2020' }
ByteString >> day03b [
	| product |
	product := 1.
	{1@1. 3@1. 5@1. 7@1. 1@2} do: [: point |
		product := product * (self day03SlopeXDelta: point x yDelta: point y)
	].
	^ product
]

{ #category : #'*AdventOfCode2020' }
ByteString >> day04WithPassport: aSymbol [ 
	| validCount passport keyValue |
	validCount := 0.
	passport := nil.
	self linesDo: [ :line | 
		line isEmpty
			ifTrue: [ 
				(passport isValidPassport: aSymbol) ifTrue: [ 
					validCount := validCount + 1 ].
				passport := nil ]
			ifFalse: [ 
				passport ifNil: [ 
					passport := Dictionary new.
					passport at: 'cid' put: #default ].
				(line splitOn: $ ) do: [ :field | 
					keyValue := field splitOn: $:.
					passport at: keyValue first put: keyValue last ] ] ].
	(passport isValidPassport: aSymbol) ifTrue: [ 
		validCount := validCount + 1 ].
	^ validCount
]

{ #category : #'*AdventOfCode2020' }
ByteString >> isAOCValidPassword [
	| strings |
	strings := self splitOn: [: char | char = $- or: [ char = $  ] ].
	^ (strings fourth select: [: char | char = strings third first ]) size
			between: strings first asNumber and: strings second asNumber
]

{ #category : #'*AdventOfCode2020' }
ByteString >> isAOCValidPassword2 [
	| strings password char |
	strings := self splitOn: [: c | c = $- or: [ c = $  ] ].
	password := strings fourth.
	char := strings third first.
	^ (((password at: strings first asNumber)=char) asBit +
			((password at: strings second asNumber)=char) asBit) = 1
]

{ #category : #'*AdventOfCode2020' }
ByteString >> isValidBirthYear [
	^ self asNumber between: 1920 and: 2002
]

{ #category : #'*AdventOfCode2020' }
ByteString >> isValidExpirationYear [
	^ self asNumber between: 2020 and: 2030
]

{ #category : #'*AdventOfCode2020' }
ByteString >> isValidEyeColor [
	^ #(amb blu brn gry grn hzl oth) includes: self
]

{ #category : #'*AdventOfCode2020' }
ByteString >> isValidHairColor [
	self size = 7 ifFalse: [ ^ false ].
	(self beginsWith: '#') ifFalse: [ ^ false ].
	self allButFirst do: [: char | ('0123456789abcdef' includes: char) ifFalse: [ ^ false ]].
	^ true
]

{ #category : #'*AdventOfCode2020' }
ByteString >> isValidHeight [
	(self endsWith: 'cm') ifTrue: [(self asNumber between: 150 and: 193) ifTrue: [ ^ true ] ].
	(self endsWith: 'in') ifTrue: [(self asNumber between: 59 and: 76) ifTrue: [ ^ true ]].
	^ false
]

{ #category : #'*AdventOfCode2020' }
ByteString >> isValidIssueYear [
	^ self asNumber between: 2010 and: 2020
]

{ #category : #'*AdventOfCode2020' }
ByteString >> isValidPassportID [
	self size = 9 ifFalse: [ ^ false ].
	self do: [: char | ('0123456789' includes: char) ifFalse: [ ^ false ]].
	^ true
]

{ #category : #'*AdventOfCode2020' }
ByteString >> wrapAt: anInteger [ 
	^ self at: ((anInteger-1) % self size)+1
]
