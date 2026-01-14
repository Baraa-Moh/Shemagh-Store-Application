<?

class OrderServices {

    public function __construct() {
       
    }   

    public function createOrder(int $user_id, float $total): ?int {
        return OrderData::createOrder($user_id, $total);
    }
    public function updateOrderStatus(int $order_id, string $status): bool {
        return OrderData::updateStatus($order_id, $status);
    }   
}