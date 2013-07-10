package org.flashgate.reflection {

public class MetadataInfo {
    private var _info:Object;
    private var _name:String;
    private var _params:Vector.<MetadataParam>;

    public function MetadataInfo(info:Object) {
        _info = info;
        _name = info["name"] as String;
    }

    public function get params():Vector.<MetadataParam> {
        return _params || listParams(_info["value"] as Array);
    }

    private function listParams(items:Array):Vector.<MetadataParam> {
        _params = new Vector.<MetadataParam>();
        if (items) {
            for each (var item:Object in items) {
                _params.push(new MetadataParam(item));
            }
        }
        return _params;
    }

    public function toString():String {
        var params:Vector.<MetadataParam> = this.params;
        return "[" + _name + (params.length ? "(" + params.join(",") + ")]" : "]");
    }
}
}

