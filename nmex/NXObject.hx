package nmex;

import flash.events.EventDispatcher;
import flash.events.Event;
import flash.Lib;

class NXObject extends EventDispatcher{
	
	public static var eventProxy:EventDispatcher = new EventDispatcher();
	public static var objects:Array<NXObject> = new Array();
	public static var eventHandleInit:Bool = false;

	public function new(){
        super();
		objects.push(this);
		if(!eventHandleInit){
			initEventHandle();
			eventHandleInit = true;
		}
	}
	
	private static function initEventHandle(){
		nmex_set_event_handle(externEventHandle);
	}
	
	private static function externEventHandle(inEvent:Dynamic){
		
		var type:Int = Std.int(Reflect.field( inEvent, "type" ) );
		var code:Int = Std.int(Reflect.field( inEvent, "code" ) );
		var value:Int = Std.int(Reflect.field( inEvent, "value" ) );
		var data:String = Std.string(Reflect.field( inEvent, "data" ) );
		var event:NXEvent;
		switch(type){
			case  0: event = new NXEvent(NXEvent.UN_KNOWN_EVENT, code, value, data);
			
			//in app purchase
			case  1: event = new NXEvent(NXEvent.IN_APP_PURCHASE_SUCCESS, code, value, data);
			case  2: event = new NXEvent(NXEvent.IN_APP_PURCHASE_FAIL, code, value, data);
			case  3: event = new NXEvent(NXEvent.IN_APP_PURCHASE_CANCEL, code, value, data);
			case  4: event = new NXEvent(NXEvent.IN_APP_PURCHASE_DATA, code, value, data);
			case  5: event = new NXEvent(NXEvent.IN_APP_PURCHASE_DATA_FAIL, code, value, data);
			
			//gamecenter
			case  6: event = new NXEvent(NXEvent.AUTH_SUCCEEDED, code, value, data);
			case  7: event = new NXEvent(NXEvent.AUTH_FAILED, code, value, data);
			case  8: event = new NXEvent(NXEvent.LEADERBOARD_VIEW_OPENED, code, value, data);
			case  9: event = new NXEvent(NXEvent.LEADERBOARD_VIEW_CLOSED, code, value, data);
			case  10: event = new NXEvent(NXEvent.ACHIEVEMENTS_VIEW_OPENED, code, value, data);
			case  11: event = new NXEvent(NXEvent.ACHIEVEMENTS_VIEW_CLOSED, code, value, data);
			case  12: event = new NXEvent(NXEvent.SCORE_REPORT_SUCCEEDED, code, value, data);
			case  13: event = new NXEvent(NXEvent.SCORE_REPORT_FAILED, code, value, data);
			case  14: event = new NXEvent(NXEvent.ACHIEVEMENT_REPORT_SUCCEEDED, code, value, data);
			case  15: event = new NXEvent(NXEvent.ACHIEVEMENT_REPORT_FAILED, code, value, data);
			case  16: event = new NXEvent(NXEvent.ACHIEVEMENT_RESET_SUCCEEDED, code, value, data);
			case  17: event = new NXEvent(NXEvent.ACHIEVEMENT_RESET_FAILED, code, value, data);
      case  18: event = new NXEvent(NXEvent.MATCHMAKING_VIEW_CLOSED, code, value, data);
      case  19: event = new NXEvent(NXEvent.MATCH_STARTED, code, value, data);
      case  20: event = new NXEvent(NXEvent.MATCH_DATA_RECEIVED, code, value, data);
      case  21: event = new NXEvent(NXEvent.MATCH_PLAYER_DISCONNECTED, code, value, data);
      case  22: event = new NXEvent(NXEvent.IN_APP_PURCHASE_RESTORE, code, value, data);
      case  24: event = new NXEvent(NXEvent.LOAD_TURN_BASED_MATCHES_SUCCESS, code, value, data);
      case  25: event = new NXEvent(NXEvent.LOAD_TURN_BASED_MATCHES_FAIL, code, value, data);
      case  26: event = new NXEvent(NXEvent.LOAD_PLAYER_DATA_SUCCESS, code, value, data);
      case  27: event = new NXEvent(NXEvent.LOAD_PLAYER_DATA_FAIL, code, value, data);
      case  28: event = new NXEvent(NXEvent.UPDATE_MATCH_SUCCESS, code, value, data);
      case  29: event = new NXEvent(NXEvent.UPDATE_MATCH_FAIL, code, value, data);
      case  30: event = new NXEvent(NXEvent.GET_MATCH_DATA_SUCCESS, code, value, data);
      case  31: event = new NXEvent(NXEvent.GET_MATCH_DATA_FAIL, code, value, data);
      case  32: event = new NXEvent(NXEvent.TURN_BASED_MATCH_INVITE, code, value, data);
      case  33: event = new NXEvent(NXEvent.TURN_BASED_MATCH_ENDED, code, value, data);
      case  34: event = new NXEvent(NXEvent.TURN_BASED_MATCH_TURN, code, value, data);
      case  35: event = new NXEvent(NXEvent.REMATCH_STARTED, code, value, data);
      case  36: event = new NXEvent(NXEvent.REMATCH_FAILED, code, value, data);
      case  37: event = new NXEvent(NXEvent.LOAD_FRIEND_IDS_SUCCESS, code, value, data);
      case  38: event = new NXEvent(NXEvent.LOAD_FRIEND_IDS_FAIL, code, value, data);

      // audiosession
      case  23: event = new NXEvent(NXEvent.AUDIO_PLAYBACK_STATE_CHANGED, code, value, data);

			default: event = new NXEvent(NXEvent.UN_KNOWN_EVENT, code, value, data);
		}
		
		//to do
		for (i in 0...objects.length){
			objects[i].dispatchEvent(event);
		}
		
	}
	
	static var nmex_set_event_handle = Lib.load("nmeExtensions","nmex_set_event_handle",1);
	
}
