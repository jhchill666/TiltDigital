package com.tiltdigital.log
{
	import com.tiltdigital.log.event.LoggerEvent;
	
	import flash.events.EventDispatcher;	

	/**
	 * @author Jamie.Hill
	 */
	public class Logger extends EventDispatcher
	{	
		/** Storage for the singleton instance. **/  
		private static const _instance : Logger = new Logger( SingletonLock ); 
		
		/**
		 * Default Logger type is TraceLogger ( traces to output window )
		 */
		public var _loggerType : ILogger;
		
		/**
		 * Boolean flag enabling/disabling logging
		 */
		private var _enable : Boolean = true;
		
		/**
		 * Currently used ILogger type
		 */
		private var _currentLogger : ILogger;

		
		/** 
		 * Constructor --
		 *  
		 * @param lock The Singleton lock class to pevent outside instantiation. 
		 **/  
		public function Logger( lock:Class )  
		{  
			// Verify that the lock is the correct class reference.  
			if( lock != SingletonLock )  
			{  
				throw new Error( "Invalid Singleton access." );  
			}
		}
		
		
		//_____________________________________________________________ PUBLIC METHODS
		
		
		/**
		 * Register a new ILogger type to use as default logger
		 * 
		 * @param logger	ILogger instance to use as new logger
		 */
		public static function registerLogger( logger:ILogger ) : void
		{
			logger.registerWithLogger( _instance );
		}
		
		public static function unregisterLogger( logger:ILogger ) : void
		{
			logger.unregisterFromLogger( _instance );
		}
		
		
		/**
		 * Enable/disable logging output
		 */
		public static function set enable( val:Boolean ) : void { _instance._enable = val; }
		public static function get enable() : Boolean { return _instance._enable; }
		
		/**
		 * Get current ILogger
		 */
		public static function get currentILogger() : ILogger { return _instance._currentLogger; }
		
		
		//_____________________________________________________________ LOG METHODS

		
		public static function log( msg:String, object:Object = null, ...args ) : void
		{
			_instance.dispatchLog( LogLevel.LOG, msg, object, args );
		}
		
		public static function info( msg:String, object:Object = null, ...args ) : void
		{
			_instance.dispatchLog( LogLevel.INFO, msg, object, args );
		}
		
		public static function debug(msg:String, object:Object = null, ...args ) : void
		{
			_instance.dispatchLog( LogLevel.DEBUG, msg, object, args );
		}
		
		public static function warning( msg:String, object:Object = null, ...args ) : void
		{
			_instance.dispatchLog( LogLevel.WARNING, msg, object, args );
		}
		
		public static function error( msg:String, object:Object = null, ...args ) : void
		{
			_instance.dispatchLog( LogLevel.ERROR, msg, object, args );
		}
		
		public static function fatal( msg:String, object:Object = null, ...args ) : void
		{
			_instance.dispatchLog( LogLevel.FATAL, msg, object, args );
		}
		
		//_______________________________________________________________ INTERNAL
		
		/**
		 * Dispatches the recieved log 
		 */
		private function dispatchLog( level:String, msg:String, object:Object, ...args ) : void
		{
			if( _instance._enable )
			{
				var vo:LogVO = new LogVO( level, msg, object, args );
				
				dispatchEvent( new LoggerEvent( LoggerEvent.TYPE_LOGEVENT, vo ));
			}
		}
	}
}

class SingletonLock{}