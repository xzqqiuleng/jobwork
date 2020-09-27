package com.pinpin.jobwork

import android.os.Bundle
import com.mob.MobSDK
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        MobSDK.init(this, "m300ee9a78350b", "c051bb0b1084c5b30c7c92d1def05f0c")

    }

    override fun onDestroy() {
        super.onDestroy()
     }
}
