// Internal action code for project agentsys

package myLib;

import jason.*;
import jason.asSemantics.*;
import jason.asSyntax.*;

public class explainArgs extends DefaultInternalAction {

    @Override
    public Object execute(TransitionSystem ts, Unifier un, Term[] args) throws Exception {

    	String explanation = " ";
    	ListTerm argList = (ListTerm) args[0];
    	Boolean first = true;
    	for (Term arg : argList)
    	{
    		if (!first)
    		{
    			explanation+= "and";
    		}
    		else 
    			first = false;
    		ListTerm argument = (ListTerm) arg;
        	Float min  = (float) 1.0;
        	Float max = (float) 1.0;
    		String name = argument.get(0).toString();
    		String minS =argument.get(1).toString();
    		String maxS = argument.get(2).toString();
    
    		min *=Float.valueOf(minS);
    		 max *=Float.valueOf(maxS);
    		if (min == -1000)
    		{
    			if (name.contains("v"))
    			{
    				name = name.substring(0,name.length() - 1);
    				explanation+= " volume value of " + name + " retina zone is smaller than " + max.toString()+ "\n";  
    			}
    			if (name.contains("t"))
    			{
    				name = name.substring(0,name.length() - 1);
    				explanation+= " thickness value of " + name + " retina zone is smaller than " + max.toString()+ "\n";  
    			}
    		}
    		else
    		if (max == 1000)
    		{
    			if (name.contains("v"))
    			{
    				name = name.substring(0,name.length() - 1);
    				explanation+= " volume value of " + name+ " retina zone is greater than " + min.toString() + "\n";  
    			}
    			if (name.contains("t"))
    			{
    				name = name.substring(0,name.length() - 1);
    				explanation+= " thickness value of " + name + " retina zone is greater than " + min.toString()+ "\n";  
    			}
    		}
    		else
    		{
    			if (name.contains("v"))
    			{
    				name = name.substring(0,name.length() - 1);
    				explanation+= " volume value of " + name + " retina zone is between " + min.toString() + " and "  + max.toString()+ "\n";  
    			}
    			if (name.contains("t"))
    			{
    				name = name.substring(0,name.length() - 1);
    				explanation+= " thickness value of " + name + " retina zone is between  " + min.toString() + " and "  + max.toString() + "\n";  
    			}
    		}
    	}
    	
        return un.unifies(args[1], new StringTermImpl(explanation));}

    
}
