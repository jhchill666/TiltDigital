package com.tiltdigital.data.lists
{
	import com.tiltdigital.data.collections.ICollection;
	import com.tiltdigital.data.iterators.IListIterator;	

	/**
	 * @author Jamie.Hill
	 * 
	 * An ordered collection (also known as a sequence). 
	 */
	public interface List extends ICollection
	{
		/**
		 * Inserts the specified element at the specified position
		 * 
		 * @param index	The index to insert the element at
		 * @param o		The Object to insert
		 */
		function addAt ( index:uint, o:Object ) : void;
		
		/**
		 * Inserts all of the elements in the specified collection
		 * into this list at the specified position
		 * 
		 * @param index	The index to insert the collection at
		 * @param c		The ICollection to insert
		 * 
		 * @return true if elements were successfully added to the list
		 */
		function addAllAt ( index:uint, c:ICollection ) : Boolean
		
		/**
		 * Returns the element at the specified position in this list.
		 * 
		 * @param index	The index of element to retrieve
		 * 
		 * @return 	the element at the specified position in this list.
		 */
		function get ( index:uint ) : Object;
		
		/**
		 * @param o		The Object to retrieven first index of
		 * 
		 * @return 		the index in this list of the first occurrence of
		 * 				the specified element, or -1 if this list does
		 * 				not contain this element. 
		 */
		function indexOf ( o:Object ) : int;
		
		/**
		 * @param o		The Object to retrieven last index of
		 * 
		 * @return 		the index in this list of the last occurrence of
		 * 				the specified element, or -1 if this list does
		 * 				not contain this element.
		 */
		function lastIndexOf ( o:Object ) : int;
		
		/**
		 * Returns a list iterator of the elements in this list
		 * 
		 * @param 		index index of first element to be returned
		 * 		  		from the list iterator (by a call to the next method).
		 * 		  	
		 * @return 		a list iterator of the elements in this list
		 * 		   		starting at the specified position in this list.
		 */
		function listIterator ( index:uint = 0 ) : IListIterator;
		
		/**
		 * Removes the element at the specified position in this list
		 * 
		 * @param 		index	the index of the element to removed.
		 * 
		 * @return 		the element previously at the specified position.
		 */
		function removeAt ( index:uint ) : Boolean;
		
		/**
		 * Replaces the element at the specified position in this
		 * list with the specified element (optional operation).
		 * 
		 * @param index	of element to replace.
		 * 
		 * @param o  	element to be stored at the specified position.
		 * 
		 * @return the element previously at the specified position.
		 */
		function set ( index:uint, o:Object ) : Object;
		
		/**
		 * Returns a view of the portion of this list between the specified
		 * fromIndex, inclusive, and toIndex, exclusive.
		 * 
		 * @param fromIndex low endpoint (inclusive) of the subList.
		 * @param toIndex 	high endpoint (exclusive) of the subList.
		 * 
		 * @return 	a view of the specified range within this list.
		 */
		function subList ( fromIndex:uint, toIndex:uint ) : List;
	}
}