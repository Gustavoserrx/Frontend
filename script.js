document.getElementById("envio").addEventListener("click", login);

        function login(e){
            e.preventDefault();

            const body = document.querySelector("body");
            const script1 = document.createElement("script");
            script1.src = 'https://cdn.jsdelivr.net/npm/sweetalert2@11';

            const script2 = document.createElement("script");

            const username = document.getElementById("username").value;
            const pass = document.getElementById("pass").value;
            let xhr = new XMLHttpRequest();

            xhr.open("POST", "login.php", true);
            xhr.setRequestHeader("Content-type", 'application/x-www-form-urlencoded');

            xhr.onreadystatechange = function(){
                if(xhr.readyState === 4 && xhr.status === 200){
                    script2.innerHTML = xhr.responseText;
                    body.appendChild(script1);
                    body.appendChild(script2);
                }
            };

            xhr.send(`username=${encodeURIComponent(username)}&pass=${encodeURIComponent(pass)}`);
        }