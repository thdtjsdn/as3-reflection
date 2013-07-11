#AS3 Reflection#

Small AS3 reflection for AVM2(avmplus) without access rights or bytecode modification.
Does not use leaky XML-version of describeType.

Example:

	var info:ClassInfo = ClassInfo.getClassInfo(MyClass);
	
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
    for each(var iface:String in info.interfaces) {
        trace("\t" + iface);
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
	

Bug report:

- [https://github.com/flashgate/as3-reflection/issues/new](https://github.com/flashgate/as3-reflection/issues/new)
 

