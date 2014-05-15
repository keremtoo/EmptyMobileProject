package {

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;

    public class EmptyProject extends Sprite {

        public function EmptyProject() {
            ( stage ? onAddedToStage( ) : addEventListener(flash.events.Event.ADDED_TO_STAGE, onAddedToStage) );
        }

        private function onAddedToStage( event:flash.events.Event=null ):void
        {
            if ( event )
                removeEventListener(flash.events.Event.ADDED_TO_STAGE, onAddedToStage);

            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align     = StageAlign.TOP_LEFT;
        }
    }
}
