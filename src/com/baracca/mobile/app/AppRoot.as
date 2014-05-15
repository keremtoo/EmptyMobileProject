/**
 * Created by keremozdemir on 5/15/14.
 */
package com.baracca.mobile.app {
    import feathers.controls.ButtonGroup;
    import feathers.controls.ScreenNavigator;
    import feathers.data.ListCollection;
    import feathers.themes.MetalWorksMobileTheme;

    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.ResizeEvent;

    public class AppRoot extends Sprite {

        private var screenNavigator : ScreenNavigator;
        private var buttonGroup : ButtonGroup;

        public function AppRoot()
        {
            super();
        }

        // initialization app root class
        public function init():void
        {
            new MetalWorksMobileTheme( );

            setButtonGroup( );

            stage.addEventListener(ResizeEvent.RESIZE, onResizeStage);
        }

        private function setButtonGroup():void
        {
            buttonGroup = new ButtonGroup( );
            buttonGroup.dataProvider = new ListCollection(
                    [
                        {label:"Local"},
                        {label:"Camera"}
                    ]
            );
            buttonGroup.verticalAlign = ButtonGroup.VERTICAL_ALIGN_MIDDLE;
            buttonGroup.addEventListener(Event.TRIGGERED, function( event:Event, data:Object ):void
                    {
                        trace( "The button with label \"" + data.label + "\" was triggered." );
                    }
            );
            this.addChild( buttonGroup );
        }

        private function onResizeStage( event:ResizeEvent ):void
        {
            updateDimensions( event.width, event.height );
            updatePositions( event.width, event.height );
        }

        private function updateDimensions( width:int, height:int ):void
        {
        }

        private function updatePositions( width:int, height:int ):void
        {
        }
    }
}
