package org.phpz.slib.utils
{
    import flash.display.LoaderInfo;
    
    /**
     * 获取 FlashVars 参数
     * @author Seven Yu
     */
    public final class FlashVars
    {
        
        private static var params:Object;
        
        /**
         * 初始化, 需传入 LoaderInfo
         * @param	info
         */
        public static function init(info:LoaderInfo):void
        {
            params = info.parameters;
        }
        
        /**
         * 取值
         * @param	key           参数键名
         * @param	defaultValue  默认值
         * @return
         */
        public static function getParam(key:String, defaultValue:* = null):*
        {
            return key in params ? params[key] : defaultValue;
        }
    
    }

}