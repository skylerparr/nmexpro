/**
*  
*  if you want to use AD, you must change nme to set keyWindows.rootViewController
*  
*  */
package nmex;

import flash.Lib;

#if android
@:build( ShortCuts.mirrors( ) )
#end
class AD{
	#if android
	//android
	private static var _showAd_func:Dynamic;
	public static function showAd(id:String, x:Int=0, y:Int=0, size:Int=0, preLoad:Int=0):Void{
	    y = -1;
		if (_showAd_func == null)
			_showAd_func = openfl.utils.JNI.createStaticMethod("com.thoughtorigin.tictac.TicTacRumble.MainActivity", "showAd", "(Ljava/lang/String;IIII)V", true);
		var a = new Array<Dynamic>();
		a.push(id);
		a.push(x);
		a.push(y);
		a.push(size);
		a.push(preLoad);
		_showAd_func(a);
	}
    
	private static var _hideAd_func:Dynamic;
	public static function hideAd():Void{
		if (_hideAd_func == null)
			_hideAd_func = openfl.utils.JNI.createStaticMethod("com.thoughtorigin.tictac.TicTacRumble.MainActivity", "hideAd", "()V", true);
		var a = new Array<Dynamic>();
		_hideAd_func(a);
	}

    #if android
    @JNI("com.thoughtorigin.tictac.TicTacRumble.MainActivity", "showInterstitial")
    #end
    public static function showInterstitial(callbackObject: Dynamic, callbackFunc: String): Void {

    }

	private static var _initInterstitial_func:Dynamic;
	public static function initInterstitial(id: String):Void{
	    trace("haxe init interstitial");
		if (_initInterstitial_func == null)
			_initInterstitial_func = openfl.utils.JNI.createStaticMethod("com.thoughtorigin.tictac.TicTacRumble.MainActivity", "initInterstitial", "(Ljava/lang/String;)V", true);
		var a = new Array<Dynamic>();
		a.push(id);
        _initInterstitial_func(a);
	}

	#elseif ios
	// iphone
	private static var running:Bool = false;
	private static var isInit:Bool = false;

     public static function showAd(id:String, x:Int=0, y:Int=0, size:Int=0, preLoad:Int=0):Void{
        init(id, x, y, size);
        show();
     }

	public static function init(id:String = "",x:Int = 0,y:Int = 0, sizeType:Int=0):Void{
		nmex_ad_init(id,x,y,sizeType);
		isInit = true;
	}

	public static function show():Void{
		if(isInit && !running){
			nmex_ad_show();
			running = true;
		}
	}

	public static function hide():Void{
		if(isInit && running){
			nmex_ad_hide();
			running = false;
		}
	}

	public static function refresh():Void{
		if(isInit){
			nmex_ad_refresh();
		}
	}

	public static function showInterstitial(callbackObject: Dynamic, callbackFunc: String):Void{
	}

	public static function initInterstitial(id: String):Void{
	}
	
	static var nmex_ad_init = Lib.load("nmeExtensions","nmex_ad_init",4);
	static var nmex_ad_show = Lib.load("nmeExtensions","nmex_ad_show",0);
	static var nmex_ad_hide = Lib.load("nmeExtensions","nmex_ad_hide",0);
	static var nmex_ad_refresh = Lib.load("nmeExtensions","nmex_ad_refresh",0);

	#else
    public static function showAd(id:String, x:Int=0, y:Int=0, size:Int=0, preLoad:Int=0):Void{

    }
	#end

}