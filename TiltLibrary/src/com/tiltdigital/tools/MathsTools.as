package com.tiltdigital.tools 
{

	/**
	 * @author jamie.hill
	 */
	public class MathsTools {
		
		
		/**
	     * Bounds a numeric value between 2 numbers.
	     * 
	     * @param value 		The value to clamp.
	     * @param min 			The min value of the range.
	     * @param max 			The max value of the range.
	     * @return a bound numeric value between 2 numbers.
	     */
	    public static function clamp( value:Number, min:Number, max:Number ) : Number 
	    {
		    if( isNaN( value )) 
		    {
    			throw new Error( "MathsTools.clamp, argument 'value' must not be 'null' or 'undefined' or 'NaN'" ) ;
    		}
    		if( isNaN( min )) min = value ;
    		if( isNaN( max )) max = value ;
    		
    		return Math.max( Math.min( value, max ), min );
    	}
    	
    	
    	
    	/**
    	 * Rounds and returns a number by a count of floating points.
    	 * 
	     * @param n 			The number to round.
	     * @param floatCount 	The count of number after the point.
	     * 
    	 * @return the floor value of a number by a count of floating points.
	     */
    	public static function floor( n:Number, floatCount:Number ) : Number 
    	{
		    if( isNaN( n )) 
    		{
			    throw new Error( "MathsTools.floor, Argument 'n' must not be 'null' or 'undefined'." );
    		}
		    var r:Number = 1 ;
    		var i:Number = -1 ;
		    while( ++i < floatCount ) 
		    {
    			r *= 10 ;
		    }
    		return Math.floor( n*r ) / r  ;
    	}
    	
    	
    	
    	/**
    	 * Rounds and returns a number by a count of floating points.
    	 * 
	     * @param n 			the number to round.
    	 * @param floatCount 	the count of number after the point.
    	 * 
    	 * @return the round of a number by a count of floating points.
	     */
    	public static function round( n:Number, floatCount:Number ) : Number 
    	{
    		if( isNaN( n )) 
    		{
    			throw new Error( "MathsTools.round, Argument 'n' must not be 'null' or 'undefined'." ) ;
    		}
    		var r:Number = 1 ;
    		var i:Number = -1 ;
    		while( ++i < floatCount ) r *= 10 ;
    		return Math.round( n * r ) / r  ;
    	}
    	
    	
    	
    	/**
	     * Returns a percentage or null.
	     * 
	     * @param nValue 		the current value.
    	 * @param nMax 			the max value.
    	 * 
    	 * @return a percentage value or null.
    	 */
    	public static function getPercent( nValue:Number = NaN, nMax:Number = NaN ) : Number 
    	{
    		var nP:Number = ( nValue / nMax ) * 100 ;
    		return ( isNaN( nP ) || !isFinite( nP )) ? NaN : nP ;
    	}
    	
    	
    	
    	
    	/**
	     * Returns 1 if the value is positive or -1.
	     * 
    	 * @param n 		the number to defined this sign.
    	 * 
	     * @return 1 if the value is positive or -1.
    	 */
    	public static function sign( n:Number ):Number 
    	{
	    	if (isNaN(n)) 
	    	{
    			throw new Error( "MathsTools.sign, Argument 'n' must not be 'null' or 'undefined'." );
		    }
    		return (( n < 0 ) ? -1 : 1 );
    	}
    	
    	
    	
    	/**
    	 * Constrains a 360 degrees based number to 360 degrees
    	 * 
    	 * @param n		The degree to constrain
    	 */
    	public static function threeSixty( n:Number ) : Number
    	{
    		return (( n %= 360 ) < 0 ) ? n + 360 : n;
    	}
    	
    	
    	
    	/**
    	 * Constrains a radians based number to 360 degrees
    	 * 
    	 * @param n		The degree to constrain
    	 */
    	public static function threeSixtyR( n:Number ) : Number
    	{
    		return (( n %= MathsTools.radians( 360 )) < 0 ) ? n + MathsTools.radians( 360 ) : n;
    	}
    	
    	
    	
    	
    	/**
    	 * Get a random number between a certain range
    	 * 
    	 * @param min		Minimum number
    	 * 
    	 * @param max		Maximum number
    	 */
    	public static function random( min:Number, max:Number ) : Number
    	{
    		return min + ( Math.random() * ( max - min ));
    	}
    	
    	
    	/**
    	 * convert radians to degrees
    	 * 
    	 * @param radians Number of radian to convert
    	 */
    	public static function degrees( radians:Number ) : Number
    	{
    		return radians * 180 / Math.PI + 90;
    	}
    	
    	
    	/**
    	 * convert degrees to radians
    	 * 
    	 * @param radians Number of degrees to convert
    	 */
    	public static function radians( degrees:Number ) : Number
    	{
    		return degrees * Math.PI / 180
    	} 
	}
}
