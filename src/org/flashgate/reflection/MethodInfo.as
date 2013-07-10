package org.flashgate.reflection {
import avmplus.factoryXml;

import flash.utils.getDefinitionByName;

public class MethodInfo extends MemberInfo {
    private var _params:Vector.<ParameterInfo>;
    private var _returnType:String;

    public function MethodInfo(info:Object, declaredBy:String = null, isStatic:Boolean = false) {
        super(info, declaredBy, isStatic);
        _returnType = info["returnType"] as String || "void";
    }

    public function get returnType():String {
        return _returnType;
    }

    public function get returnTypeInfo():ClassInfo {
        return ClassInfo.getClassInfo(_returnType);
    }

    public function get params():Vector.<ParameterInfo> {
        return _params || listParams(info["parameters"] as Array);
    }

    protected function listParams(items:Array):Vector.<ParameterInfo> {
        _params = new Vector.<ParameterInfo>();
        if (items) {
            for each (var item:Object in items) {
                _params.push(new ParameterInfo(item));
            }
        }
        return _params;
    }

    override public function toString():String {
        return super.toString() + "(" + params.join(", ") + "):" + _returnType;
    }
}
}

