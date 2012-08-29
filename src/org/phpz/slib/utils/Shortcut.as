package org.phpz.slib.utils
{
    import flash.display.Stage;
    import flash.events.KeyboardEvent;
    
    /**
     * 快捷键管理器
     * @author Seven Yu
     */
    public final class Shortcut
    {
        
        // 注册/注销快捷键动作
        private static const ACTION_ADD:int = 1;
        private static const ACTION_DEL:int = -1;
        
        // 保存按键与方法映射
        private static var _keyMaps:Object = {};
        
        // 绑定键盘监听的 stage
        private static var _stage:Stage;
        
        // 是否开始监听标记 (可以暂停全部监听, 改造成非静态类可以按需暂停/监听)
        private static var _started:Boolean = false;
        
        // 事件类型对应方法计数器
        private static var _upFuncsCount:int = 0;
        private static var _downFuncsCount:int = 0;
        
        /**
         * 初始化
         * @param	stage     绑定键盘事件的 stage
         * @param	autoStart 自动开始监听 (默认: false)
         */
        public static function init(stage:Stage, autoStart:Boolean = false):void
        {
            _stage = stage;
            autoStart && start();
        }
        
        /**
         * 开始监听键盘事件
         */
        public static function start():void
        {
            if (_stage)
            {
                _started = true;
            }
        }
        
        /**
         * 停止监听
         */
        public static function stop():void
        {
            _started = false;
        }
        
        
        /**
         * 处理快捷键响应
         * @param	evt
         */
        private static function keyHandler(evt:KeyboardEvent):void
        {
            trace('event type:', evt.type, 'key code:', evt.keyCode);
            if (!_started)
            {
                return;
            }
            var keyName:String = getKeyName(evt.type, evt.keyCode);
            if (keyName in _keyMaps)
            {
                var funcs:Array = _keyMaps[keyName].concat();
                for (var i:int = 0, len:int = funcs.length; i < len; i++)
                {
                    funcs[i]();
                }
            }
        }
        
        /**
         * 注册快捷键
         * @param	keyCode
         * @param	func
         * @param	type
         */
        public static function register(keyCode:int, func:Function, type:String = 'keyUp'):void
        {
            trace('shortcat.register', keyCode);
            var keyName:String = getKeyName(type, keyCode);
            if (keyName in _keyMaps)
            {
                trace(_keyMaps[keyName].indexOf(func));
                if (_keyMaps[keyName].indexOf(func) == -1)
                {
                    _keyMaps[keyName].push(func);
                    checkFuncs(type, ACTION_ADD);
                }
            }
            else
            {
                _keyMaps[keyName] = [func];
                checkFuncs(type, ACTION_ADD);
            }
        }
        
        /**
         * 注销快捷键
         * @param	keyCode
         * @param	func
         * @param	type
         */
        public static function unregister(keyCode:int, func:Function, type:String = 'keyUp'):void
        {
            trace('shortcat.unregister', keyCode);
            var keyName:String = getKeyName(type, keyCode);
            if (keyName in _keyMaps)
            {
                var funcIndex:int = _keyMaps[keyName].indexOf(func);
                if (funcIndex >= 0)
                {
                    _keyMaps[keyName].splice(funcIndex, 1);
                    checkFuncs(type, ACTION_DEL);
                }
            }
        }
        
        /**
         * 检测注册函数数, 以确定绑定或移除事件监听
         * @param	type   事件类型
         * @param	action 动作(添加或移除)
         */
        private static function checkFuncs(type:String, action:int):void
        {
            trace('check funcs', type, action);
            if (!_stage)
            {
                throw new Error('Please call Shortcut.init method first.');  
            }
            switch (type)
            {
                case KeyboardEvent.KEY_UP: 
                {
                    _upFuncsCount += action;
                    if (1 == _upFuncsCount)
                    {
                        _stage.addEventListener(KeyboardEvent.KEY_UP, keyHandler);
                    }
                    if (0 == _upFuncsCount)
                    {
                        _stage.removeEventListener(KeyboardEvent.KEY_UP, keyHandler);
                    }
                    break;
                }
                case KeyboardEvent.KEY_DOWN: 
                {
                    _downFuncsCount += action;
                    if (1 == _downFuncsCount)
                    {
                        _stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
                    }
                    if (0 == _downFuncsCount)
                    {
                        _stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
                    }
                    break;
                }
                default: 
                {
                    throw new Error('KeyboardEvent.KEY_UP & KeyboardEvent.KEY_DOWN only.');
                    break;
                }
            }
        }
        
        /**
         * 获取映射名
         * @param	type    事件类型
         * @param	keyCode 按键键值
         * @return  形如 type_keyCode 的字符串
         */
        private static function getKeyName(type:String, keyCode:int):String
        {
            return [type, keyCode].join('_');
        }
        
        /**
         * 是否已开始监听
         */
        static public function get started():Boolean
        {
            return _started;
        }
    }

}