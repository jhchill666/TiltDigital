package com.tiltdigital.swiz.beans.audio.model 
{
	import com.tiltdigital.swiz.beans.audio.vo.AudioVO;
	import com.tiltdigital.log.*;
	
	import flash.media.Sound;

	/**
	 * @author Jamie.Hill
	 */
	public class AudioCache
	{
		/**
		 * Array for all AudioVO's
		 */
		private var _audio : Array;
		
		
		/**
		 * Constructor --
		 */
		public function AudioCache ()
		{
			clear();
		}
		
		
		//___________________________________________________________________________________ PUBLIC METHODS
		
		
		
		/**
		 * Adds an individual Sound
		 * 
		 * @param sound			Sound Object instance 
		 * @param soundId		Id for the Sound we're adding
		 */
		public function add ( sound:Sound, soundId:String ) : Boolean
		{
			var vo:AudioVO = new AudioVO( sound, soundId );
			
			if( contains( vo ))
			{
				Logger.warning( "AudioCache.add ( "+vo.id+" :: already added to audiocache! )" );
				return false;
			}
			
			Logger.info( "Adding sound to AudioCache :: "+vo.id );

			_audio.push( vo ); return true;
		}
		
		
		
		/**
		 * Retrieve an individual Sound 
		 * 
		 * @param soundId		Id for the Sound we want to retrieve
		 * 
		 */
		public function get ( soundId:String ) : AudioVO
		{
			var vo:AudioVO;
			vo = ( getValueObjectById( soundId ) as AudioVO );
			
			if( vo == null )
				Logger.warning( "AudioCache.get ( "+soundId+" does not exist! )" );
				
			return vo;
		}
		
		
		
		/**
		 * Removes a Sound froom AudioCache
		 * 
		 * @param soundId		Id for the Sound we want to remove from the cache
		 */
		public function remove ( soundId:String ) : void
		{
			var _vo:AudioVO;
			
			_vo = ( getValueObjectById( soundId ) as AudioVO );
			
			if( _vo == null )
			{
				Logger.warning( "AudioCache.remove ( "+soundId+" does not exist - No need to remove! )" );
				
			} else removeVO( _vo );
		}
		
		
		
		/**
		 * Check if the channels contain the requested AudioVO
		 * 
		 * @param vo		AudioVO to check for
		 */
		public function contains ( vo:AudioVO ) : Boolean
		{
			return ( _audio.indexOf( vo ) != -1 );
		}
		
		
		
		
		/**
		 * Clears all Sound Objects
		 */
		public function clear () : void
		{
			_audio		= new Array();
		} 
		
		
		//___________________________________________________________________________________ PRIVATE METHODS
		
		
		/**
		 * Array contains a AudioVO with the specified id
		 * 
		 * @param id			Id of the AudioVO we're looking for
		 * 
		 * @return LoaderVO		Returns the AudioVO as specified by it's id, or null
		 */
		private function getValueObjectById( id:String ) : AudioVO 
		{
			var vo:AudioVO;
			
			for each( vo in _audio )
			{
				if( vo.id == id ) 
				{
					return vo;
					break;
				}
			}
			return null;
		}
		
		
		/**
		 * Remove an AudioVO from the Mixer
		 * 
		 * @param vo		AudioVO to remove
		 */
		private function removeVO( vo:AudioVO ) : void
		{
			_audio.splice( _audio.indexOf( vo ));
		}
	}
}
