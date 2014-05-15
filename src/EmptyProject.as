package {

    import flash.desktop.NativeApplication;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import flash.system.Capabilities;

    import starling.core.Starling;
    import starling.events.Event;
    import starling.utils.RectangleUtil;
    import starling.utils.ScaleMode;

    public class EmptyProject extends Sprite {

        private var mStarling                   : Starling;

        public function EmptyProject() {
            ( stage ? onAddedToStage( ) : addEventListener(flash.events.Event.ADDED_TO_STAGE, onAddedToStage) );
        }

        private function onAddedToStage( event:flash.events.Event=null ):void
        {
            if ( event )
                removeEventListener(flash.events.Event.ADDED_TO_STAGE, onAddedToStage);

            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align     = StageAlign.TOP_LEFT;

            initStarling( );
        }

        private function initStarling():void
        {
            mouseChildren = mouseEnabled = false;

            Starling.multitouchEnabled = Capabilities.manufacturer.indexOf( "iOS" ) != -1;
            Starling.handleLostContext = false;

            const stageWidth  = stage.fullScreenWidth;
            const stageHeight = stage.fullScreenHeight;

            var viewPort : Rectangle = RectangleUtil.fit(
                    new Rectangle( 0, 0, stageWidth, stageHeight ),
                    new Rectangle( 0, 0, stage.stageWidth, stage.stageHeight ),
                    ScaleMode.SHOW_ALL,
                    true
            );

            mStarling = new Starling( AppRoot, stage, viewPort );
            mStarling.stage.stageWidth      = stageWidth;
            mStarling.stage.stageHeight     = stageHeight;
            mStarling.simulateMultitouch    = false;
            mStarling.enableErrorChecking   = false;

            mStarling.addEventListener(starling.events.Event.ROOT_CREATED, function( event:starling.events.Event ):void
                    {
                        var appRoot : AppRoot = mStarling.root as AppRoot;
                        appRoot.init( );
                        mStarling.start( );
                    }
            );

            NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE,
                    function( event:flash.events.Event ):void
                    {
                        mStarling.start();
                    }
            );

            NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE,
                    function( event:flash.events.Event ):void
                    {
                        mStarling.stop( );
                    }
            );

            stage.addEventListener(flash.events.Event.RESIZE, onResizeStage, false, int.MAX_VALUE, true);
        }

        private function onResizeStage( event:flash.events.Event ):void
        {
            mStarling.stage.stageWidth  = stage.stageWidth;
            mStarling.stage.stageHeight = stage.stageHeight;

            const viewPort : Rectangle = mStarling.viewPort;
            viewPort.width  = stage.stageWidth;
            viewPort.height = stage.stageHeight;

            try {
                mStarling.viewPort = viewPort;
            } catch ( error:Error ) {
                trace( "Starling View Port Problem: ", error.message );
            }
        }
    }
}
