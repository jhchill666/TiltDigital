package com.tiltdigital.data.collections
{
	import com.tiltdigital.data.iterators.IIterator;	
	
	/**
	 * @author Jamie.Hill
	 * 
	 * ICollection implementation for all Collections
	 */	public interface ICollection 
	{
		/**
	     * @return true if this collection contains the specified element.
	     */
		function contains ( o:Object ) : Boolean;

		/**
	     * Removes all of the elements from this collection
	     */
		function clear () : void;
		
		/**
		 * Returns an iterator contain all objects in collection
		 */
		function getIterator() : IIterator;
		
		/**
	     * Returns the number of elements in this collection.
	     */
		function size () : uint;
		
		/**
		 * Checks if the collection is empty.
		 * 
		 * @return True if empty, otherwise false.
		 */
		function isEmpty() : Boolean
		
		/**
	     * Returns an array containing all of the elements in this collection.
	     */
		function toArray () : Array;
	}
}