package com.tiltdigital.swiz.beans.loader.model.loaders 
{
	import com.tiltdigital.log.Logger;
	import com.tiltdigital.swiz.beans.loader.vo.LoaderVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;

	/**	 * @author Jamie.Hill	 */	public class LoaderBase extends EventDispatcher
	{
		protected var _vo 							: LoaderVO;
		protected var _loadMode						: Boolean 		= true;	
		
		
		/**
		 * constructor
		 */
		public function LoaderBase ( vo:LoaderVO ) 
		{
			_vo = vo;
		}
		
		
		//___________________________________________________________________________________ PUBLIC METHODS

		
		
		/**
		 * Configure listeners for the loader
		 */
		public function configureListeners() : void
		{
			throw new Error( "AbstractMethodError :: you must override the abstract method with your sub-classes" );
		}
		
		
		
		/**
		 * Deconfigure listeners for the loader
		 */
		public function deconfigureListeners() : void
		{
			throw new Error( "AbstractMethodError :: you must override the abstract method with your sub-classes" );
		}
		
	
		
		/**
		 * @return the loaderVO for this ILoader
		 */
		public function getVO () : LoaderVO
		{
			return _vo;
		}
		
		
		
		/**
		 * Get/Set the operation mode - findFileSize or Load
		 */
		public function set loadMode( val:Boolean ) : void { _loadMode = val; }
		public function get loadMode() : Boolean { return _loadMode; }
		
		
		
		
		/**
		 * String representation of this client
		 */
		override public function toString () : String
		{
			throw new Error( "AbstractMethodError :: you must override the abstract method with your sub-classes" );
		}
		
		
		//___________________________________________________________________________________ PRIVATE METHODS
		
		
		/**
		 * Initialise the Client -- Override with subclasses
		 */
		protected function initialise() : void
		{
			throw new Error( "AbstractMethodError :: you must override the abstract method with your sub-classes" );
		}
		
		
		/**
		 * Handle security error events
		 */
		protected function securityErrorHandler( event:SecurityErrorEvent ) : void
        {
        	Logger.debug("LoaderBase.securityErrorHandler(event)");
        	
			dispatchEvent( event );
        }
        
        
        /**
		 * Handle http status events
		 */
        protected function httpStatusHandler( event:HTTPStatusEvent ) : void
        {
//        	Logger.debug("LoaderBase.httpStatusHandler(event)");
        	
            dispatchEvent( event );
        }
        
        
		/**
		 * Handle input/output error events
		 */
        protected function ioErrorHandler( event:IOErrorEvent ) : void
        {
        	Logger.debug("LoaderBase.ioErrorHandler(event)");
        	
            dispatchEvent( event );
        }
        
        
        /**
         * Handle progress events
         */
        protected function progressHandler( event:ProgressEvent ) : void
        {
        	( _vo as LoaderVO ).bytesLoaded	= ( event.bytesLoaded as uint );
            ( _vo as LoaderVO ).bytesTotal	= ( event.bytesTotal as uint );
			
            dispatchEvent( event );
        }
        
        
        /**
         * Handle load complete events
         */
        protected function loadCompleteHandler( event:Event ) : void
        {
//            Logger.info( "LoaderBase.loadCompleteHandler("+_vo.urlRequest.url+");");
			
			deconfigureListeners();
			
            ( _vo as LoaderVO ).loaded = true;
            
//            Logger.debug("LoaderBase.loaded : "+( _vo as LoaderVO ).bytesLoaded+" total : "+( _vo as LoaderVO ).bytesTotal);
			
            dispatchEvent( event );
        }
	}}