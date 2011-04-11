package com.tiltdigital.log.loggers
{
	import com.tiltdigital.log.ILogger;
	import com.tiltdigital.log.Logger;
	import com.tiltdigital.log.LoggerBase;
	
	import flash.external.ExternalInterface;	

	/**
	 * @author Jamie.Hill
	 */
	public class FireBugLogger extends LoggerBase implements ILogger
	{
		public function FireBugLogger() { super(); }
		
		
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
		
		
		//___________________________________________________________________ PRIVATE METHODS
		
		
		/**
		 * Route log to FireBug, but if not connected route to default logger
		 */
		override protected function defaultLog( level:String, msg:String, object:Object = null, ...args ) : void
		{
			var lines:Array, i:uint, l:uint;
			
			if ( ExternalInterface.available ) {
				
				lines = String( msg ).split( /\n/ );
				i = 0;
				l = lines.length;
				while ( i < l ) {
					
					ExternalInterface.call( "console.log('" + level + ": " + lines[ i ] + "')" );
					i++;  
				} 
			}
			else
			{
				super.defaultLog( level, msg, object, args );
			}
		}
	}
}