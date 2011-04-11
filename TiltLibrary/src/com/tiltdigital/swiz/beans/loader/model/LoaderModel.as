package com.tiltdigital.swiz.beans.loader.model 
{
	import com.tiltdigital.swiz.beans.loader.model.*;
	
	import flash.events.EventDispatcher;

	/**
	 * @author Jamie.Hill
	 */
	public class LoaderModel extends EventDispatcher
	{
		public var cache 						: VirtualCache				= new VirtualCache();
		public var queue						: LoaderQueue				= new LoaderQueue();
		public var stats						: LoaderStats				= new LoaderStats();
		
		/**
		 * Constructor --
		 */
		public function LoaderModel ()
		{
			clear();
		}
		
		
		//___________________________________________________________________________________ PUBLIC METHODS
		
		
		
		/**
		 * Clears model to initialstate
		 */
		public function clear () : void
		{
			stats.clear();
			cache.clear();
		} 
	
		
		//___________________________________________________________________________________ PRIVATE METHODS
	}
}
