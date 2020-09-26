score(0.96).
!learnRules.
+diagnose
    <-.print("Received diagnose command");
   .send(agentMaster, tell, myScore(0.96));
      .send(agentMaster, tell, needs([s1t, s1v], 0)).
+diagnose([S1t, S1v],0 ): 
    true
  & S1t<=0.35
  & S1v<=0.52
   <- 
    .send(agentMaster, tell, newDiagnosis(2, 100.00, [
[s1t, -1000.00, 0.35], [s1v, -1000.00, 0.52]])).

+diagnose([S1t, S1v],0)
  <-
      .send(agentMaster, tell, needs([s1t, s1v, c0v, n1v], 1)).
+diagnose([S1t, S1v, C0v, N1v],1 ): 
    true
  & S1t<=0.35
  & S1v>0.52
  & C0v<=0.22
  & N1v<=0.52
   <- 
    .send(agentMaster, tell, newDiagnosis(2, 100.00, [
[s1t, -1000.00, 0.35], [s1v, 0.52, 1000.00], [c0v, -1000.00, 0.22], [n1v, -1000.00, 0.52]])).

+diagnose([S1t, S1v, C0v, N1v],1)
  <-
      .send(agentMaster, tell, needs([s1t, s1v, c0v, n1v, n1t, s2v], 2)).
+diagnose([S1t, S1v, C0v, N1v, N1t, S2v],2 ): 
    true
  & S1t<=0.35
  & S1v>0.52
  & C0v<=0.22
  & N1v>0.52
  & N1t<=0.35
  & S2v<=1.48
   <- 
    .send(agentMaster, tell, newDiagnosis(2, 100.00, [
[s1t, -1000.00, 0.35], [s1v, 0.52, 1000.00], [c0v, -1000.00, 0.22], [n1v, 0.52, 1000.00], [n1t, -1000.00, 0.35], [s2v, -1000.00, 1.48]])).

+diagnose([S1t, S1v, C0v, N1v, N1t, S2v],2)
  <-
      .send(agentMaster, tell, needs([s1t, s1v, c0v, n1v, n1t, s2v], 3)).
+diagnose([S1t, S1v, C0v, N1v, N1t, S2v],3 ): 
    true
  & S1t<=0.35
  & S1v>0.52
  & C0v<=0.22
  & N1v>0.52
  & N1t<=0.35
  & S2v>1.48
   <- 
    .send(agentMaster, tell, newDiagnosis(0, 100.00, [ 
[s1t, -1000.00, 0.35], [s1v, 0.52, 1000.00], [c0v, -1000.00, 0.22], [n1v, 0.52, 1000.00], [n1t, -1000.00, 0.35], [s2v, 1.48, 1000.00]])).

+diagnose([S1t, S1v, C0v, N1v, N1t, S2v],3)
  <-
      .send(agentMaster, tell, needs([s1t, s1v, c0v, n1v, n1t], 4)).
+diagnose([S1t, S1v, C0v, N1v, N1t],4 ): 
    true
  & S1t<=0.35
  & S1v>0.52
  & C0v<=0.22
  & N1v>0.52
  & N1t>0.35
   <- 
    .send(agentMaster, tell, newDiagnosis(2, 100.00, [
[s1t, -1000.00, 0.35], [s1v, 0.52, 1000.00], [c0v, -1000.00, 0.22], [n1v, 0.52, 1000.00], [n1t, 0.35, 1000.00]])).

+diagnose([S1t, S1v, C0v, N1v, N1t],4)
  <-
      .send(agentMaster, tell, needs([s1t, s1v, c0v], 5)).
+diagnose([S1t, S1v, C0v],5 ): 
    true
  & S1t<=0.35
  & S1v>0.52
  & C0v>0.22
   <- 
    .send(agentMaster, tell, newDiagnosis(2, 100.00, [
[s1t, -1000.00, 0.35], [s1v, 0.52, 1000.00], [c0v, 0.22, 1000.00]])).

+diagnose([S1t, S1v, C0v],5)
  <-
      .send(agentMaster, tell, needs([s1t, s1v, s2t], 6)).
+diagnose([S1t, S1v, S2t],6 ): 
    true
  & S1t>0.35
  & S1v<=0.58
  & S2t<=0.30
   <- 
    .send(agentMaster, tell, newDiagnosis(2, 100.00, [
[s1t, 0.35, 1000.00], [s1v, -1000.00, 0.58], [s2t, -1000.00, 0.30]])).

+diagnose([S1t, S1v, S2t],6)
  <-
      .send(agentMaster, tell, needs([s1t, s1v, s2t, t2t], 7)).
+diagnose([S1t, S1v, S2t, T2t],7 ): 
    true
  & S1t>0.35
  & S1v<=0.58
  & S2t>0.30
  & T2t<=0.30
  & S2t<=0.31
   <- 
    .send(agentMaster, tell, newDiagnosis(2, 100.00, [
[s1t, 0.35, 1000.00], [s1v, -1000.00, 0.58], [s2t, 0.30, 1000.00], [t2t, -1000.00, 0.30], [s2t, -1000.00, 0.31]])).

+diagnose([S1t, S1v, S2t, T2t],7)
  <-
      .send(agentMaster, tell, needs([s1t, s1v, s2t, t2t, t1t], 8)).
+diagnose([S1t, S1v, S2t, T2t, T1t],8 ): 
    true
  & S1t>0.35
  & S1v<=0.58
  & S2t>0.30
  & T2t<=0.30
  & S2t>0.31
  & T1t<=0.34
   <- 
    .send(agentMaster, tell, newDiagnosis(1, 100.00, [
[s1t, 0.35, 1000.00], [s1v, -1000.00, 0.58], [s2t, 0.30, 1000.00], [t2t, -1000.00, 0.30], [s2t, 0.31, 1000.00], [t1t, -1000.00, 0.34]])).

+diagnose([S1t, S1v, S2t, T2t, T1t],8)
  <-
      .send(agentMaster, tell, needs([s1t, s1v, s2t, t2t, t1t], 9)).
+diagnose([S1t, S1v, S2t, T2t, T1t],9 ): 
    true
  & S1t>0.35
  & S1v<=0.58
  & S2t>0.30
  & T2t<=0.30
  & S2t>0.31
  & T1t>0.34
   <- 
    .send(agentMaster, tell, newDiagnosis(1, 87.50, [
[s1t, 0.35, 1000.00], [s1v, -1000.00, 0.58], [s2t, 0.30, 1000.00], [t2t, -1000.00, 0.30], [s2t, 0.31, 1000.00], [t1t, 0.34, 1000.00]])).

+diagnose([S1t, S1v, S2t, T2t, T1t],9)
  <-
      .send(agentMaster, tell, needs([s1t, s1v, s2t, t2t, c0t], 10)).
+diagnose([S1t, S1v, S2t, T2t, C0t],10 ): 
    true
  & S1t>0.35
  & S1v<=0.58
  & S2t>0.30
  & T2t>0.30
  & C0t<=0.29
   <- 
    .send(agentMaster, tell, newDiagnosis(0, 100.00, [ 
[s1t, 0.35, 1000.00], [s1v, -1000.00, 0.58], [s2t, 0.30, 1000.00], [t2t, 0.30, 1000.00], [c0t, -1000.00, 0.29]])).

+diagnose([S1t, S1v, S2t, T2t, C0t],10)
  <-
      .send(agentMaster, tell, needs([s1t, s1v, s2t, t2t, c0t, i1v], 11)).
+diagnose([S1t, S1v, S2t, T2t, C0t, I1v],11 ): 
    true
  & S1t>0.35
  & S1v<=0.58
  & S2t>0.30
  & T2t>0.30
  & C0t>0.29
  & I1v<=0.62
   <- 
    .send(agentMaster, tell, newDiagnosis(2, 100.00, [
[s1t, 0.35, 1000.00], [s1v, -1000.00, 0.58], [s2t, 0.30, 1000.00], [t2t, 0.30, 1000.00], [c0t, 0.29, 1000.00], [i1v, -1000.00, 0.62]])).

+diagnose([S1t, S1v, S2t, T2t, C0t, I1v],11)
  <-
      .send(agentMaster, tell, needs([s1t, s1v, s2t, t2t, c0t, i1v], 12)).
+diagnose([S1t, S1v, S2t, T2t, C0t, I1v],12 ): 
    true
  & S1t>0.35
  & S1v<=0.58
  & S2t>0.30
  & T2t>0.30
  & C0t>0.29
  & I1v>0.62
   <- 
    .send(agentMaster, tell, newDiagnosis(1, 100.00, [
[s1t, 0.35, 1000.00], [s1v, -1000.00, 0.58], [s2t, 0.30, 1000.00], [t2t, 0.30, 1000.00], [c0t, 0.29, 1000.00], [i1v, 0.62, 1000.00]])).

+diagnose([S1t, S1v, S2t, T2t, C0t, I1v],12)
  <-
      .send(agentMaster, tell, needs([s1t, s1v, t2t], 13)).
+diagnose([S1t, S1v, T2t],13 ): 
    true
  & S1t>0.35
  & S1v>0.58
  & T2t<=0.36
   <- 
    .send(agentMaster, tell, newDiagnosis(2, 100.00, [
[s1t, 0.35, 1000.00], [s1v, 0.58, 1000.00], [t2t, -1000.00, 0.36]])).

+diagnose([S1t, S1v, T2t],13)
  <-
      .send(agentMaster, tell, needs([s1t, s1v, t2t, s2t, c0t], 14)).
+diagnose([S1t, S1v, T2t, S2t, C0t],14 ): 
    true
  & S1t>0.35
  & S1v>0.58
  & T2t>0.36
  & S2t<=0.41
  & C0t<=0.38
   <- 
    .send(agentMaster, tell, newDiagnosis(2, 100.00, [
[s1t, 0.35, 1000.00], [s1v, 0.58, 1000.00], [t2t, 0.36, 1000.00], [s2t, -1000.00, 0.41], [c0t, -1000.00, 0.38]])).

+diagnose([S1t, S1v, T2t, S2t, C0t],14)
  <-
      .send(agentMaster, tell, needs([s1t, s1v, t2t, s2t, c0t, i1v], 15)).
+diagnose([S1t, S1v, T2t, S2t, C0t, I1v],15 ): 
    true
  & S1t>0.35
  & S1v>0.58
  & T2t>0.36
  & S2t<=0.41
  & C0t>0.38
  & I1v<=0.74
   <- 
    .send(agentMaster, tell, newDiagnosis(1, 100.00, [
[s1t, 0.35, 1000.00], [s1v, 0.58, 1000.00], [t2t, 0.36, 1000.00], [s2t, -1000.00, 0.41], [c0t, 0.38, 1000.00], [i1v, -1000.00, 0.74]])).

+diagnose([S1t, S1v, T2t, S2t, C0t, I1v],15)
  <-
      .send(agentMaster, tell, needs([s1t, s1v, t2t, s2t, c0t, i1v, i1t], 16)).
+diagnose([S1t, S1v, T2t, S2t, C0t, I1v, I1t],16 ): 
    true
  & S1t>0.35
  & S1v>0.58
  & T2t>0.36
  & S2t<=0.41
  & C0t>0.38
  & I1v>0.74
  & I1t<=0.65
   <- 
    .send(agentMaster, tell, newDiagnosis(2, 100.00, [
[s1t, 0.35, 1000.00], [s1v, 0.58, 1000.00], [t2t, 0.36, 1000.00], [s2t, -1000.00, 0.41], [c0t, 0.38, 1000.00], [i1v, 0.74, 1000.00], [i1t, -1000.00, 0.65]])).

+diagnose([S1t, S1v, T2t, S2t, C0t, I1v, I1t],16)
  <-
      .send(agentMaster, tell, needs([s1t, s1v, t2t, s2t, c0t, i1v, i1t], 17)).
+diagnose([S1t, S1v, T2t, S2t, C0t, I1v, I1t],17 ): 
    true
  & S1t>0.35
  & S1v>0.58
  & T2t>0.36
  & S2t<=0.41
  & C0t>0.38
  & I1v>0.74
  & I1t>0.65
   <- 
    .send(agentMaster, tell, newDiagnosis(1, 100.00, [
[s1t, 0.35, 1000.00], [s1v, 0.58, 1000.00], [t2t, 0.36, 1000.00], [s2t, -1000.00, 0.41], [c0t, 0.38, 1000.00], [i1v, 0.74, 1000.00], [i1t, 0.65, 1000.00]])).

+diagnose([S1t, S1v, T2t, S2t, C0t, I1v, I1t],17)
  <-
      .send(agentMaster, tell, needs([s1t, s1v, t2t, s2t], 18)).
+diagnose([S1t, S1v, T2t, S2t],18 ): 
    true
  & S1t>0.35
  & S1v>0.58
  & T2t>0.36
  & S2t>0.41
   <- 
    .send(agentMaster, tell, newDiagnosis(2, 100.00, [
[s1t, 0.35, 1000.00], [s1v, 0.58, 1000.00], [t2t, 0.36, 1000.00], [s2t, 0.41, 1000.00]])).

+diagnose([S1t, S1v, T2t, S2t],18)
  <-
    .print("Not enough data"). 
+!learnRules    <- +rules([ 
[[s1t, -1000.00, 0.35], [s1v, -1000.00, 0.52]]
, [[s1t, -1000.00, 0.35], [s1v, 0.52, 1000.00], [c0v, -1000.00, 0.22], [n1v, -1000.00, 0.52]]
, [[s1t, -1000.00, 0.35], [s1v, 0.52, 1000.00], [c0v, -1000.00, 0.22], [n1v, 0.52, 1000.00], [n1t, -1000.00, 0.35], [s2v, -1000.00, 1.48]]
, [[s1t, -1000.00, 0.35], [s1v, 0.52, 1000.00], [c0v, -1000.00, 0.22], [n1v, 0.52, 1000.00], [n1t, -1000.00, 0.35], [s2v, 1.48, 1000.00]]
, [[s1t, -1000.00, 0.35], [s1v, 0.52, 1000.00], [c0v, -1000.00, 0.22], [n1v, 0.52, 1000.00], [n1t, 0.35, 1000.00]]
, [[s1t, -1000.00, 0.35], [s1v, 0.52, 1000.00], [c0v, 0.22, 1000.00]]
, [[s1t, 0.35, 1000.00], [s1v, -1000.00, 0.58], [s2t, -1000.00, 0.30]]
, [[s1t, 0.35, 1000.00], [s1v, -1000.00, 0.58], [s2t, 0.30, 1000.00], [t2t, -1000.00, 0.30], [s2t, -1000.00, 0.31]]
, [[s1t, 0.35, 1000.00], [s1v, -1000.00, 0.58], [s2t, 0.30, 1000.00], [t2t, -1000.00, 0.30], [s2t, 0.31, 1000.00], [t1t, -1000.00, 0.34]]
, [[s1t, 0.35, 1000.00], [s1v, -1000.00, 0.58], [s2t, 0.30, 1000.00], [t2t, -1000.00, 0.30], [s2t, 0.31, 1000.00], [t1t, 0.34, 1000.00]]
, [[s1t, 0.35, 1000.00], [s1v, -1000.00, 0.58], [s2t, 0.30, 1000.00], [t2t, 0.30, 1000.00], [c0t, -1000.00, 0.29]]
, [[s1t, 0.35, 1000.00], [s1v, -1000.00, 0.58], [s2t, 0.30, 1000.00], [t2t, 0.30, 1000.00], [c0t, 0.29, 1000.00], [i1v, -1000.00, 0.62]]
, [[s1t, 0.35, 1000.00], [s1v, -1000.00, 0.58], [s2t, 0.30, 1000.00], [t2t, 0.30, 1000.00], [c0t, 0.29, 1000.00], [i1v, 0.62, 1000.00]]
, [[s1t, 0.35, 1000.00], [s1v, 0.58, 1000.00], [t2t, -1000.00, 0.36]]
, [[s1t, 0.35, 1000.00], [s1v, 0.58, 1000.00], [t2t, 0.36, 1000.00], [s2t, -1000.00, 0.41], [c0t, -1000.00, 0.38]]
, [[s1t, 0.35, 1000.00], [s1v, 0.58, 1000.00], [t2t, 0.36, 1000.00], [s2t, -1000.00, 0.41], [c0t, 0.38, 1000.00], [i1v, -1000.00, 0.74]]
, [[s1t, 0.35, 1000.00], [s1v, 0.58, 1000.00], [t2t, 0.36, 1000.00], [s2t, -1000.00, 0.41], [c0t, 0.38, 1000.00], [i1v, 0.74, 1000.00], [i1t, -1000.00, 0.65]]
, [[s1t, 0.35, 1000.00], [s1v, 0.58, 1000.00], [t2t, 0.36, 1000.00], [s2t, -1000.00, 0.41], [c0t, 0.38, 1000.00], [i1v, 0.74, 1000.00], [i1t, 0.65, 1000.00]]
, [[s1t, 0.35, 1000.00], [s1v, 0.58, 1000.00], [t2t, 0.36, 1000.00], [s2t, 0.41, 1000.00]]
]); 
+diagnoses([2, 2, 2, 0, 2, 2, 2, 2, 1, 1, 0, 2, 1, 2, 2, 1, 2, 1, 2]).
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