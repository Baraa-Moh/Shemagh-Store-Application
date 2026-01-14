<?
require_once __DIR__.'/../Data/ProductData.php';

class ProductServices {
    
    public function __construct() {
        
    }   

    public function editProductById(int $id, string $name, float $price1, ?float $price2, string $image) {
        return ProductData::editProductById($id, $name, $price1, $price2, $image);
    }
    public function deleteProductById(int $id) {
        return ProductData::deleteProductById($id);
    }
    public function addProduct(string $name, float $price1, ?float $price2, string $image): void {
        ProductData::addProduct($name, $price1, $price2, $image);
    }
    public function getAllProducts(): array {
        return ProductData::getAllProducts();
    }
    public function getProductById(int $id): ?Product {
        return ProductData::getProductById($id);
    }
}