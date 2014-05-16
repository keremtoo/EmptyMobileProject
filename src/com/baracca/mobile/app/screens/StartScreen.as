/**
 * Created by keremozdemir on 5/15/14.
 */
package com.baracca.mobile.app.screens {
    import feathers.controls.ButtonGroup;
    import feathers.controls.PanelScreen;
    import feathers.data.ListCollection;
    import feathers.events.FeathersEventType;
    import feathers.layout.AnchorLayout;
    import feathers.layout.AnchorLayoutData;

    import starling.events.Event;


    [Event(name="localScreen", type="starling.events.Event")]
    [Event(name="cameraScreen", type="starling.events.Event")]
    public class StartScreen extends PanelScreen {

        public static const LOCAL_SCREEN       : String = "localScreen";
        public static const CAMERA_SCREEN      : String = "cameraScreen";

        public function StartScreen()
        {
            super();
            this.addEventListener(FeathersEventType.INITIALIZE, startScreenInitialized);
        }

        private function startScreenInitialized( event:Event ):void
        {
            this.layout = new AnchorLayout();

            var buttonGroup:ButtonGroup = new ButtonGroup();
            buttonGroup.dataProvider = new ListCollection( [
                        {label: "Choose Local Photo", event: LOCAL_SCREEN},
                        {label: "Camera Capture Photo", event: CAMERA_SCREEN}
                    ] );

            buttonGroup.addEventListener( Event.TRIGGERED, function ( evt:Event, data:Object ):void
                    {
                        trace( "The button with label \"" + data.event + "\" was triggered." );
                        var eventType:String = data.event as String;
                        dispatchEventWith( eventType );
                    } );


            const buttonGroupLayoutData:AnchorLayoutData = new AnchorLayoutData();
            buttonGroupLayoutData.horizontalCenter = 0;
            buttonGroupLayoutData.verticalCenter = 0;
            buttonGroup.layoutData = buttonGroupLayoutData;
            addChild( buttonGroup );
        }
    }
}
