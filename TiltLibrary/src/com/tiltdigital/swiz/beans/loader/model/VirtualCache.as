package com.tiltdigital.swiz.beans.loader.model 
{
	import com.tiltdigital.log.Logger;
	import com.tiltdigital.swiz.beans.loader.model.loaders.ILoader;
	import com.tiltdigital.swiz.beans.loader.vo.LoaderVO;
	
	import flash.events.EventDispatcher;

	public class VirtualCache extends EventDispatcher
	{
		private var cache 						: Array;
		
		
		/**
		 * Constructor --
		 */
		public function VirtualCache ()
		{
			clear();
		}
		
		
		//___________________________________________________________________________________ PUBLIC METHODS
	
		
		/**
		 * Adds an individual LoaderVO to the cache
		 * 
		 * @param vo			LoaderVO to add to the virtual cache
		 * 
		 * @return Boolean 		True if successfully addedto the model
		 */
		public function add ( vo:LoaderVO ) : Boolean
		{
			if( contains( vo ))
			{
				Logger.warning( "VirtualCache.add ( "+vo.id+" :: already exists! )" );
				
				return false;
			}

			cache.push( vo );
			
			return true;
		}
		
		
		
		/**
		 * Retrieve an individual ILoader 
		 * 
		 * @param id			Id for the ILoader we want to retrieve
		 */
		public function get ( id:String ) : ILoader
		{
			var vo:LoaderVO;
			vo = getValueObjectById( id ) as LoaderVO;
			
			if( vo == null )
				Logger.warning( "VirtualCache.get ( "+id+" :: does not exist! )" );
				
			return ( vo.loader as ILoader );
		}
		
		
		
		/**
		 * Removes a LoaderVO from the model
		 * 
		 * @param soundId		Id for the LoaderVO we want to remove
		 * 
		 * @return Boolean		True if successfully removed
		 */
		public function remove ( id:String ) : Boolean
		{
			var vo:LoaderVO;
			vo = getValueObjectById( id ) as LoaderVO;
			
			if( vo == null )
			{
				Logger.warning( "VirtualCache.remove ( "+id+" :: does not exist! )" );
				return false;
			}
			cache.splice( cache.indexOf( vo ));
			
			return true;
		}
		
		
		
		/**
		 * Check if the cache contains the requested data
		 * 
		 * @param data		Data to check for
		 */
		public function contains ( data:* ) : Boolean
		{
			return ( cache.indexOf( data ) != -1 );
		}

	
		

		/**
		 * Clears all ILoaders
		 */
		public function clear () : void
		{
			cache 				= new Array();
		} 
		
		
		
		/**
		 * Get total number of LoaderVO's in cache
		 */
		public function totalFiles () : int
		{
			return cache.length;
		}
		
		
		//___________________________________________________________________________________ PRIVATE METHODS
		
		
		/**
		 * ListCollectionView contains a LoaderVO with the specified id
		 * 
		 * @param id			Id of the LoaderVO we're looking for
		 * 
		 * @return LoaderVO		Returns the LoaderVO as specified by it's id, or null
		 */
		private function getValueObjectById( id:String ) : LoaderVO 
		{
			var vo:LoaderVO;
			
			for each( vo in cache )
			{
				if( vo.id == id ) 
				{
					return vo;
					break;
				}
			}
			return null;
		}
	}
}
