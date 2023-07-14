<%@page import="com.shams.jsp.PvSemanticWeb"%>
<html>
<head>
        <title>Recommended Module</title>
        <link rel="stylesheet" type="text/css" href="pvm1.css"/>
	</head>
<body>
	<div class="container">

                        <div id="RDF-header">
                            <!--   <div id="logoBox">
                                   <a href="">
                                        <img src="Images/pvImage.jpg" alt="PV logo" width="150"
                      height="90" border="0" id="logo"/>
                                   </a>
                                   
                             </div>-->
                              <div id="RDF-header-title"> Semantic IFC PV Calculator</div>
						 <!--  <p><h4>Sustainable, Affordable, Profitable</h4></p> -->
    					  </div>
						  <div id="RDF-title-bar">
                          <!-- ><img src="Images/pvImage.jpg" alt="left bar top"/>
						<h3>Sustainable, Affordable, Profitable...</h3> -->
                         </div>  
                         
                         <div id="RDF-separator"></div>
						 <div id="empty"></div>
						 <div id="RDF-separator"></div>
                         <div id="left-bar">
                              <div id="left-bar-menu">
								 
                                   <a href="">Solar Home</a>
                                   <div class="separator"><hr/></div>
                                   <a href="http://localhost:8080/shams/manufacturer1.jsp">Wholesale Max Modules</a><br/>
                                  <a href="http://localhost:8080/shams/manufacturer2.jsp">Solar Shop Nigeria</a><br/>
                                  
                                  <a href="http://localhost:8080/shams/manufacturer3.jsp">Simba Solar Solutions</a><br/>
                                  
								   <div class="separator"><hr/></div>
                                   <a href="http://localhost:8080/shams/calculate.html">Solar Calculators</a>
								   <div class="separator"><hr/></div>
								   <a href="">Contact Us</a>
                              </div>
                         </div>
    </div>
 	
 	<div id="RDF-main">

    <h1>
		Recommend Components Based on Budget
    </h1>
    Budget $: <%= request.getParameter("budget") %>
    <br>
    Solar radiation of location: <%= request.getParameter("solar") %>    
    <br>
    Energy Load of Building in KiloWatts: <%= request.getParameter("energyLoad") %>
    <br>
    <hr>
  
	<%  PvSemanticWeb.getOnto();
		java.util.Map<String,Double> values = new java.util.HashMap<String,Double>();
		
		String budget = request.getParameter("budget");
		double b = Double.parseDouble(budget);
		
		String energy = request.getParameter("energyLoad");
		double x = Double.parseDouble(energy);
		
		String solar = request.getParameter("solar");
		double y = Double.parseDouble(solar);
		
		double moduleWattHrs = x*1000*3.5;
		double result = 3540*x/y; //where result is the watt peak rating expected from the modules
		
		String t = PvSemanticWeb.trimax.get("hasRatedPower"); //reads the rated power of trimax as saved in the HashMap in PvSemanticWeb.java
		t = t.replaceAll("\\D+","");
		double tOutput = Double.parseDouble(t);
		String pt = PvSemanticWeb.trimax.get("hasCost"); //reads the cost of trimax as saved in the HashMap in PvSemanticWeb.java
		pt = pt.replaceAll("[$]","");
		double ptt = Double.parseDouble(pt);
		double tas = result/tOutput; //trimax array size
		double nmn = tas * ptt; //total cost of trimax array size
		double totalTrimax = nmn*1.099; //total component cost of installing Trimax based on user requirements
		double inverterBatteryTrimax = totalTrimax-nmn; //cost of inverter and battery
		double f = totalTrimax-b; //returns absolute difference between the budget and trimax module
		values.put("trimax",f);
		
		String ptg = PvSemanticWeb.protago.get("hasRatedPower");
		ptg = ptg.replaceAll("\\D+","");
		double ptgOutput = Double.parseDouble(ptg);
		String ptCost = PvSemanticWeb.protago.get("hasCost");
		ptCost = ptCost.replaceAll("[$]","");
		Double ptgS = Double.parseDouble(ptCost);
		double pas = result/ptgOutput; //protago array size
		//double protagoArrayTotalRated = ptgOutput*pas; //total rated power
		double nmnP = result/ptgOutput * ptgS; //total cost of protago array size
		double totalProtago = nmnP*100/91; //total component costs
		double inverterBatteryProtago = totalProtago-nmnP; //inverter and battery costs
		double q = totalProtago-b;
		values.put("protago",q);
		
		String ul = PvSemanticWeb.ultron.get("hasRatedPower");
		ul = ul.replaceAll("\\D+","");
		double ulOutput = Double.parseDouble(ul);
		String ulCost = PvSemanticWeb.ultron.get("hasCost");
		ulCost = ulCost.replaceAll("[$]","");
		Double ulS = Double.parseDouble(ulCost);
		double uas = result/ulOutput; //ultron array size
		double nmnUl = result/ulOutput * ulS; //total cost of ultron array size
		double totalUltron = nmnUl*100/91; //total component costs
		double inverterBatteryUltron = totalUltron-nmnUl; //inverter and battery costs
		double u = totalUltron-b;
		values.put("ultron", u);
		
		String jk = PvSemanticWeb.jinko.get("hasRatedPower");
		jk = jk.replaceAll("\\D+","");
		double jkOutput = Double.parseDouble(jk);
		String jkCost = PvSemanticWeb.jinko.get("hasCost");
		jkCost = jkCost.replaceAll("[$]","");
		Double jkS = Double.parseDouble(jkCost);
		double jas = result/jkOutput; //array size if jinko is selected
		double arrayJinkoRatingTotal = jkOutput*jas;
		double nmnJk = result/jkOutput * jkS; //total cost of jinko array size
		double totalJinko = nmnJk*1.099; //total component cost
		double inverterBatteryJinko = totalJinko-nmnJk; //inverter and battery costs
		double j = totalJinko-b;
		values.put("jinko", j);
		
		String sm = PvSemanticWeb.sunModule.get("hasRatedPower");
		sm = sm.replaceAll("\\D+","");
		double smOutput = Double.parseDouble(sm);
		String smCost = PvSemanticWeb.sunModule.get("hasCost");
		smCost = smCost.replaceAll("[$]","");
		Double smS = Double.parseDouble(smCost);
		double sunas = result/smOutput; //array size if sunModule is selected
		double nmnSm = result/smOutput * smS; //total cost of array
		double totalSunModule = nmnSm*1.099; //total component costs
		double inverterBatterySunModule = totalSunModule-nmnSm; //costs of inverter and batter
		double mi = totalSunModule-b;
		values.put("sunModule", mi);

		String xl = PvSemanticWeb.solarWorldXl.get("hasRatedPower");
		xl = xl.replaceAll("\\D+","");
		double xlOutput = Double.parseDouble(xl);
		String xlCost = PvSemanticWeb.solarWorldXl.get("hasCost");
		xlCost = xlCost.replaceAll("[$]","");
		Double xlS = Double.parseDouble(xlCost);
		double soas = result/xlOutput; //array size if solarWorldXl is selected
		double nmnXl = result/xlOutput * xlS; //total cost of array
		double totalSolarWorldXl = nmnXl*100/91; //totoal component costs
		double inverterbatterySolarWorld = totalSolarWorldXl-nmnXl; //cost of inverter and battery
		double mxl = totalSolarWorldXl-b;
		values.put("solarWorldXl", mxl);
		
		//new Neon
		String ne = PvSemanticWeb.neon.get("hasRatedPower");
		ne = ne.replaceAll("\\D+","");
		double neOutput = Double.parseDouble(ne);
		String neCost = PvSemanticWeb.neon.get("hasCost");
		neCost = neCost.replaceAll("[$]","");
		Double nelS = Double.parseDouble(neCost);
		double neonas = result/neOutput; //array size if neon is selected
		double nmnNe = result/neOutput * nelS; //total cost of array
		double totalNeon = nmnNe*100/91; //totoal component costs
		double inverterbatteryNeon = totalNeon-nmnNe; //cost of inverter and battery
		double nxl = totalNeon-b;
		values.put("neon", nxl);
		
		//perc
		String pc = PvSemanticWeb.perc.get("hasRatedPower");
		pc = pc.replaceAll("\\D+","");
		double pcOutput = Double.parseDouble(pc);
		String pcCost = PvSemanticWeb.perc.get("hasCost");
		pcCost = pcCost.replaceAll("[$]","");
		Double pclS = Double.parseDouble(pcCost);
		double pconas = result/pcOutput; //array size if perc is selected
		double nmnPc = result/pcOutput * pclS; //total cost of array
		double totalPerc = nmnPc*100/91; //totoal component costs
		double inverterbatteryPerc = totalPerc-nmnPc; //cost of inverter and battery
		double pxl = totalPerc-b;
		values.put("perc", pxl);
		
		//jasolar
		String ja = PvSemanticWeb.jasolar.get("hasRatedPower");
		ja = ja.replaceAll("\\D+","");
		double jaOutput = Double.parseDouble(ja);
		String jaCost = PvSemanticWeb.jasolar.get("hasCost");
		jaCost = jaCost.replaceAll("[$]","");
		Double jalS = Double.parseDouble(jaCost);
		double jaas = result/jaOutput; //array size if jasolar is selected
		double nmnJa = result/jaOutput * jalS; //total cost of attay
		double totalJa = nmnJa*100/91; //totoal component costs
		double inverterbatteryJa = totalJa-nmnJa; //cost of inverter and battery
		double jxl = totalJa-b;
		values.put("jasolar", jxl);
		
		//alpha
		String ala = PvSemanticWeb.alpha.get("hasRatedPower");
		ala = ala.replaceAll("\\D+","");
		double alOutput = Double.parseDouble(ala);
		String alCost = PvSemanticWeb.alpha.get("hasCost");
		alCost = alCost.replaceAll("[$]","");
		Double allS = Double.parseDouble(alCost);
		double alas = result/alOutput; //array size if alpha is selected
		double nmnal = result/alOutput * allS; //total cost of array
		double totalal = nmnal*100/91; //totoal component costs
		double inverterbatteryal = totalal-nmnal; //cost of inverter and battery
		double all = totalal-b;
		values.put("alpha", all);
		
		//maxeon
		String max = PvSemanticWeb.maxeon.get("hasRatedPower");
		max = max.replaceAll("\\D+","");
		double maxOutput = Double.parseDouble(max);
		String maxCost = PvSemanticWeb.alpha.get("hasCost");
		maxCost = maxCost.replaceAll("[$]","");
		Double maxS = Double.parseDouble(maxCost);
		double arraymax = result/maxOutput; //array size if maxeon is selected
		double nmnmax = result/maxOutput * maxS; //total cost of array
		double totalmax = nmnmax*100/91; //totoal component costs
		double inverterbatterymax = totalmax-nmnmax; //cost of inverter and battery
		double maxeo = totalmax-b;
		values.put("maxeon", maxeo);
		
		
		t = PvSemanticWeb.pc5max.get("hasRatedPower");
		t = t.replaceAll("\\D+","");
		tOutput = Integer.parseInt(t);
		pt = PvSemanticWeb.pc5max.get("hasCost");
		pt = pt.replaceAll("[$]","");
		ptt = Double.parseDouble(pt);
		pas = result/tOutput; //arraysize if pc5Max is selected
		double nmnPm = result/tOutput * ptt; //total array cost 
		double totalpc5 = nmnPm*1.099; //total component cost
		double inverterbatterypc5 = totalpc5-nmnPm; //inverter and battery cost
		f = totalpc5-b;
		values.put("pc5max",f);
		
		String s = PvSemanticWeb.allMaxModule.get("hasRatedPower");
		s = s.replaceAll("\\D+","");
		int eOutput = Integer.parseInt(s);
		String price = PvSemanticWeb.allMaxModule.get("hasCost");
		price = price.replaceAll("[$]","");
		Double p = Double.parseDouble(price);
		double aas = result/eOutput; //array size for allmaxmodule
		double nmnAm = result/eOutput * p; //total cost of array size if allmax module is selected
		double totalAllmax = nmnAm*1.099; //total component cost
		double inverterBatteryAllMax = totalAllmax-nmnAm; //inverter battery costs
		double i = totalAllmax-b;
		values.put("allMaxModule",i);
		
		String best = "trimax";
		String diff = "";
		String bigger = " (This indicates that it is greater than the budget)";
		String smaller = " (This indicates that it is smaller than the budget)";
		
		for(String o:values.keySet()){
			if(Math.abs(values.get(o)) < Math.abs(values.get(best)) ) {
				best = o;
				if(values.get(best) > 0){
					diff = bigger;
				}
				else{
					diff = smaller;
				}
			}
		}
		
	   
		
		// retrieve eficiceny and manufacturer
		String et = PvSemanticWeb.trimax.get("hasComponentEfficiency");
		et = et.replaceAll("\\D+","");
		double etri = Double.parseDouble(et);
		double etrimax = etri/10;

		String mt = PvSemanticWeb.trimax.get("IsManufacturedBy");
		
		
		String ep = PvSemanticWeb.protago.get("hasComponentEfficiency");
		ep = ep.replaceAll("\\D+","");
		double epro = Double.parseDouble(ep);
		double eprotago = epro/10;
		
		String mpr = PvSemanticWeb.protago.get("IsManufacturedBy");
		
		String ej = PvSemanticWeb.jinko.get("hasComponentEfficiency");
		ej = ej.replaceAll("\\D+","");
		double ejin = Double.parseDouble(ej);
		double ejinko = ejin/10;
		String mji = PvSemanticWeb.jinko.get("IsManufacturedBy");
		
		String es = PvSemanticWeb.sunModule.get("hasComponentEfficiency");
		es = es.replaceAll("\\D+","");
		double esun = Double.parseDouble(es);
		double esunModule = esun/10;
		String msun = PvSemanticWeb.sunModule.get("IsManufacturedBy");
		
		String eso = PvSemanticWeb.solarWorldXl.get("hasComponentEfficiency");
		eso = eso.replaceAll("\\D+","");
		double esolar = Double.parseDouble(eso);
		double esolarWorldXl = esolar/10;
		String msolar = PvSemanticWeb.solarWorldXl.get("IsManufacturedBy");
		
		String epc = PvSemanticWeb.pc5max.get("hasComponentEfficiency");
		epc = epc.replaceAll("\\D+","");
		double epc5 = Double.parseDouble(epc);
		double epc5max = epc5/10;
		String mpc5 = PvSemanticWeb.pc5max.get("IsManufacturedBy");
		
		String ea = PvSemanticWeb.allMaxModule.get("hasComponentEfficiency");
		ea = ea.replaceAll("\\D+","");
		double eall = Double.parseDouble(ea);
		double eallmax = eall/10;
		String mall = PvSemanticWeb.allMaxModule.get("IsManufacturedBy");
		
		//new
		String en = PvSemanticWeb.neon.get("hasComponentEfficiency");
		en = en.replaceAll("\\D+","");
		double eNe = Double.parseDouble(en);
		double eNeon = eNe/10;
		String mNeon = PvSemanticWeb.neon.get("IsManufacturedBy");
		
		String eper = PvSemanticWeb.perc.get("hasComponentEfficiency");
		eper = eper.replaceAll("\\D+","");
		double ePe = Double.parseDouble(eper);
		double ePerc = ePe/10;
		String mPerc = PvSemanticWeb.perc.get("IsManufacturedBy");
		
		String eja = PvSemanticWeb.jasolar.get("hasComponentEfficiency");
		eja = eja.replaceAll("\\D+","");
		double ejasol = Double.parseDouble(eja);
		double ejasolar = ejasol/10;
		String mja = PvSemanticWeb.jasolar.get("IsManufacturedBy");
		
		String eal = PvSemanticWeb.alpha.get("hasComponentEfficiency");
		eal = eal.replaceAll("\\D+","");
		double ealp = Double.parseDouble(eal);
		double ealpha = ealp/10;
		String malpha = PvSemanticWeb.alpha.get("IsManufacturedBy");
		
		String ult = PvSemanticWeb.ultron.get("hasComponentEfficiency");
		ult = ult.replaceAll("\\D+","");
		double eult = Double.parseDouble(ult);
		double efultron = eult/10;
		String ultman = PvSemanticWeb.ultron.get("IsManufacturedBy");
		
		String emax = PvSemanticWeb.maxeon.get("hasComponentEfficiency");
		emax = emax.replaceAll("\\D+","");
		double eemax = Double.parseDouble(emax);
		double efmaxeon = eemax/10;
		
		String maxman = PvSemanticWeb.maxeon.get("IsManufacturedBy");
		
		
		
		
		// Math.max(etrimax, eprotago, ejinko, esunModule, esolarWorldXl, epc5max, eallmax);
	
		out.println("Based on your requirements; "+ "</br>");
		out.println("Module recommended is " + best +  " --> " + "Difference from Budget: $" +Math.round(values.get(best)) + diff + diff+ "</br></br></br>");
		
		
		//out.println("Your target Watt Peak Rating is: " + Math.round(result) + "Watts" + "</br></br>");
		
		out.println("Find details of all modules below; "+ "</br></br>");
		//Output for Trimax
		out.println("Array size needed with Trimax: "+ "</br>");
		out.println("Efficiency: " +etri+"%"+ "</br>");
		out.println("Manufacturer: " +mt + "</br>");
		out.println("Number of Modules: " +Math.round(tas) + "</br>");
		out.println("Total Array cost: $" +Math.round(nmn) + "</br>");
		out.println("Inverter and Battery Costs: $" + Math.round(inverterBatteryTrimax) + "</br>");
		out.println("Total component cost if Trimax is selected: $" + Math.round(totalTrimax) + "</br></br>");
		
		
		//Output for Ultron
		out.println("Array size needed with Ultron: "+ "</br>");
		out.println("Efficiency: " +eult+"%"+ "</br>");
		out.println("Manufacturer: " + ultman + "</br>");
		out.println("Number of Modules: " +Math.round(uas) + "</br>");
		out.println("Total Array cost: $" +Math.round(nmnUl) + "</br>");
		out.println("Inverter and Battery Costs: $" + Math.round(inverterBatteryUltron) + "</br>");
		out.println("Total component cost if Ultron is selected: $" + Math.round(totalUltron) + "</br></br>");

		
		//Output for Alpha
		out.println("Array size needed with Alpha: " + "</br>");
		out.println("Efficiency: " +ealpha+"%"+ "</br>");
		out.println("Manufacturer: " +malpha + "</br>");
		out.println("Number of Modules: " +Math.round(alas) + "</br>");
		out.println("Total Array cost: $" +Math.round(nmnal) + "</br>");
		out.println("Inverter and Battery Costs: $" + Math.round(inverterbatteryal) + "</br>");
		out.println("Total component cost if Alpha is selected: $" + Math.round(totalal) + "</br></br>");
		
		
		
		//Output for SolarWorldXl
		out.println("Array size needed with SolarWorldXl: " + "</br>");
		out.println("Efficiency: " +esolarWorldXl+"%"+ "</br>");
		out.println("Manufacturer: " +msolar + "</br>");
		out.println("Number of Modules: " +Math.round(soas) + "</br>");
		out.println("Total Array cost: $" +Math.round(nmnXl) + "</br>");
		out.println("Inverter and Battery Costs: $" + Math.round(inverterbatterySolarWorld) + "</br>");
		out.println("Total component cost if SolarWorldXl is selected: $" + Math.round(totalSolarWorldXl) + "</br></br>");
		
		//Output for Protago
		out.println("Array size needed with Protago: " + "</br>");
		out.println("Efficiency: " +eprotago+"%"+ "</br>");
		out.println("Manufacturer: " +mpr + "</br>");
		out.println("Number of Modules: " +Math.round(pas) +  "</br>");
		out.println("Total Array cost: $" +Math.round(nmnJk) + "</br>");
		out.println("Inverter and Battery Costs: $" + Math.round(inverterBatteryProtago) + "</br>");
		out.println("Total component cost if Protago is selected: $" + Math.round(totalProtago) + "</br></br>");
		
		//Output for Jinko
		out.println("Array size needed with Jinko: " + "</br>");
		out.println("Efficiency: " +ejin+"%"+ "</br>");
		out.println("Manufacturer: " +mji + "</br>");
		out.println("Number of Modules: " +Math.round(jas) + "</br>"); 
		out.println("Total Array cost: $" +Math.round(nmnJk) + "</br>");
		out.println("Inverter and Battery Costs: $" + Math.round(inverterBatteryJinko) + "</br>");
		out.println("Total component cost if Jinko is selected: $" + Math.round(totalJinko) + "</br></br>");
		
		//Output for Neon
		out.println("Array size needed with Neon: " + "</br>");
		out.println("Efficiency: " +eNe+"%"+ "</br>");
		out.println("Manufacturer: " +mNeon + "</br>");
		out.println("Number of Modules: " +Math.round(neonas) + "</br>");
		out.println("Total Array cost: $" +Math.round(nmnNe) + "</br>");
		out.println("Inverter and Battery Costs: $" + Math.round(inverterbatteryNeon) + "</br>");
		out.println("Total component cost if Neon is selected: $" + Math.round(totalNeon) + "</br></br>");

		
		//Output for SunModule
		out.println("Array size needed with SunModule: " + "</br>");
		out.println("Efficiency: " +esun+"%"+ "</br>");
		out.println("Manufacturer: " +msun + "</br>");
		out.println("Number of Modules: " +Math.round(sunas) + "</br>");
		out.println("Total Array cost: $" +Math.round(nmnSm) + "</br>");
		out.println("Inverter and Battery Costs: $" + Math.round(inverterBatterySunModule) + "</br>");
		out.println("Total component cost if SunModule is selected: $" + Math.round(totalSunModule) + "</br></br>");
		
		//Output for PC5Max
		out.println("Array size needed with PC5max: " + "</br>");
		out.println("Efficiency: " +epc5max+"%"+ "</br>");
		out.println("Manufacturer: " +mpc5 + "</br>");
		out.println("Number of Modules: " +Math.round(pas) + "</br>");
		out.println("Total Array cost: $" +Math.round(nmnPm) + "</br>");
		out.println("Inverter and Battery Costs: $" + Math.round(inverterbatterySolarWorld) + "</br>");
		out.println("Total component cost if PC5Max is selected: $" + Math.round(totalpc5) + "</br></br>");
		
		
		//Output for Perc
		out.println("Array size needed with Perc: " + "</br>");
		out.println("Efficiency: " +ePerc+"%"+ "</br>");
		out.println("Manufacturer: " +mPerc + "</br>");
		out.println("Number of Modules: " +Math.round(pconas) + "</br>");
		out.println("Total Array cost: $" +Math.round(nmnPc) + "</br>");
		out.println("Inverter and Battery Costs: $" + Math.round(inverterbatteryPerc) + "</br>");
		out.println("Total component cost if Perc is selected: $" + Math.round(totalPerc) + "</br></br>");

		//Output for Maxeon
		out.println("Array size needed with Maxeon: " + "</br>");
		out.println("Efficiency: " +eemax+"%"+ "</br>");
		out.println("Manufacturer: " +maxman + "</br>");
		out.println("Number of Modules: " +Math.round(arraymax) + "</br>");
		out.println("Total Array cost: $" +Math.round(nmnmax) + "</br>");
		out.println("Inverter and Battery Costs: $" + Math.round(inverterbatterymax) + "</br>");
		out.println("Total component cost if  Maxeon is selected: $" + Math.round(totalmax) + "</br></br>");

		//Output for AllMaxModule
		out.println("Array size needed with AllMaxModule: " + "</br>");
		out.println("Efficiency: " +eallmax+"%"+ "</br>");
		out.println("Manufacturer: " +mall + "</br>");
		out.println("Number of Modules: " +Math.round(aas) + "</br>");
		out.println("Total Array cost: $" +Math.round(nmnAm) + "</br>");
		out.println("Inverter and Battery Costs: $" + Math.round(inverterBatteryAllMax) + "</br>");
		out.println("Total component cost if AllMaxModule is selected: $" + Math.round(totalAllmax) + "</br></br>");
		
		
		//Output for JaSolar
		out.println("Array size needed with JaSolar: " + "</br>");
		out.println("Efficiency: " +ejasolar+"%"+ "</br>");
		out.println("Manufacturer: " +mja + "</br>");
		out.println("Number of Modules: " +Math.round(jaas) + "</br>");
		out.println("Total Array cost: $" +Math.round(nmnJa) + "</br>");
		out.println("Inverter and Battery Costs: $" + Math.round(inverterbatteryJa) + "</br>");
		out.println("Total component cost if JaSolar is selected: $" + Math.round(totalJa) + "</br></br>");

		
		
		//out.println("Module recommended is " + efficiencybest +  " --> " + "efficienct " +"%"+values.get(efficiencybest) + "</br></br></br></br>");
		
		//v = v.replaceAll("\\D+","");
	    //int t = Integer.parseInt(v);
	    //out.println(t); */ --%>

	
	</div>
	<div>
	
	</div>

</body>
</html>