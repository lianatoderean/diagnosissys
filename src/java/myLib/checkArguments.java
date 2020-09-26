package myLib;

import jason.asSemantics.DefaultInternalAction;
import jason.asSemantics.TransitionSystem;
import jason.asSemantics.Unifier;
import jason.asSyntax.DefaultTerm;
import jason.asSyntax.ListTerm;
import jason.asSyntax.ListTermImpl;
import jason.asSyntax.NumberTermImpl;
import jason.asSyntax.StringTermImpl;
import jason.asSyntax.Term;

public class checkArguments extends DefaultInternalAction{
	
	@Override
	public Object execute(TransitionSystem ts, Unifier un, Term[] args) throws Exception{
		//args[0] toate regulile invatate de agent, contine reguli formate din lista de clauze		
		ListTerm rules = (ListTerm) args[0];
		//args[1] diagnosticul care corespunde fiecarei reguli
		ListTerm diags = (ListTerm) args[1];
		
		//args[2] diagnosticul pus initial de agent		
		int diagP = Integer.parseInt(args[2].toString());
		
		//args[3] diagnosticul contradictoriu
		int diagC = Integer.parseInt(args[3].toString());
		//args[4] lista cu argumentele pe care le accepta sau nu pt diag
		ListTerm arguments = (ListTerm) args[4];
		
		//lista cu numele tuturor parametrilor
		ListTerm namesP = (ListTerm) args[5];
		//lista cu valorile tuturor parametrilor
		ListTerm valuesP = (ListTerm) args[6];
		Term change = args[7];
						
		
		int index = 0;
		

		int pro = 0; //numarul argumentelor pentru diagnosticul propriu
		int contra = arguments.size(); //nr argumentelor contra diagnosticului propriu
		ListTerm proListP =  new ListTermImpl();
		ListTerm contraListP =  new ListTermImpl();
		
		
		ListTerm proListC =  new ListTermImpl();
		ListTerm contraListC =  new ListTermImpl();
		
		
		for(Term t: rules)
		{	
			ListTerm rule = (ListTerm) t;
			for(Term t2: rule)
			{
							
				//clauze pentru diagnosticul contradictoriu
				if(diagC == Integer.parseInt(diags.get(index).toString()))		
				{ 
					
					ListTerm clause = (ListTerm) t2;
					
					String name = ((Term) clause.get(0)).toString();
					Float min = Float.parseFloat(((Term) clause.get(1)).toString());
					Float max = Float.parseFloat(((Term) clause.get(2)).toString());				 	
				 	//cauta valoarea parametrului si verifica care sunt respectate
				 	int indexP = 0;
				 	for(Term nameP: namesP)
				 	{
				 		if (name.toString().toLowerCase().replace("\"", "").equals(name))
				 				{
				 					break;
				 				}
				 		
				 		indexP++;
				 	}
				 	Float value = Float.parseFloat(valuesP.get(indexP).toString());

					 
				 	if ((value < max) && (value>min))
				 	{

				 		contra++;
				 		proListC.add(t2);
				 	}
				 	else
				 	{

				 		pro++;
				 		contraListC.add(t2);
				 	}
				 	
				
				}  
				//clauze pentru diagnosticul propriu
				if(diagP == Integer.parseInt(diags.get(index).toString()))		
				{ ListTerm clause = (ListTerm) t2;
				 String name = ((Term) clause.get(0)).toString();

				 Float min = Float.parseFloat(((Term) clause.get(1)).toString());

				 Float max = Float.parseFloat(((Term) clause.get(2)).toString());
				
				
				 	int indexP = 0;
				 	for(Term nameP: namesP)
				 	{
				 		if (name.toString().toLowerCase().replace("\"", "").equals(name))
				 				{
				 					break;
				 				}
				 		
				 		indexP++;
				 	}
				 	Float value = Float.parseFloat(valuesP.get(indexP).toString());
				
					 
				 	if ((value <=max) && (value>=min))
				 	{

				 		pro++;
				 		proListP.add(t2);
				 	}
				 	else
				 	{

				 		contra++;
				 		contraListP.add(t2);
				 	}
				}  
				
			}

			index++;
			
		}	
	
		//decizie daca se accepta sau nu argumentele impreuna cu diagnosticul
		if (pro<contra)
		{
			change = new NumberTermImpl(1);
			return un.unifies(change, args[7]) && un.unifies(args[8], new NumberTermImpl(diagC)) && un.unifies(args[9], contraListP) && un.unifies(args[10], proListC);
		}
		else
		{
			change = new NumberTermImpl(0);
			return un.unifies(change, args[7]) && un.unifies(args[8], new NumberTermImpl(diagC)) && un.unifies(args[9], contraListP) && un.unifies(args[10], proListC);
			
			
			
		}

	}

}
