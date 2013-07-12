package org.flashgate.reflection {
import avmplus.AVMPlusAdapter;
import avmplus.getQualifiedClassName;

import flash.utils.Dictionary;
import flash.utils.getDefinitionByName;

public class ClassInfo {

    protected static var _cache:Dictionary = new Dictionary(true);

    public static function getClassInfoByName(name:String):ClassInfo {
        return getClassInfo(getDefinitionByName(name) as Class);
    }

    public static function getClassInfoByInstance(instance:Object):ClassInfo {
        return instance == null ? null : getClassInfo((instance as Object).constructor as Class);
    }

    public static function getClassInfo(type:Class):ClassInfo {
        return type ? _cache[type] || (_cache[type] = new ClassInfo(type)) : null;
    }

    private var _type:Class;
    private var _statics:Boolean;

    private var _name:String;
    private var _short:String;
    private var _package:String;
    private var _bases:Vector.<String>;
    private var _interfaces:Vector.<String>;
    private var _params:Vector.<ParameterInfo>;
    private var _methods:Vector.<MethodInfo>;
    private var _fields:Vector.<FieldInfo>;
    private var _metadata:Vector.<MetadataInfo>;
    private var _traits:Object;
    private var _instance:Object;

    public function ClassInfo(type:Class, discoverStaticMembers:Boolean = true) {
        _type = type;
        _statics = discoverStaticMembers;
        _name = getQualifiedClassName(type);

        var index:int = _name.indexOf("::");
        if (index != -1) {
            _package = _name.substr(0, index);
            _short = _name.substring(index + 2);
        } else {
            _package = "";
            _short = _name;
        }
    }

    protected function get traits():Object {
        return _traits || (_traits = AVMPlusAdapter.describeTypeJson(_type, AVMPlusAdapter.INCLUDE_ALL_TRAITS));
    }

    protected function get instance():Object {
        return _instance || (_instance = AVMPlusAdapter.describeTypeJson(_type, AVMPlusAdapter.INCLUDE_ALL_ITRAITS));
    }

    public function get name():String {
        return _name;
    }

    public function get shortName():String {
        return _short;
    }

    public function get packageName():String {
        return _package;
    }

    public function get isDynamic():Boolean {
        return instance["isDynamic"] as Boolean;
    }

    public function get isFinal():Boolean {
        return instance["isFinal"] as Boolean;
    }

    public function get superClass():String {
        var bases:Vector.<String> = this.baseClasses;
        return bases.length ? bases[0] : null;
    }

    public function get baseClasses():Vector.<String> {
        return _bases || (_bases = Vector.<String>(instance["traits"]["bases"]));
    }

    public function get interfaces():Vector.<String> {
        return _interfaces || (_interfaces = Vector.<String>(instance["traits"]["interfaces"]));
    }

    public function get methods():Vector.<MethodInfo> {
        return _methods || (_methods = listMethods());
    }

    public function getMethod(name:String):MethodInfo {
        for each(var method:MethodInfo in methods) {
            if (method.name == name) {
                return method;
            }
        }
        return null;
    }

    public function get fields():Vector.<FieldInfo> {
        return _fields || (_fields = listFields());
    }

    public function getField(name:String):FieldInfo {
        for each(var field:FieldInfo in fields) {
            if (field.name == name) {
                return field;
            }
        }
        return null;
    }

    public function get constructorParams():Vector.<ParameterInfo> {
        return _params || (_params = listConstructorParams());
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

    private function listMethods():Vector.<MethodInfo> {
        var result:Vector.<MethodInfo> = new Vector.<MethodInfo>();
        var item:Object;
        for each (item in instance["traits"]["methods"]) {
            result.push(new MethodInfo(item));
        }
        if (_statics) {
            for each (item in traits["traits"]["methods"]) {
                result.push(new MethodInfo(item, _name, true));
            }
        }
        return result;
    }

    private function listMetadata():Vector.<MetadataInfo> {
        var result:Vector.<MetadataInfo> = new Vector.<MetadataInfo>();
        for each (var item:Object in instance["traits"]["metadata"]) {
            result.push(new MetadataInfo(item));
        }
        return result;
    }

    private function listFields():Vector.<FieldInfo> {
        var result:Vector.<FieldInfo> = new Vector.<FieldInfo>();
        var item:Object;
        for each (item in instance["traits"]["variables"]) {
            result.push(new FieldInfo(item));
        }
        for each (item in instance["traits"]["accessors"]) {
            result.push(new FieldInfo(item));
        }
        if (_statics) {
            for each (item in traits["traits"]["variables"]) {
                result.push(new FieldInfo(item, _name, true));
            }
            for each (item in traits["traits"]["accessors"]) {
                result.push(new FieldInfo(item, _name, true));
            }
        }
        return result;
    }

    private function listConstructorParams():Vector.<ParameterInfo> {
        var result:Vector.<ParameterInfo> = new Vector.<ParameterInfo>();
        for each (var info:Object in instance["traits"]["constructor"]) {
            result.push(new ParameterInfo(info));
        }
        return result;
    }

    public function toString():String {
        return metadata.join("") + _name + "(" + constructorParams.join(", ") + ")";
    }
}
}