package com.tiltdigital.swiz.beans.loader.model.loaders 
{
	import com.tiltdigital.swiz.beans.loader.vo.LoaderVO;
	
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * @author Jamie.Hill
	 */
	public class DataLoader extends LoaderBase implements ILoader
	{
		protected var _loader 								: URLLoader		= new URLLoader();
		
		/**
		 * constructor
		 */
		public function DataLoader ( vo:LoaderVO ) 
		{
			super( vo );
		}
		
		
		
		//___________________________________________________________________________________ PUBLIC METHODS
		
	
		
		/**
		 * Start loading the asset
		 * 
		 * @param simple		[optional] Performs simple load operation,
		 * only adding listeners to facilitate retrieval of bytesTotal
		 */
		public function load () : void
		{
			configureListeners();
			
			_loader.load( _vo.urlRequest );
		}
		
		
		
		/**
		 * Unload the asset
		 */
		public function unload () : void
		{
			//no unload method for URLLoader
		}
	
		
		
		
		/**
		 * Cancel a load operation that is currently in progress.
		 */
		public function close () : void
		{
			deconfigureListeners();
			
			_loader.close();
			
			dispatchEvent( new Event( Event.CANCEL ));
		}
		
		
		
		/**
		 * Retrieve the URLRequest
		 */
		public function getUrlRequest() : URLRequest
		{
			return _vo.urlRequest;
		}
		
		
		
		/**
		 * Retrieve the loaded data (read only)
		 */
		public function getData () : *
		{
			return _loader.data;
		}

		
		
		/**
		 * @return the loader info (read only)
		 */
		public function getLoaderInfo () : LoaderInfo
		{
			return null;
		}
		
		
		
		/**
		 * String representation of this client
		 */
		override public function toString () : String
		{
			return String( "[DataLoader - " + _vo.urlRequest.url + "]" );
		}
		
		
		
		//___________________________________________________________________________________ PRIVATE METHODS
		
		
		
		/**
		 * Configure listeners for the loader
		 */
		override public function configureListeners() : void
		{
			_loader.addEventListener( ProgressEvent.PROGRESS, progressHandler, false, 0, true );
			
			if( loadMode )
			{
				_loader.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true );
	            _loader.addEventListener( HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true );
	            _loader.addEventListener( Event.COMPLETE, loadCompleteHandler, false, 0, true );
			}
		}
		
		
		
		/**
		 * Deconfigure listeners for the loader
		 */
		override public function deconfigureListeners() : void
		{
			_loader.removeEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
            _loader.removeEventListener( HTTPStatusEvent.HTTP_STATUS, httpStatusHandler );
            _loader.removeEventListener( ProgressEvent.PROGRESS, progressHandler );
            _loader.removeEventListener( Event.COMPLETE, loadCompleteHandler );
		}
	}
}
