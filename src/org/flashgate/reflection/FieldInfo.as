package org.flashgate.reflection {
import flash.utils.getDefinitionByName;

public class FieldInfo extends MemberInfo {
    private var _type:String;
    private var _readable:Boolean;
    private var _writable:Boolean;

    public function FieldInfo(info:Object, declaredBy:String = null, isStatic:Boolean = false) {
        super(info, declaredBy, isStatic);
        _type = info["type"] as String;

        switch (info["access"]) {
            case "readonly":
                _readable = true;
                break;
            case "writeonly":
                _writable = true;
                break;
            default:
                _writable = true;
                _readable = true;
        }
    }

    public function get isReadable():Boolean {
        return _readable;
    }

    public function get isWritable():Boolean {
        return _writable;
    }

    public function get type():String {
        return _type;
    }

    public function get typeInfo():ClassInfo {
        return ClassInfo.getClassInfo(_type);
    }

    override public function toString():String {
        return super.toString() + ":" + _type;
    }
}
}

