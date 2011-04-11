package com.tiltdigital.swiz.beans.loader.model.loaders 
{
	import com.tiltdigital.log.*;
	import com.tiltdigital.swiz.beans.audio.model.*;
	import com.tiltdigital.swiz.beans.loader.vo.LoaderVO;
	
	import flash.display.LoaderInfo;
	import flash.events.*;
	import flash.media.*;
	
	import org.swizframework.Swiz;

	/**
	 * @author Jamie.Hill
	 */
	public class SoundLoader extends DisplayObjectLoader implements ILoader
	{
		[Bindable]
		[Autowire( bean="audioModel", property="audio" )]
		public var audioCache 										: AudioCache;
		
		protected var _soundLoader 									: Sound			= new Sound();
		
		/**
		 * constructor
		 */
		public function SoundLoader ( vo:LoaderVO ) 
		{
			super( vo );
		}
		
		
		
		//___________________________________________________________________________________ PUBLIC METHODS
		
	
		
		/**
		 * Start loading the sound
		 * 
		 * @param simple		[optional] Performs simple load operation,
		 * only adding listeners to facilitate retrieval of bytesTotal
		 */
		override public function load () : void
		{
			configureListeners();
			
			_soundLoader.load( _vo.urlRequest, _vo.context as SoundLoaderContext );
		}
		
		
		
		/**
		 * Unload the asset
		 */
		override public function unload () : void
		{
			//no unload method for Sound
		}
		
		
		
		
		/**
		 * Cancel a load operation that is currently in progress.
		 */
		override public function close () : void
		{
			deconfigureListeners();
			
			_soundLoader.close();
			
			dispatchEvent( new Event( Event.CANCEL ));
		}
		
		
		
		/**
		 * Retrieve the loaded sound data (read only)
		 */
		override public function getData () : *
		{
			return _soundLoader;
		}

		
		
		/**
		 * Retrieve the loader info - null for Sound
		 */
		override public function getLoaderInfo () : LoaderInfo
		{
			return null;
		}
		
		
		
		/**
		 * String representation of this client
		 */
		override public function toString () : String
		{
			return String( "[SoundLoader - " + _vo.urlRequest.url + "]" );
		}
		
		
		
		//___________________________________________________________________________________ PRIVATE METHODS

		
		
		/**
         * Handle load complete events
         */
        override protected function loadCompleteHandler( event:Event ) : void
        {
        	Logger.error( "SoundLoaded :: "+getData() + " id :: " + _vo.id );
        	
        	( Swiz.getBean( "audioModel" ) as AudioModel ).audio.add( getData() as Sound, _vo.id );
        	
			super.loadCompleteHandler( event );
        }
        
        
        
        
		/**
		 * Configure listeners for the loader
		 */
		override public function configureListeners() : void
		{
            _soundLoader.addEventListener( ProgressEvent.PROGRESS, progressHandler, false, 0, true );
			
			if( loadMode )
			{
				_soundLoader.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true );
	            _soundLoader.addEventListener( HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true );
	            _soundLoader.addEventListener( Event.COMPLETE, loadCompleteHandler, false, 0, true );
	            _soundLoader.addEventListener( Event.ID3, id3DataHandler );
			}
			
		}
		
		
		
		/**
		 * Deconfigure listeners for the loader
		 */
		override public function deconfigureListeners() : void
		{
			_soundLoader.removeEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
            _soundLoader.removeEventListener( HTTPStatusEvent.HTTP_STATUS, httpStatusHandler );
            _soundLoader.removeEventListener( Event.COMPLETE, loadCompleteHandler );
            _soundLoader.removeEventListener( Event.ID3, id3DataHandler );

            _soundLoader.removeEventListener( ProgressEvent.PROGRESS, progressHandler );
		}
		
		
		
		/**
         * Handle progress events
         */
        override protected function progressHandler( event:ProgressEvent ) : void
        {
        	( _vo as LoaderVO ).bytesLoaded	= ( _soundLoader.bytesLoaded as uint );
            ( _vo as LoaderVO ).bytesTotal	= ( _soundLoader.bytesTotal as uint );
			
            dispatchEvent( event );
        }
        
		
		
		
		/**
		 * ID3 data handler
		 */
		private function id3DataHandler( event:Event ) : void
		{
			( _vo as LoaderVO ).id3	= ( event.target as Sound ).id3;
		}
	}
}
