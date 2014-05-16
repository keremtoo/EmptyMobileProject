/**
 * Created by keremozdemir on 5/16/14.
 */
package com.baracca.mobile.app.screens {
    import feathers.controls.Button;
    import feathers.controls.ButtonGroup;
    import feathers.controls.PanelScreen;
    import feathers.data.ListCollection;
    import feathers.events.FeathersEventType;
    import feathers.layout.AnchorLayout;
    import feathers.layout.AnchorLayoutData;
    import feathers.system.DeviceCapabilities;

    import starling.core.Starling;
    import starling.display.DisplayObject;

    import starling.events.Event;

    public class CameraScreen extends PanelScreen {

        private var backButton : Button;

        public function CameraScreen()
        {
            super();
            this.addEventListener(FeathersEventType.INITIALIZE, cameraScreenInitialized);
        }

        private function cameraScreenInitialized( event:Event ):void
        {
            this.layout = new AnchorLayout();

            var buttonGroup:ButtonGroup = new ButtonGroup();
            buttonGroup.dataProvider = new ListCollection( [
                        {label: "Photo Capture", triggered: triggeredPhoto},
                        {label: "Photo Done", triggered: triggeredPhoto}
                    ] );
            addChild( buttonGroup );

            const screenLayoutData:AnchorLayoutData = new AnchorLayoutData();
            screenLayoutData.horizontalCenter = 0;
            screenLayoutData.verticalCenter = 0;
            buttonGroup.layoutData = screenLayoutData;

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


        private function triggeredPhoto( event:Event ):void
        {
            var button : Button = Button( event.currentTarget );
            trace( button.label );

            //scre
        }
    }
}
