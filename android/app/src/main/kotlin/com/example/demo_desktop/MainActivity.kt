package com.example.demo_desktop;

import android.Manifest
import android.app.Activity
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.content.ContextCompat

class MainActivity: FlutterActivity() {

    private val GALLERY_CHANNEL = "flutter.io/gallery"
    private lateinit var methodChannelResult: MethodChannel.Result

    private val RequestPermissionChannel = "flutter.io/requestPermission"
    private val CheckPermissionChannel = "flutter.io/checkPermission"

    private lateinit var pendingResult: MethodChannel.Result
    private val UPDATE_INTERVAL = (30000).toLong()
    private val FASTEST_UPDATE_INTERVAL = UPDATE_INTERVAL / 2
    private val MAX_WAIT_TIME = UPDATE_INTERVAL * 2

    private val REQUEST_PERMISSION = 100
    private val REQUEST_CAMERA_PERMISSION = 101
    private val REQUEST_LOCATION_PERMISSION = 102
    private val REQUEST_RECORD_AUDIO_PERMISSION = 103
    private val REQUEST_STORAGE_PERMISSION = 104
    private var isUpdateLocation: Boolean = false

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, GALLERY_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "gallery" -> {
                    methodChannelResult = result
                    startActivityForResult(Intent(this, GalleryActivity::class.java), 0)
                }
            }
        }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, RequestPermissionChannel).setMethodCallHandler { call, result ->
            pendingResult = result
            when (call.method) {
                "open_screen" -> {
                    val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
                    intent.data = Uri.parse("package:$packageName")
                    startActivityForResult(intent, REQUEST_PERMISSION)
                }
                "camera" -> {
                    handlePermission(result, arrayOf(Manifest.permission.CAMERA), REQUEST_CAMERA_PERMISSION)
                }
                "location" -> {
                    handlePermission(result, arrayOf(Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION), REQUEST_LOCATION_PERMISSION)
                }
                "record_audio" -> {
                    handlePermission(result, arrayOf(Manifest.permission.RECORD_AUDIO), REQUEST_RECORD_AUDIO_PERMISSION)
                }
                "storage" -> {
                    handlePermission(result, arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.READ_EXTERNAL_STORAGE), REQUEST_STORAGE_PERMISSION)
                }
            }
        }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CheckPermissionChannel).setMethodCallHandler { call, result ->
            when (call.method) {
                "camera" -> {
                    handlePermission(result, arrayOf(Manifest.permission.CAMERA), 0)
                }
                "location" -> {
                    handlePermission(result, arrayOf(Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION), 0)
                }
                "record_audio" -> {
                    handlePermission(result, arrayOf(Manifest.permission.RECORD_AUDIO), 0)
                }
                "storage" -> {
                    handlePermission(result, arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.READ_EXTERNAL_STORAGE), 0)
                }
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == 0) {
            if (resultCode == Activity.RESULT_OK) {
                val result = data!!.getStringExtra("result")
                methodChannelResult.success(result)
            }
            else {
                methodChannelResult.success(null)
            }
        }
    }
    private fun handlePermission(result: MethodChannel.Result, permissions: Array<String>, keyRequest: Int){
        var granted = true
        for(it: String in permissions){
            if (ContextCompat.checkSelfPermission(this, it) != PackageManager.PERMISSION_GRANTED) {
                granted = false
                break
            }
        }
        if (granted) {
            result.success(1)
        }
        else{
            if(keyRequest == 0){
                result.success(0)
            }
            else{
                ActivityCompat.requestPermissions(this,
                        permissions,
                        keyRequest)
            }
        }
    }

    private fun handleRequestPermissionsResult(permissions: Array<String>, grantResults: IntArray, isLocation: Boolean){
        val permissionGranted = grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED
        if (!permissionGranted) {
            var shouldShowRequest = true
            for(it: String in permissions){
                if (!ActivityCompat.shouldShowRequestPermissionRationale(this, it)) {
                    shouldShowRequest = false
                    break
                }
            }

            if(shouldShowRequest)
                pendingResult.success(0)
            else
                pendingResult.success(-1)
        }
        else{
            pendingResult.success(1)
        }
    }
    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        when (requestCode) {
            REQUEST_LOCATION_PERMISSION -> {
                handleRequestPermissionsResult(arrayOf(Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION), grantResults, true)
            }
            REQUEST_CAMERA_PERMISSION -> {
                handleRequestPermissionsResult(arrayOf(Manifest.permission.CAMERA), grantResults, false)
            }
            REQUEST_RECORD_AUDIO_PERMISSION -> {
                handleRequestPermissionsResult(arrayOf(Manifest.permission.RECORD_AUDIO), grantResults, false)
            }
            REQUEST_STORAGE_PERMISSION -> {
                handleRequestPermissionsResult(arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.READ_EXTERNAL_STORAGE), grantResults, false)
            }
        }
    }
}
