/**
 * Created by keremozdemir on 5/19/14.
 */
package com.baracca.mobile.app.photo {
    import feathers.controls.ButtonGroup;
    import feathers.controls.ImageLoader;
    import feathers.controls.Screen;
    import feathers.controls.ScrollContainer;
    import feathers.data.ListCollection;
    import feathers.events.FeathersEventType;
    import feathers.layout.VerticalLayout;

    import flash.display.Bitmap;

    import flash.display.Loader;

    import flash.display.LoaderInfo;

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
    import flash.utils.ByteArray;
    import flash.utils.IDataInput;

    import starling.display.Image;

    import starling.display.Quad;
    import starling.events.Event;
    import starling.textures.Texture;


    public class PhotoContainer extends Screen {

        private var scrollContainer         : ScrollContainer;
        private var buttonGroup             : ButtonGroup;

        private var cameraUI                : CameraUI;
        private var cameraRoll              : CameraRoll;

        private var dataSource              : IDataInput;
        private var tempDir                 : File;
        private var imageLoader             : Loader;

        public function PhotoContainer()
        {
            this.addEventListener(FeathersEventType.INITIALIZE, photoContainerInitialized);
        }


        private function photoContainerInitialized( event:starling.events.Event ):void
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
            cameraUI = new CameraUI();
            cameraRoll = new CameraRoll();

            scrollContainer = new ScrollContainer( );
            scrollContainer.backgroundSkin = new Quad( 300, 300, 0xffffff );
            addChild( scrollContainer );

            buttonGroup = new ButtonGroup();
            buttonGroup.dataProvider = new ListCollection( [
                {label: "Take a Photo", triggered: triggeredTakePhoto},
                {label: "Select a Photo", triggered: triggeredSelectPhoto}
            ] );
            buttonGroup.direction = ButtonGroup.DIRECTION_HORIZONTAL;
            addChild( buttonGroup );
        }


        private function triggeredTakePhoto( event:starling.events.Event ):void
        {
            if ( CameraUI.isSupported )
            {
                cameraUI.addEventListener(flash.events.MediaEvent.COMPLETE, imageSelected);
                cameraUI.addEventListener(flash.events.Event.CANCEL, browseCancelled);
                cameraUI.addEventListener(flash.events.ErrorEvent.ERROR, mediaEventError);

                cameraUI.launch( MediaType.IMAGE );
                //trace( "CameraUI ", cameraUI, " / ", CameraUI.isSupported );
            }
            else
            {
                trace( "This device does not support CameraUI functions." );
            }
        }


        private function triggeredSelectPhoto( event:starling.events.Event ):void
        {
            if ( CameraRoll.supportsBrowseForImage )
            {
                cameraRoll.addEventListener(flash.events.MediaEvent.SELECT, imageSelected);
                cameraRoll.addEventListener(flash.events.Event.CANCEL, browseCancelled);
                cameraRoll.addEventListener(flash.events.ErrorEvent.ERROR, mediaEventError);

                cameraRoll.browseForImage( );
                //trace( "CameraRoll ", cameraRoll, " / ", CameraRoll.supportsBrowseForImage );
            }
            else
            {
                trace( "This device does not support CameraRoll functions." );
            }
        }


        private function imageSelected( event:flash.events.MediaEvent ):void
        {
            var mediaPromise : MediaPromise = event.data;
            trace( "CameraRoll ", mediaPromise );

            if ( mediaPromise.isAsync )
            {
                //var eventSource : IEventDispatcher = event.data as IEventDispatcher;
                //eventSource.addEventListener(flash.events.Event.COMPLETE, onMediaLoaded);
                imageLoader = new Loader( );
                imageLoader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onMediaLoaded);
                imageLoader.addEventListener(IOErrorEvent.IO_ERROR, onCameraError);

                imageLoader.loadFilePromise( mediaPromise );
            }
            else
            {
                imageLoader.loadFilePromise( mediaPromise );
                readMediaData( imageLoader );
            }
        }

        private function onCameraError( event:IOErrorEvent ):void
        {
            trace( "IOError ", event.text );
        }


        private function browseCancelled( event:flash.events.Event ):void
        {
            trace( "Browse CameraRoll Cancelled" );
        }


        private function mediaEventError( event:flash.events.ErrorEvent ):void
        {
            trace( "There was an error ", event.text );
        }


        private function onMediaLoaded( event:flash.events.Event ):void
        {
            // image capture or add child
            /*var loaderInfo : LoaderInfo = event.target as LoaderInfo;
            var texture : Texture = Texture.fromBitmap( loaderInfo.content as Bitmap );
            var image : Image = new Image( texture );
            scrollContainer.addChild( image );
            image.pivotX = - image.width * 0.5;
            image.pivotY = - image.height * 0.5;*/

            readMediaData( imageLoader );

            //readMediaData( );
        }

        private function readMediaData( loader:Loader ):void
        {
            var texture : Texture = Texture.fromBitmap( loader.contentLoaderInfo.content as Bitmap );
            //var image : Image = new Image( texture );
            var imgLoader : ImageLoader = new ImageLoader();
            imgLoader.source = texture;
            imgLoader.maintainAspectRatio = true;
            //imgLoader.setSize(  )
            scrollContainer.addChild( imgLoader );

            /*var mediaBytes : ByteArray = new ByteArray( );
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
            temp.addEventListener(IOErrorEvent.IO_ERROR, ioError);*/
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
