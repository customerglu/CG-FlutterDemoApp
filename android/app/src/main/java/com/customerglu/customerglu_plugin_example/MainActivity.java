package com.customerglu.customerglu_plugin_example;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import android.content.Context;
import org.json.JSONObject;
import android.content.BroadcastReceiver;
import android.content.Intent;
import android.content.IntentFilter;

import com.customerglu.customerglu_plugin.CGUtils;
import com.customerglu.customerglu_plugin.FLNativeFactoryBannerView;

import android.os.Bundle;


public class MainActivity extends FlutterActivity {

    private MethodChannel methodChannel;
    Context context;

    @Override
    public void configureFlutterEngine( FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        context = getApplicationContext();


    }

    @Override
    protected void onResume() {
        super.onResume();
        System.out.println("custoo App onResume");
        CGUtils.gluSDKDebuggingMode(this,true);
        CGUtils.setActivity(this);

    }

    @Override
    protected void onCreate( Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        CGUtils.gluSDKDebuggingMode(this,true);

    }

    @Override
    protected void onRestart() {
        super.onRestart();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
    }
}
