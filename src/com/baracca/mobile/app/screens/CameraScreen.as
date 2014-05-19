/**
 * Created by keremozdemir on 5/16/14.
 */
package com.baracca.mobile.app.screens {
    import com.baracca.mobile.app.photo.PhotoContainer;

    import feathers.controls.Button;
    import feathers.controls.PanelScreen;
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

            var photoContainer : PhotoContainer = new PhotoContainer( );
            addChild( photoContainer );

            const screenLayoutData:AnchorLayoutData = new AnchorLayoutData();
            screenLayoutData.horizontalCenter = 0;
            screenLayoutData.verticalCenter = 0;
            photoContainer.layoutData = screenLayoutData;

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
    }
}
