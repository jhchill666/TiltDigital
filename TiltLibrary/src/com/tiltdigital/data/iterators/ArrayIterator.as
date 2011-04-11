package com.tiltdigital.data.iterators 
{
	/**
	 * @author Jamie.Hill
	 * 
	 * The ArrayIterator Class provides a convenient way to iterate through each entry of an Array
	 */
	public class ArrayIterator implements IListIterator 
	{
		protected var _array 						: Array;
		protected var _size 						: uint;
		protected var _index 						: uint;
		protected var _added 						: Boolean;
		protected var _removed 						: Boolean;

		/**
		 * Creates a new iterator for the passed-in array.
		 * 
		 * @param array			Array iterator's target
		 * @param index			Iterator's start index
		 */
		public function ArrayIterator ( array:Array, index:uint = 0 )
	    {
	    	if( array == null )
				throw new Error( "Array target of " + this + "can't be null." );

	    	if( array.length < index )
	    		throw new Error( "'"+index+" is not a valid index for an array with '"+array.length+"' length." );
		
			_array 		= array;
	        _size 		= array.length;
	        _index 		= ( index - 1 );
			_removed 	= _added = false;
		}

		
		
		/**
		 * @return Boolean 		true if the Array contains another element
		 */
	    public function hasNext () : Boolean
	    {
	        return (( _index + 1 ) < _size );
	    }
	    
	    

		
		/**
		 * @return Object		The next Array in the iteration
		 */	
	    public function next () : *
	    {
	    	if( !hasNext() )
				throw new Error( this + " has no more elements at index "+(_index+1) );
			
	    	_removed 	= _added = false;
			
			return _array[ ++_index ];
	    }
		
		
		
		/**
		 * Removes an element from the ArrayIterator
		 */
		public function remove () : void
		{
			if( !_removed )
			{
				_array.splice( _index --, 1 );
				_size --;
				_removed = true;

			} else
			{
				throw new Error( this + ".remove() has been already called in this iteration." );
			}
		}



		/**
		 * Adds elements to the ArrayIterator
		 */
		public function add ( o:Object ) : void
		{
			if( !_added )
			{
				_array.splice ( _index + 1, 0, o );
				_size++;
				_added = true;

			} else
			{
				throw new Error( this + ".add() has been already called in this iteration." );
			}
		}

		
		
		/**
		 * @return Boolean 		true if the Array contains previous element
		 */
		public function hasPrevious () : Boolean
		{
			return ( _index >= 0 );
		}



		/**
		 * @return the next element in the array
		 */
		public function nextIndex () : uint
		{
			return ( _index + 1 );
		}



		/**
		 * @return the previous element in the array
		 */
		public function previous () : *
		{
			if( !hasPrevious() )
				throw new Error( this + " has no more element at '" + ( _index ) + "' index." );
			
	    	_removed 	= _added = false;
			
			return _array[ _index -- ];
		}
		
		

		/**
		 * @return the previous index number
		 */
		public function previousIndex () : uint
		{
			return _index;
		}



		/**
		 * Explicity set object into array at current index
		 */
		public function set ( o:Object ) : void
		{
			if( !_removed && !_added )
				
				_array[ _index ] = o;

			else
				
				throw new Error( this+".add() or "+this+".remove() have already been called in this iteration" );
		}
	}
}
