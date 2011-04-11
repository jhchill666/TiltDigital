package com.tiltdigital.data.iterators
{

	/**
	 * @author Jamie.Hill
	 * 
	 * An iterator for lists
	 */
	public interface IListIterator extends IIterator
	{
		/**
		 * Adds the specified element into the list
		 */
		function add ( o:Object ) : void;
		
		/**
		 * @return true if the list iterator has more elements when
		 * 			traversing the list in the reverse direction.
		 */
		function hasPrevious () : Boolean;
		
		/**
		 * @return 	the index of the element that would be returned
		 * 			by a subsequent call to next, or list size if list
		 * 			iterator is at end of list. 
		 */
		function nextIndex () : uint;
		
		/**
		 * @return 	the previous element in the list.
		 */
		function previous () : *;
		
		/**
		 * @return	the index of the element that would be returned
		 * 			by a subsequent call to previous, or -1
		 * 			if list iterator is at beginning of list.
		 */
		function previousIndex () : uint;
		
		/**
		 * Replaces the last element returned by next or previous
		 * with the specified element
		 */
		function set ( o:Object ) : void;
	}
}