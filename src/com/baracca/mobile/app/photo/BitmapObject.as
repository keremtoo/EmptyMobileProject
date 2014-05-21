/**
 * Created by keremozdemir on 5/20/14.
 */
package com.baracca.mobile.app.photo {
    import com.vlabs.ane.cameraroll.PhotoMetadata;

    import starling.display.Sprite;

    public class BitmapObject extends Sprite {

        private var _metadata:PhotoMetadata;

        public function BitmapObject( bitmap:*, metadata:PhotoMetadata )
        {
            addChild(bitmap);
            _metadata = metadata;
        }


        public function get metadata():PhotoMetadata
        {
            return _metadata;
        }

        public function set metadata(value:PhotoMetadata):void
        {
            _metadata = value;
        }
    }
}
