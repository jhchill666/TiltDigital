package com.tiltdigital.data.iterators 
{

	/**
	 * @author Jamie.Hill
	 * 
	 * The ObjectIterator Class provides a convenient way to iterate
	 * through each property of an Object instance as with a Collection instance.
	 */
	public class ObjectIterator implements IIterator 
	{
		protected var _object : Object;
		protected var _keys : Array;
		protected var _index : Number;
		protected var _size : uint;
		protected var _removed : Boolean;


		/**
		 * Creates a new iterator to iterate through each property of the passed-in object.
		 * 
		 * @param o			Object iterator's target
		 */
		public function ObjectIterator ( o:Object )
		{
			_object 	= o;
			_keys 		= new Array();
			
			for( var k:String in _object ) _keys.push( k );
			
			_index 		= -1;
			_size 		= _keys.length;
			_removed 	= false;
		}
		
		
		
		/**
		 * @return Boolean 		true if the Object contains another element
		 */
		public function hasNext () : Boolean
		{
			 return (( _index + 1 ) < _size );
		}
		
		
		
		/**
		 * @return Object		The next Object in the iteration
		 */		
		public function next () : *
		{
			if( !hasNext() )
				throw new Error( this + " has no more elements at index "+( _index + 1 ));

			_removed 	= false;
			
			return _object[ _keys[ ++_index ]];
		}
		
		
		
		/**
		 * Removes an element from the ObjectIterator
		 */		
		public function remove () : void
		{
			if( !_removed )
			{
				if( delete _object[ _keys[ _index ]] )
				{
					_index --;
					_removed = true;

				} else
				{
					throw new Error( this + " remove() can't delete " + _object + "." + _keys[ _index ] );
				}

			} else
			{
				throw new Error( this + ".remove() has been already called in this iteration." );
			}
		}
	}
}
