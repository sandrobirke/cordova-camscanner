# cordova-camscanner

## Install
Run `cordova plugin add cordova-camscanner ANDROID_APP_KEY=APP_KEY` replace `APP_KEY` with your key.

## Usage

`var srcUri = "/storage/extSdCard/DCIM/Camera/20160229_171353.jpg";`
`var outpuUri = "storage/emulated/legacy";`
`cordovaCamscanner.scan(srcUri , outpuUri, function(response){console.log("success: " + response);}, function(response){console.log("error: " + response);});`
