package com.tiltdigital.components.text.textInput
{
    import flash.events.FocusEvent;
    import spark.components.TextInput;

    public class TiltTextInput extends TextInput
    {
        [SkinState("focused")];
        
        private var bfocused:Boolean;
        
        public function TiltTextInput()
        {
            super();
        }
        
        override protected function partAdded( partName:String, instance:Object ) : void
        {
            super.partAdded( partName, instance );
            
            if( instance == this.textView )
            {
                this.textView.addEventListener( FocusEvent.FOCUS_IN, focusInHandler );
                this.textView.addEventListener( FocusEvent.FOCUS_OUT, focusOutHandler );
            }
        }
        

        override protected function partRemoved( partName:String, instance:Object ) : void
        {
            super.partRemoved( partName, instance );
            
            if( instance == this.textView )
            {
                this.textView.removeEventListener( FocusEvent.FOCUS_IN, focusInHandler );
                this.textView.removeEventListener( FocusEvent.FOCUS_OUT, focusOutHandler );
            }
        }
        

        override protected function getCurrentSkinState() : String
        {
            if( bfocused ) 	return "focused";
            else 			return super.getCurrentSkinState();
        }
        
        
        
        private function focusInHandler( event:FocusEvent ) : void
        {
            bfocused = true;
            invalidateSkinState();
        }
        

        private function onFocusOutHandler( event:FocusEvent ) : void
        {
            bfocused = false;
            invalidateSkinState();
        }
    }
}