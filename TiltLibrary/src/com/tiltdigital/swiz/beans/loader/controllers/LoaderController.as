package com.tiltdigital.swiz.beans.loader.controllers
{
	import com.tiltdigital.log.Logger;
	import com.tiltdigital.swiz.beans.loader.delegate.*;
	import com.tiltdigital.swiz.beans.loader.event.LoaderEvent;
	import com.tiltdigital.swiz.beans.loader.model.*;
	import com.tiltdigital.swiz.beans.loader.model.loaders.ILoader;
	import com.tiltdigital.swiz.beans.loader.vo.LoaderVO;
	
	import flash.events.Event;
	
	import org.swizframework.Swiz;
	import org.swizframework.controller.*;

	public class LoaderController extends AbstractController
	{	
		[Autowire( bean="loaderModel", property="queue" )]
		public var queue 							: LoaderQueue;
		
		[Autowire( bean="loaderModel", property="cache" )]
		public var cache 							: VirtualCache;
		
		
		/**
		 * Constructor --
		 */
		public function LoaderController ()
		{
			super();
			reset();
		}
		
		
		
		//____________________________________________________________________ PUBLIC METHODS
		
		
		
		/**
		 * Reset the loader queue
		 */
		public function reset ( event:Event = null ) : void
		{
			Swiz.addEventListener( LoaderEvent.START_LOAD, findFileSize );
		}
		
		
		
		
		/**
		 * Add a LoaderVO to the load queue
		 * 
		 * @return Boolean true if successfully addded
		 */
		public function add ( vo:LoaderVO ) : Boolean
		{
			Logger.info( vo.urlRequest.url + " added to LoaderQueue" );
			
			return queue.add( vo as LoaderVO );
		}
		
		
		
		
		/**
		 * Retrieves an asset from the cache
		 * 
		 * @param id			String identifier for the asset to retrieve
		 */
		public function get ( id:String ) : ILoader
		{
			var vo:LoaderVO;
			vo = ( cache.get( id ) as LoaderVO );
			
			return ( vo.loader as ILoader );
		}
		
		
		
		
		/**
		 * Remove a LoaderVO from the cache
		 * 
		 * @return Boolean true if successfully removed
		 */
		public function remove ( id:String ) : Boolean
		{
			Logger.info( vo.urlRequest.url + " added to LoaderQueue" );
			
			var vo:LoaderVO;
			vo = ( cache.get( id ) as LoaderVO );
			
			return queue.remove( vo );
		}
		
		
		
		//____________________________________________________________________ PRIVATE METHODS
		
		
		
		/**
		 * Find file sizes
		 */
		private function findFileSize ( event:Event ) : void
		{
			Logger.info( "Starting LoaderQueue" );
			
			Swiz.removeEventListener( LoaderEvent.START_LOAD, findFileSize );
			
			if( LoaderConfig.USE_ACCURATE_PROGRESS )
			{
				Swiz.addEventListener( LoaderEvent.LOAD_ASSETS, startLoad );
				
				FileSizeDelegate( Swiz.getBean( "fileSizeDelegate" )).startLoad(); 
			
			} else startLoad(); //start load if not using accurate progress
		}
		
		
		
		/**
         * Start the main load process
         */ 
        private function startLoad ( event:Event = null ) : void
        {
        	Swiz.removeEventListener( LoaderEvent.LOAD_ASSETS, startLoad );

            LoaderQueueDelegate( Swiz.getBean( "loaderQueueDelegate" )).startLoad(); 
        }
	}
}