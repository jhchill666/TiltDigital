package com.tiltdigital.swiz.beans.loader.event 
{
	import com.tiltdigital.swiz.beans.loader.vo.LoaderVO;
	
	import flash.events.Event;

	/**
	 * @author Jamie.Hill
	 */
	public class LoaderEvent extends Event 
	{
		public static const START_LOAD				: String = "start_initial_load";
		public static const FIND_FILE_SIZE 			: String = "find_assets_file_size";
		public static const LOAD_ASSETS	 			: String = "start_load_assets";
		public static const LOAD_COMPLETE			: String = "load_complete";
		public static const FILE_COMPLETE			: String = "file_complete";
		public static const PROGRESS				: String = "load_progress";
		
		public var vo								: *;
		
		/**
		 * @param type 				The type of event
		 * @param vo				LoadaerVO instance containing all necessary properties
		 */
		public function LoaderEvent ( type:String, vo:LoaderVO = null )
		{
			super( type );
			
			this.vo 	= vo;
		}
	}
}
