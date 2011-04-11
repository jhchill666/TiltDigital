package com.tiltdigital.log.loggers
{
	import com.tiltdigital.log.ILogger;
	import com.tiltdigital.log.Logger;
	import com.tiltdigital.log.LoggerBase;	

	/**
	 * @author Jamie.Hill
	 */
	public class TraceLogger extends LoggerBase implements ILogger
	{
		public function TraceLogger() { super(); }
		
		
		/**
		 * Register / Unregister logger with the main application Logger
		 */
		override public function registerWithLogger( logger:Logger ) : void
		{
			trace( this+".registerWithLogger( "+logger+" )" );
			
			super.registerWithLogger( logger );
		}
		override public function unregisterFromLogger( logger:Logger ) : void
		{
			trace( this+".unregisteredFromLogger( "+logger+" )" );
			
			super.unregisterFromLogger( logger );
		}
	}
}