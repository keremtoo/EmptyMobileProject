package {

    import com.baracca.mobile.app.AppRoot;

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.geom.Rectangle;

    import starling.core.Starling;
    import starling.events.Event;

    public class EmptyProject extends Sprite {

        private var mStarling                   : Starling;
        private var saveAutoOrients             : Boolean;

        public function EmptyProject() {
            if ( stage )
            {
                stage.scaleMode = StageScaleMode.NO_SCALE;
                stage.align     = StageAlign.TOP_LEFT;
            }

            mouseChildren = mouseEnabled = false;

            this.loaderInfo.addEventListener(flash.events.Event.COMPLETE, loaderInfoComplete);
        }

        private function loaderInfoComplete( event:flash.events.Event ):void
        {
            Starling.handleLostContext = true;
            Starling.multitouchEnabled = true;

            saveAutoOrients = stage.autoOrients;

            mStarling = new Starling( AppRoot, stage );
            mStarling.enableErrorChecking = false;
            mStarling.start( );
            mStarling.addEventListener(starling.events.Event.ROOT_CREATED, starlingRootCreated);

            stage.addEventListener(flash.events.Event.RESIZE, stageResided);
            stage.addEventListener(flash.events.Event.DEACTIVATE, stageDeactivated);
        }

        private function stageDeactivated( event:flash.events.Event ):void
        {
            mStarling.stop( );
            stage.addEventListener(flash.events.Event.ACTIVATE, stageActivated, false, 0, true);
        }

        private function stageActivated( event:flash.events.Event ):void
        {
            stage.removeEventListener(flash.events.Event.ACTIVATE, stageActivated);
            mStarling.start( );
        }

        private function stageResided( event:flash.events.Event ):void
        {
            mStarling.stage.stageWidth  = stage.stageWidth;
            mStarling.stage.stageHeight = stage.stageHeight;

            const viewPort : Rectangle  = mStarling.viewPort;
            viewPort.width              = stage.stageWidth;
            viewPort.height             = stage.stageHeight;

            try {
                mStarling.viewPort = viewPort;
            } catch ( error:Error ) {}
        }

        private function starlingRootCreated( event:starling.events.Event ):void
        {
            stage.autoOrients = saveAutoOrients;
        }
    }
}
