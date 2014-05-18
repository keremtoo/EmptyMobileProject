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

    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    import flash.events.IOErrorEvent;

    import flash.events.MediaEvent;

    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;

    import flash.media.CameraRoll;

    import flash.media.CameraUI;
    import flash.media.MediaPromise;
    import flash.media.MediaType;

    import flash.ui.Multitouch;
    import flash.ui.MultitouchInputMode;
    import flash.utils.ByteArray;
    import flash.utils.IDataInput;

    import starling.core.Starling;
    import starling.display.DisplayObject;

    import starling.events.Event;

    public class CameraScreen extends PanelScreen {

        private var backButton          : Button;

        private var cameraRoll          : CameraRoll;
        private var cameraUI            : CameraUI;
        private var dataSource          : IDataInput;
        private var tempDir             : File;

        public function CameraScreen()
        {
            super();
            this.addEventListener(FeathersEventType.INITIALIZE, cameraScreenInitialized);
        }


        private function cameraScreenInitialized( event:starling.events.Event ):void
        {
            Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

            this.layout = new AnchorLayout();

            cameraRoll = new CameraRoll( );
            cameraUI = new CameraUI( );

            var buttonGroup:ButtonGroup = new ButtonGroup();
            buttonGroup.dataProvider = new ListCollection( [
                        {label: "Select a Photo", triggered: triggeredSelectPhoto},
                        {label: "Take a Photo", triggered: triggeredTakePhoto}
                    ] );
            addChild( buttonGroup );

            const screenLayoutData:AnchorLayoutData = new AnchorLayoutData();
            screenLayoutData.horizontalCenter = 0;
            screenLayoutData.verticalCenter = 0;
            buttonGroup.layoutData = screenLayoutData;
            buttonGroup.direction = ButtonGroup.DIRECTION_HORIZONTAL;

            this.headerProperties.title = "Photo Capture";

            if ( !DeviceCapabilities.isTablet( Starling.current.nativeStage ) )
            {
                backButton = new Button();
                backButton.nameList.add( Button.ALTERNATE_NAME_BACK_BUTTON );
                backButton.label = "Back";
                backButton.addEventListener( starling.events.Event.TRIGGERED, backToScreen );

                this.headerProperties.leftItems = new <DisplayObject>
                        [
                            this.backButton
                        ];
                this.backButtonHandler = this.onBackButton;
            }
        }


        private function onBackButton():void
        {
            this.dispatchEventWith( starling.events.Event.COMPLETE );
        }


        private function backToScreen( event:starling.events.Event ):void
        {
            this.onBackButton();
        }


        private function triggeredSelectPhoto( event:starling.events.Event ):void
        {
            if ( CameraUI.isSupported )
            {
                cameraUI.addEventListener(MediaEvent.COMPLETE, imageSelected);
                cameraUI.addEventListener(flash.events.Event.CANCEL, browseCancelled);
                cameraUI.addEventListener(ErrorEvent.ERROR, mediaEventError);

                cameraUI.launch( MediaType.IMAGE );
            }
            else
            {
                trace( "This device does not support Camera functions." );
            }
        }


        private function triggeredTakePhoto( event:starling.events.Event ):void
        {
            if ( CameraRoll.supportsBrowseForImage )
            {
                cameraRoll.addEventListener(MediaEvent.COMPLETE, imageSelected);
                cameraRoll.addEventListener(flash.events.Event.CANCEL, browseCancelled);
                cameraRoll.addEventListener(ErrorEvent.ERROR, mediaEventError);

                cameraRoll.browseForImage( );
            }
            else
            {
                trace( "This device does not support CameraRoll functions." );
            }
        }

        private function imageSelected( event:MediaEvent ):void
        {
            var mediaPromise : MediaPromise = event.data;
            dataSource = mediaPromise.open( );

            if ( mediaPromise.isAsync )
            {
                var eventSource : IEventDispatcher = dataSource as IEventDispatcher;
                eventSource.addEventListener(flash.events.Event.COMPLETE, onMediaLoaded);
            }
            else
            {
                readMediaData( );
            }
        }

        private function browseCancelled( event:flash.events.Event ):void
        {
            trace( "Browse CameraRoll Cancelled" );
        }

        private function mediaEventError( event:ErrorEvent ):void
        {
            trace( "There was an error" );
        }


        private function onMediaLoaded( event:flash.events.Event ):void
        {
            readMediaData( );
        }

        private function readMediaData():void
        {
            var mediaBytes : ByteArray = new ByteArray( );
            dataSource.readBytes( mediaBytes );
            tempDir = File.createTempDirectory( );

            var now : Date = new Date();
            var filename : String = "IMG" + now.fullYear + now.month + now.day + now.hours + now.minutes + now.seconds;

            var temp:File = tempDir.resolvePath(filename);
            var stream : FileStream = new FileStream( );
            stream.open( temp, FileMode.WRITE );
            stream.writeBytes( mediaBytes );
            stream.close( );

            temp.addEventListener(flash.events.Event.COMPLETE, uploadComplete);
            temp.addEventListener(IOErrorEvent.IO_ERROR, ioError);
        }

        private function uploadComplete( event:flash.events.Event ):void
        {
            trace( "Upload Complete" );
        }

        private function ioError( event:IOErrorEvent ):void
        {
            trace( "Unable to process photo" );
        }
    }
}
