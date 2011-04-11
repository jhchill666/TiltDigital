package com.tiltdigital.swiz.beans.loader.model 
{
	/**	 * @author Jamie.Hill	 */	public class LoaderConfig 
	{
		public static var EXTENSION_REGEXP					: RegExp 	= /\.([^\.]+)(?=($|\?|\#))/;		
		public static var DISPLAY_EXTENSIONS				: Array 	= [ ".swf", ".jpg", ".jpeg", ".jpe", ".gif", ".png" ];
		public static var SOUND_EXTENSIONS					: Array 	= [ ".mp3" ];
		public static var DATA_EXTENSIONS					: Array		= [ ".xml", ".dae" ];
		public static var CONCURRENTSTREAMS					: int		= 1;
		public static var USE_CACHE							: Boolean	= true;
		public static var AUTO_START						: Boolean	= false;
		public static var USE_ACCURATE_PROGRESS				: Boolean 	= true;
		public static var IF								: int		= 100;			}}