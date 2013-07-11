package org.flashgate.reflection {
import flash.utils.getDefinitionByName;

public class MemberInfo {

    private var _info:Object;
    private var _uri:String;
    private var _name:String;
    private var _declaredBy:String;
    private var _metadata:Vector.<MetadataInfo>;
    private var _static:Boolean;

    public function MemberInfo(info:Object, declaredBy:String = null, isStatic:Boolean = false) {
        _info = info;
        _uri = info["uri"] as String;
        _name = info["name"] as String;
        _declaredBy = declaredBy || info["declaredBy"] as String;
        _static = isStatic;
    }

    public function get uri():String {
        return _uri;
    }

    public function get name():String {
        return _name;
    }

    public function get isStatic():Boolean {
        return _static;
    }

    public function get declaredBy():String {
        return _declaredBy;
    }

    public function get metadata():Vector.<MetadataInfo> {
        return _metadata || (_metadata = listMetadata());
    }

    public function getMetadata(name:String):MetadataInfo {
        for each(var meta:MetadataInfo in metadata) {
            if (meta.name == name) {
                return meta;
            }
        }
        return null;
    }

    private function listMetadata():Vector.<MetadataInfo> {
        var result:Vector.<MetadataInfo> = new Vector.<MetadataInfo>();
        for each (var item:Object in info["metadata"]) {
            result.push(new MetadataInfo(item));
        }
        return result;
    }

    protected function get info():Object {
        return _info;
    }

    public function toString():String {
        return metadata.join("") + _declaredBy + "." + (_uri ? _uri + ":" + _name : _name);
    }
}
}