package avmplus {

/**
 * AVM2(avmplus) Adapter
 */
public class AVMPlusAdapter {

    public static const INCLUDE_BASES:uint = avmplus.INCLUDE_BASES;
    public static const INCLUDE_INTERFACES:uint = avmplus.INCLUDE_INTERFACES;
    public static const INCLUDE_VARIABLES:uint = avmplus.INCLUDE_VARIABLES;
    public static const INCLUDE_ACCESSORS:uint = avmplus.INCLUDE_ACCESSORS;
    public static const INCLUDE_METHODS:uint = avmplus.INCLUDE_METHODS;
    public static const INCLUDE_METADATA:uint = avmplus.INCLUDE_METADATA;
    public static const INCLUDE_CONSTRUCTOR:uint = avmplus.INCLUDE_CONSTRUCTOR;
    public static const INCLUDE_TRAITS:uint = avmplus.INCLUDE_TRAITS;
    public static const USE_ITRAITS:uint = avmplus.USE_ITRAITS;

    public static const HIDE_NSURI_METHODS:uint = avmplus.HIDE_NSURI_METHODS;
    public static const HIDE_OBJECT:uint = avmplus.HIDE_OBJECT;
    public static const FLASH10_FLAGS:uint = avmplus.FLASH10_FLAGS;

    public static const INCLUDE_ALL_TRAITS:uint = FLASH10_FLAGS | INCLUDE_METADATA | INCLUDE_METHODS | INCLUDE_VARIABLES | INCLUDE_ACCESSORS | INCLUDE_TRAITS;
    public static const INCLUDE_ALL_ITRAITS:uint = FLASH10_FLAGS | INCLUDE_BASES | INCLUDE_CONSTRUCTOR | INCLUDE_INTERFACES | INCLUDE_METHODS | INCLUDE_VARIABLES | INCLUDE_ACCESSORS | INCLUDE_METADATA | USE_ITRAITS;

    public static function describeTypeXml(object:*, flags:uint):XML {
        return describeType(object, flags);
    }

    public static function describeTypeJson(object:*, flags:uint):Object {
        return describeTypeJSON(object, flags);
    }
}
}