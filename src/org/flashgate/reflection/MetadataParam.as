package org.flashgate.reflection {

public class MetadataParam {

    private var _name:String;
    private var _value:String;

    public function MetadataParam(info:Object) {
        _name = info["key"] as String;
        _value = info["value"] as String;
    }

    public function get name():String {
        return _name;
    }

    public function get value():String {
        return _value;
    }

    public function toString():String {
        return _name ? _name + "=" + _value : _value;
    }
}
}

