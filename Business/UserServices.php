<?

class UserServices
{
    
    public function __construct() {
        
    }
    public function validateLoginInput(string $username, string $password){
        $errors = [];
        
        if (empty($username) || empty($password)) {
            $errors[] = 'جميع الحقول مطلوبة.';
        }
        
        return [
            'valid' => empty($errors),
            'errors' => $errors
        ];
    }

    public function authenticateUser(string $username, string $password):array{

        $user = UserData::VerifyLogin($username, $password);
    
    if ($user) {
        return [
            'success' => true, 
            'message' => 'تم تسجيل الدخول بنجاح.', 
            'user' => $user
        ];
    }
    
    return [
        'success' => false, 
        'message' => 'اسم المستخدم أو كلمة المرور غير صحيحة.', 
        'user' => null
    ];
}
public function validateRegisterInput(string $username, string $email, string $password, string $confirm):array{
        $errors = [];
        
        
        if (empty($username) || empty($email) || empty($password) || empty($confirm)) {
            $errors[] = 'جميع الحقول مطلوبة.';
            return ['valid' => false, 'errors' => $errors]; // Return early
        }
        
        
        if (strlen($username) < 3) {
            $errors[] = 'اسم المستخدم يجب أن يكون 3 أحرف على الأقل.';
        }
        
        if (strlen($username) > 50) {
            $errors[] = 'اسم المستخدم يجب ألا يتجاوز 50 حرفاً.';
        }
        
        
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $errors[] = 'البريد الإلكتروني غير صالح.';
        }
        
        
        if (strlen($password) < 6) {
            $errors[] = 'كلمة المرور يجب أن تكون 6 أحرف على الأقل.';
        }
        
        
        if ($password !== $confirm) {
            $errors[] = 'كلمتا المرور غير متطابقتين.';
        }
        
        return [
            'valid' => empty($errors),
            'errors' => $errors
        ];
    }
    public function registerUser(string $username, string $email, string $password): array{

        
        if(UserData::getUserByUsername($username)){
            return ['success' => false, 'message' => 'اسم المستخدم موجود بالفعل.', 'user' => null];
        }

        
        if(UserData::getUserByEmail($email)){
            return ['success' => false, 'message' => 'البريد الإلكتروني مسجل بالفعل.', 'user' => null];
        }

        
        $userId = UserData::CreateUser($username, $email, $password);
        
        if ($userId > 0) {
            $user = UserData::GetUserByID($userId);
            return ['success' => true, 'message' => 'تم إنشاء الحساب بنجاح.', 'user' => $user];
        }
        
        return ['success' => false, 'message' => 'حدث خطأ أثناء إنشاء الحساب.', 'user' => null];
    }
}