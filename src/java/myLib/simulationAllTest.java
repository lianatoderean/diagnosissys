// Internal action code for project agentsys

package myLib;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import jason.*;
import jason.asSemantics.*;
import jason.asSyntax.*;

public class simulationAllTest extends DefaultInternalAction {
   
    ListTerm names = new ListTermImpl();
    @Override
    public Object execute(TransitionSystem ts, Unifier un, Term[] args) throws Exception {
       	   int lineNo = Integer.parseInt(args[0].toString());
           String filename = "allTest";
       	ts.getAg().getLogger().info("models/"+filename);			
    	ArrayList<String> strings = new ArrayList();
    	// execute the internal action
        ListTerm values = new ListTermImpl();
        BufferedReader reader;
        	System.out.println("sdadsas");
		try {
        	reader = new BufferedReader(new FileReader("models/"+filename));
        	String thisLine = "";
            String line = "";
            int count = 0;
			line = reader.readLine();
		
            while (((thisLine = reader.readLine()) != null) && count<lineNo)            
        	{
                line = thisLine;
                count = count + 1;
            }
            if (line!=null)
            {
                String delims = "[ ]" ;
        	int i = 0;
        	for (String param: line.split(delims))
        	{
        		if (i%2 == 0)
        			names.add(new StringTermImpl(param));
        		else 
        			values.add(new NumberTermImpl(Double.parseDouble(param)));
        		i++;
        	}
        	
        	System.out.println(names);
            }
        	
        }
        catch(IOException e)
        {
        	ts.getAg().getLogger().info("Input parameters not found");
        }
        
        // everything ok, so returns true
        return  un.unifies(args[1],(ListTerm) names) && un.unifies(args[2], (ListTerm) values) ;
    }
}
