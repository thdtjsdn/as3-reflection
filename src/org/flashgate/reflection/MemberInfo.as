package org.flashgate.reflection {
import flash.utils.getDefinitionByName;

public class MemberInfo {
    private var _info:Object;
    private var _uri:String;
    private var _name:String;
    private var _declaredBy:String;
    private var _metadata:Vector.<MetadataInfo>;
    private var _isStatic:Boolean;

    public function MemberInfo(info:Object, declaredBy:String = null, isStatic:Boolean = false) {
        _info = info;
        _uri = info["uri"] as String;
        _name = info["name"] as String;
        _declaredBy = declaredBy || info["declaredBy"] as String;
        _isStatic = isStatic;
    }

    public function get uri():String {
        return _uri;
    }

    public function get name():String {
        return _name;
    }

    public function get isStatic():Boolean {
        return _isStatic;
    }

    public function get declaredBy():String {
        return _declaredBy;
    }

    public function get declaredByInfo():ClassInfo {
        return ClassInfo.getClassInfo(_declaredBy);
    }

    public function get metadata():Vector.<MetadataInfo> {
        return _metadata || listMetadata(_info["metadata"] as Array);
    }

    private function listMetadata(items:Array):Vector.<MetadataInfo> {
        _metadata = new Vector.<MetadataInfo>();
        if (items) {
            for each (var item:Object in items) {
                _metadata.push(new MetadataInfo(item));
            }
        }
        return _metadata;
    }

    protected function get info():Object {
        return _info;
    }

    public function toString():String {
        return metadata.join("") + _declaredBy + "." + (_uri ? _uri + ":" + _name : _name);
    }
}
}