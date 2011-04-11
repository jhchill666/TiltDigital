package com.tiltdigital.swiz.beans.loader.delegate 
{
	import com.tiltdigital.log.Logger;
	import com.tiltdigital.swiz.beans.loader.controllers.LoaderController;
	import com.tiltdigital.swiz.beans.loader.event.LoaderEvent;
	import com.tiltdigital.swiz.beans.loader.model.*;
	import com.tiltdigital.swiz.beans.loader.model.loaders.ILoader;
	import com.tiltdigital.swiz.beans.loader.vo.LoaderVO;
	import com.tiltdigital.tools.MathsTools;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.getTimer;
	
	import org.swizframework.Swiz;

	/**	 * @author Jamie.Hill	 */	public class LoaderQueueDelegate 
	{
		[Autowire( bean="loaderController" )]
		public var loaderController				: LoaderController;
		
		[Autowire( bean="loaderModel", property="queue" )]
		public var _queue						: LoaderQueue;
		
		[Autowire( bean="loaderModel", property="cache" )]
		public var _cache						: VirtualCache;
		
		[Autowire( bean="loaderModel", property="stats" )]
		public var _stats						: LoaderStats;

		protected var _queueRunning				: Boolean			= false;
		
		
		//___________________________________________________________________________________ PUBLIC METHODS
		
		
		
		/**
		 * Start the queue loading
		 */
		public function startLoad () : void
		{
			_queueRunning 		= true;
			_queue.persist		= false;
			
			_stats.filesTotal 	= _queue.totalFiles();
			_stats.bytesLoaded	= 0;

			startNext();
		}
		
		
		
		/**
		 * Clears the queue
		 */
		public function clear () : void
		{
			_queue.clear();
		} 
		
		
		
		//___________________________________________________________________________________ PRIVATE METHODS
		
		
		
		/**
		 * Start loading the next item(s) in the queue.  
		 */
		protected function startNext () : void
		{
			var _loaderVO:LoaderVO, _loader:ILoader, i:int;
						
			if( _queue.hasNext() )
			{
				_loaderVO 					= ( _queue.next() as LoaderVO );
				_loaderVO.bytesLoaded		= 0;
				
				_stats.currentLoader		= _loaderVO;

				_loader						= ( _loaderVO.loader as ILoader );
				_loader.loadMode			= true;

				_loader.addEventListener( ProgressEvent.PROGRESS, progressHandler );
				_loader.addEventListener( Event.COMPLETE, processAssetHandler, false, 0, true );
				_loader.load();

			} else

			{
				Logger.error("LoaderQueueDelegate.queueComplete( "+(_stats.bytesLoaded/1024)+" kb(s) Loaded )");

				_stats.timeElapsed 			= ( getTimer() - _stats.startTime );
				_queueRunning 				= false;
				
				loaderController.reset();
				_stats.clear();
				
				Swiz.dispatchEvent( new LoaderEvent( LoaderEvent.LOAD_COMPLETE ));
			}
		} 
		

		
		/**
		 * Process the loadaed asset before moving onto next in queue
		 */
		protected function processAssetHandler ( event:Event ) : void
		{
			var _loader:ILoader, _loaderVO:LoaderVO;
			
			_stats.filesLoaded ++;
			
			_loader 			= ( event.target as ILoader );
			_loader.removeEventListener( Event.COMPLETE, processAssetHandler );
			_loader.removeEventListener( ProgressEvent.PROGRESS, progressHandler );
			
			_loaderVO			= ( _loader.getVO() as LoaderVO );
			_loaderVO.loaded	= true;

			_cache.add( _loaderVO );
			
			Swiz.dispatchEvent( new LoaderEvent( LoaderEvent.FILE_COMPLETE, _loaderVO ));

			startNext();
		}
		
		
		
		/**
		 * Dispatch progress event to observers
		 */
		protected function progressHandler ( event:ProgressEvent ) : void
		{
			var total:uint, loaded:uint, percent:Number;
			
			_stats.bytesLoaded += ( event.target as ILoader ).getVO().progress;
			
			total				= ( LoaderConfig.USE_ACCURATE_PROGRESS ) ? _stats.totalBytes  : getTotalFiles();
			loaded				= ( LoaderConfig.USE_ACCURATE_PROGRESS ) ? _stats.bytesLoaded : getFilesLoaded()+1;
			
			percent 			= MathsTools.round( loaded / total, 3 );
			_stats.percent		= MathsTools.clamp( percent, 0, 1 );
			
			Logger.info( "OverallPercentage :: "+_stats.percent+" %" );

			Swiz.dispatchEvent( new ProgressEvent( ProgressEvent.PROGRESS, true, true, loaded, total ));
		}
		
		
		
		/**
		 * Get the total number of files to load, devided by any interpolation factor applied.
		 */
		protected function getTotalFiles () : int
		{
			return ( _stats.filesTotal * LoaderConfig.IF );
		}

		
		
		/**
		 * Returns total number of files, interpolated by interpolationFactor in order to
		 * articficially smooth loading progress when useAccurateProgress = false
		 */
		protected function getFilesLoaded () : int
		{
			var loaderVO:LoaderVO, psuedoBytesTotal:Number, psuedoFilesLoaded:Number;
			
			loaderVO			= ( _stats.currentLoader as LoaderVO );
			
			psuedoBytesTotal	= ( loaderVO.bytesTotal / LoaderConfig.IF );
			psuedoFilesLoaded	= Math.floor( _stats.bytesLoaded / psuedoBytesTotal );

			return ( psuedoFilesLoaded + _stats.filesLoaded );
		}
	}}