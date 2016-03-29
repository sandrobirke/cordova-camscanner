module.exports = {
  cordovaCamscanner : function(srcUri, outputUri, successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "CordovaCamscanner", "scan", [srcUri, outputUri]);
  }
}
