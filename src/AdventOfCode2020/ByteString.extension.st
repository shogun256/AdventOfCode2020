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
ByteString >> wrapAt: anInteger [ 
	^ self at: ((anInteger-1) % self size)+1
]
