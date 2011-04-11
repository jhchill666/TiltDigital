package com.tiltdigital.swiz.beans.localisation.controllers
{
	import com.tiltdigital.swiz.beans.loader.controllers.LoaderController;
	import com.tiltdigital.swiz.beans.loader.event.LoaderEvent;
	import com.tiltdigital.swiz.beans.loader.model.VirtualCache;
	import com.tiltdigital.swiz.beans.loader.model.loaders.ILoader;
	import com.tiltdigital.swiz.beans.loader.vo.LoaderVO;
	import com.tiltdigital.swiz.beans.localisation.delegate.*;
	import com.tiltdigital.swiz.beans.localisation.event.LocaleEvent;
	
	import flash.events.Event;
	
	import mx.controls.Alert;
	
	import org.swizframework.Swiz;
	import org.swizframework.controller.*;

	public class LocaleController extends AbstractController
	{	
		[Autowire]
        public var localeDelegate 					: LoadLocaleDelegate;
        
        [Autowire( bean="loaderModel", property="cache" )]
		public var cache 							: VirtualCache;
		
		[Autowire( bean="localeModel", property="data" )]
		public var data 							: Object;
		
		/**
		 * Constructor --
		 */
		public function LocaleController ()
		{
			super();
			
			
		}
		
		
		
		//____________________________________________________________________ PUBLIC METHODS
		
		
		
		/**
		 * Load in the main localisation xml
		 */
		public function loadData( url:String, bean:String ) : void
		{
			var loaderController:LoaderController;
			
			loaderController = Swiz.getBean( bean ) as LoaderController;
			loaderController.add( new LoaderVO( "localeXml", url ));
			
			Swiz.addEventListener( LoaderEvent.LOAD_COMPLETE, loadDataComplete );
			Swiz.dispatchEvent( new Event( LoaderEvent.START_LOAD ));
		}
		
		
		
		//____________________________________________________________________ PRIVATE METHODS
		
		
		/**
		 * Xml Data loaded successfully - Result handler
		 */
		private function loadDataComplete( event:LoaderEvent ) : void
		{
			Swiz.removeEventListener( LoaderEvent.LOAD_COMPLETE, loadDataComplete );
			
			var loader:ILoader;
			
			loader 	= cache.get( "localeXml" ) as ILoader;
			data	= loader.getData();
			
			Alert.show( loader.getData() );
			
			Swiz.dispatchEvent( new LocaleEvent( LocaleEvent.COMPLETE ));
		}
	}
}