const loginForm = document.getElementById('login-form');
const errorMessage = document.getElementById('error-message');

loginForm.addEventListener('submit', (event) => {
  event.preventDefault();

  const username = document.getElementById('username').value;
  const password = document.getElementById('password').value;

  // Simulate form validation (replace this with your actual validation logic)
  if (username === '' || password === '') {
    errorMessage.textContent = 'Please fill in all fields';
    return;
  }

  // Simulate login logic (replace this with your actual login functionality)
  if (username !== 'admin' || password !== 'password123') {
    errorMessage.textContent = 'Invalid username or password';
    return;
  }

  // Successful login (redirect or show success message)
  alert('Login successful!');
});
