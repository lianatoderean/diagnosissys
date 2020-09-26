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

public class requestDiagnosis extends DefaultInternalAction {
    ListTerm names = new ListTermImpl();
    @Override
    public Object execute(TransitionSystem ts, Unifier un, Term[] args) throws Exception {
       	String filename = args[0].toString();
       	ts.getAg().getLogger().info("test/"+filename);			
    	ArrayList<String> strings = new ArrayList();
        ListTerm values = new ListTermImpl();
        ListTerm scaledValues = new ListTermImpl();
        BufferedReader reader;
        try {
        	reader = new BufferedReader(new FileReader("test/"+filename+".txt"));
        	String line = reader.readLine();
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
        	
        	//pentru neural network parametrii sunt scalati si sunt cititi dintr-un alt fisier
        	reader = new BufferedReader(new FileReader("test/"+ filename+"_scaled.txt"));
        	String lineS = reader.readLine();
        	i = 0;
        	for (String param: lineS.split(delims))
        	{
        		if (i%2 == 0)
        			names.add(new StringTermImpl(param));
        		else 
        			scaledValues.add(new NumberTermImpl(Double.parseDouble(param)));
        		i++;
        	}
        	
        	
        }
        catch(IOException e)
        {
        	ts.getAg().getLogger().info("Input parameters not found");
        }
        
        return  un.unifies(args[1],(ListTerm) names) && un.unifies(args[2], (ListTerm) values) && un.unifies(args[3], (ListTerm) scaledValues);
    }
}
