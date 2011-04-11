package com.tiltdigital.log.loggers
{
	import com.tiltdigital.log.ILogger;
	import com.tiltdigital.log.Logger;
	import com.tiltdigital.log.LoggerBase;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.XMLSocket;	

	/**
	 * @author Jamie.Hill
	 */
	public class SOSLogger extends LoggerBase implements ILogger
	{
		private var _socket : XMLSocket;
		private var _socketConnected : Boolean;

		/**
		 * SOSLogger creates a xml socket connection to SOS Max, so that
		 * colour coding of LogLevels can be implemented for Logging to SOS Max.
		 * 
		 * @see http://solutions.powerflasher.com/products/sosmax/
		 */
		public function SOSLogger()
		{
			super();
			
			//establish socket connection
			_socket = new XMLSocket();
            _socket.addEventListener( Event.CONNECT, onConnect );
			_socket.addEventListener( IOErrorEvent.IO_ERROR, onError );
			_socket.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onError );
			_socket.connect( "localhost", 4444 );
		}
		
		
		//_____________________________________________________________ PUBLIC METHODS
		
		
		/**
		 * Register / Unregister logger with the main application Logger
		 */
		override public function registerWithLogger( logger:Logger ) : void
		{
			info( this+".registerWithLogger( "+logger+" )" );
			
			super.registerWithLogger( logger );
		}
		
		override public function unregisterFromLogger( logger:Logger ) : void
		{
			info( this+".unregisteredFromLogger( "+logger+" )" );
			
			super.unregisterFromLogger( logger );
		}
		

		//_____________________________________________________________ PRIVATE METHODS
		
		/**
		 * Route log to SOS Max, unless not connected then route to default logger
		 */
		override protected function defaultLog( level:String, msg:String, object:Object = null, ...args ) : void
		{
			if( _socketConnected ) 
			{
				_socket.send( "!SOS<showMessage key='"+level+"'><![CDATA["+msg+"]]></showMessage>\n" );  
			}
			else
			{
				super.defaultLog( level, msg, object, args );
			}
		}
		
		
		/**
		 * Socket connection error handler
		 */
		private function onError( eo:Event ) : void
		{
        	trace( "Error in SOSAppender: " + eo );
        	
        	_socketConnected = false;
        }

		/**
		 * Socket connection success handler
		 */
        private function onConnect( eo:Event ) : void
        {
        	_socketConnected = true; 
        	
			_socket.send( "!SOS<showMessage key='info'>SOS Max - Socket connected!</showMessage>\n" );
		}
	}
}