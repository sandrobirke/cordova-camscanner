package com.beelphegor.cordovacamscanner;

import android.content.Context;
import android.content.Intent;

import com.intsig.csopen.sdk.CSOpenAPI;
import com.intsig.csopen.sdk.CSOpenAPIParam;
import com.intsig.csopen.sdk.CSOpenApiFactory;
import com.intsig.csopen.sdk.CSOpenApiHandler;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.text.SimpleDateFormat;

/**
 * Created by Juanjo on 16/03/2016.
 */
public class CordovaCamscanner extends CordovaPlugin {
    CSOpenAPI api;
    CallbackContext _callbackContext;
    String _scannedFileUri;
    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        _callbackContext = callbackContext;

        try{
            if(action.equals("scan")) {
                String srcUri = args.getString(0);
                String outputUri = args.getString(1);
                validateInputs(srcUri, outputUri);
                Context context = this.cordova.getActivity().getApplicationContext();
                int appResId = cordova.getActivity().getResources().getIdentifier("camscanner_app_key", "string", cordova.getActivity().getPackageName());
                String appKey = cordova.getActivity().getString(appResId);
                api = CSOpenApiFactory.createCSOpenApi(context, appKey, null);

                String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new java.util.Date());
                _scannedFileUri = outputUri + "/" + timeStamp;
                CSOpenAPIParam openApiParam = new CSOpenAPIParam(
                        srcUri,
                        _scannedFileUri + ".jpg",
                        _scannedFileUri + ".pdf",
                        _scannedFileUri + "_org.jpg",
                        1.0f);
                boolean res = api.scanImage(this.cordova.getActivity(), 2, openApiParam);
                return true;
            }
        }catch (Exception e){
            callbackContext.error(e.getMessage());
            return false;
        }
        return false;
    }

    @Override
    public void  onActivityResult(int requestCode, int resultCode, Intent data){
        if(requestCode == 2){
            api.handleResult(requestCode, resultCode, data, new CSOpenApiHandler() {

                @Override
                public void onSuccess() {
                    _callbackContext.success(_scannedFileUri + ".jpg");
                }

                @Override
                public void onError(int errorCode) {

                }

                @Override
                public void onCancel() {

                }
            });
        }
    }

    public void validateInputs(String srcUri, String outputUri) throws InvalidInputException {
        if(srcUri == null || srcUri.isEmpty()){
            throw new InvalidInputException("invalid value for parameter: srcUri");
        }
        if(outputUri == null || outputUri.isEmpty()){
            throw new InvalidInputException("invalid value for parameter: outputUri");
        }
    }
}

class InvalidInputException extends Exception {
    public InvalidInputException(String message) {
        super(message);
    }
}
