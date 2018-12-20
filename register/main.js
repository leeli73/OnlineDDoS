var label_email = document.getElementsByClassName('emaillabel')[0];
var label_password = document.getElementsByClassName('passwordlabel')[0];
var email = document.getElementById('email');
var password = document.getElementById('password');
email.addEventListener('blur', function(){
    if(email.value){
        label_email.className = 'labelactive';
    }else{
        label_email.className = '';
    }
});
password.addEventListener('blur', function(){
    if(password.value){
        label_password.className = 'labelactive';
    }else{
        label_password.className = '';
    }
});
