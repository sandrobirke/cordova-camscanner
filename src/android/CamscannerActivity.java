package com.beelphegor.cordovacamscanner;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import com.intsig.csopen.sdk.CSOpenAPI;
import com.intsig.csopen.sdk.CSOpenAPIParam;
import com.intsig.csopen.sdk.CSOpenApiFactory;
import com.intsig.csopen.sdk.CSOpenApiHandler;

import java.text.SimpleDateFormat;

public class CamscannerActivity extends Activity {
    CSOpenAPI api;
    String _scannedFileUri;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Intent intent = this.getIntent();
        String srcUri = intent.getStringExtra("SRC_URI");
        String outputUri = intent.getStringExtra("OUTPUT_URI");
        int appResId = this.getResources().getIdentifier("camscanner_app_key", "string", this.getPackageName());
        String appKey = this.getString(appResId);
        api = CSOpenApiFactory.createCSOpenApi(this.getApplicationContext(), appKey, null);
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new java.util.Date());
        _scannedFileUri = outputUri + "/" + timeStamp;
        CSOpenAPIParam openApiParam = new CSOpenAPIParam(
                srcUri,
                _scannedFileUri + ".jpg",
                _scannedFileUri + ".pdf",
                _scannedFileUri + "_org.jpg",
                1.0f);
        boolean res = api.scanImage(this, 2, openApiParam);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        api.handleResult(requestCode, resultCode, data, new CSOpenApiHandler() {

            @Override
            public void onSuccess() {
                Intent databackIntent = new Intent();
                databackIntent.putExtra("RESULT", "success");
                databackIntent.putExtra("SCANNED_IMAGE_URI", _scannedFileUri + ".jpg");
                setResult(Activity.RESULT_OK, databackIntent);
                finish();
            }

            @Override
            public void onError(int errorCode) {
                Intent databackIntent = new Intent();
                databackIntent.putExtra("RESULT", "error");
                databackIntent.putExtra("ERROR", "There was an error creating the image. Error Code: " + errorCode);
                setResult(Activity.RESULT_OK, databackIntent);
                finish();
            }

            @Override
            public void onCancel() {
                Intent databackIntent = new Intent();
                databackIntent.putExtra("RESULT", "cancel");
                setResult(Activity.RESULT_OK, databackIntent);
                finish();
            }
        });
    }
}
