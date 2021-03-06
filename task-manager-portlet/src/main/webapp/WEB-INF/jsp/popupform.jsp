<%--

  $Id$
  
  Copyright (C) 2011 Arcusys Oy - http://www.arcusys.fi/
  
  This file is part of Arcusys Taskmanager.
  
  Arcusys Taskmanager is free software: you can redistribute it and/or modify
  it under the terms of the GNU Affero General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
  
  Arcusys Taskmanager is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Affero General Public License for more details.
  
  You should have received a copy of the GNU Affero General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.

 --%>

<%@ include file="init.jsp"%>

<portlet:renderURL var="ajaxURL"
	windowState="<%= LiferayWindowState.EXCLUSIVE.toString()%>">
	<portlet:param name="myaction" value="getState" />
</portlet:renderURL>

<script type="text/javascript"> 
/* the times that iframe loads different srcs */
var loadingTimes = 0;
/* the source url that iframe loads */
var formUrl = "${tasklink}";

var taskId = getTaskId(formUrl);
var taskType = getTaskType(formUrl);
var refreshTimer;

$(document).ready(function(){
	
	if(taskType == 'PATask' || taskType == 'Notification') {
		removeRefreshTimer();
		setRefreshTimer();
	} else { // for PIPATask process
		$('#taskform').load(function(){
			loadingTimes += 1;
			
			if(loadingTimes > 1) {
				setTimeout('closeWindow()', 500);
			}
			
			
		});
	}
	
							
});

/**
 * Set auto refresh timer, which checks the task status automatically
 */
function setRefreshTimer() {
	refreshTimer = setInterval('ajaxGetTaskStatus()', 1000);
}

/**
 * Remove the auto refresh timer
 */
function removeRefreshTimer() {
	clearInterval(refreshTimer);
}

/**
 * Execute ajax query to get task status in Post way, and parse the Json format response
 */
function ajaxGetTaskStatus() {
	var url="<%= ajaxURL %>";

	$.post(url, {taskId:taskId}, function(data) {
		var obj = eval('(' + data + ')');
		var json = obj.response;		
		taskStatus = json["taskState"];
		
		if(taskStatus == 'COMPLETED') {
			setTimeout('closeWindow()', 500);
		}
	});
	
}
/**
 * Returns to the main portlet page
 */
function closeWindow() {
	window.close();
}

/**
 * Checks the operation of forms finished or not. Usually the form operation is
 * finished if the source url forwards to another url such as empty.jsp
 */
function checkForm() {
	//var url = $('#taskform').attr("src");
	
	if(loadingTimes > 1) {
		setTimeout('returnMainPage()', 500);
	}
	
	loadingTimes += 1;
}

function getTaskId(url) {
	var from = url.indexOf("id=");
	var to = url.indexOf("type=");	
	var taskId = url.substring(from+3, to-1);
	
	return taskId;
}

function getTaskType(url) {
	var from = url.indexOf("type=");
	var to = url.indexOf("url=");	
	var taskType = url.substring(from+5, to-1);
	
	return taskType;
}

</script>
<div id="frameform" style="position:absolute; top:0px; left:0px; right:0px; bottom:0px; width:100%; height:100%;">
<iframe src="<c:out value="${tasklink}" />" id="taskform" name="taskform" style="width:100%; height:100%;" frameborder="0" scrolling="auto" ></iframe>
</div>



