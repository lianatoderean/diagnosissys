score(0.94).
!learnRules.
+diagnose
    <-.print("Received diagnose command");
   .send(agentMaster, tell, myScore(0.94));
      .send(agentMaster, tell, needs([s2t], 0)).
+diagnose([S2t], 0 ): 
    true
  & S2t<=(-0.58)
   <- 
    .send(agentMaster, tell, newDiagnosis(2, 95.53, [
[s2t, -1000.00, -0.58]])).

+diagnose([S2t], 0)
  <-
      .send(agentMaster, tell, needs([t2t], 1)).
+diagnose([T2t], 1 ): 
    true
  & T2t>=(0.56)
   <- 
    .send(agentMaster, tell, newDiagnosis(2, 62.11, [
[t2t, 0.56, 1000.00]])).

+diagnose([T2t], 1)
  <-
      .send(agentMaster, tell, needs([i1v, i2t], 2)).
+diagnose([I1v, I2t], 2 ): 
    true
  & I1v<=(-0.44)
  & I2t<=(-0.88)
   <- 
    .send(agentMaster, tell, newDiagnosis(0, 61.70, [
[i1v, -1000.00, -0.44], [i2t, -1000.00, -0.88]])).

+diagnose([I1v, I2t], 2)
  <-
      .send(agentMaster, tell, needs([c0t, i1t], 3)).
+diagnose([C0t, I1t], 3 ): 
    true
  & C0t<=(-0.52)
  & I1t>(-1.35) & I1t<(-0.43) 

   <- 
    .send(agentMaster, tell, newDiagnosis(2, 66.67, [
[c0t, -1000.00, -0.52], [i1t, -1.35, -0.43]])).

+diagnose([C0t, I1t], 3)
  <-

    .send(agentMaster, tell, newDiagnosis(2, 0.94, [])).
+!learnRules    <- +rules([ 
[[s2t, -1000.00, -0.58]]
, [[t2t, 0.56, 1000.00]]
, [[i1v, -1000.00, -0.44], [i2t, -1000.00, -0.88]]
, [[c0t, -1000.00, -0.52], [i1t, -1.35, -0.43]]
]); 
+diagnoses([2, 2, 0, 2]).
+convince(DiagP, DiagC, ArgsC, NamesP, ValuesP):
   rules(X) & diagnoses(Y) &
     myLib.checkArguments(X, Y, DiagP, DiagC, ArgsC, NamesP, ValuesP, 0, NewDiag, ProListP, ContraListC)
    <- 
     .send(agentMaster, tell,  notChangedDiagnosis(ProListP, ContraListC, DiagP)).
+convince(DiagP, DiagC, ArgsC, NamesP, ValuesP):
 rules(X) & diagnoses(Y) &
     myLib.checkArguments(X, Y, DiagP, DiagC, ArgsC, NamesP, ValuesP, 1, NewDiag, ContraListP, ProListC)
    <- 
     .send(agentMaster, tell, changedDiagnosis(ContraListP, ProListC, DiagC));.