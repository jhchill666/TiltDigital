package com.tiltdigital.log
{
	import com.tiltdigital.log.event.LoggerEvent;
	
	import flash.events.EventDispatcher;	

	/**
	 * @author Jamie.Hill
	 */
	public class LoggerBase extends EventDispatcher implements ILogger
	{	
		//___________________________________________________________________ PUBLIC METHODS
		
		/**
		 * Register / Unregister logger with the main application Logger
		 */
		public function registerWithLogger( logger:Logger ) : void
		{
			logger.addEventListener( LoggerEvent.TYPE_LOGEVENT, logHandler );
		}
		public function unregisterFromLogger( logger:Logger ) : void
		{
			logger.removeEventListener( LoggerEvent.TYPE_LOGEVENT, logHandler );
		}
		
		
		/**
		 * Main debugger methods - these should not be overridden.
		 */
		public function log( msg:String, object:Object=null, ...args ) : void
		{
			defaultLog( LogLevel.LOG, msg, object, args );
		}
		public function info( msg:String, object:Object=null, ...args ) : void
		{
			defaultLog( LogLevel.INFO, msg, object, args );
		}
		public function debug( msg:String, object:Object=null, ...args ) : void
		{
			defaultLog( LogLevel.DEBUG, msg, object, args );
		}
		public function warning( msg:String, object:Object=null, ...args ) : void
		{
			defaultLog( LogLevel.WARNING, msg, object, args );
		}
		public function error( msg:String, object:Object=null, ...args ) : void
		{
			defaultLog( LogLevel.ERROR, msg, object, args );
		}
		public function fatal( msg:String, object:Object=null, ...args ) : void
		{
			defaultLog( LogLevel.FATAL, msg, object, args );
		}
		
		
		//___________________________________________________________________ DEFAULT LOG METHOD
		
		/**
		 * Provides a default logging mechanism.  Should be overridden in ILogger implementations
		 * to provide an alternative logging mechanism, ie. to route to SOS Max, ro FireBug
		 */
		protected function defaultLog( level:String, msg:String, object:Object = null, ...args ) : void
		{
			trace( level, msg, args );
		}
		
		
		//___________________________________________________________________ PRIVATE METHODS
		
		/**
		 * Log events handler
		 */
		protected function logHandler( eo:LoggerEvent ) : void
		{
			switch( eo.logVO.level )
			{
				case LogLevel.LOG: 		log( 		eo.logVO.msg, eo.logVO.object, eo.logVO.args ); 	break;
				case LogLevel.INFO: 	info( 		eo.logVO.msg, eo.logVO.object, eo.logVO.args ); 	break;
				case LogLevel.ERROR: 	error( 		eo.logVO.msg, eo.logVO.object, eo.logVO.args ); 	break;
				case LogLevel.DEBUG: 	debug( 		eo.logVO.msg, eo.logVO.object, eo.logVO.args ); 	break;
				case LogLevel.WARNING: 	warning( 	eo.logVO.msg, eo.logVO.object, eo.logVO.args ); 	break;
				case LogLevel.FATAL: 	fatal( 		eo.logVO.msg, eo.logVO.object, eo.logVO.args ); 	break;
				
				default : 				log( 		eo.logVO.msg, eo.logVO.object, eo.logVO.args ); 	break;
			}	
		}
	}
}