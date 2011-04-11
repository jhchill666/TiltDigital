package com.tiltdigital.swiz.beans.loader.model.loaders 
{
	import com.tiltdigital.swiz.beans.loader.vo.LoaderVO;
	
	import flash.display.LoaderInfo;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;

	/**	 * @author Jamie.Hill	 */	public interface ILoader extends IEventDispatcher
	{	
		/**
		 * Start loading the client
		 */
		function load () : void;
		
		/**
		 * Unload the current loader object
		 */
		function unload() : void;
		
		/**
		 * Cancels a load operation that is currently in progress.
		 */
		function close () : void;
		
		/**
		 * Configure listeners for the loader
		 */
		function configureListeners() : void;
		
		/**
		 * Deconfigure listeners for the loader
		 */
		function deconfigureListeners() : void;
		
		/**
		 * Retrieve the URLRequest
		 */
		function getUrlRequest() : URLRequest;
		
		/**
		 * @return the loaded data (read only)
		 */
		function getData () : *;
		
		/**
		 * @return the loaderVO for this ILoader
		 */
		function getVO () : LoaderVO;
		
		/**
		 * @return the loader info (read only)
		 */
		function getLoaderInfo () : LoaderInfo;
		
		/**
		 * String representation of this client
		 */
		function toString () : String;
		
		/**
		 * Get/Set the operation mode - findFileSize or Load
		 */
		function set loadMode( val:Boolean ) : void;
		function get loadMode() : Boolean;	}}