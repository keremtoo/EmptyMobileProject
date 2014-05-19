/**
 * Created by keremozdemir on 5/19/14.
 */
package com.baracca.mobile.app.photo {
    import feathers.controls.ButtonGroup;
    import feathers.controls.Screen;
    import feathers.controls.ScrollContainer;
    import feathers.data.ListCollection;
    import feathers.events.FeathersEventType;
    import feathers.layout.VerticalLayout;

    import starling.display.Quad;
    import starling.events.Event;


    public class PhotoContainer extends Screen {

        private var scrollContainer         : ScrollContainer;
        private var buttonGroup             : ButtonGroup;

        public function PhotoContainer()
        {
            this.addEventListener(FeathersEventType.INITIALIZE, photoContainerInitialized);
        }


        private function photoContainerInitialized( event:Event ):void
        {
            const verticalLayout : VerticalLayout = new VerticalLayout();
            verticalLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_TOP;
            verticalLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
            verticalLayout.gap = 20;
            verticalLayout.padding = 20;

            this.layout = verticalLayout;

            buildControls( );
        }

        private function buildControls():void
        {
            scrollContainer = new ScrollContainer( );
            scrollContainer.backgroundSkin = new Quad( 300, 300, 0xffffff );
            addChild( scrollContainer );

            buttonGroup = new ButtonGroup();
            buttonGroup.dataProvider = new ListCollection( [
                {label: "Photo Capture", triggered: triggeredPhoto},
                {label: "Photo Done", triggered: triggeredPhoto}
            ] );
            buttonGroup.direction = ButtonGroup.DIRECTION_HORIZONTAL;
            addChild( buttonGroup );
        }

        private function triggeredPhoto( event:Event ):void
        {
        }
    }
}
