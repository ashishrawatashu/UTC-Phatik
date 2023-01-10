package `in`.nic.uk.utc.starbuspathik

import io.flutter.embedding.android.FlutterFragmentActivity
import android.view.WindowManager.LayoutParams
import io.flutter.embedding.engine.FlutterEngine
import android.view.WindowManager;
import android.os.Bundle;

class MainActivity : FlutterFragmentActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        window.addFlags(LayoutParams.FLAG_SECURE)
        super.configureFlutterEngine(flutterEngine)
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE);
    }

}