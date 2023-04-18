<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.UUID" %>
<%@ page import="org.eclipse.paho.client.mqttv3.IMqttClient" %>
<%@ page import="org.eclipse.paho.client.mqttv3.MqttClient" %>
<%@ page import="org.eclipse.paho.client.mqttv3.MqttConnectOptions" %>
<%@ page import="org.eclipse.paho.client.mqttv3.MqttMessage" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Message Sent</title>
</head>
<body>
	<%
		String message=request.getParameter("message");
		String topic=request.getParameter("topic");
		String publisherId = UUID.randomUUID().toString();
		IMqttClient publisher = new MqttClient("tcp://test.mosquitto.org:1883", publisherId);
		
		MqttConnectOptions options = new MqttConnectOptions();
		options.setCleanSession(true);
		options.setConnectionTimeout(10);
		publisher.connect(options);
		
		MqttMessage msg = new MqttMessage(message.getBytes());
        msg.setQos(0);
        msg.setRetained(true);
        publisher.publish(topic, msg);
        out.print("Message Sent: "+ message);
	%>
</body>
</html>