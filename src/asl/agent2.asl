score(0.75).
!learnRules.
+diagnose
    <-.print("Received diagnose command");
   .send(agentMaster, tell, myScore(0.75));
      .send(agentMaster, tell, needs([c0t], 0)).
+diagnose([C0t], 0 ): 
    true
  & C0t<=(0.09)
   <- 
    .send(agentMaster, tell, newDiagnosis(2, 70.73, [
[c0t, -1000.00, 0.09]])).

+diagnose([C0t], 0)
  <-
      .send(agentMaster, tell, needs([n2v], 1)).
+diagnose([N2v], 1 ): 
    true
  & N2v>=(2.41)
   <- 
   .send(agentMaster, tell, newDiagnosis(1, 54.29, [
[n2v, 2.41, 1000.00]])).

+diagnose([N2v], 1)
  <-
      .send(agentMaster, tell, needs([t2t, n2t], 2)).
+diagnose([T2t, N2t], 2 ): 
    true
  & T2t<=(0.35)
  & N2t<=(0.37)
   <- 
    .send(agentMaster, tell, newDiagnosis(2, 97.95, [
[t2t, -1000.00, 0.35], [n2t, -1000.00, 0.37]])).

+diagnose([T2t, N2t], 2)
  <-
      .send(agentMaster, tell, needs([t2v, n2v], 3)).
+diagnose([T2v, N2v], 3 ): 
    true
  & T2v>=(2.22)
  & N2v>(1.95) & N2v<(2.41) 

   <- 
   .send(agentMaster, tell, newDiagnosis(1, 53.73, [
[t2v, 2.22, 1000.00], [n2v, 1.95, 2.41]])).

+diagnose([T2v, N2v], 3)
  <-
      .send(agentMaster, tell, needs([i1t], 4)).
+diagnose([I1t], 4 ): 
    true
  & I1t>=(0.43)
   <- 
    .send(agentMaster, tell, newDiagnosis(2, 96.99, [
[i1t, 0.43, 1000.00]])).

+diagnose([I1t], 4)
  <-

    .send(agentMaster, tell, newDiagnosis(2, 0.71, [])).
+!learnRules    <- +rules([ 
[[c0t, -1000.00, 0.09]]
, [[n2v, 2.41, 1000.00]]
, [[t2t, -1000.00, 0.35], [n2t, -1000.00, 0.37]]
, [[t2v, 2.22, 1000.00], [n2v, 1.95, 2.41]]
, [[i1t, 0.43, 1000.00]]
]); 
+diagnoses([2, 1, 2, 1, 2]).
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