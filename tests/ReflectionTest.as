package {
import flash.display.Bitmap;
import flash.display.Sprite;

import flexunit.framework.TestCase;

import org.flashgate.reflection.ClassInfo;
import org.flashgate.reflection.FieldInfo;
import org.flashgate.reflection.MetadataInfo;
import org.flashgate.reflection.MethodInfo;

dynamic final public class ReflectionTest extends TestCase {

    [Test]
    public function testClassInfo():void {
        var info:ClassInfo = ClassInfo.getClassInfo(ReflectionTest);
        assertEquals(info.shortName, "ReflectionTest");
        assertEquals(info.packageName, "");
        assertEquals(info.name, "ReflectionTest");
        assertEquals(info.isDynamic, true);
        assertEquals(info.isFinal, true);
    }

    [Test]
    public function testClassPackageInfo():void {
        var info:ClassInfo = ClassInfo.getClassInfo(Sprite);
        assertEquals(info.shortName, "Sprite");
        assertEquals(info.packageName, "flash.display");
        assertEquals(info.name, "flash.display::Sprite");
        assertEquals(info.isDynamic, false);
        assertEquals(info.isFinal, false);
    }

    [Test]
    public function testCache():void {
        assertEquals(ClassInfo.getClassInfo(Sprite), ClassInfo.getClassInfo(Sprite));
        assertEquals(ClassInfo.getClassInfoByName("flash.display::Sprite"), ClassInfo.getClassInfoByName("flash.display::Sprite"));
        assertEquals(ClassInfo.getClassInfoByInstance(new Sprite()), ClassInfo.getClassInfoByInstance(new Sprite()));
        assertEquals(ClassInfo.getClassInfo(null), null);
        assertEquals(ClassInfo.getClassInfoByInstance(null), null);
        assertEquals(ClassInfo.getClassInfoByName("flash.display::Sprite"), ClassInfo.getClassInfo(Sprite));
    }

    [Test]
    public function testConstructor():void {
        var info:ClassInfo = ClassInfo.getClassInfo(Bitmap);
        assertEquals(info.constructorParams[0].type, "flash.display::BitmapData");
    }

    [Test]
    public function testMethod():void {
        var info:ClassInfo = ClassInfo.getClassInfo(Sprite);
        var method:MethodInfo = info.getMethod("addChild");
        assertEquals(method.name, "addChild");
        assertEquals(method.params[0].type, "flash.display::DisplayObject");
        assertEquals(method.params[0].isOptional, false);
        assertEquals(method.returnType, "flash.display::DisplayObject");
        assertEquals(method.declaredBy, "flash.display::DisplayObjectContainer");
        assertEquals(method.isStatic, false);
    }

    [Test]
    public function testFields():void {
        var info:ClassInfo = ClassInfo.getClassInfo(Sprite);
        var field:FieldInfo = info.getField("alpha");
        assertEquals(field.type, "Number");
        assertEquals(field.declaredBy, "flash.display::DisplayObject");
        assertEquals(field.isReadable, true);
        assertEquals(field.isWritable, true);
        assertEquals(field.uri, null);
        assertEquals(field.isStatic, false);
        assertEquals(info.getField("numChildren").isWritable, false);
    }

    [Test]
    public function testStatic():void {
        var info:ClassInfo = ClassInfo.getClassInfo(Math);
        assertEquals(info.getField("PI").isStatic, true);
        assertEquals(info.getMethod("random").isStatic, true);
    }

    [Test]
    public function testBases():void {
        assertEquals(ClassInfo.getClassInfo(undefined), null);
        assertEquals(ClassInfo.getClassInfo(Object).superClass, null);
        assertEquals(ClassInfo.getClassInfo(Class).superClass, "Object");
    }

    [Test(description="test")]
    public function testMetadata():void {
        var meta:MetadataInfo = ClassInfo.getClassInfoByInstance(this).getMethod("testMetadata").getMetadata("Test");
        assertEquals(meta.name, "Test");
        assertEquals(meta.getParam("description").value, "test");
    }

    [Test]
    public function testNumbers():void {
        assertEquals(ClassInfo.getClassInfoByInstance(NaN).name, "Number");
        assertEquals(ClassInfo.getClassInfoByInstance(Number.POSITIVE_INFINITY).name, "Number");
        assertEquals(ClassInfo.getClassInfoByInstance(Number.NEGATIVE_INFINITY).name, "Number");
        assertEquals(ClassInfo.getClassInfoByInstance(0).name, "Number");
        assertEquals(ClassInfo.getClassInfo(int).name, "int");
        assertEquals(ClassInfo.getClassInfo(uint).name, "uint");
        assertEquals(ClassInfo.getClassInfo(Math).getField("PI").type, "Number");
    }

}
}