<?php
require_once __DIR__.'/../Web/Others/init.php';
require_once __DIR__.'/../Business/User.php';

class UserController{

    private $errors = [];
    private $userService;

    public function __construct(){
        $this->userService = new UserServices();
    }

    public function login(){
        if($_SERVER['REQUEST_METHOD']==='POST'){

            $username = trim($_POST['username'] ?? '');
        $password = $_POST['password'] ?? '';

        $validation = $this->userService->validateLoginInput($username, $password);

        if (!$validation['valid']) {
            $this->errors = array_merge($this->errors, $validation['errors']);
            return;
        }

        $result = $this->userService->authenticateUser($username, $password);

        if($result['success']){

             $user = $result['user'];


            $_SESSION['user'] = $user;

            if($user->isAdmin()){
                 header("Location: admin.php");
        exit;
            }
            else {
    header("Location: index.php");
            }
            exit;
        }
        else {
            $this->errors[] = $result['message'];
        }
        }
    }

    public static function requireNonUser(){
        if (isset($_SESSION['user'])) {
        
            header("Location: notAllowed.php");
            exit;
    }
}


    public static function requireNonAdmin() {
    
   if (isset($_SESSION['user'])) {
        
        if ($_SESSION['user']->isAdmin()) {
            header("Location: notAllowed.php");
            exit;
        }
    }
}

public static function requireAdmin() {
    if (!isset($_SESSION['user'])) {
        header("Location: login.php");
        exit;
    }
    
    
    if (!$_SESSION['user']->isAdmin()) {
        header("Location: notAllowed.php");
        exit;
    }
}

public static function requireLogin() {
    
    if (!isset($_SESSION['user'])) {
        header("Location: login.php");
        exit;
    }
}
    
    public function register():void{
        if($_SERVER['REQUEST_METHOD']==='POST'){

            $username = trim($_POST['username'] ?? '');
            $email = trim($_POST['email'] ?? '');
            $password = $_POST['password'] ?? '';
            $confirm = $_POST['confirm-password'] ?? '';

            $validation = $this->userService->validateRegisterInput($username, $email, $password, $confirm);

            if(!$validation['valid']){
                $this->errors = array_merge($this->errors, $validation['errors']);
                return;
            }

            $result = $this->userService->registerUser($username, $email, $password);

            if($result['success']){
                header("Location: login.php");
                exit;
            } else {
                $this->errors[] = $result['message'];
            }
        }
    }

    public function getErrors():array{
        return $this->errors;
    }
}