package org.phpz.slib.utils
{
    import flash.events.NetStatusEvent;
    import flash.net.SharedObject;
    
    /**
     * ShareObject 操作类
     * @author Seven Yu
     */
    public final class SOProxy
    {
        
        private static var _so:SharedObject;
        
        private static var _name:String;
        private static var _path:String;
        
        
        /**
         * 初始化
         * @param	name   数据键值
         * @param	path   数据路径
         */
        public static function init(name:String, path:String = null, version:String = 'NoVersion'):void
        {
            try
            {
                _name = name;
                _path = path;
                _so = SharedObject.getLocal(name, path);
                checkVersion(version);
            }
            catch (e:Error)
            {
                trace(e);
            }
        }
        
        /**
         * 检查数据版本
         * @param	ver  数据版本号
         */
        static private function checkVersion(ver:String):void
        {
            trace('SO version', ver);
            
            // 若版本不统一则先清除老数据
            if (getData('version') != ver)
            {
                clear();
            }
            setData('version', ver);
        }
        
        /**
         * 初始化标识
         * @return 是否已经
         */
        private static function get hasSO():Boolean
        {
            return _so != null;
        }
        
        /**
         * 保存数据
         * @param	key
         * @param	value
         */
        public static function setData(key:String, value:*):void
        {
            if (hasSO)
            {
                try
                {
                    _so.data[key] = value;
                    _so.flush();
                }
                catch (e:Error)
                {
                    trace(e);
                }
            }
        }
        
        /**
         * 获取数据
         * @param	key
         * @return
         */
        public static function getData(key:String, defaultValue:* = null):*
        {
            if (hasSO)
            {
                return _so.data[key] || defaultValue;
            }
            else
            {
                return defaultValue;
            }
        }
        
        /**
         * 删除数据
         * @param	key
         */
        public static function delData(key:String):void
        {
            hasSO && (delete _so.data[key]);
        }
        
        /**
         * 清除全部数据
         */
        public static function clear():void
        {
            hasSO && _so.clear();
        }
    
    }


}