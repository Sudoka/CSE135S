<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="support.*, java.util.*, CSE135S.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title></title>
<link type="text/css" rel="stylesheet" href="styles/stylesheet.css" />

</head>
<body>
	<h4>Hello <%= request.getParameter("firstName") + " " + request.getParameter("lastName") + "," %></h4>
	
	<div id="progress">
		<ul>
			<li>Citizen of: <%= request.getParameter("citizenship") %></li>
		</ul>
	</div>
	
	<h3>Select Country of Residence:</h3>
	
	<% 
		String first = request.getParameter("firstName");
		String last = request.getParameter("lastName");
		String middle = request.getParameter("middleInitial");
		String citizenship = request.getParameter("citizenship");
	
		String url = "address.jsp?firstName=" + first + "&lastName=" + last + "&middleInitial=" + middle +
						"&citizenship=" + citizenship;
				
		Vector<String> countries = SQL.getCountries();
		
		int size = countries.size();	//grab the number of countries
		int approx = size / 3; 			//divide up the countries
		
		int iStart = 0; 
		int iEnd = approx; 
		int jStart = iEnd;
		int jEnd = approx * 2; 
		int kStart = jEnd; 
		int kEnd = size; 
		
		
		char currentLetter = 0;
	%>
	
	<a href='<%= url + "&residence=" + citizenship %>'>I am also a resident of <%= citizenship %></a><br />
	
	<div id="countries" class="threeColumn">
		
		<ul id="column1">
		<%
		    for(; iStart < iEnd; iStart++) {
		    	
		    	if(currentLetter == 0 || countries.get(iStart).charAt(0) > currentLetter)
		    	{
		    		currentLetter = countries.get(iStart).charAt(0);
		    		out.println("<li class='index'><strong>" + currentLetter + "</strong></li>");
		    	}
		        out.println("<li><a href='" + url + "&residence=" + countries.get(iStart) + "'>" + countries.get(iStart) + "</a></li>");
		    }
		%>
		</ul>
		<ul id="column2">
		<%
		    for(; jStart < jEnd; jStart++) {
		    	
		    	if(currentLetter == 0 || countries.get(jStart).charAt(0) > currentLetter)
		    	{
		    		currentLetter = countries.get(jStart).charAt(0);
		    		out.println("<li class='index'><strong>" + currentLetter + "</strong></li>");
		    	}
		        out.println("<li><a href='" + url + "&residence=" + countries.get(jStart) + "'>" + countries.get(jStart) + "</a></li>");
		    }
		%>
		</ul>
		<ul id="column3">
		<%
		    for(; kStart < kEnd; kStart++) {
		    	
		    	if(currentLetter == 0 || countries.get(kStart).charAt(0) > currentLetter)
		    	{
		    		currentLetter = countries.get(kStart).charAt(0);
		    		out.println("<li class='index'><strong>" + currentLetter + "</strong></li>");
		    	}
		        out.println("<li><a href='" + url + "&residence=" + countries.get(kStart) + "'>" + countries.get(kStart) + "</a></li>");
		    }
		%>
		</ul>
	</div>
</body>
</html>