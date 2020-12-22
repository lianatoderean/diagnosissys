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
	.send(agentMaster, achieve, paramForDiag(Names,Values, AgentName)).


+systemBusy <-

	+waiting(1)
	.
	
+systemAvailable 
<-
	?paramName(Names);
	?paramValues(Values);
	?name(AgentName);

	.send(agentMaster, tell, paramForDiag(Names,Values,AgentName)).
	
	
+result(Expl, Arg) <-
	.print("Received result \n");
//	.print(Expl, " This diagnosis was chosen because ",Arg)
	
	
	.
	
	
	
