/**
 * Created by keremozdemir on 5/15/14.
 */
package com.baracca.mobile.app {
    import com.baracca.mobile.app.screens.StartScreen;

    import feathers.controls.Drawers;

    import feathers.events.FeathersEventType;
    import feathers.themes.MetalWorksMobileTheme;

    import starling.events.Event;

    public class AppRoot extends Drawers {

        public function AppRoot()
        {
            this.addEventListener(FeathersEventType.INITIALIZE, appRootInitialized);
        }

        private function appRootInitialized( event:Event ):void
        {
            new MetalWorksMobileTheme( );

            this.openGesture = Drawers.OPEN_GESTURE_DRAG_CONTENT_EDGE;
            this.content = new StartScreen();
        }
    }
}
