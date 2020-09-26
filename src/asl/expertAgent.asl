+!diagnose <- 
	-diagnoseExpert(X);
	-check(Y);
.

+diagnoseEXPERT([C0,S1,S2,T1,T2,N1,N2,I1,I2]) 
 	<- 

 		+check(c0, C0);
	 	+check(s1, S1);
 		+check(s2, S2);
 		+check(t1, T1);
 		+check(t2, T2);
 		+check(n1, N1);
 		+check(n2, N2);
 		+check(i1, I1);
 		+check(i2, I2);
 		.wait(10);
 		!result;
 		.
 		
 		
+check(c0, V):
V>=0.21 - 0.02 &
V<=0.21 + 0.02
<- 

	.print("Normal value for zone C0");
	+normal(c0);
	.

+check(c0, V):
	V>=0.21 + 0.02 
<- 
   +notNorma(c0); 
  .print("Retina is too thick in zone C0").
	
+check(c0, V):
	V<=0.21 - 0.02 
<- 
  +notNorma(c0); 
  .print("Retina is too thin in zone C0").
		
	
	
+check(s1, V):
V>=0.25 - 0.017 &
V<=0.25 + 0.017
<- 

	.print("Normal value for zone S1");
	+normal(s1);
	.

+check(s1, V):
	V>=0.25 + 0.017
<- 
   +notNormal(s1); 
   .print("Retina is too thick in zone S1").
	
+check(s1, V):
	V<=0.25 + 0.017
<- 
   +notNormal(s1); 
  .print("Retina is too thin in zone S1").
  
  
  
+check(s2, V):
V>=0.23 - 0.016 &
V<=0.23 + 0.016
<- 

	.print("Normal value for zone S2");
	+normal(s2);
	.

+check(s2, V):
	V>=0.23 + 0.016
<- 
   +notNormal(s2); 
   .print("Retina is too thick in zone S2").
	
+check(s2, V):
	V<=0.23 + 0.016
<- 
   +notNormal(s2); 
  .print("Retina is too thin in zone S2").
	
+check(t1, V):
V>=0.25 - 0.013 &
V<=0.25 + 0.013
<- 

	.print("Normal value for zone T1");
	+normal(t1);
	.

+check(t1, V):
	V>=0.25 + 0.013
<- 
   +notNormal(t1); 
   .print("Retina is too thick in zone T1").
	
+check(t1, V):
	V<=0.25 + 0.013
<- 
   +notNormal(t1); 
  .print("Retina is too thin in zone T1").
 
 +check(t2, V):
V>=0.21 - 0.014 &
V<=0.21 + 0.014
<- 

	.print("Normal value for zone T2");
	+normal(t2);
	.

+check(t2, V):
	V>=0.21 + 0.014
<- 
   +notNormal(t2); 
   .print("Retina is too thick in zone T2").
	
+check(t2, V):
	V<=0.21 + 0.014
<- 
   +notNormal(t2); 
  .print("Retina is too thin in zone T2").
  

 +check(n1, V):
V>=0.25 - 0.013 &
V<=0.25 + 0.013
<- 

	.print("Normal value for zone N1");
	+normal(n1);
	.

+check(n1, V):
	V>=0.25 + 0.013
<- 
   +notNormal(n1); 
   .print("Retina is too thick in zone N1").
	
+check(n1, V):
	V<=0.25 + 0.013
<- 
   +notNormal(n1); 
  .print("Retina is too thin in zone N1").
 
 +check(n2, V):
V>=0.24 - 0.014 &
V<=0.24 + 0.014
<- 

	.print("Normal value for zone N2");
	+normal(n2);
	.

+check(n2, V):
	V>=0.24 + 0.014
<- 
   +notNormal(n2); 
   .print("Retina is too thick in zone N2").
	
+check(n2, V):
	V<=0.24 + 0.014
<- 
   +notNormal(n2); 
  .print("Retina is too thin in zone N2").
  
  
  
  +check(i1, V):
V>=0.26 - 0.015 &
V<=0.26 + 0.015
<- 

	.print("Normal value for zone I1");
	+normal(i1);
	.

+check(i1, V):
	V>=0.26 + 0.015
<- 
   +notNormal(i1); 
   .print("Retina is too thick in zone I1").
	
+check(i1, V):
	V<=0.26 + 0.015
<- 
   +notNormal(n1); 
  .print("Retina is too thin in zone I1").
 
 +check(i2, V):
V>=0.21 - 0.013 &
V<=0.21 + 0.013
<- 

	.print("Normal value for zone I2");
	+normal(i2);
	.

+check(i2, V):
	V>=0.21 + 0.013
<- 
   +notNormal(i2); 
   .print("Retina is too thick in zone I2").
	
+check(i2, V):
	V<=0.21 + 0.013
<- 
   +notNormal(i2); 
  .print("Retina is too thin in zone I2"). 
  
+!result:
	.count(normal(Z),N) &
	N>5  
	
	<-
	.print("Patient is healthy");
//	.send(agentMaster, tell, expertNormal);
	.
	
+!result 
     <-
	.print("Patient is not healthy");
//	.send(agentMaster, tell, expertNotNormal)
	.

