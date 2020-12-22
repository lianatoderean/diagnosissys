listNames([]).
listValues([]).
free.
count(0).



+!paramForDiag(Names,Values,AgentName):
	free
	<- 
		-free;
		+busy;
		-listNames(X);
		+listNames(Names);
		-listValues(X);
		+listValues(Values);
		.print("Human ", AgentName, " wants the diagnosis for ", Values);
		.print("The system is available");
 		 
	
		!startDiagnose.
	
+!paramForDiag(Name,Values,AgentName):
	busy
	<- 
		.send(humanAgent, achieve, systemBusy);
		.abolish(paramForDiag(Name,Values,AgentName));
		.print("The system is not available right now").
		
+!startDiagnose <-
	?listNames(X);
	.print("Sending agents signal to start diagnosis");
	.broadcast(achieve, diagnose)
	.wait(50);
	!completeDiagnosis;
 
 .
	
	

	
+!needs(Params, No)[source(Sender)]<-
	?listNames(Names);
	?listValues(Values);
	
	.print(Sender, " needs ", Params, " (", No, ") ");
	myLib.getParameters(Names,Values,Params, ParamsV);
	.print("Send " ,ParamsV," with ", No, " to ", Sender);
	.send(Sender, achieve, diagnose(ParamsV, No))
	.

+!myScore(S)[source(Sender)] <- 
	.print(Sender, " has training score: ", S);
	+score(Sender, S).



+!newDiagnosis(D, Prob, [])[source(Sender)]:
	diagnosis(D, L, A)
	 <-
  
	+diag(Sender, D, Prob, []);

	 .concat(A, Sender, A2);
	 -diagnosis(D,L,A);
	 +diagnosis(D,L,A2)
	.print("Received new diagnosis without arguments: ");
.



+!newDiagnosis(0, Prob, List)[source(Sender)]
	 <-

	+diag(Sender, 0, Prob, List);

		 for(.member(M, List))
	 { +args(0,M);}
	
	 +ag(0,Sender);
	 	.print("Received new normal diagnosis from ", Sender, "\n with arguments: ", List);
	


	.	
+!newDiagnosis(1, Prob, List)[source(Sender)]
//	diagnosis(1, L, A)
	 <-

	+diag(Sender, 1, Prob, List);
//	 .concat(L,List,L2);
//	 .concat(A, [Sender], A2);
//	 -diagnosis(1,L,A);
	 for(.member(M, List))
	 { +args(1,M);}
	
	 +ag(1,Sender);
	 .print("Received new diabetic retinopathy diagnosis from ", Sender, "\n with arguments: ", List);

	



	.	


+!newDiagnosis(2, Prob, List)[source(Sender)]
//	diagnosis(2, L, A)
	 <-

	for(.member(M, List))
	 { +args(2,M);}
	
	 +ag(2,Sender);
	+diag(Sender, 2, Prob, List); 

	 .concat(A, [Sender], A2);
	 
	 
	 .print("Received new amd diagnosis from ", Sender, "\n with arguments: ", List);
	


	.

	


	
+!completeDiagnosis:
 diag(agent1, D1, Prob1, List1) &
 diag(agent2, D2, Prob2, List2) &
 diag(agent3, D3, Prob3, List3)  
 <-

	.print("Received diagnosis from all agents. Choosing final diagnosis ");
    .findall(A0,args(0,A0), Arguments0);
    .findall(L0,ag(0,L0), Agents0);
    .findall(A1,args(1,A1), Arguments1);
    .findall(L1,ag(1,L1), Agents1);
    .findall(A2,args(2,A2), Arguments2);
    .findall(L2,ag(2,L2), Agents2);
//      .print(Agents0, Arguments0);
//      .print(Agents1, Arguments1);
//       .print(Agents2, Arguments2);
      
     +diagnosis(0,Arguments0, Agents0);
     +diagnosis(1,Arguments1, Agents1);
     +diagnosis(2,Arguments2, Agents2);
      .wait(1000);
 
      
   +completeDiagnosis(3);
   
   .
	
	
+!completeDiagnosis
	<- 

		.wait(1000);			
		.print("Waiting...");
		!completeDiagnosis;
		.	
//toti agentii au pus diagnosticul 0
+completeDiagnosis(X):
	diagnosis(0,L0,A0) &
 	diagnosis(1,[],[]) &
 	diagnosis(2,[],[]) 
 	
 	
 <-
 	.wait(20);
 	myLib.explainArgs(L0, E);
	.print("Final diagnosis is normal.  This diagnosis was chosen because ", E);
	 !askExpert
  
.
//toti agentii au pus diagnosticul 1

+completeDiagnosis(X):
	diagnosis(0,[],[]) &
 	diagnosis(1,L1,A1) &
 	diagnosis(2,[],[]) 
 	
 <-
 
   .wait(20);

	myLib.explainArgs(L1, E);
	.print("Final diagnosis is diabetic retinopathy. This diagnosis was chosen because ", E);
	 !askExpert
  
.
//toti agentii au pus diagnosticul 2
+completeDiagnosis(X):
	diagnosis(0,L0,[]) &
 	diagnosis(1,L1,[]) &
 	diagnosis(2,L2,A2) 
 	
 <-

 	.wait(20);
	myLib.explainArgs(L2, E);
	.print("Final diagnosis is amd. This diagnosis was chosen because ", E);
	 !askExpert
  
.
+completeDiagnosis(X) :
	diagnosis(0,L0,A0) &
 	diagnosis(1,L1,A1) &
 	diagnosis(2,L2,A2) &
 	.length(L0, N0) & .length(L1, N1) & .length(L2,N2) &
 	N0> N1 & N0>N2 &
 	listNames(Names) &
	listValues(Values) 

	<-

	for ( .member(Ag, A1) ){
		
		.print("Try to convince ", Ag, " for diagnosis normal");
		
        .send(Ag, tell, convince(1, 0 , L0, Names, Values)) ;
       };
       
    for ( .member(Ag, A2) ){
    	
		.print(Ag);
		.print("Try to convince ", Ag, " for diagnosis normal");
        .send(Ag, tell, convince(2, 0 , L0, Names, Values)) ;
       };
       		.wait(500);
              !finaldiagnose
       .
       	
+completeDiagnosis(X) :
	diagnosis(0,L0,A0) &
 	diagnosis(1,L1,A1) &
 	diagnosis(2,L2,A2) &
 	.length(L0, N0) & .length(L1, N1) & .length(L2,N2) &
 	N1> N0 & N1>N2 &
 	listNames(Names) &
	listValues(Values) 

	<-

	for ( .member(Ag, A0) ){
		.print("Try to convince ", Ag, " for diagnosis diabetic retinopathy" );
        .send(Ag, tell, convince(0, 1 , L1, Names, Values)) ;
       };
       
    for ( .member(Ag, A2) ){
    	
		.print("Try to convince ", Ag, " for diagnosis diabetic retinopathy" );
        .send(Ag, tell, convince(2, 1 , L1, Names, Values)) ;
       };
       		.wait(15);
       !finaldiagnose
       .
        	
+completeDiagnosis(X) :
	diagnosis(0,L0,A0) &
 	diagnosis(1,L1,A1) &
 	diagnosis(2,L2,A2) &
 	.length(L0, N0) & .length(L1, N1) & .length(L2,N2) &
 	N2> N0 & N2>N1 &
 	listNames(Names) &
	listValues(Values) 

	<-

	for ( .member(Ag, A0) ){
		.print("Try to convince ", Ag, " for diagnosis amd" );
        .send(Ag, tell, convince(0, 2 , L1, Names, Values)) ;
       };
       
    for ( .member(Ag, A1) ){
    	
		.print("Try to convince ", Ag, " for diagnosis amd" );
        .send(Ag, tell, convince(1, 2 , L1, Names, Values)) ;
       };
       		.wait(15);
       !finaldiagnose
       .      	
  
+completeDiagnosis(X) :
	diagnosis(0,L0,A0) &
 	diagnosis(1,L1,A1) &
 	diagnosis(2,L2,A2) &
 	.length(L0, N0) & .length(L1, N1) & .length(L2,N2) &
 	N2> N0 & N2>N1 &
 	listNames(Names) &
	listValues(Values) 

	<-
 	!askExpert
       .
       
+completeDiagnosis(X) <- 

 	!askExpert.

+!expertNormal <-

	?diagnosis(0,L0,A0) ;
 	?diagnosis(1,L1,A1) ;
 	?diagnosis(2,L2,A2) ;
 	?listNames(Names) ;
	?listValues(Values) ;
		for ( .member(Ag, A1) ){
		
		.print("Try to convince ", Ag, " for diagnosis normal");
		
        .send(Ag, tell, convince(1, 0 , L0, Names, Values)) ;
       };
       
   	 for ( .member(Ag, A2) ){
    	
		.print("Try to convince ", Ag, " for diagnosis normal");

        .send(Ag, tell, convince(2, 0 , L0, Names, Values)) ;
       };
       		.wait(15);
              !finaldiagnose
       .
+!expertNotNormal <-
	.print("Expert said that diagnosis is not normal ");
	?diagnosis(0,L0,A0) ;
 	?diagnosis(1,L1,A1) ;
 	?diagnosis(2,L2,A2) ;
 	 	?listNames(Names) ;
	?listValues(Values) ;

       for ( .member(Ag, A0) ){
    	
		.print("Try to convince ", Ag, " to change its normal diagnosis in dmlv");

        .send(Ag, achieve, convince(0, 2 , L2, Names, Values)) ;
      	.wait(10);
      	+testChanged(Ag);
       };
		 !finaldiagnose
       .

+testChanged(Ag):
	diag(Ag, 0, Prob, List)
<-
	?diagnosis(0,L0,A0) ;
 	?diagnosis(1,L1,A1) ;
 	?diagnosis(2,L2,A2) ;
 	 	?listNames(Names) ;
	?listValues(Values) ;
	.print(Ag, "didn't change its normal diagnosis in dmlv")
	.print("Try to convince ", Ag, " to change its normal diagnosis in diabetic retinopathy");
	.send(Ag, achieve, convince(0, 1 , L2, Names, Values)) ;
   		.wait(15);
              !finaldiagnose
	.
	
+testChanged(Ag)
<-
	.print(Ag, "changed its normal diagnosis in dmlv")
	   		.wait(15);
              !finaldiagnose
	.
+!changedDiagnosis([], [], ND)[source(Sender)]
<- 
.print(Sender, " changed its diagnosis").
	
+!changedDiagnosis([], ProListC, ND)[source(Sender)]
 <-
  ?diag(Sender, D, Prob, L);
 -diag(Sender, D, Prob, L);
 +diag(Sender, ND, Prob, ProListC);
 ?diagnosis(ND, L1, A1);
 -diagnosis(ND, L1, A1);
 .concat(L1, ProListC, NL);
 .concat(A1, [Sender], NA);
 +diagnosis(ND,NL,NA);
  myLib.explainArgs(ProListC, E2);
 .print(Sender, " changed its diagnosis because ",  E2, ". This indicates that the new diagnosis could be correct. ");
 
 .

+!changedDiagnosis(ContraListP, [], ND)[source(Sender)]
 <-
 ?diag(Sender, D, Prob, L);
 -diag(Sender, D, Prob, L);
 +diag(Sender, ND, Prob, ContraListP);
 
  myLib.explainArgs(ContraListP, E1);
 .print(Sender, " changed its diagnosis because ", E1, " This shows that previous diagnosis may be wrong.");
 
 .


+!changedDiagnosis(ContraListP, ProListC, ND)[source(Sender)]
 <-
 

   ?diag(Sender, D, Prob, L);
 -diag(Sender, D, Prob, L);
 +diag(Sender, ND, Prob, ProListC);
  ?diagnosis(ND, L1, A1);
 -diagnsis(ND, L1, A1);
 
 .concat(L1, ProListC, NL2);
 .concat(A1, [Sender], NA);
 +diagnosis(ND,NL2,NA);
  myLib.explainArgs(ContraListP, E1);
  myLib.explainArgs(ProListC, E2);
 .print(Sender, " changed its diagnosis because ", E1, " This shows that previous diagnosis may be wrong. Also, ", E2, ". This indicates that the new diagnosis could be correct. ");
 
 .

+!notChangedDiagnosis(ProListP, [], D)[source(Sender)]
 <-
  ?diag(Sender, D, Prob, L);
 -diag(Sender, D, Prob, L);
 .concat(L, ProListP, NL);
 +diag(Sender, D, Prob, NL);

  myLib.explainArgs(ProListP, E1);
 
 .print(Sender, " didn't changed its diagnosis because ", E1, " This shows that previous diagnosis is correct." );


 .

+!notChangedDiagnosis([], ContraListC, D)[source(Sender)]
 <-
  ?diag(Sender, D, Prob, L);
 -diag(Sender, D, Prob, L);
 .concat(L, ContraListC, NL);
 +diag(Sender, D, Prob, NL);

  myLib.explainArgs(ContraListC, E2);
 
 .print(Sender, " didn't changed its diagnosis because ", E2, " This indicates that the new diagnosis is wrong. "
 );


 
 .


+!notChangedDiagnosis(ProListP, ContraListC, D)[source(Sender)]
 <-
   ?diag(Sender, D, Prob, L);
 -diag(Sender, D, Prob, L);
 .concat(L, ProListP, Aux);
 .concat(Aux, ContraListC, NL);
 +diag(Sender, D, Prob, NL);
  myLib.explainArgs(ProListP, E1);
  myLib.explainArgs(ContraListC, E2);
 
 .print(Sender, " didn't changed its diagnosis because ", E1, " This shows that previous diagnosis is correct. Also, ", E2, ". This indicates that the new diagnosis is wrong. ");

.
+!finaldiagnose
 <-
 .wait(30);

 ?diag(agent1, D1, Prob1, List1);
 ?diag(agent2, D2, Prob2, List2);
 ?diag(agent3, D3, Prob3, List3);

 ?score(agent1, S1);
 ?score(agent2, S2);
 ?score(agent3, S3);

 myLib.choseDiagnosisAndExplain([agent1, agent2, agent3], [D1, D2, D3], [Prob1, Prob2, Prob3] , [List1, List2, List3], [S1,S2,S3], F, Expl);
 ?diagnosis(F, L, A);

 myLib.explainArgs(L, E1);
 .print("This diagnosis was chosen because " , E1);
 .send(simAgent, tell, result(Expl, E1));
 !askExpert;
  
 .
 



+!askExpert<-
	.print("Asking expert opinion");
	?listNames(Names);
//	.print(Names);
	?listValues(Values);
//	.print(Values);
	myLib.getParameters(Names,Values, [c0t, s1t, s2t, t1t,t2t, n1t, n2t, i1t, i2t], ParamsV); 
//		.print(ParamsV);
	.send(expertAgent, achieve, diagnoseEXPERT(ParamsV));
	.wait(200);
	-busy;
	+free;
	-diagnosis(0,[],[]);
	-diagnosis(1,[],[]);
	-diagnosis(2,[],[]);
	.broadcast(tell, systemAvailable)
	.	 


	
	
	
	
	
	
	
	
