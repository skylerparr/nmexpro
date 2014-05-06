/**
 *  2011-3-3 Yann
 *  please purchase a product every time.
 */
package nmex;

import flash.Lib;

class InAppPurchase extends NXObject{
	
	private static var instance:InAppPurchase;
	
	private function new(){
        super();
		nmex_system_in_app_purchase_init();
	}
	
	public static function getInstance():InAppPurchase{
		if(instance == null){
			instance = new InAppPurchase();
		}	
		return instance;
	}
	
	public function canPurchase():Bool{
		return nmex_system_in_app_purchase_can_purchase();
	}
	
	public function purchase(productID:String):Void{
		nmex_system_in_app_purchase_purchase(productID);
	}
	
  public function requestData(productIDs:Array<String>) : Void {
    nmex_system_in_app_purchase_request_product_data(productIDs.join(","));
  }

  public function restorePurchases() : Void {
    nmex_system_in_app_purchase_restore_purchases();
  }

	public function destroy():Void{
		nmex_system_in_app_purchase_release();
		instance = null;
	}
	
	static var nmex_system_in_app_purchase_init = Lib.load("nmeExtensions","nmex_system_in_app_purchase_init",0);
	static var nmex_system_in_app_purchase_purchase = Lib.load("nmeExtensions","nmex_system_in_app_purchase_purchase",1);
	static var nmex_system_in_app_purchase_can_purchase = Lib.load("nmeExtensions","nmex_system_in_app_purchase_can_purchase",0);
	static var nmex_system_in_app_purchase_release = Lib.load("nmeExtensions","nmex_system_in_app_purchase_release",0);
  static var nmex_system_in_app_purchase_request_product_data = Lib.load("nmeExtensions","nmex_system_in_app_purchase_request_product_data",1);
  static var nmex_system_in_app_purchase_restore_purchases = Lib.load("nmeExtensions","nmex_system_in_app_purchase_restore_purchases",0);
}
