async function login() {
  console.log("Dentro da função login");
  const email = document.getElementById("email").value;
  const password = document.getElementById("password").value;

  console.log("Email:", email);
  console.log("Password:", password);

  //testanto se os campos estão vazios

  if (!email && !password) {
    alert("Campos de email e senha obrigatórios.");
    return;
  }
  if (!email) {
    alert("Campo de email obrigatório.");
    return;
  }
  if (!password) {
    alert("Campo de senha obrigatório.");
    return;
  }

  const response = await fetch("http://localhost:3000/api/login/login", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ email, password }),
  });

  const data = await response.json();
  console.log("Resposta do servidor: ", data);

  if (response.status === 200) {
    localStorage.setItem("token", data.token);
    localStorage.setItem("role", data.role);
    alert("Login bem-sucedido!");
    if (data.role === "admin") {
      window.location.href = "profile.html";
    } else {
      window.location.href = "profile.html";
    }
  } else {
    alert("Erro no login: " + data.message);
  }
}
