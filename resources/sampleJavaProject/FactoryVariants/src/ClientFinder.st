"first below indicates the first MooseModel in the browser. If you have more than one loaded, you can change it to second, third, etc. to specify other models that are loaded from MSE files."
classes := MooseModel root allModels first allClasses.
interfaces := (classes select: [ :c |
	   (c mooseName beginsWith:'java::') not and:
	   (c isInterface)]) asSet.

interface := interfaces detect: [ :c | (c name = 'IProduct')].


localClients := interface structuresWithDeclaredType collect:
		[ :struct |
			(struct isMemberOf:FAMIXAttribute)
				ifTrue:
			 		[ struct parentType ]
				ifFalse:
					[ (struct isMemberOf:FAMIXParameter)
						ifTrue:
							[ struct parentBehaviouralEntity parentType ]
						ifFalse:
							[ (struct isMemberOf:FAMIXLocalVariable)
								ifTrue:
									[ struct parentBehaviouralEntity parentType ]
								ifFalse:
									[ Transcript show:'*** Unanticipated type: '. Transcript show: struct class;cr ]
							]
					]
		].

"Sub-interfaces are rejected because they are not implementations"
localImplementations := interface directSubclasses reject: [ :cls | cls isInterface ].

refLocalImplementations := Set new.	"don't allow duplicates"

localImplementations
	do:
		[ :implementation | refLocalImplementations := refLocalImplementations , implementation clientTypes ].

localStableClients := localClients difference: refLocalImplementations.
localUnstableClients := localClients intersection: refLocalImplementations.

"Looking for <<creates>> relationship"

c1 := localUnstableClients at: 1.

m1 := c1 methods.

oi := Set new.

m1 do: [ :m | oi := oi , (m outgoingInvocations) ].


in1 := oi asArray first.

in1 getReceivingFAMIXClass.

"

createsClasses := Set new.

oi do: [ :invoc | (invoc signature beginsWith:'new ')
	ifTrue: [createsClasses := createsClasses , (invoc receiver) ]].

createsClasses.

"
"
m1 do: [ :m |
	m outgoingInvocations do: [ :o |
		(o signature beginsWith:'new ') ifTrue: [createsClasses := createsClasses, o ] ] ].

createsClasses."