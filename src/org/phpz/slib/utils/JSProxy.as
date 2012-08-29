package org.phpz.slib.utils
{
    import flash.external.ExternalInterface;
    
    /**
     * JS 类
     * @author Seven Yu
     */
    public final class JSProxy
    {
        private static var isInit:Boolean = false;
        
        private static var jsFunc:String;
        private static var funcDict:Object = {};
        
        /**
         * 初始化
         * @param	fn  js 函数名
         */
        public static function init(fn:String):void
        {
            jsFunc = fn;
            if (fn == null)
            {
                isInit = false;
                return;
            }
            if (ExternalInterface.available)
            {
                try
                {
                    isInit = true;
                    ExternalInterface.addCallback('exec', run);
                }
                catch (e:Error)
                {
                    isInit = false;
                }
            }
        }
        
        /**
         * flash 调 js
         * @param	func   方法名
         * @param	args   参数
         * @return
         */
        public static function call(func:String, args:* = null):*
        {
            if (available)
            {
                try
                {
                    return ExternalInterface.call(jsFunc + '.' + func, args);
                }
                catch (e:Error)
                {
                    return false;
                }
            }
            return false;
        }
        
        /**
         * js 调 flash
         * @param	key    方法名
         * @param	args   参数
         * @return
         */
        public static function run(key:String, args:* = null):*
        {
            if (funcDict[key])
            {
                return funcDict[key](args);
            }
            else
            {
                return null;
            }
        }
        
        /**
         * 注册 flash 方法
         * @param	key    方法 id
         * @param	func   方法实现
         */
        public static function register(key:String, func:Function):void
        {
            funcDict[key] = func;
        }
        
        public static function get available():Boolean
        {
            trace('js proxy is init:', isInit);
            return isInit && ExternalInterface.available;
        }
    
    }

}