/**
 * Created by keremozdemir on 5/16/14.
 */
package com.baracca.mobile.app.screens {
    import feathers.controls.Button;
    import feathers.controls.ButtonGroup;
    import feathers.controls.Panel;
    import feathers.controls.PanelScreen;
    import feathers.controls.ScrollContainer;
    import feathers.data.ListCollection;
    import feathers.events.FeathersEventType;
    import feathers.layout.AnchorLayout;
    import feathers.layout.AnchorLayoutData;
    import feathers.layout.VerticalLayout;
    import feathers.system.DeviceCapabilities;

    import flash.ui.Multitouch;
    import flash.ui.MultitouchInputMode;

    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.events.Event;

    public class LocalScreen extends PanelScreen {

        private var backButton          : Button;


        public function LocalScreen()
        {
            super();
            this.addEventListener(FeathersEventType.INITIALIZE, cameraScreenInitialized);
        }

        private function cameraScreenInitialized( event:Event ):void
        {
            Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

            const verticalLayout : VerticalLayout = new VerticalLayout();
            verticalLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
            verticalLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_BOTTOM;

            this.layout = verticalLayout;

            var panel : Panel = new Panel( );
            panel.layout =
            addChild( panel );

            var buttonGroup:ButtonGroup = new ButtonGroup();
            buttonGroup.dataProvider = new ListCollection( [
                {label: "Select a Photo", triggered: triggeredSelectPhoto},
                {label: "Take a Photo", triggered: triggeredTakePhoto}
            ] );
            panel.addChild( buttonGroup );
            buttonGroup.direction = ButtonGroup.DIRECTION_HORIZONTAL;

            this.headerProperties.title = "Photo Capture";

            if ( !DeviceCapabilities.isTablet( Starling.current.nativeStage ) )
            {
                backButton = new Button();
                backButton.nameList.add( Button.ALTERNATE_NAME_BACK_BUTTON );
                backButton.label = "Back";
                backButton.addEventListener( Event.TRIGGERED, backToScreen );

                this.headerProperties.leftItems = new <DisplayObject>
                        [
                            this.backButton
                        ];
                this.backButtonHandler = this.onBackButton;
            }
        }

        private function onBackButton():void
        {
            this.dispatchEventWith( Event.COMPLETE );
        }


        private function backToScreen( event:Event ):void
        {
            this.onBackButton();
        }


        private function triggeredSelectPhoto( event:Event ):void
        {
        }


        private function triggeredTakePhoto( event:Event ):void
        {
        }
    }
}
