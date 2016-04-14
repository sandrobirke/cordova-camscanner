module.exports = {
  scan : function(srcUri, outputUri, successCallback, failureCallback) {
    cordova.exec(successCallback, failureCallback, "CordovaCamscanner", "scan", [srcUri, outputUri]);
  }
}
