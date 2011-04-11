package com.tiltdigital.swiz.beans.loader.model.loaders 
{
	import com.tiltdigital.swiz.beans.loader.vo.LoaderVO;
	
	import flash.net.URLLoaderDataFormat;

	/**
	 * @author Jamie.Hill
	 */
	public class BinaryDataLoader extends DataLoader implements ILoader
	{
		/**
		 * constructor
		 */
		public function BinaryDataLoader ( vo:LoaderVO ) 
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
		override public function load () : void
		{
			configureListeners();
			
			_loader.dataFormat = URLLoaderDataFormat.BINARY;
			_loader.load( _vo.urlRequest );
		}
		
		
		
		/**
		 * String representation of this client
		 */
		override public function toString () : String
		{
			return String( "[BinaryDataLoader - " + _vo.urlRequest.url + "]" );
		}
		
		
		
		//___________________________________________________________________________________ PRIVATE METHODS
	}
}
