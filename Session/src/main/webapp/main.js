//Error or Success Messages in welcome div
const error1 = document.getElementById("errTxt1");
const setSuccess = (element, message) => {
	element.innerText = message;
	element.style.display = "block";
	element.style.backgroundColor = "lightgreen";
	element.style.color = "black";
	element.style.border = "1px solid green";
}
const setError = (element, message) => {
	element.innerText = message;
	element.style.display = "block";
}
var peopleFriend = document.querySelector("#peopleContacts");
peopleFriend.addEventListener("click", function() {
	setSuccess(error1,"Your Friend is Added In Your Chat List");
});

//Scroll button in Textarea
function scrollBottom() {
	if (document.querySelector(".messages").scrollTop >= 100) {
		document.querySelector(".msgtop").style.display = "block";
	}
	if (document.querySelector(".messages").scrollTop <= 20) {
		document.querySelector(".msgtop").style.display = "none";
	}
}

//Menu toggle for chat and people
const chat = document.querySelector("#chat");
const people = document.querySelector("#people");
chat.addEventListener('click', function() {
	document.querySelector("#chat-sidebar").style.display = "block";
	document.querySelector("#people-sidebar").style.display = "none";
	chat.style.borderLeft = "5px solid black";
	people.style.borderLeft = "none";
});
people.addEventListener('click', function() {
	document.querySelector("#people-sidebar").style.display = "block";
	document.querySelector("#chat-sidebar").style.display = "none";
	people.style.borderLeft = "5px solid black";
	chat.style.borderLeft = "none";
});

//People Search in people-sidebar
const peopleSearch = document.querySelector(".peopleSearch");
peopleSearch.addEventListener("search",function(){
	var pemail = document.getElementById("pemail").value;
	const xhr = new XMLHttpRequest();
	xhr.onload = function() {
		document.getElementById("peopleContacts").innerHTML = this.responseText;
	}
	xhr.open("GET", "AddPeople.jsp?q=" + pemail, true);
	xhr.send();
});

//Chat-sidebar AJAX
function friend() {
	
	const xhr = new XMLHttpRequest();
	xhr.onload = function() {
		document.getElementById("contacts").innerHTML = this.responseText;
	}
	xhr.open("GET", "friends.jsp", true);
	xhr.send();
}


//Contains AJAX
function chatFriend(n) {
	const xhr = new XMLHttpRequest();
	xhr.onload = function() {
		
		document.getElementById("contains").innerHTML = this.responseText;
		var element = document.querySelector('#ta');

		element.scrollTop = element.scrollHeight;
	}
	xhr.open("GET", "chat.jsp?femail="+n);
	xhr.send();
}

function msg(n){
	const xhr = new XMLHttpRequest();
	var msg = document.getElementById("sendMsg").value;	
	xhr.onload = function() {
		document.getElementById("ta").innerHTML = this.responseText;
	}
	xhr.open("GET","send.jsp?msg="+msg+"&fremail="+n);
	xhr.send();
}
