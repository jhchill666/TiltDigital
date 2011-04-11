package com.tiltdigital.log
{
	import flash.events.IEventDispatcher;	
	
	/**
	 * @author Jamie.Hill
	 */
	public interface ILogger extends IEventDispatcher
	{
		/**
		 * Register / Unregister logger with the main application Logger
		 */
		function registerWithLogger( logger:Logger ) : void;
		function unregisterFromLogger( logger:Logger ) : void;
	}
}