<?

class CartServices{
    public function __construct(){
        
    }

    public function addToCart($product, $quantity, $size){
        CartData::addToCart($product, $quantity, $size);
    }   
    public function removeItem($item){
        CartData::removeItem($item);
    }
}