const token = localStorage.getItem("token");

async function register() {
  const name = document.getElementById("name").value;
  const email = document.getElementById("email").value;
  const password = document.getElementById("password").value;
  const res = await fetch("http://localhost:3000/api/users/register", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ name, email, password }),
  });
  const data = await res.json();
  alert(data.message);
}

async function loadProfile() {
  const res = await fetch("http://localhost:3000/api/users/profile", {
    headers: { authorization: token },
  });
  const user = await res.json();
  document.getElementById("name").value = user.name;
  document.getElementById("email").value = user.email;
}

async function updateUser() {
  const name = document.getElementById("name").value;
  const email = document.getElementById("email").value;
  const password = document.getElementById("password").value;
  const res = await fetch("http://localhost:3000/api/users/update", {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
      authorization: token,
    },
    body: JSON.stringify({ name, email, password }),
  });
  const data = await res.json();
  alert(data.message);
}

async function deleteUser() {
  const res = await fetch("http://localhost:3000/api/users/delete", {
    method: "DELETE",
    headers: { authorization: token },
  });
  const data = await res.json();
  alert(data.message);
  localStorage.removeItem("token");
  window.location.href = "index.html";
}

loadProfile();
