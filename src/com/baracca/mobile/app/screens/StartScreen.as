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

    public class StartScreen extends PanelScreen {

        private var buttonGroup : ButtonGroup;

        public function StartScreen()
        {
            super();
            this.addEventListener(FeathersEventType.INITIALIZE, startScreenInitialized);
        }

        private function startScreenInitialized( event:Event ):void
        {
            this.layout = new AnchorLayout();

            buttonGroup = new ButtonGroup( );
            buttonGroup.dataProvider = new ListCollection(
                    [
                        {label:"Choose Local Photo"},
                        {label:"Camera Capture Photo"}
                    ]
            );
            const buttonGroupLayoutData : AnchorLayoutData = new AnchorLayoutData( );
            buttonGroupLayoutData.horizontalCenter = 0;
            buttonGroupLayoutData.verticalCenter = 0;
            buttonGroup.layoutData = buttonGroupLayoutData;
            addChild( buttonGroup );
        }
    }
}
