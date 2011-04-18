<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*, support.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Provide Degrees</title>
<link type="text/css" rel="stylesheet" href="styles/stylesheet.css" />

</head>
<body>
	<% 
		session.setAttribute("universityLocation", request.getParameter("universityLocation"));
	
		support sp = new support();
		
		String realPath = "/data/universities.txt";
		
		String path = config.getServletContext().getRealPath(realPath);
		Vector universities = sp.getUniversities(path);
	
		boolean found = false;
	
		for(Object v : universities) {
			
			Vector tuple = (Vector)v;
			String location = tuple.get(0).toString();
			
			if(location.equals(session.getAttribute("universityLocation").toString()))
			{
				universities = (Vector)tuple.get(1); //set university to a valid list of universities
				found = true;
				break;
			}
		}
		
		if(!found)
		{
			universities.clear();
		}
		
		int size = universities.size();	//grab the number of universities
		int approx = size / 3; 			//divide up the universities
		
		int iStart = 0; 
		int iEnd = approx; 
		int jStart = iEnd;
		int jEnd = approx * 2; 
		int kStart = jEnd; 
		int kEnd = size;
		
		if(size < 3)
		{
			iEnd = size; 
			jEnd = 0;
			kEnd = 0;
		}
			
		char currentLetter = 0;
		
		String countryCode = "";
		if(session.getAttribute("countrycode") != null) 
		{
			countryCode = session.getAttribute("countrycode").toString();
		}
	%>
	
	<h4>Hello <%= session.getAttribute("firstName") + " " + session.getAttribute("lastName") + ", " %></h4>
	
	<div id="progress">
		<ul>
			<li>Citizen of: <%= session.getAttribute("citizenship") %></li>
			<li>Resident of: <%= session.getAttribute("residence") %></li>
			<li><%= session.getAttribute("address") %></li>
			<li><%= session.getAttribute("city") + " " + session.getAttribute("state") + " " + session.getAttribute("zipcode") %></li>
			<li><%= countryCode + " " + session.getAttribute("areacode") + " " + session.getAttribute("phoneNumber") %></li>
		</ul>
	</div>
	
	<h3>Add a degree:</h3>
	
	<h4>Universities in <%= session.getAttribute("universityLocation") %>:</h4>
	
	<form id="addUniversityForm" method="post" action="provideDegreesDisciplines.jsp" style="display: none">
		<ul>
			<li>
				<label for="addUniversity">University Name:</label><br />
				<input type="text" id="addUniversity" name="universityName" />
			</li>
			<li><br /><input type="submit" value="Submit" /></li>
		</ul>
	</form>
	
	<div id="universites" class="threeColumn">

		Can't find your university? <a href="#" id="addLink">Add it.</a>
		<br /><br />
		
		<ul>
		<% 
			if(universities.size() == 0)
			{
				out.println("<strong>D'oh!<br/> No results for this location.</strong>");
				out.println("<li><a href='provideDegreesLocations.jsp'> Go Back </a></li>");
			}
			else
			{
			    for(; iStart < iEnd; iStart++) {
			    	
			    	if(currentLetter == 0 || universities.get(iStart).toString().charAt(0) > currentLetter)
			    	{
			    		currentLetter = universities.get(iStart).toString().charAt(0);
			    		out.println("<li class='index'><strong>" + currentLetter + "</strong></li>");
			    	}
			        out.println("<li><a href='provideDegreesDisciplines.jsp?universityName=" + universities.get(iStart) + "'>" + universities.get(iStart) + "</a></li>");
			    }
			}
		%>
		</ul>
		<ul>
		<% 
			if(universities.size() != 0)
			{
			    for(; jStart < jEnd; jStart++) {
			    	
			    	if(currentLetter == 0 || universities.get(jStart).toString().charAt(0) > currentLetter)
			    	{
			    		currentLetter = universities.get(jStart).toString().charAt(0);
			    		out.println("<li class='index'><strong>" + currentLetter + "</strong></li>");
			    	}
			        out.println("<li><a href='provideDegreesDisciplines.jsp?universityName=" + universities.get(jStart) + "'>" + universities.get(jStart) + "</a></li>");
			    }
			}
		%>
		</ul>
		<ul>
		<% 
			if(universities.size() != 0)
			{
			    for(; kStart < kEnd; kStart++) {
			    	
			    	if(currentLetter == 0 || universities.get(kStart).toString().charAt(0) > currentLetter)
			    	{
			    		currentLetter = universities.get(kStart).toString().charAt(0);
			    		out.println("<li class='index'><strong>" + currentLetter + "</strong></li>");
			    	}
			        out.println("<li><a href='provideDegreesDisciplines.jsp?universityName=" + universities.get(kStart) + "'>" + universities.get(kStart) + "</a></li>");
			    }
			}
		%>
		</ul>
	</div>

	<script type="text/javascript" src="http://yui.yahooapis.com/combo?3.3.0/build/yui/yui-min.js"></script>
	<script type="text/javascript">

		YUI().use('node', function(Y) {
			
			
			Y.one("#addLink").on('click', function() {
				
				Y.one("#universites").setStyle('display', 'none');
				Y.one("#addUniversityForm").setStyle('display', 'block');
			});
		});
	
	</script>
</body>
</html>