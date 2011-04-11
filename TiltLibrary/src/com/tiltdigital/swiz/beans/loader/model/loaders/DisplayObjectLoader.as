package com.tiltdigital.swiz.beans.loader.model.loaders 
{
	import com.tiltdigital.swiz.beans.loader.vo.LoaderVO;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	/**
	 * @author Jamie.Hill
	 */
	public class DisplayObjectLoader extends LoaderBase implements ILoader
	{
		protected var _loader 								: Loader		= new Loader();
		
		/**
		 * constructor
		 */
		public function DisplayObjectLoader ( vo:LoaderVO ) 
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
			
			_loader.load( _vo.urlRequest, _vo.context );
		}
		
		
		
		/**
		 * Unload the asset
		 */
		public function unload () : void
		{
			_loader.unload();
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
			return _loader.content;
		}

		
		
		/**
		 * @return the loader info (read only)
		 */
		public function getLoaderInfo () : LoaderInfo
		{
			return _loader.contentLoaderInfo;
		}
		
		
		
		/**
		 * String representation of this client
		 */
		override public function toString () : String
		{
			return String( "[DisplayObjectLoader - " + _vo.urlRequest.url + "]" );
		}
		
		
		
		//___________________________________________________________________________________ PRIVATE METHODS

		
		
		/**
		 * Configure listeners for the loader
		 */
		override public function configureListeners() : void
		{
            _loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, progressHandler, false, 0, true );
            
			if( loadMode )
			{
				_loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true );
	            _loader.contentLoaderInfo.addEventListener( HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true );
	            _loader.contentLoaderInfo.addEventListener( Event.COMPLETE, loadCompleteHandler, false, 0, true );
			}
		}
		
		
		
		/**
		 * Deconfigure listeners for the loader
		 */
		override public function deconfigureListeners() : void
		{
			_loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
            _loader.contentLoaderInfo.removeEventListener( HTTPStatusEvent.HTTP_STATUS, httpStatusHandler );
            _loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, progressHandler );
            _loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, loadCompleteHandler );
		}
		
		
		
		
		/**
         * Handle progress events
         */
        override protected function progressHandler( event:ProgressEvent ) : void
        {
        	( _vo as LoaderVO ).bytesLoaded	= ( _loader.contentLoaderInfo.bytesLoaded as uint );
            ( _vo as LoaderVO ).bytesTotal	= ( _loader.contentLoaderInfo.bytesTotal as uint );
			
            dispatchEvent( event );
        }
	}
}
