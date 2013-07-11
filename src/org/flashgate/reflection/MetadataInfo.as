package org.flashgate.reflection {

public class MetadataInfo {

    private var _info:Object;
    private var _name:String;
    private var _params:Vector.<MetadataParam>;

    public function MetadataInfo(info:Object) {
        _info = info;
        _name = info["name"] as String;
    }

    public function get name():String {
        return _name;
    }

    public function get params():Vector.<MetadataParam> {
        return _params || (_params = listParams());
    }

    public function getParam(name:String):MetadataParam {
        for each(var item:MetadataParam in params) {
            if (item.name == name) {
                return item;
            }
        }
        return null;
    }

    protected function get info():Object {
        return _info;
    }

    private function listParams():Vector.<MetadataParam> {
        var result:Vector.<MetadataParam> = new Vector.<MetadataParam>();
        for each (var item:Object in info["value"]) {
            result.push(new MetadataParam(item));
        }
        return result;
    }

    public function toString():String {
        var params:Vector.<MetadataParam> = this.params;
        return "[" + _name + (params.length ? "(" + params.join(",") + ")]" : "]");
    }
}
}

