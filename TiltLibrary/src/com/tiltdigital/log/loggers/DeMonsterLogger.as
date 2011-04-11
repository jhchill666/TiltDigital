package com.tiltdigital.log.loggers
{
	import com.tiltdigital.log.ILogger;
	import com.tiltdigital.log.Logger;
	import com.tiltdigital.log.LoggerBase;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * @author Jamie.Hill
	 */
	public class DeMonsterLogger extends LoggerBase implements ILogger
	{

		private var _debugger : MonsterDebugger;
		
		
		/**
		 * Debugs output to the DeMonsterDebugger debugging console
		 * 
		 * <see>http://demonsterdebugger.com/</see>
		 */
		public function DeMonsterLogger()
		{ 
			super();
			
			_debugger = new MonsterDebugger( this );
		}
		
		
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
		
		
		
		
		/**
		 * Main debugger methods - these should not be overridden.
		 */
		override public function log( msg:String, object:Object=null, ...args ) : void
		{
			defaultLog( msg, 0xBEFFBE, object, args );
		}
		override public function info( msg:String, object:Object=null, ...args ) : void
		{
			defaultLog( msg, 0xFFFF3D, object, args );
		}
		override public function debug( msg:String, object:Object=null, ...args ) : void
		{
			defaultLog( msg, 0x21BCFE, object, args );
		}
		override public function warning( msg:String, object:Object=null, ...args ) : void
		{
			defaultLog( msg, 0xFF6B00, object, args );
		}
		override public function error( msg:String, object:Object=null, ...args ) : void
		{
			defaultLog( msg, 0xFF0E0E, object, args );
		}
		override public function fatal( msg:String, object:Object=null, ...args ) : void
		{
			defaultLog( msg, 0xde0000, object, args );
		}
		
		
		
		
		
		//_____________________________________________________________ PRIVATE METHODS
		
		/**
		 * Route log to SOS Max, unless not connected then route to default logger
		 */
		private function deMonsterLog( msg:String, colour:uint, object:Object=null, ...args ) : void
		{
			var _obj:Object;
			
			_obj	= ( object ) ? object : this ;

			MonsterDebugger.trace( _obj, msg, colour );  
		}
		
		
		
		/**
		 * Override the defaultlogger with nothing to kill it
		 */
		override protected function defaultLog( level:String, msg:String, object:Object = null, ...args ) : void{}
	}
}