package com.tiltdigital.tools
{
	/**
	 * @author jamie.hill
	 */
	public class StringTools
	{
		/**
		 * trim all whitespace from a the beginning and end of a string
		 * 
		 * @param _str		String to trim
		 */			
		public static function trim( _str:String ) : String
		{
			return StringTools.trimLeft( StringTools.trimRight( _str ));
		}



		/**
		 * trim all white space from the beginning of a string
		 */
		public static function trimLeft( _str:String ) : String 
		{
			return _str.replace( /^\s+/, "" );
		}



		/**
		 * trim all white space from the end of a string
		 */
		public static function trimRight( _str:String ) : String
		{
			return _str.replace( /\s+$/, "" );
		}



		/**
		 * Replaces all instances of the replace string in the input string
		 * 
		 * @param _str			The string to replace copy in
		 * @param find			The copy that you want to remove
		 * @param replace		The copy to replace in teh string
		 */
		public static function replace( _str:String, _find:String, _replace:String ):String
		{
			return _str.split( _find ).join( _replace );
		}
		
		
		
		/**
		 * count number of words in a string
		 * 
		 * @param str		The string to count
		 */
		public static function wordCount( _str:String ) : Number
		{
			return _str.match( /\b\w+\b/g ).length;
		}
		
	
		
		/**
		 * get the extension from a file path
		 */
		public static function getExtension( str:String ) : String
		{
			var parts:Array = str.split( /\./g );
			
			return String( "." + parts[ parts.length-1 ].toLowerCase() );
		}
		
		
		
		/**
		 * get a boolean value from a string
		 */
		public static function getBoolean( str:String ) : Boolean
		{
			str = StringTools.trim( str );
			
			if( str == "true" )
			{
				return true;
			}else{
				return false;
			}
		}
		
		
		
		/**
		 * strip all html tags from a string
		 * 
		 * NB// this will not strip any html comments!
		 * 
		 * @param str		The string to strip
		 */
		public static function stripHtml( str:String ) : String
		{
		    return str.replace( /<\/?[^>]+>/igm, "" );
		}
		
		
		
		/**
		 * strip all html tags from a string
		 * 
		 * NB// this will not strip any html comments!
		 * 
		 * @param str		The string to strip
		 */
		public static function firstLetterUpper( _str:String ) : String
		{
			return _str.substring( 0 , 1 ).toUpperCase() + _str.substring( 1 ).toLowerCase();
		}
	}
}