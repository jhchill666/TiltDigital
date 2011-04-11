package com.tiltdigital.swiz.beans.loader.model.loaders 
{
	import com.tiltdigital.swiz.beans.loader.vo.LoaderVO;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.text.Font;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 * @author Jamie.Hill
	 */
	public class FontLoader extends FontLoaderBase implements ILoader
	{
		protected var _fontCount 							: Number;
		protected var _libLoader 							: Loader;
		
		protected var _loader 								: URLLoader		= new URLLoader();
		protected var _fonts								: Array			= new Array( );

		/**
		 * constructor
		 */
		public function FontLoader ( vo:LoaderVO ) 
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
			
			_fontCount 			= 0;
			_loader.dataFormat 	= URLLoaderDataFormat.BINARY;
			_loader.load( _vo.urlRequest );
		}
		
		
		
		/**
		 * Unload the asset
		 */
		public function unload () : void
		{
			close();
		}
		
		
		
		
		/**
		 * Cancel a load operation that is currently in progress.
		 */
		public function close () : void
		{
			deconfigureListeners();
			
			_loader.close();
			
			if( _libLoader )
            {
                try{ _libLoader.close(); } 	catch (error:Error) {}
                try{ _libLoader.unload(); } catch (error:Error) {}

                _libLoader = null;
            }
		}
		
		
		
		/**
		 * Retrieve the URLRequest
		 */
		public function getUrlRequest () : URLRequest
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
			return String( "[FontLoader - " + _vo.urlRequest.url + "]" );
		}
		
		
		
		//___________________________________________________________________________________ PRIVATE METHODS

		
		
		/**
		 * Configure listeners for the loader
		 */
		override public function configureListeners () : void
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
		override public function deconfigureListeners () : void
		{
			_loader.removeEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
            _loader.removeEventListener( HTTPStatusEvent.HTTP_STATUS, httpStatusHandler );
            _loader.removeEventListener( ProgressEvent.PROGRESS, progressHandler );
            _loader.removeEventListener( Event.COMPLETE, loadCompleteHandler );
            
            if( _libLoader )
            	_libLoader.contentLoaderInfo.removeEventListener( Event.COMPLETE, libLoadComplete );
		}
		
		
		
		
		/**
         * Handle progress events
         */
        override protected function progressHandler ( event:ProgressEvent ) : void
        {
        	( _vo as LoaderVO ).bytesLoaded	= ( _loader.bytesLoaded as uint );
            ( _vo as LoaderVO ).bytesTotal	= ( _loader.bytesTotal as uint );
			
            dispatchEvent( event );
        }
        
        
        
        
        override protected function loadCompleteHandler ( event:Event ) : void
        {
        	var o:Object, stringID:String, id:uint, fontID:uint, tag:uint, length:uint;
            var pos:Number, tempData:ByteArray, fontSWF:ByteArray, classCodeLength:uint;
            var data:ByteArray, fontData:Object = new Object();
            
            data 			= new SwfByteArray( _loader.data as ByteArray );
            fontData 		= new Object();
			classCodeLength = classCode.length;
                        
            while( data.bytesAvailable )
            {
                tag			= data.readUnsignedShort();
                id			= tag >> 6;
                length		= (( tag & 0x3F ) == 0x3F ) ? data.readUnsignedInt() : ( tag & 0x3F );
                pos			= data.position;
                
                switch( id )
                {
                    case 88 :
                    
                        fontID 					= data.readUnsignedShort();
                        tempData 				= fontData[fontID] as ByteArray;
                        
                        if( !tempData ) 
                        {
                            tempData 			= new ByteArray();
                            tempData.endian 	= Endian.LITTLE_ENDIAN;
                            fontData[fontID] 	= tempData;
                        }
                        
                        if(( tag & 0x3F ) == 0x3F )
                        {
                            tempData.writeShort(( id << 6 ) | 0x3F );
                            tempData.writeUnsignedInt( length );
                        } 
                        else
                        {
                            tempData.writeShort(( id << 6 ) | ( length & 0x3F ));
                        }
                        
                        tempData.writeShort( fontID );
                        tempData.writeBytes( data, data.position, length - 2 );
                        
                    break;
                }

                data.position = pos + length;
            }
            
            tempData = new ByteArray();
            tempData.endian = Endian.LITTLE_ENDIAN;
            tempData.writeBytes( swfHeader );
            id = 0;

            for (o in fontData)
            {
                data = fontData[o] as ByteArray;
                
                if( data )
                {
                    stringID = id.toString();
                    while( stringID.length < 3 ) stringID = '0' + stringID;
                    stringID = ( classNamePrefix + stringID );
                    
                    tempData.writeShort			( tagDoABC );
                    tempData.writeUnsignedInt	( 10 + stringID.length + classCodeLength );
                    tempData.writeUnsignedInt	( 0x002E0010 );
                    tempData.writeUnsignedInt	( 0x10000000 );
                    tempData.writeByte			( stringID.length );
                    tempData.writeUTFBytes		( stringID );
                    tempData.writeByte			( 0 );
                    tempData.writeBytes			( classCode );
                    tempData.writeBytes			( data );
                    tempData.writeShort			( tagSymbolClass );
                    tempData.writeUnsignedInt	( 5 + stringID.length );
                    tempData.writeShort			( 1 );
                    tempData.writeShort			( o as uint );
                    tempData.writeUTFBytes		( stringID );
                    tempData.writeByte			( 0 );
                   
                    id++;
                }
            }
            
            _fontCount = id;
            
            if( _fontCount )
            {
                tempData.writeUnsignedInt		( 0x00000040 );
                fontSWF 						= new ByteArray();
                fontSWF.endian 					= Endian.LITTLE_ENDIAN;
                fontSWF.writeUTFBytes			( "FWS" );
                fontSWF.writeByte				( 9 );
                fontSWF.writeUnsignedInt		( tempData.length + 8 );
                fontSWF.writeBytes				( tempData );
               
                _libLoader = new Loader();
                _libLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, libLoadComplete );
                _libLoader.loadBytes(fontSWF);
            }
            else
            {
                this.close();
                super.loadCompleteHandler( event );
            }
        }
        
        
        
        /**
         * @private
         */
        private function libLoadComplete( event:Event ) : void
        {
            var id:String, i:uint, fontClass:Class, font:Font;
            
            for( i = 0;i < _fontCount; i++ )
            {
                id 		= i.toString();
                while( id.length < 3 ) id = '0' + id;
                id 		= ( classNamePrefix + id );
                
                if( _libLoader.contentLoaderInfo.applicationDomain.hasDefinition( id ))
                {
                    fontClass	= _libLoader.contentLoaderInfo.applicationDomain.getDefinition(id) as Class;
                    font		= new fontClass() as Font;
                    
                    if (font && font.fontName)
                    {
                        _fonts.push( font );
                        Font.registerFont( fontClass );
                    }
                }
            }

            close();
            
            dispatchEvent( new Event( Event.COMPLETE ));
        }
	}
}
