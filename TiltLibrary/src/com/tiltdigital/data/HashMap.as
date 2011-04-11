package com.tiltdigital.data
{
	import flash.utils.Dictionary;		

	/**
	 * @author Jamie.Hill
	 * 
	 * An object that maps keys to values.  A map cannot contain duplicate keys;
	 * each key can map to at most one value.
	 */
	public class HashMap 
	{
		protected var _size							: uint;
		protected var _keys 						: Dictionary;
		protected var _values 						: Dictionary;
		
		/**
		 * Creates a new empty hash map object.
		 */
		public function HashMap ()
		{
			clear();
		}
		
		
		/**
		 * Clears the current HashMap
		 */
		protected function clear () : void
		{
			_size 	= 0;
			_keys 	= new Dictionary ( true );
			_values = new Dictionary ( true );
		}
	
	
		
		/**
	     * @param key	 	key object whose presence in this map is to be tested
	     * @return true 	if this map contains a mapping for the specified key
	     */
		public function containsKey ( key:* ) : Boolean
		{
			if( key == null )
				throw new Error( this + ".containsKey() failed. key can't be null" );

			return ( _keys[ key ] != null );
		}



		/**
	     * @param value	 	value object whose presence in this map is to be tested
	     * @return true 	if this map contains a mapping for the specified value
	     */
		public function containsValue ( value:* ) : Boolean
		{
			return ( _values[ value ] != null );
		}



	    /**
	     * Associates the specified value with the specified key in this map
	     *
	     * @param key 		key with which the specified value is to be associated
	     * @param value 	value to be associated with the specified key
	     * 
	     * @return the previous value associated with key, or null if there was no
	     * 			mapping for key.
	     */
		public function put ( key:*, value:* ) : *
		{
			var oldVal:*, count:uint;
			
			if( key != null )
			{
				oldVal = null;
				
				if( containsKey( key )) oldVal = remove( key );
				
				_size ++;
				
				count 				= _values[ value ];
				_values[ value ] 	= ( count > 0 ) ? ( count + 1 ) : 1;
				_keys  [ key ] 		= value;
				
				return oldVal;

			} else
			{
				throw new Error( this + ".put() failed. key can't be null" );
			}
		}



		/**
	     * Returns the value to which the specified key is mapped,
	     * or null if this map contains no mapping for the key.
	     * 
	     * @param key 	the key whose associated value is to be returned
	     * @return 		the value to which the specified key is mapped, or
	     *         		null if this map contains no mapping for the key
	     */
		public function get ( key:* ) : *
		{
			if( key == null )
				throw new Error( this + ".get() failed. key can't be null" );

			return _keys[ key ];
		}
		
		
		
		/**
	     * Removes the mapping for a key from this map if it is present
	     * 
	     * @param key	key whose mapping is to be removed from the map
	     * 
	     * @return 		the previous value associated with key, or
	     *         		null if there was no mapping for key
	     */
		public function remove ( key : * ) : *
		{
			var value:*, count : uint;
			
			if( containsKey( key )) 
			{
				_size --;
				
				value 	= _keys[ key ];
				count 	= _values[ value ];
				
				if( count > 1 ) _values[ value ] = ( count - 1 );
				else 			delete _values[ value ];
				
				delete _keys[ key ];
			}
			
			return value;
		}
		
		
		
		/**
	     * @return the number of key-value mappings in this map
	     */
		public function size () : Number
		{
			return _size;
		}
		
		
		
		/**
	     * @return an array of the keys contained in this map
	     */
		public function getKeys () : Array
		{
			var array:Array, key:*;
			
			array = new Array();
			
			for each ( key in _keys ) array.push( key );
			
			return array;
		}
		
		
		
		/**
		 * Retrieve the key for a particular value
		 * 
		 * @param value		The value of the key yoou want to retrieve
		 */
		public function getKey( value:* ) : *
		{
			return _values[ value ];
		}



		/**
	     * @return an array of the values contained in this map
	     */
		public function getValues () : Array
		{
			var array:Array, value:*;
			
			array = new Array();
			
			for each( value in _values ) array.push( value );
			
			return array;
		}
		
		
		
		/**
		 * Returns the string representation of this instance.
		 * 
		 * @return the string representation of this instance
		 */
		public function toString () : String 
		{
			return String( "[ HashMap :: "+this+" ]" );
		}
		
	}
}