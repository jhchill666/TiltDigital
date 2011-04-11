package com.tiltdigital.log
{

	/**
	 * @author Jamie.Hill
	 */
	public class LogVO
	{	
		public var level : String;
		public var msg : String;
		public var object : Object;
		public var args : Array;
		
		/**
		 * @param level		A <see>LogLevel</see> constant
		 * @param msg		Log message to output
		 * @param object	[optional] Adds string representation of specified <see>Object</see>
		 * @param arg		[optional] Additional arguments
		 */
		public function LogVO( level:String, msg:String, object:Object, ...args )
		{
			this.level 	= level;
			this.msg 	= msg;
			this.object = object;
			this.args 	= args;	
		}
	}
}