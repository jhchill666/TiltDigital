package com.tiltdigital.swiz.beans.loader.model 
{
	import com.tiltdigital.swiz.beans.loader.vo.LoaderVO;

	[Bindable]
	public class LoaderStats
	{
		public var totalBytes						: uint;
		public var bytesLoaded						: uint;
		public var startTime						: uint;
		public var timeElapsed						: uint; // in milliseconds
		public var progress							: Number;
		public var filesLoaded						: int;
		public var filesTotal						: int;
		public var currentLoader 					: LoaderVO;
		public var percent							: Number;

		/**
		 * The LoaderStats Class houses all LoaderDecorator updatable statistics
		 */		 
		public function LoaderStats ()
		{
			clear();
		}
		

		
		/**
		 * 
		 */
		public function clear () :void
		{
			totalBytes		= 0;
			bytesLoaded		= 0;
			startTime		= 0;
			timeElapsed		= 0;
			progress		= 0;
			filesLoaded		= 0;
			filesTotal		= 0;
			percent			= 0;
			currentLoader	= null;
		}
		
		
		
		
		/**
		 * 
		 */
		public function dump ( tab:String = "" ) : String 
		{
			return 	tab + "Stats {\n" +
					tab + "\ttotalBytes:\t" + totalBytes + ";\n" +
					tab + "\tbytesLoaded:\t" + bytesLoaded + ";\n" +
					tab + "\tstartTime:\t" + startTime + ";\n" +
					tab + "\ttimeElapsed:\t" + timeElapsed + ";\n" +
					tab + "\tprogress:\t" + progress + ";\n" +
					tab + "\tfilesLoaded:\t" + filesLoaded + ";\n" +
					tab + "\tfilesTotal:\t" + filesTotal + ";\n" +
					tab + "}\n";
		}
	}
}
