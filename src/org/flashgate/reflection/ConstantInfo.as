package org.flashgate.reflection {
import flash.utils.getDefinitionByName;

import org.flashgate.reflection.MemberInfo;

public class ConstantInfo extends MemberInfo {
    private var _type:String;

    public function ConstantInfo(info:Object, declaredBy:String = null, isStatic:Boolean = false) {
        super(info, declaredBy, isStatic);
        _type = info["type"] as String;
    }

    public function get type():String {
        return _type;
    }

    override public function toString():String {
        return super.toString() + ":" + _type;
    }
}
}

