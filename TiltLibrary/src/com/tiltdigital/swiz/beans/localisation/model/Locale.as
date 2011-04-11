package com.tiltdigital.swiz.beans.localisation.model 
{
	import com.tiltdigital.tools.StringTools;	
	
	/**
	 * @author Jamie.Hill
	 */
	public class Locale 
	{
		public var lc				: String; // language code ie. en
		public var sc				: String; // character set ie. Latn
		public var cc				: String; // country code  ie. GB
		public var id				: String; // id for this locale ie. 'en-Latn-GB'
		public var xml				: XML;	  // main locale specific xml file
		
		public var content			: Object		= new Object();
		
		public function Locale( lc:String, sc:String, cc:String, xml:XML )
		{
			this.lc		= lc.toLowerCase();
			this.sc		= StringTools.firstLetterUpper( sc );
			this.cc		= cc.toUpperCase();
			this.id		= String( lc+"-"+sc+"-"+cc );
			this.xml	= xml;
		}
		
		
		
		/**
		 * Retrieve content
		 * 
		 * @param key			Lolcat key for this content
		 * @param warn			If true, empty string returned if key doesn't exist
		 */
		public function getContent( key:String, warn:Boolean = true ) : String
		{
			var _content:String;
			
			try{ _content = content[ key ]; }
			
			catch( er:* )
			{
				if( warn ) 	_content 	= String( key + " :: missing!" );
				else		_content	= "";
			}
			
			return _content;
		}
		
		
		
		
		/**
		 * Retrieve setting for this locale
		 * 
		 * @param key			Lolcat key for this setting
		 * @param warn			If true, empty string returned if key doesn't exist
		 */
		public function getSetting( key:String, warn:Boolean = true ) : String
		{
			var _content:String;
			
			try{ _content = content[ key ]; }
			
			catch( er:* )
			{
				if( warn ) 	_content 	= String( key + " :: missing!" );
				else		_content	= "";
			}
			
			return _content;
		}
	}
}
