package com.shams.jsp;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.jena.ontology.*;
import org.apache.jena.rdf.model.Model;
import org.apache.jena.rdf.model.ModelFactory;
import org.apache.jena.rdf.model.Property;
import org.apache.jena.rdf.model.RDFNode;
import org.apache.jena.rdf.model.Resource;
import org.apache.jena.rdf.model.Statement;
import org.apache.jena.rdf.model.StmtIterator;
import org.apache.jena.util.*;
import org.apache.jena.util.iterator.ExtendedIterator;
import org.apache.log4j.BasicConfigurator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PvSemanticWeb {

	static String defaultNameSpace = "http://semanticweb.org/ontologies";
	Model schema = null;
	public static Map<String,String> trimax = new HashMap<String,String>(); //stores properties of the instance trimax in a Map
	public static Map<String,String> protago = new HashMap<String,String>();
	public static Map<String,String> pc5max = new HashMap<String,String>();
	public static Map<String,String> allMaxModule = new HashMap<String,String>();
	public static Map<String,String> ultron = new HashMap<String,String>();
	public static Map<String,String> jinko = new HashMap<String,String>();
	public static Map<String,String> sunModule = new HashMap<String,String>();
	public static Map<String,String> solarWorldXl = new HashMap<String,String>();
	public static Map<String,String> neon = new HashMap<String,String>();
	public static Map<String,String> perc = new HashMap<String,String>();
	public static Map<String,String> jasolar = new HashMap<String,String>();
	public static Map<String,String> alpha = new HashMap<String,String>();
	public static Map<String,String> maxeon = new HashMap<String,String>();
	public static Map<String,String> tesla = new HashMap<String,String>();

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		PvSemanticWeb load = new PvSemanticWeb();
		System.out.println("Showing ontologies");
		load.getOntology();
		//BasicConfigurator.configure();
		System.out.println("******** Trimax **********");
		getInstances(trimax);
		System.out.println("******** ProtagoModule **********");
		getInstances(protago);
		System.out.println("******** PC5Max **********");
		getInstances(pc5max);
		System.out.println("******** AllmaxModule **********");
		getInstances(allMaxModule);
		System.out.println("******** Ultron **********");
		getInstances(ultron);
		System.out.println("******** Jinko **********");
		getInstances(jinko);
		System.out.println("******** SunModule **********");
		getInstances(sunModule);
		System.out.println("******** SolarWorldXL **********");
		getInstances(solarWorldXl);
		System.out.println("******** Neon **********");
		getInstances(neon);
		System.out.println("******** Perc **********");
		getInstances(perc);
		System.out.println("******** JaSolar **********");
		getInstances(jasolar);
		System.out.println("******** Alpha **********");
		getInstances(alpha);
		System.out.println("******** Maxeon **********");
		getInstances(maxeon);
		System.out.println("******** Tesla **********");
		getInstances(tesla);
	}
	
	
	public static void getOnto() throws IOException {
		PvSemanticWeb load = new PvSemanticWeb();
		load.getOntology();
	}
	
	public void getOntology() throws IOException{
		schema = ModelFactory.createOntologyModel();
		InputStream inschema = FileManager.get().open("./ifcOWL-pvOntologyMaxPv.rdf");
		schema.read(inschema,defaultNameSpace);
		
		ExtendedIterator<OntClass> it = ((OntModel) schema).listClasses();

		while(it.hasNext()) {
			OntClass cls = (OntClass)it.next(); //Loops through the classes of the ontology
			//System.out.println(cls.getLocalName());
			if(cls.getLocalName().equals("SolarModule")) {
				System.out.println("A class of the IfcOWL_pvOntology: " + cls.getLocalName() + "\n");
				System.out.println("URI: " + cls.getURI() + "\n");
				
				ExtendedIterator Instances = cls.listInstances();
				while(Instances.hasNext())
				{
					Individual currInstance = (Individual)Instances.next();
					//System.out.println("Individual of SolarModule Class:" + currInstance.getLocalName() +"\n");
					if(currInstance.getLocalName().equalsIgnoreCase("tesla"))  // case ignored because individuals are named in caps
					{
						//System.out.println("Individual of SolarModule Class: " + currInstance.getLocalName());
					
						for(StmtIterator ti= currInstance.listProperties(); ti.hasNext();) {
							Statement t = ti.next();
							
							if(t.getPredicate().getLocalName().equals("type") || t.getPredicate().getLocalName().equals("topDataProperty")) continue;
							String propertyName = t.getPredicate().getLocalName();
							String propertyValue = "";
							if(propertyName.equals("IsInvolvedIn") || propertyName.equals("topObjectProperty") ) continue;
							
							if(propertyName.equals("IsManufacturedBy")) {
								propertyValue= t.getResource().getLocalName();
								tesla.put(propertyName, propertyValue);
							} 
					
							if(propertyName.equals("hasModuleMaterialType")) {
								propertyValue= t.getResource().getLocalName();
								tesla.put(propertyName, propertyValue);
							} 
							//else {
							//	propertyValue = t.getLiteral().getLexicalForm();
							//}
							//	ultron.put(propertyName, propertyValue);
							}
					}
					else if(currInstance.getLocalName().equalsIgnoreCase("trimax"))
					{
						for(StmtIterator ti= currInstance.listProperties(); ti.hasNext();) {
							Statement t = ti.next();
						    
							if(t.getPredicate().getLocalName().equals("type") || t.getPredicate().getLocalName().equals("topDataProperty")) continue;
							String propertyName = t.getPredicate().getLocalName();
							String propertyValue = "";
							if(propertyName.equals("IsInvolvedIn") || propertyName.equals("topObjectProperty") ) continue;
							
							if(propertyName.equals("IsManufacturedBy")) {
								propertyValue= t.getResource().getLocalName();
								trimax.put(propertyName, propertyValue);
							} 
				
							else if(propertyName.equals("hasModuleMaterialType")) {
								propertyValue= t.getResource().getLocalName();
								trimax.put(propertyName, propertyValue);
							} 
							
							else {
								propertyValue = t.getLiteral().getLexicalForm();
							}
								trimax.put(propertyName, propertyValue);
							}
					}
					else if(currInstance.getLocalName().equalsIgnoreCase("pc5max"))
					{
						for(StmtIterator ti= currInstance.listProperties(); ti.hasNext();) {
							Statement t = ti.next();
						    
							if(t.getPredicate().getLocalName().equals("type") || t.getPredicate().getLocalName().equals("topDataProperty")) continue;
							String propertyName = t.getPredicate().getLocalName();
							String propertyValue = "";
							if(propertyName.equals("IsInvolvedIn") || propertyName.equals("topObjectProperty") ) continue;
							
							if(propertyName.equals("IsManufacturedBy")) {
								propertyValue= t.getResource().getLocalName();
								pc5max.put(propertyName, propertyValue);
							} 
				
							else if(propertyName.equals("hasModuleMaterialType")) {
								propertyValue= t.getResource().getLocalName();
								pc5max.put(propertyName, propertyValue);
							} 
							
							else {
								propertyValue = t.getLiteral().getLexicalForm();
							}
							    pc5max.put(propertyName, propertyValue);
							}
					}
					else if(currInstance.getLocalName().equalsIgnoreCase("ProtagoModule"))
					{
						for(StmtIterator ti= currInstance.listProperties(); ti.hasNext();) {
							Statement t = ti.next();
						    
							if(t.getPredicate().getLocalName().equals("type") || t.getPredicate().getLocalName().equals("topDataProperty")) continue;
							String propertyName = t.getPredicate().getLocalName();
							String propertyValue = "";
							if(propertyName.equals("IsInvolvedIn") || propertyName.equals("topObjectProperty") ) continue;
							
							if(propertyName.equals("IsManufacturedBy")) {
								propertyValue= t.getResource().getLocalName();
								protago.put(propertyName, propertyValue);
							} 
				
							else if(propertyName.equals("hasModuleMaterialType")) {
								propertyValue= t.getResource().getLocalName();
								protago.put(propertyName, propertyValue);
							} 
							
							else {
								propertyValue = t.getLiteral().getLexicalForm();
								}
								protago.put(propertyName, propertyValue);
							}
					}
					else
					{
						for(StmtIterator ti= currInstance.listProperties(); ti.hasNext();) {
							Statement t = ti.next();
						    
							if(t.getPredicate().getLocalName().equals("type") || t.getPredicate().getLocalName().equals("topDataProperty")) continue;
							String propertyName = t.getPredicate().getLocalName();
							String propertyValue = "";
							if(propertyName.equals("IsInvolvedIn") || propertyName.equals("topObjectProperty") ) continue;
							
							if(propertyName.equals("IsManufacturedBy")) {
								propertyValue= t.getResource().getLocalName();
								allMaxModule.put(propertyName, propertyValue);
							} 
				
							else if(propertyName.equals("hasModuleMaterialType")) {
								propertyValue= t.getResource().getLocalName();
								allMaxModule.put(propertyName, propertyValue);
							} 
							
							else if(propertyName.equals("IsResearchedBy")) { continue; }
							
							else {
								propertyValue = t.getLiteral().getLexicalForm();
								}
								allMaxModule.put(propertyName, propertyValue);
							}
					}
					
				}
				break;
			}
			//inschema.close();
		}
		//schema.close();
		InputStream inschema1 = FileManager.get().open("./ifcOWL-pvOntologySimbaSolarSolutions.rdf");
		schema.read(inschema1,defaultNameSpace);
		
		ExtendedIterator<OntClass> it1 = ((OntModel) schema).listClasses();

		while(it1.hasNext()) {
			OntClass cls = (OntClass)it1.next(); //Loops through the classes of the ontology
			//System.out.println(cls.getLocalName());
			if(cls.getLocalName().equals("SolarModule")) {
	
				
				ExtendedIterator Instances = cls.listInstances();
				while(Instances.hasNext())
				{
					Individual currInstance = (Individual)Instances.next();
					//System.out.println("Individual of SolarModule Class:" + currInstance.getLocalName() +"\n");
				
						if(currInstance.getLocalName().equalsIgnoreCase("Neon"))
						{
						for(StmtIterator ti= currInstance.listProperties(); ti.hasNext();) {
							Statement t = ti.next();
						    
							if(t.getPredicate().getLocalName().equals("type") || t.getPredicate().getLocalName().equals("topDataProperty")) continue;
							String propertyName = t.getPredicate().getLocalName();
							String propertyValue = "";
							if(propertyName.equals("IsInvolvedIn") || propertyName.equals("topObjectProperty") ) continue;
							
							if(propertyName.equals("IsManufacturedBy")) {
								propertyValue= t.getResource().getLocalName();
								neon.put(propertyName, propertyValue);
							} 
				
							else if(propertyName.equals("hasModuleMaterialType")) {
								propertyValue= t.getResource().getLocalName();
								//System.out.println(propertyValue);
								neon.put(propertyName, propertyValue);
							} 
							
							else {
								propertyValue = t.getLiteral().getLexicalForm();
								}
								neon.put(propertyName, propertyValue);
							}
					}
					
					else if(currInstance.getLocalName().equalsIgnoreCase("Perc"))
					{
						for(StmtIterator ti= currInstance.listProperties(); ti.hasNext();) {
							Statement t = ti.next();
						    
							if(t.getPredicate().getLocalName().equals("type") || t.getPredicate().getLocalName().equals("topDataProperty")) continue;
							String propertyName = t.getPredicate().getLocalName();
							String propertyValue = "";
							if(propertyName.equals("IsInvolvedIn") || propertyName.equals("topObjectProperty") ) continue;
							
							if(propertyName.equals("IsManufacturedBy")) {
								propertyValue= t.getResource().getLocalName();
								perc.put(propertyName, propertyValue);
							} 
				
							else if(propertyName.equals("hasModuleMaterialType")) {
								propertyValue= t.getResource().getLocalName();
								//System.out.println(propertyValue);
								perc.put(propertyName, propertyValue);
							} 
							
							else {
								propertyValue = t.getLiteral().getLexicalForm();
								}
								perc.put(propertyName, propertyValue);
							}
					}
					else if(currInstance.getLocalName().equalsIgnoreCase("Jasolar"))
					{
						for(StmtIterator ti= currInstance.listProperties(); ti.hasNext();) {
							Statement t = ti.next();
						    
							if(t.getPredicate().getLocalName().equals("type") || t.getPredicate().getLocalName().equals("topDataProperty")) continue;
							String propertyName = t.getPredicate().getLocalName();
							String propertyValue = "";
							if(propertyName.equals("IsInvolvedIn") || propertyName.equals("topObjectProperty") ) continue;
							
							if(propertyName.equals("IsManufacturedBy")) {
								propertyValue= t.getResource().getLocalName();
								jasolar.put(propertyName, propertyValue);
							} 
				
							else if(propertyName.equals("hasModuleMaterialType")) {
								propertyValue= t.getResource().getLocalName();
								//System.out.println(propertyValue);
								jasolar.put(propertyName, propertyValue);
							} 
							
							else {
								propertyValue = t.getLiteral().getLexicalForm();
								}
								jasolar.put(propertyName, propertyValue);
							}
					}
		
					else
					{
						for(StmtIterator ti= currInstance.listProperties(); ti.hasNext();) {
							Statement t = ti.next();
						    
							if(t.getPredicate().getLocalName().equals("type") || t.getPredicate().getLocalName().equals("topDataProperty")) continue;
							String propertyName = t.getPredicate().getLocalName();
							String propertyValue = "";
							if(propertyName.equals("IsInvolvedIn") || propertyName.equals("topObjectProperty") ) continue;
							
							if(propertyName.equals("IsManufacturedBy")) {
								propertyValue= t.getResource().getLocalName();
								alpha.put(propertyName, propertyValue);
							} 
				
							else if(propertyName.equals("hasModuleMaterialType")) {
								propertyValue= t.getResource().getLocalName();
								alpha.put(propertyName, propertyValue);
							} 
							
							else if(propertyName.equals("IsResearchedBy")) { continue; }
							
							else {
								propertyValue = t.getLiteral().getLexicalForm();
								}
							alpha.put(propertyName, propertyValue);
							}
					}
					
				}
				break;
			}
		}
		
		InputStream inschema11 = FileManager.get().open("./ifcOWL-pvOntologySolarShop.rdf");
		schema.read(inschema11,defaultNameSpace);
		
		ExtendedIterator<OntClass> it11 = ((OntModel) schema).listClasses();

		while(it11.hasNext()) {
			OntClass cls = (OntClass)it11.next(); //Loops through the classes of the ontology
			//System.out.println(cls.getLocalName());
			if(cls.getLocalName().equals("SolarModule")) {
				
				ExtendedIterator Instances = cls.listInstances();
				while(Instances.hasNext())
				{
					Individual currInstance = (Individual)Instances.next();
					//System.out.println("Individual of SolarModule Class:" + currInstance.getLocalName() +"\n");
				
					if(currInstance.getLocalName().equalsIgnoreCase("jinko"))
					{
						for(StmtIterator ti= currInstance.listProperties(); ti.hasNext();) {
							Statement t = ti.next();
						    
							if(t.getPredicate().getLocalName().equals("type") || t.getPredicate().getLocalName().equals("topDataProperty")) continue;
							String propertyName = t.getPredicate().getLocalName();
							String propertyValue = "";
							if(propertyName.equals("IsInvolvedIn") || propertyName.equals("topObjectProperty") ) continue;
							
							if(propertyName.equals("IsManufacturedBy")) {
								propertyValue= t.getResource().getLocalName();
								jinko.put(propertyName, propertyValue);
							} 
				
							else if(propertyName.equals("hasModuleMaterialType")) {
								propertyValue= t.getResource().getLocalName();
								jinko.put(propertyName, propertyValue);
							} 
							
							else {
								propertyValue = t.getLiteral().getLexicalForm();
								}
								jinko.put(propertyName, propertyValue);
							}
					}
					else if(currInstance.getLocalName().equalsIgnoreCase("sunModule"))
					{
						for(StmtIterator ti= currInstance.listProperties(); ti.hasNext();) {
							Statement t = ti.next();
						    
							if(t.getPredicate().getLocalName().equals("type") || t.getPredicate().getLocalName().equals("topDataProperty")) continue;
							String propertyName = t.getPredicate().getLocalName();
							String propertyValue = "";
							if(propertyName.equals("IsInvolvedIn") || propertyName.equals("topObjectProperty") ) continue;
							
							if(propertyName.equals("IsManufacturedBy")) {
								propertyValue= t.getResource().getLocalName();
								sunModule.put(propertyName, propertyValue);
							} 
				
							else if(propertyName.equals("hasModuleMaterialType")) {
								propertyValue= t.getResource().getLocalName();
								sunModule.put(propertyName, propertyValue);
							} 
							
							else {
								propertyValue = t.getLiteral().getLexicalForm();
								}
								sunModule.put(propertyName, propertyValue);
							}
					}
					else if(currInstance.getLocalName().equalsIgnoreCase("SolarWorldXl"))
					{
						for(StmtIterator ti= currInstance.listProperties(); ti.hasNext();) {
							Statement t = ti.next();
						    
							if(t.getPredicate().getLocalName().equals("type") || t.getPredicate().getLocalName().equals("topDataProperty")) continue;
							String propertyName = t.getPredicate().getLocalName();
							String propertyValue = "";
							if(propertyName.equals("IsInvolvedIn") || propertyName.equals("topObjectProperty") ) continue;
							
							if(propertyName.equals("IsManufacturedBy")) {
								propertyValue= t.getResource().getLocalName();
								solarWorldXl.put(propertyName, propertyValue);
							} 
				
							else if(propertyName.equals("hasModuleMaterialType")) {
								propertyValue= t.getResource().getLocalName();
								//System.out.println(propertyValue);
								solarWorldXl.put(propertyName, propertyValue);
							} 
							
							else {
								propertyValue = t.getLiteral().getLexicalForm();
								}
								solarWorldXl.put(propertyName, propertyValue);
							}
					} 
				
					else
					{
						for(StmtIterator ti= currInstance.listProperties(); ti.hasNext();) {
							Statement t = ti.next();
						    
							if(t.getPredicate().getLocalName().equals("type") || t.getPredicate().getLocalName().equals("topDataProperty")) continue;
							String propertyName = t.getPredicate().getLocalName();
							String propertyValue = "";
							if(propertyName.equals("IsInvolvedIn") || propertyName.equals("topObjectProperty") ) continue;
							
							if(propertyName.equals("IsManufacturedBy")) {
								propertyValue= t.getResource().getLocalName();
								ultron.put(propertyName, propertyValue);
							} 
				
							else if(propertyName.equals("hasModuleMaterialType")) {
								propertyValue= t.getResource().getLocalName();
								ultron.put(propertyName, propertyValue);
							} 
							
							else if(propertyName.equals("IsResearchedBy")) { continue; }
							
							else {
								propertyValue = t.getLiteral().getLexicalForm();
								}
							ultron.put(propertyName, propertyValue);
							}
					}
					
				}
				break;
			}
		}
		
		InputStream inschema111 = FileManager.get().open("./ifcOWL-pvOntologySunpower.rdf");
		schema.read(inschema111,defaultNameSpace);
		
		ExtendedIterator<OntClass> it111 = ((OntModel) schema).listClasses();

		while(it111.hasNext()) {
			OntClass cls = (OntClass)it111.next(); //Loops through the classes of the ontology
			//System.out.println(cls.getLocalName());
			if(cls.getLocalName().equals("SolarModule")) {
				
				ExtendedIterator Instances = cls.listInstances();
				while(Instances.hasNext())
				{
					Individual currInstance = (Individual)Instances.next();
					//System.out.println("Individual of SolarModule Class:" + currInstance.getLocalName() +"\n");
					
					if(currInstance.getLocalName().equalsIgnoreCase("Maxeon"))
					{
						for(StmtIterator ti= currInstance.listProperties(); ti.hasNext();) {
							Statement t = ti.next();
						    
							if(t.getPredicate().getLocalName().equals("type") || t.getPredicate().getLocalName().equals("topDataProperty")) continue;
							String propertyName = t.getPredicate().getLocalName();
							String propertyValue = "";
							if(propertyName.equals("IsInvolvedIn") || propertyName.equals("topObjectProperty") ) continue;
							
							if(propertyName.equals("IsManufacturedBy")) {
								propertyValue= t.getResource().getLocalName();
								maxeon.put(propertyName, propertyValue);
							} 
				
							else if(propertyName.equals("hasModuleMaterialType")) {
								propertyValue= t.getResource().getLocalName();
								maxeon.put(propertyName, propertyValue);
							} 
							else if(propertyName.equals("IsInstalledBy")) {
								propertyValue= t.getResource().getLocalName();
								maxeon.put(propertyName, propertyValue);
							} 
							else {
								propertyValue = t.getLiteral().getLexicalForm();
							}
							maxeon.put(propertyName, propertyValue);
							}
					}
					else
					{
						for(StmtIterator ti= currInstance.listProperties(); ti.hasNext();) {
							Statement t = ti.next();
						    
							if(t.getPredicate().getLocalName().equals("type") || t.getPredicate().getLocalName().equals("topDataProperty")) continue;
							String propertyName = t.getPredicate().getLocalName();
							String propertyValue = "";
							if(propertyName.equals("IsInvolvedIn") || propertyName.equals("topObjectProperty") ) continue;
							
							if(propertyName.equals("IsManufacturedBy")) {
								propertyValue= t.getResource().getLocalName();
								allMaxModule.put(propertyName, propertyValue);
							} 
				
							else if(propertyName.equals("hasModuleMaterialType")) {
								propertyValue= t.getResource().getLocalName();
								allMaxModule.put(propertyName, propertyValue);
							} 
							
							else if(propertyName.equals("IsResearchedBy")) { continue; }
							
							else {
								propertyValue = t.getLiteral().getLexicalForm();
								}
								allMaxModule.put(propertyName, propertyValue);
							}
					}
					
				}
				break;
			}
		}
		
	}
	
	public static void getInstances(Map<String,String> map) {
		for(String s: map.keySet()){
			if(!map.isEmpty())
			{	
				System.out.println( s + " -> " + map.get(s));
			}
		}
	}

}


