function generateRandomPassword(length = 10) {
    const uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const lowercase = "abcdefghijklmnopqrstuvwxyz";
    const digits = "0123456789";
    const allChars = uppercase + lowercase + digits;
    let password = "";

    // Aseguramos que la contraseña cumpla con tener al menos una mayúscula, minúscula y dígito.
    password += uppercase[Math.floor(Math.random() * uppercase.length)];
    password += lowercase[Math.floor(Math.random() * lowercase.length)];
    password += digits[Math.floor(Math.random() * digits.length)];

    for (let i = 3; i < length; i++) {
        password += allChars[Math.floor(Math.random() * allChars.length)];
    }

    // Opcional: revolver el string para que los primeros caracteres no sean fijos
    password = password.split('').sort(() => Math.random() - 0.5).join('');
    return password;
}

document.getElementById("generatePassword").addEventListener("click", function() {
    const newPassword = generateRandomPassword(10);
    document.getElementById("password").value = newPassword;
});