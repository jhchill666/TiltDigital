package com.tiltdigital.swiz.beans.loader.model 
{
	import com.tiltdigital.log.Logger;
	import com.tiltdigital.swiz.beans.loader.vo.LoaderVO;

	public class LoaderQueue
	{
		private var _persist					: Boolean 				= true;

		private var _currentIndex				: int;
		private var _queue 						: Array;
		
		
		//___________________________________________________________________________________ PUBLIC METHODS

		
		
		/**
		 * Constructor --
		 */
		public function LoaderQueue ()
		{
			clear();
		}
		
		
		
		
		/**
		 * Clears the queue
		 */
		public function clear () : void
		{
			_queue 				= new Array();
			_currentIndex 		= 0;
		} 
		
		
		
		/**
		 * Set whether data in the queue should persist when iterated through
		 * 
		 * @param val		Boolean whether the queue should persist.  Items removed from queue when iterated through
		 */
		public function set persist( val:Boolean ) : void
		{
			_persist = val;
		}
		
		
		
		
		/**
		 * Adds an individual LoaderVO to the loader queue
		 * 
		 * @param vo			The LoaderVo you want to remove
		 * 
		 * @return Boolean 		True if added successfully
		 */
		public function add ( vo:LoaderVO ) : Boolean
		{
			if( contains( vo )) 
			{
				Logger.warning( "LoaderQueue.add ( "+vo.id+" :: already exists! )" );
				return false;
			}
			addPriorityItem( vo );
			
			return true;
		}
		
		
		
		/**
		 * Removes an individual LoaderVO from the loader queue
		 * 
		 * @param vo			The LoaderVo you want to remove
		 * 
		 * @return Boolean 		True if added successfully
		 */
		public function remove ( vo:LoaderVO ) : Boolean
		{
			if( !contains( vo )) 
			{
				Logger.warning( "LoaderQueue.remove ( "+vo.id+" :: does not exist! )" );
				return false;
			}
			_queue.splice( _queue.indexOf( vo ));
			
			return true;
		}
		
		
		
		
		/**
		 * Check if the queue contains the requested data
		 * 
		 * @param data		Data to check for
		 */
		public function contains ( data:* ) : Boolean
		{
			return ( _queue.indexOf( data ) != -1 );
		}

	
		
		
		/**
		 *Retrieves the next item and remove it from the queue 
		 */
		public function next () : LoaderVO
		{
			if( _persist )	
			{
				_currentIndex ++;
				
				return _queue[ _currentIndex-1 ] as LoaderVO;
				
			} else return _queue.shift() as LoaderVO;
		}
		
		
		
		
		/**
		 * Return true if the queue contains the specified number of items still
		 * 
		 * @param count		Number of remaining items to check for
		 */
		public function hasNext ( count:int = 0 ) : Boolean
		{
			if( _persist )	return ( _currentIndex < totalFiles() );
			else			return ( totalFiles() > 0 );
		}
		
		
		
		
		/**
		 * Return total number of files in queue
		 */
		public function totalFiles () : int
		{
			return _queue.length;
		}
		
		
		
		
		/**
		 * Clones the current Queue
		 */
		public function clone() : Array
		{
			return _queue.slice();
		}
		
		
		
		/**
		 * Represent this queue as a String
		 */
		public function toString() : String
		{
			return _queue.toString();
		}
		
		
		
		
		//___________________________________________________________________________________ PRIVATE METHODS
		
		
		
		/**
		 * The queue attempts to sort the items by their priority.  If the new item has a higher priority
		 * than the first item in the collection, it gracefully positions the new item at index 2 so as
		 * not to interfere with any current operation currently using that particular item.
		 */
		private function addPriorityItem ( vo:LoaderVO ) : void
		{
			var _sorted:Array, _newPriority:int;
			
			if( _queue.length > 0 )
			{
				_queue.sortOn( "priority", Array.NUMERIC | Array.DESCENDING );

				if( vo.priority >= _queue[ 0 ].priority ) _queue.splice( 1, 0, vo );
				
				else
				{
					_queue.push( vo );
					_queue.sortOn( "priority", Array.NUMERIC | Array.DESCENDING );
				}
			} else 	_queue.push( vo );
		}
	}
}
