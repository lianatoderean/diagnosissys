// Agent humanAgent in project agentsys

/* Initial beliefs and rules */

/* Initial goals */
name("Agent ").
filename(test1).
!start.

/* Plans */

+!start : true <- 
		.print("Human agent started")
		!getDiagnosis.
+!diagnose <- .print("Notified that diagnosis process started").
+!getDiagnosis <-
	.print("Human agent requested diagnosis");
	?filename(X)
	myLib.requestDiagnosis(X, Names, Values, ScaledValues);
	+paramName(Names);
	+paramValues(Values);
	+scaledValues(ScaledValues);
	?name(AgentName);
	.send(agentMaster, tell, paramForDiag(Names,Values,ScaledValues, AgentName)).


+systemBusy <-

	+waiting(1)
	.
	
+systemAvailable 
<-
	?paramName(Names);
	?paramValues(Values);
	?scaledValues(ScaledValues);
	?name(AgentName);

	.send(agentMaster, tell, paramForDiag(Names,Values,ScaledValues, AgentName)).
	
