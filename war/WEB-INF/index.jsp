<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.todo.jdo.TodoListJdo"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Todo Project</title>

<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js"></script>
<script type="text/javascript"
	src="http://ajax.cdnjs.com/ajax/libs/underscore.js/1.1.4/underscore-min.js"></script>
<script type="text/javascript"
	src="http://ajax.cdnjs.com/ajax/libs/backbone.js/0.3.3/backbone-min.js"></script>
<link rel="stylesheet"
	href="//cdnjs.cloudflare.com/ajax/libs/animate.css/3.2.0/animate.min.css">

<link rel="apple-touch-icon" href="apple-touch-icon.png">
<!-- Place favicon.ico in the root directory -->
<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="css/icons.css">
<link rel="stylesheet" href="css/normalize.css">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/forms.css">
<link rel="stylesheet" href="bootstrap/css/sweetalert.css">
<script src="bootstrap/js/sweetalert.min.js"></script>
<script src="js/vendor/modernizr-2.8.3.min.js"></script>
<style>
body {
	overflow: hidden;
}

button.btn.btn-danger.deleteBtn {
	height: 45px;
	margin-top: -5px;
}

.scroll {
	height: 638px;
	overflow: auto;
}

.appendNotes {
	margin-left: 200px;
	margin-top: -200px;
	width: 500px;
}

.addbutton span {
	margin-right: 0px;
}




.round-button {
	width:25%;
}
.round-button-circle {
	width: 10%;
	height:0;
	padding-bottom: 10%;
    border-radius: 50%;
	border:10px solid #cfdcec;
    overflow:hidden;
    
    background: #4679BD; 
    box-shadow: 0 0 3px gray;
}
.round-button-circle:hover {
	background:#30588e;
}
.round-button a {
    display:block;
	float:left;
	width:100%;
	padding-top:50%;
    padding-bottom:50%;
	line-height:1em;
	margin-top:-0.5em;
    
	text-align:center;
	color:#e2eaf3;
    font-family:Verdana;
    font-size:1.2em;
    font-weight:bold;
    text-decoration:none;
}



.addbutton {
	border-radius: 25px;
	background-color: #4CAF50;
	border: none;
	color: white;
	font-size: 16px;
	margin: 4px 2px;
	margin-top: 71px;
	 margin-left: 21px;
 	padding: 8px 15px;
}

.slide {
	list-style-type: none;
	margin: 0;
	padding: 0;
    width: 78px;
	background-color: #F8F97B;
	height: 738px;
	margin-top: -10px;
	margin-left: -7px;
}

}
li a {
	display: block;
	color: #000;
	padding: 8px 0 8px 16px;
	text-decoration: none;
}

li a:hover {
	background-color: #555;
	color: white;
}

.modal-body {
	position: relative;
	padding: 2px;
}

#results {
	margin-left: 200px;
	width: 600px;
	margin-top: -208px;
}

#pendingTask {

    background-color: #F8F97B;
    padding: 9px;
    color: white;
    margin-left: -8px;
    width: 71px;

}

#completedTask {

    background-color: #4CAF50;
    padding: 9px;
    color: white;
    margin-left: -8px;
    width: 71px;

}
</style>
<script>

	
	$( document ).ready(function() {
		loadPreviousData();
		$('.addbutton').click(function(){
			 $('#notes').focus(); 
		  });
	});
	
	
	
	var textBox = "";

	function loadPreviousData() {

		$
				.ajax({
					url : "getNotes",
					type : "POST",
					beforeSend : function(xhr) {
						xhr.setRequestHeader("Accept", "application/json");
						xhr.setRequestHeader("Content-Type",
										"application/json");
					},
					success : function(response) {
						console.log(response);

						for (var i = 0; i < response.length; i++) {
							console.log(response[i].key.id);

							console.log(response[i].notes);

						

							textBox += '<li id="'+response[i].key.id+'" class="input-group input-group-lg notesDiv">'
									
									+ '<div class="icon-addon addon-lg">'

									+ '<input type="text" id="'+response[i].key.id+'" name="notes" class = "'+response[i].key.id+'"value = "'+response[i].notes+'"onblur="updateNotes('+response[i].key.id+')"></input></div>'
									+ '<span class="input-group-btn"><button class="btn btn-danger deleteBtn" type="button" onclick="deleteNotes('+response[i].key.id+')"><span class="glyphicon glyphicon-trash"</button></span>'
									//+'<a href="#"><span class="glyphicon glyphicon-trash"></span></a>' 

									+ '</li>'

						}

						$("#results").append(textBox);

					}
				});
	

	}
	function updateNotes(noteId)
	{
		console.log("update ID "+noteId);
		//var notes = $(".notes").val();
		var notes = $('.'+noteId).val();
		
		var json = { "noteId" : noteId,"notes":notes };
		$
		.ajax({

			url : "updateNote",
			data : JSON.stringify(json),
			type : "POST",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("Accept", "application/json");
				xhr
						.setRequestHeader("Content-Type",
								"application/json");
			},
			success : function(data) {

				$('#showmsg').html(msg);
				$('#voice-box').css( 'display' , 'block' );
				$('#voice-box').delay(3000).fadeOut(3000);
			


				
			}
		});

		
	}
	function deleteNotes(noteId)
	{
		
		console.log("delete"+noteId);
		var json = { "noteId" : noteId };
		$
		.ajax({

			url : "deleteNote",
			data : JSON.stringify(json),
			type : "POST",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("Accept", "application/json");
				xhr
						.setRequestHeader("Content-Type",
								"application/json");
			},
			success : function(data) {


				
			}
		});
		$('#'+noteId).remove();

		
	}
	
	function callAddTask() {

		var createdOn = new Date();
		/* var isDeleted = "false";
		var status = "inProcess"; */
		var notes = $("#notes").val();
		console.log("CreatedOn " + createdOn + " notes " + notes);
		
		var notes = $('#notes').val();
		var json = {
			"taskNotes" : notes,
			"createdOn" : createdOn
		};

		$
				.ajax({
					url : "addNotes",
					data : JSON.stringify(json),
					type : "POST",
					beforeSend : function(xhr) {
						xhr.setRequestHeader("Accept", "application/json");
						xhr
								.setRequestHeader("Content-Type",
										"application/json");
					},
					success : function(data) {


						console.log(JSON.stringify(data))
						console.log(data.key.id);

						
						$(
								'<li id="'+data.key.id+'"class="input-group input-group-lg notesDiv">'
										+ '<div class="icon-addon addon-lg">'
										+ '<input type="text" name="notes" class="'+data.key.id+'" id="'+data.key.id+'" value = "'+data.notes+'" onblur="updateNotes('+data.key.id+')"></input></div>'
										+ '<span class="input-group-btn"><button class="btn btn-danger deleteBtn" type="button" onclick="deleteNotes('+data.key.id+')"><span class="glyphicon glyphicon-trash"</button></span>'
										//+'<a href="#"><span class="glyphicon glyphicon-trash"></span></a>' 
										+ '</li>').appendTo("ul");

					}
				});

	}

	
</script>

</head>




<body>

	<div class="slide">

		<button type="button" class="addbutton" data-toggle="modal"
			data-target="#myModal">
			<span> + </span>
		</button>
		
		<!--  <div class="navbar-collapse collapse">
						<ul class="nav navbar-nav">
							<li><a id="pendingTask" href="/adminqueuegae">Pending Task</a></li>
							<li  class= "active"><a id="completedTask" href="/emaillistener">Completed Task</a></li>
</ul> -->
 

		<div class="container">
<div class="completedTask"></div>

			<ul class="scroll" id="results"></ul>
		</div>
		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Add your task here</h4>
					</div>
					<div class="modal-body">

						<input type="text" style="border: hidden; padding: 2px"
							name="notes" id="notes" required></input>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn" id="addNotes"
							style="color: white; font-weight: bold; background-color: #4CAF50;"
							data-dismiss="modal" onclick="callAddTask()">Done</button>
						<!--           <button type="button" class="btn btn-success" data-dismiss="modal">Cancel</button>
 -->
					</div>
				</div>

			</div>
		</div>


	</div>
	</div>


</body>
</html>
