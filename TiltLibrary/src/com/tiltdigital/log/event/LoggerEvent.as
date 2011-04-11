package com.tiltdigital.log.event
{
	import com.tiltdigital.log.LogVO;
	
	import flash.events.Event;	

	/**
	 * @author Jamie Hill
	 */
	public class LoggerEvent extends Event
	{
		public static const TYPE_LOGEVENT : String = "logger_event_log";
		
		public var logVO:LogVO;
		
		public function LoggerEvent( type:String, logVO:LogVO )
		{
			this.logVO = logVO;
			
			super( type );
		}
	}
}