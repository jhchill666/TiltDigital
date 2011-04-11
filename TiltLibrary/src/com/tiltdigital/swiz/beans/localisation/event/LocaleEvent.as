package com.tiltdigital.swiz.beans.localisation.event 
{
	import com.tiltdigital.swiz.beans.loader.vo.LoaderVO;
	
	import flash.events.Event;

	/**
	 * @author Jamie.Hill
	 */
	public class LocaleEvent extends Event 
	{
		public static const COMPLETE				: String = "locale_load_complete";
		
		/**
		 * @param type 				The type of event
		 */
		public function LocaleEvent ( type:String )
		{
			super( type );
		}
	}
}
