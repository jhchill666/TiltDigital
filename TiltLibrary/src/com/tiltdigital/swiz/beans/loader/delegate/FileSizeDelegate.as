package com.tiltdigital.swiz.beans.loader.delegate 
{
	import com.tiltdigital.log.Logger;
	import com.tiltdigital.swiz.beans.loader.event.LoaderEvent;
	import com.tiltdigital.swiz.beans.loader.model.LoaderQueue;
	import com.tiltdigital.swiz.beans.loader.model.LoaderStats;
	import com.tiltdigital.swiz.beans.loader.model.loaders.ILoader;
	import com.tiltdigital.swiz.beans.loader.vo.LoaderVO;
	
	import flash.events.ProgressEvent;
	
	import org.swizframework.Swiz;

	/**	 * @author Jamie.Hill	 */	public class FileSizeDelegate
	{
		[Autowire( bean="loaderModel", property="queue" )]
		public var _queue						: LoaderQueue;
		
		[Autowire( bean="loaderModel", property="stats" )]
		public var _stats						: LoaderStats;
		
		protected var _queueRunning				: Boolean			= false;
		
		
		//___________________________________________________________________________________ PUBLIC METHODS
		
		
		
		/**
		 * Start the queue loading
		 */
		public function startLoad () : void
		{
			_queueRunning 	= true;
			_queue.persist	= true;

			startNext();
		}
		
		
		
		
		//___________________________________________________________________________________ PRIVATE METHODS
		
		
		
		
		/**
		 * Start loading the next item in the queue.  
		 */
		protected function startNext () : void
		{
			var _loaderVO:LoaderVO, _loader:ILoader;
			
			if( _queue.hasNext() )
			{				
				_loaderVO 				= ( _queue.next() as LoaderVO );
				
				if( _loaderVO.bytesTotal == 0 ) 
				{	
					_loader				= ( _loaderVO.loader as ILoader );
					_loader.loadMode	= false;
					
					_loader.addEventListener( ProgressEvent.PROGRESS, progressHandler );
					_loader.load();
					
				} else startNext(); //if size already found, startNext()
				
			} else
			
			{
				Logger.info("FileSizeDelegate.queueComplete( totalBytes :: "+(_stats.totalBytes/1024)+ " kb(s) )" );
				
				_queueRunning 		= false;
				_queue.persist		= false;
				
				Swiz.dispatchEvent( new LoaderEvent( LoaderEvent.LOAD_ASSETS ));
			}
		} 
		
		
		
		
		/**
		 * Once the first 'ProgressEvent' has been fired, the base class for all ILoader, LoaderBase
		 * automatically populates this loader's LoaderVO.bytesTotal with the size of this asset
		 */
		protected function progressHandler ( event:ProgressEvent ) : void
		{
			var _loader:ILoader, _loaderVO:LoaderVO;
			
			_loader 				= ( event.target as ILoader );
			_loader.removeEventListener( ProgressEvent.PROGRESS, progressHandler );
			_loader.close();
			
			_loaderVO				= ( event.target as ILoader ).getVO();
			_loaderVO.bytesLoaded	= 0;
			
			_stats.totalBytes += _loaderVO.bytesTotal;
			
			startNext();
		}	}}