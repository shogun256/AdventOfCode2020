Class {
	#name : #BaselineOfAdventOfCode2020,
	#superclass : #BaselineOf,
	#category : #BaselineOfAdventOfCode2020
}

{ #category : #baselines }
BaselineOfAdventOfCode2020 >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ "Packages"
			spec
				package: 'AdventofCode2020';
				package: 'AdventofCode2020-Tests'
					with: [ spec requires: #('AdventofCode2020') ] ]
]
