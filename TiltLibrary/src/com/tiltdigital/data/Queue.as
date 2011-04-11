package com.tiltdigital.data 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;		

	/**
	 * @author Jamie.Hill
	 */
	public class Queue extends EventDispatcher
	{
		private var _queue 							: Array;
		private var _fieldName 						: Object;
		private var _options 						: Object;
		private var _persist						: Boolean;
		private var _index 							: Number;

		/**
		 * The Queue Class queue's an array of items by priority.  It's two parameters 'fieldName'
		 * and 'options' adopt exactly the same operations as the AS3 Array.sortOn() parameters
		 * 
		 * @param fieldName		A string that identifies a field to be used as the sort value
		 * @param options		One or more numbers or names of defined constants that change sorting behavior
		 * @param queuePersist	Boolean whether the queue should persist.  Items removed from queue when iterated through
		 */		 
		public function Queue ( fieldName:Object, options:Object = null, queuePersist:Boolean = false )
		{
			super();
			
			_fieldName 	= fieldName;
			_options	= options;
			_persist	= queuePersist;
			
			clear();
		}
		
		
		
		/**
		 * Clears the queue completely
		 */
		public function clear() : void
		{
			_queue 	= new Array();
			_index	= 0;
		}
		
		
		
		/**
		 * Set whether data in the queue should persist when iterated through
		 * 
		 * @param val		Boolean whether the queue should persist.  Items removed from queue when iterated through
		 */
		public function set persist( val:Boolean ) : void
		{
			_persist	= val;
			_index		= 0;
		}
		
		
		
		/**
		 * Adds an item to the queue.  When adding a new item, the queue attempts to sort the
		 * items by their priority.  If the new item has a higher priority than the first item in 
		 * the array, it gracefully positions the new item at index 2 so as not to interfere with
		 * any current operation currently using that particular item.
		 */
		public function add ( data:* ) :void
		{
			var _sorted:Array, _newPriority:int;
			
			if( _queue.length > 0 )
			{
				_sorted 		= _queue.sortOn( _fieldName, _options );
				_newPriority	= data[ _fieldName ];
				
				if( _newPriority >= _sorted[ 0 ][ _fieldName ] ) _queue.splice( 1, 0, data );
				
				else
				{
					_queue.push( data );
					_queue.sortOn( _fieldName, _options );
				}
			} else 	_queue.push( data );
			
			dispatchEvent( new Event( Event.CHANGE ));
		}



		
		/**
		 * Check if the queue contains the requested data
		 * 
		 * @param data		Data to check for
		 */
		public function contains ( data:* ) :Boolean
		{
			return ( _queue.indexOf( data ) != -1 );
		}

	
		
		
		/**
		 *Retrieves the next item and remove it from the queue 
		 */
		public function next () :*
		{
			if( _persist )	return _queue[ _index ++ ];
			else			return _queue.pop();
		}
		
		
		
		
		/**
		 * Return true if the queue contains the specified number of items still
		 * 
		 * @param count		Number of remaining items to check for
		 */
		public function hasNext ( count:int = 0 ) : Boolean
		{
			if( _persist )	return (( _queue.length - _index ) > count );
			else			return ( _queue.length > count );
		}
		
		
		
		
		/**
		 * Return total number of files in queue
		 */
		public function totalFiles () : int
		{
			return _queue.length;
		}
		
		
		
		
		/**
		 * Return a copy of the queue as an Array
		 */
		public function toArray() : Array
		{
			return _queue;
		}
		
		
		
		
		/**
		 * Clones the current Queue
		 */
		public function clone() : Queue
		{
			var _newQueue:Queue, item:*;
			
			_newQueue = new Queue( _fieldName, _options, _persist );
			
			for each( item in _queue ) _newQueue.add( item );
			
			return _newQueue;
		}
	}
}
