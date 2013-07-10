package {
import flash.display.Sprite;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;
import flash.utils.IExternalizable;

import org.flashgate.reflection.ClassInfo;
import org.flashgate.reflection.ConstantInfo;
import org.flashgate.reflection.FieldInfo;
import org.flashgate.reflection.MetadataInfo;
import org.flashgate.reflection.MethodInfo;

[SWF(width=640, height=480)]
public class DumpClassExample extends Sprite implements IExternalizable {

    public function DumpClassExample() {
        var info:ClassInfo = ClassInfo.getClassInfo(DumpClassExample);
        dump(info);
        //trace(describeType(DumpClassExample));

    }

    public static var test:int = 1;
    public static const TEST:String = "test";

    public static function dump(info:ClassInfo):void {
        trace("Class: " + info.name);
        trace("Superclass: " + info.superClass);
        trace("Package Name: " + info.packageName);
        trace("Short Name: " + info.shortName);
        trace("Is Dynamic: " + info.isDynamic);
        trace("Is Final: " + info.isFinal);

        trace("Metadata: ");
        for each(var metadata:MetadataInfo in info.metadata) {
            trace("\t" + metadata);
        }

        trace("Bases: ");
        for each(var base:String in info.baseClasses) {
            trace("\t" + base);
        }

        trace("Interfaces: ");
        for each(var item:String in info.interfaces) {
            trace("\t" + item);
        }

        trace("Fields: ");
        for each(var field:FieldInfo in info.fields) {
            var line:String = "\t";
            if (field.isStatic) line += "static ";
            if (field.metadata.length) line += field.metadata.join("") + " ";
            if (field.isReadable) line += "get ";
            if (field.isWritable) line += "set ";
            if (field.uri) line += field.uri + "::";
            line += field.name + ": ";
            line += field.type;
            trace(line);
        }

        trace("Methods: ");
        for each(var method:MethodInfo in info.methods) {
            var line:String = "\t"
            if (method.isStatic) line += "static ";
            if (method.metadata.length) line += method.metadata.join("") + " ";
            if (method.uri) line += method.uri + "::";
            line += method.name + "(" + method.params.join(", ") + "): " + method.returnType;
            trace(line);
        }
    }

    public function writeExternal(output:IDataOutput):void {
    }

    public function readExternal(input:IDataInput):void {
    }
}
}

