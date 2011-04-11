package com.tiltdigital.swiz.beans.loader.vo 
{
	import com.tiltdigital.swiz.beans.loader.model.LoaderConfig;
	import com.tiltdigital.swiz.beans.loader.model.loaders.*;
	import com.tiltdigital.tools.StringTools;
	
	import flash.media.ID3Info;
	import flash.net.URLRequest;

	/**	 * @author Jamie.Hill	 */	public class LoaderVO
	{
		public var id 								: String;
		public var urlRequest						: URLRequest;
		public var loader 							: ILoader;
		public var context 							: *;			
		public var priority 						: Number;
		public var id3								: ID3Info;
		public var progress 						: uint;
		
		public var loaded							: Boolean 			= false;
		private var _bytesTotal						: uint				= 0;	
		private var _bytesLoaded					: uint 				= 0;

		
		/**
		 * The LoaderVO vlaue object acts as a data holder for loader assets
		 * 
		 * @param id			String identifier for the asset to load
		 * @param request		Either asset url String, URLRequest or ILoader instance
		 * @param priority		[optional] Priority in the load queue
		 * @param context		[optional] Specify load context for assets 
		 * @param type			[optional] Explicitly specify an ILoader class to use ie. FontLoader
		 */
		public function LoaderVO ( id:String, request:*, priority:int = 0, context:* = null, type:Class = null )
		{
			this.id				= id;
			this.urlRequest		= getRequest( request );
			this.priority		= Math.max( Math.min( priority, 100 ), 0 );
			this.context		= context;
			this.loader			= getLoader( urlRequest.url, type );
		}
		
		
		
		//___________________________________________________________________________________ PRIVATE METHODS
		
		
		
		/**
		 * Get/Set total filesize in bytes of this asset
		 */
		public function set bytesTotal( val:uint ) : void
		{
			_bytesTotal = val;
			
//			Logger.debug("LoaderVO.total : "+id+" --- "+(val/1024)+" kb(s)");
		}
		public function get bytesTotal() : uint { return _bytesTotal; }
		
		
		
		
		
		/**
		 * Get/Set loaded filesize in bytes of this asset
		 */
		public function set bytesLoaded( val:uint ) : void
		{
			progress		= ( val - _bytesLoaded );
			_bytesLoaded 	= val;
			
//			Logger.debug("LoaderVO.loaded : "+id+" --- "+(val/1024)+" kb(s)");
		}
		public function get bytesLoaded() : uint { return _bytesLoaded; }
		
		
		
		
		
		/**
		 * Returns a URLRequest from the passed request type
		 * 
		 * @param request		Either url String, URLRequest or ILoaderClient
		 * 
		 * @return URLRequest
		 */
		private function getRequest( request:* ) : URLRequest
		{
			var _request:URLRequest;
			
			if( request is String )		_request = new URLRequest( request );
			if( request is ILoader )	_request =  ILoader( request ).getUrlRequest();
			
			return ( _request as URLRequest );
		}
		
		
		
		/**
		 * Returns an ILoader type dependant on url extension
		 */
		private function getLoader(	url:String, type:Class = null ) : ILoader
		{
			if( type ) return new type( this ) as ILoader;
			
			var _loader:ILoader, _extension:String;
			
			_extension 	= StringTools.getExtension( url );

			if( LoaderConfig.DISPLAY_EXTENSIONS.indexOf( _extension ) != -1 )
				_loader = new DisplayObjectLoader	( this );
			
			if( LoaderConfig.SOUND_EXTENSIONS.indexOf( _extension ) != -1 )
				_loader = new SoundLoader	( this );
				
			if( LoaderConfig.DATA_EXTENSIONS.indexOf( _extension ) != -1 )
				_loader = new BinaryDataLoader	( this );
			
			return _loader;
		}	}}