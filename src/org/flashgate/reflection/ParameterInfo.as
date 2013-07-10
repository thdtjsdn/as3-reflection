package org.flashgate.reflection {

public class ParameterInfo {
    private var _type:String;
    private var _isOptional:Boolean;

    public function ParameterInfo(info:Object) {
        _type = info["type"] as String;
        _isOptional = info["optional"] as Boolean;
    }

    public function get type():String {
        return _type;
    }

    public function get isOptional():Boolean {
        return _isOptional;
    }

    public function toString():String {
        return _type;
    }
}
}

