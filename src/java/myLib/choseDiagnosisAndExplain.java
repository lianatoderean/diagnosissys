// Internal action code for project agentsys

package myLib;

import jason.*;
import jason.asSemantics.*;
import jason.asSyntax.*;

public class choseDiagnosisAndExplain extends DefaultInternalAction {

    @Override
    public Object execute(TransitionSystem ts, Unifier un, Term[] args) throws Exception {

    	ListTerm agents = (ListTerm) args[0];
    	ListTerm diags = (ListTerm) args[1];
    	ListTerm probs = (ListTerm) args[2];
    	ListTerm arguments = (ListTerm) args[3];
    	ListTerm scores = (ListTerm) args[4];

    	 Term d1 = diags.get(0);
	   	 Term d2 = diags.get(1);
	   	 Term d3 = diags.get(2);
	   	 Term agent1 = agents.get(0);
	   	 Term agent2 = agents.get(1);
	   	 Term agent3 = agents.get(2);
    	 int dg1 = Integer.parseInt(d1.toString());
    	 int dg2 = Integer.parseInt(d2.toString());
   
    	 int dg3 = Integer.parseInt(d3.toString());
	   	 Term prob1  = probs.get(0);
	   	 Term prob2  = probs.get(1);
	   	 Term prob3  = probs.get(2);
	  	 ListTerm args1  = (ListTerm)arguments.get(0);
	   	 ListTerm args2  = (ListTerm)arguments.get(1);
	   	 ListTerm args3  = (ListTerm)arguments.get(2);

	   	if ((dg1==dg2) && (dg2 == dg3 ))
	   	{
	   		ts.getAg().getLogger().info(" There is no conflict between agents ");
	   		ts.getAg().getLogger().info("Final diagnosis is ");
        	if (Integer.parseInt(d1.toString()) == 0)
        		ts.getAg().getLogger().info(" normal ");
        	if (Integer.parseInt(d1.toString()) == 1)
        		ts.getAg().getLogger().info(" diabetic retinopathy ");
        	if (Integer.parseInt(d1.toString()) == 2)
        		ts.getAg().getLogger().info(" amd ");
        	ts.getAg().getLogger().info(agent1.toString() + " is " + prob1  +"% sure of its diagnosis and has training score of " + scores.get(0).toString());
        	ts.getAg().getLogger().info(agent2.toString() + " is " + prob2  +"% sure of its diagnosis and has training score of " + scores.get(1).toString());
        	ts.getAg().getLogger().info(agent3.toString() + " is " + prob3  +"% sure of its diagnosis and has training score of " + scores.get(2).toString());
        	
    	   	args1.append(args2);
    	   	args1.append(args3);
        	return un.unifies(args[5], d1);
        	
	   	}
	   	else
	   	 if (dg1==dg2)
	   	 {

	        	ts.getAg().getLogger().info("Solving the conflict using majority vote ");
	        	
	        	ts.getAg().getLogger().info("Final diagnosis is ");
	        	if (dg1 == 0)
	        		ts.getAg().getLogger().info(" normal ");
	        	if (dg1 == 1)
	        		ts.getAg().getLogger().info(" diabetic retinopathy ");
	        	if (dg1 == 2)
	        		ts.getAg().getLogger().info(" amd ");
	        	
	           	args1.append(args2);
	        	ts.getAg().getLogger().info(" because  agent " + agent1.toString() + " and " + agent2.toString()+ " voted for it ");
	        	ts.getAg().getLogger().info(agent1.toString() + " is " + prob1  +"% sure of its diagnosis and has training score of " + scores.get(0).toString());
	        	ts.getAg().getLogger().info(agent2.toString() + " is " + prob2  +"% sure of its diagnosis and has training score of " + scores.get(1).toString());
	        	return un.unifies(args[5], d1) ;
	   	 }
	   	 
	   	 else
	   	 if (dg1==dg3)
	   	 {

	        	ts.getAg().getLogger().info("Solving the conflict using majority vote ");
	        	
	        	ts.getAg().getLogger().info("Final diagnosis is ");
	        	if (Integer.parseInt(d1.toString()) == 0)
	        		ts.getAg().getLogger().info(" normal ");
	        	if (Integer.parseInt(d1.toString()) == 1)
	        		ts.getAg().getLogger().info(" diabetic retinopathy ");
	        	if (Integer.parseInt(d1.toString()) == 2)
	        		ts.getAg().getLogger().info(" amd ");
	          	args1.append(args3);

	        	ts.getAg().getLogger().info(" because  agent " + agent1.toString() + " and " + agent3.toString()+ " voted for it ");
	        	ts.getAg().getLogger().info(agent1.toString() + " is " + prob1  +"% sure of its diagnosis and has training score of " + scores.get(0).toString());
	        	ts.getAg().getLogger().info(agent3.toString() + " is " + prob3  +"% sure of its diagnosis and has training score of " + scores.get(2).toString());
	        	return un.unifies(args[5], d1);
	   	 }
	   	 
	   	 else
	   	 if (dg2==dg3)
	   	 {

	        	ts.getAg().getLogger().info("Solving the conflict using majority vote ");
	        	
	        	ts.getAg().getLogger().info("Final diagnosis is ");
	        	if (Integer.parseInt(d2.toString()) == 0)
	        		ts.getAg().getLogger().info(" normal ");
	        	if (Integer.parseInt(d2.toString()) == 1)
	        		ts.getAg().getLogger().info(" diabetic retinopathy ");
	        	if (Integer.parseInt(d2.toString()) == 2)
	        		ts.getAg().getLogger().info(" amd ");
	        	
//	        	ts.getAg().getLogger().info(args3.toString() + "------------- " + args2.toString() + "===" +args2.append(args3).toString() );
	          	args2.append((Term)args3);
	        	ts.getAg().getLogger().info(" because  " + agent2.toString() + " and " + agent3.toString()+ " voted for it ");
	        	ts.getAg().getLogger().info(agent2.toString() + " is " + prob2  +"% sure of its diagnosis and has training score of " + scores.get(1).toString());
	        	ts.getAg().getLogger().info(agent3.toString() + " is " + prob3  +"% sure of its diagnosis and has training score of " + scores.get(2).toString());
	        	return un.unifies(args[5], d2); 
	   	 }
	   	 else {
	   	 ts.getAg().getLogger().info("Solving the conflict by making a compromise between performance score and confidence  ");

	   	 Double p1 = Double.parseDouble(probs.get(0).toString()) + 100 * Double.parseDouble(scores.get(0).toString());
         Double p2 = Double.parseDouble(probs.get(1).toString()) + 100 * Double.parseDouble(scores.get(1).toString());
         Double p3 = Double.parseDouble(probs.get(2).toString()) + 100 * Double.parseDouble(scores.get(2).toString());
         Double max = p1;
         if (max<p2)
         	max = p2;
         if (max<p3)
         	max=p3;
      
     	if (max == p1)
	   	{
	   		ts.getAg().getLogger().info("Final diagnosis is ");
        	if (Integer.parseInt(d1.toString()) == 0)
        		ts.getAg().getLogger().info(" normal ");
        	if (Integer.parseInt(d1.toString()) == 1)
        		ts.getAg().getLogger().info(" diabetic retinopathy ");
        	if (Integer.parseInt(d1.toString()) == 2)
        		ts.getAg().getLogger().info(" amd ");
        	ts.getAg().getLogger().info(" made by " + agent1.toString() + ".It is the final one because he is " +  prob1.toString() + "% sure and its performance score is " + scores.get(0).toString());
        	return un.unifies(args[5], d1);
	   	}
     	if (max == p2)
	   	{
	   		ts.getAg().getLogger().info("Final diagnosis is ");
        	if (Integer.parseInt(d2.toString()) == 0)
        		ts.getAg().getLogger().info(" normal ");
        	if (Integer.parseInt(d2.toString()) == 1)
        		ts.getAg().getLogger().info(" diabetic retinopathy ");
        	if (Integer.parseInt(d2.toString()) == 2)
        		ts.getAg().getLogger().info(" amd ");
        	ts.getAg().getLogger().info(" made by " + agent2.toString() + ".It is the final one because he is " +  prob2.toString() + "% sure and its performance score is " + scores.get(1).toString());
        	return un.unifies(args[5], d2);
	   	}
     	if (max == p3)
	   	{
	   		ts.getAg().getLogger().info("Final diagnosis is ");
        	if (Integer.parseInt(d3.toString()) == 0)
        		ts.getAg().getLogger().info(" normal ");
        	if (Integer.parseInt(d3.toString()) == 1)
        		ts.getAg().getLogger().info(" diabetic retinopathy ");
        	if (Integer.parseInt(d3.toString()) == 2)
        		ts.getAg().getLogger().info(" amd ");
        	ts.getAg().getLogger().info(" made by " + agent3.toString() + ". It is the final one because he is " +  prob3.toString() + "% sure and its performance score is " + scores.get(2).toString());
        	return un.unifies(args[5], d3);
	   	}
	   	 }

	   
	   	return false;
    	
    	
    }
}
