package com.tiltdigital.swiz.beans.localisation.model 
{
	import flash.events.EventDispatcher;

	/**
	 * @author Jamie.Hill
	 */
	public class LocaleModel extends EventDispatcher
	{
		public var data 						: Object				= new Object();
		
		
		
		/**
		 * Clears all Locales' data
		 */
		public function clear () : void
		{
			data		= new Object();
		} 
	}
}
