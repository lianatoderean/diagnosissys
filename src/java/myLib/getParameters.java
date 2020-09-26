// Internal action code for project agentsys

package myLib;

import java.util.ArrayList;
import java.util.List;

import jason.*;
import jason.asSemantics.*;
import jason.asSyntax.*;

public class getParameters extends DefaultInternalAction {
    @Override
    public Object execute(TransitionSystem ts, Unifier un, Term[] args) throws Exception {
        // execute the internal action
        if (args[0].isList() & args[1].isList() & args[2].isList() & args[3].isVar())
        {
        	ListTerm names = (ListTerm) args[0];  //numele tuturor parametrilor dati ca input
        	ListTerm values = (ListTerm) args[1];	//valorile parametrilor
        	ListTerm paramsN = (ListTerm) args[2]; //numele parametrilor de care are nevoie un agent
        	ListTerm paramsV = new ListTermImpl();
        	//se selecteaza doar valorile parametrilor specificati in paramsN in aceeasi ordine
        	for(Term param: paramsN)
        	{

        		int i = 0;
        		for (Term name: names)
        		{     	

        			if (name.toString().toLowerCase().replace("\"", "").equals(param.toString()))
        			{	
        				paramsV.add(values.get(i));	
        			}
        			i=i+1;   
        		}
        	}

        	return un.unifies(args[3], paramsV);
        }
        
        return true;

     
    }
}
