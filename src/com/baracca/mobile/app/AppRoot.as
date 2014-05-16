/**
 * Created by keremozdemir on 5/15/14.
 */
package com.baracca.mobile.app {
    import com.baracca.mobile.app.screens.CameraScreen;
    import com.baracca.mobile.app.screens.LocalScreen;
    import com.baracca.mobile.app.screens.StartScreen;

    import feathers.controls.Drawers;
    import feathers.controls.ScreenNavigator;
    import feathers.controls.ScreenNavigatorItem;

    import feathers.events.FeathersEventType;
    import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
    import feathers.system.DeviceCapabilities;
    import feathers.themes.MetalWorksMobileTheme;

    import starling.core.Starling;

    import starling.events.Event;

    public class AppRoot extends Drawers {

        private static const MAIN_MENU          : String = "mainEvent";
        private static const SCREEN_LOCAL       : String = "localEvent";
        private static const SCREEN_CAMERA      : String = "cameraEvent";

        private static const MAIN_MENU_EVENTS   : Object =
        {
            localScreen:SCREEN_LOCAL,
            cameraScreen:SCREEN_CAMERA
        };


        private var screenNavigator             : ScreenNavigator;
        private var screenTransition            : ScreenSlidingStackTransitionManager;
        private var mainMenu                    : StartScreen;

        public function AppRoot()
        {
            this.addEventListener(FeathersEventType.INITIALIZE, appRootInitialized);
        }

        private function appRootInitialized( event:Event ):void
        {
            new MetalWorksMobileTheme( );

            screenNavigator = new ScreenNavigator( );
            this.content = screenNavigator;

            setScreenNavigator( );
        }

        private function setScreenNavigator():void
        {
            screenNavigator.addScreen( SCREEN_LOCAL, new ScreenNavigatorItem( LocalScreen, {complete:MAIN_MENU} ) );
            screenNavigator.addScreen( SCREEN_CAMERA, new ScreenNavigatorItem( CameraScreen, {complete:MAIN_MENU} ) );

            screenTransition = new ScreenSlidingStackTransitionManager( screenNavigator );
            screenTransition.duration = 0.5;

            if ( DeviceCapabilities.isTablet( Starling.current.nativeStage ) )
            {
                screenNavigator.clipContent = true;
                mainMenu = new StartScreen( );

                for ( var eventType:String in MAIN_MENU_EVENTS )
                {
                    mainMenu.addEventListener(eventType, mainMenuEventHandler);
                }
            }
            else
            {
                screenNavigator.addScreen(MAIN_MENU, new ScreenNavigatorItem( StartScreen, MAIN_MENU_EVENTS ) );
                screenNavigator.showScreen( MAIN_MENU );
            }
        }

        private function mainMenuEventHandler( event:Event ):void
        {
            const screenName : String = MAIN_MENU_EVENTS[event.type];

            screenTransition.clearStack();
            screenTransition.skipNextTransition = true;
            screenNavigator.showScreen( screenName );
        }
    }
}
