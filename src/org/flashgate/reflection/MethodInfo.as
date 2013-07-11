package org.flashgate.reflection {

public class MethodInfo extends MemberInfo {

    private var _params:Vector.<ParameterInfo>;
    private var _returnType:String;

    public function MethodInfo(info:Object, declaredBy:String = null, isStatic:Boolean = false) {
        super(info, declaredBy, isStatic);
        _returnType = info["returnType"] as String;
    }

    public function get returnType():String {
        return _returnType;
    }

    public function get params():Vector.<ParameterInfo> {
        return _params || (_params = listParams());
    }

    protected function listParams():Vector.<ParameterInfo> {
        var result:Vector.<ParameterInfo> = new Vector.<ParameterInfo>();
        for each (var item:Object in info["parameters"]) {
            result.push(new ParameterInfo(item));
        }
        return result;
    }

    override public function toString():String {
        return super.toString() + "(" + params.join(", ") + "):" + (_returnType || "void");
    }
}
}

