const error1 = document.getElementById("errTxt1");
const setError = (element, message) => {
	element.innerText = message;
	element.style.display = "block";
}
const setSuccess = (element, message) => {
	element.innerText = message;
	element.style.display = "block";
	element.style.backgroundColor = "lightgreen";
	element.style.color = "green";
}
var status1 = document.getElementById("status1").value;
if (status1 == "failed") {
	setError(error1, 'Incorrect Username or Password!');
}
var status2 = document.getElementById("status2").value;
if (status2 == "success") {
	setSuccess(error1, 'Account Created');
} else if (status2 == "failed") {
	setError(error1, 'Registration Failed!');
} else if (status2 == "accountExist") {
	setError(error1, 'User is already exists!');
} else if (status2 == "empty") {
	setError(error1, "Fill all the Spaces");
}
//Login-Logout toggle
function hide1() {
	document.querySelector(".hide1").style.display = "block";
	document.querySelector(".hide2").style.display = "none";
}
function hide2() {
	document.querySelector(".hide1").style.display = "none";
	document.querySelector(".hide2").style.display = "block";
}
//Password show or hide for login
const ltogglePassword = document.querySelector("#togglePassword");
const rtogglePassword = document.querySelector("#rtogglePassword");
const rctogglePassword = document.querySelector("#rctogglePassword");
const showHidelpwd = document.querySelector("#lpwd");
const showHiderpwd = document.querySelector("#rpwd");
const showHidercpwd = document.querySelector("#rcpwd");
const showHidePwd = (id) => {
	const type = id.getAttribute("type") === "password" ? "text" : "password";
	id.setAttribute("type", type);
}
ltogglePassword.addEventListener("click", function () {
	showHidePwd(showHidelpwd);
});
rtogglePassword.addEventListener("click", function () {
	showHidePwd(showHiderpwd);
});
rctogglePassword.addEventListener("click", function () {
	showHidePwd(showHidercpwd);
});
