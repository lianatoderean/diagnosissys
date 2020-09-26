// Environment code for project agentsys
import jason.runtime.RuntimeServices;

import jason.asSyntax.*;
import jason.asSyntax.parser.ParseException;
import jason.environment.*;
import jason.infra.centralised.BaseCentralisedMAS;

import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
import javax.swing.JButton;
import javax.swing.JFrame;

import java.util.List;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.logging.*;
import org.python.util.PythonInterpreter;

import myLib.getParameters;
public class SysEnv extends Environment {

    private Logger logger = Logger.getLogger("agentsys."+SysEnv.class.getName());
    /** Called before the MAS execution with the args informed in .mas2j */
    @Override
    public void init(String[] args) {
    

    }

    @Override
    public boolean executeAction(String agName, Structure action) {

	
        if (true) { // you may improve this condition

        }
        return true; // the action was executed with success
    }

    /** Called before the end of MAS execution */
    @Override
    public void stop() {
        super.stop();
    }
}
