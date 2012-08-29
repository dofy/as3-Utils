package org.phpz.display.components.seven 
{
    import flash.display.DisplayObject;
    import flash.display.SimpleButton;
	import flash.display.Sprite;
    import flash.events.MouseEvent;
	
	/**
     * 简单按钮组件
     * @author Seven Yu
     */
    public class Button extends Sprite 
    {
        
        private var _normalButton:SimpleButton;
        private var _disableButton:Sprite;
        
        private var _enabled:Boolean = true;
        
        private var _clickHandler:Function;
        
        /**
         * 简单按钮组件
         * @param	upState      正常状态
         * @param	overState    悬停状态
         * @param	downState    按下状态
         * @param	disableState 不可用状态
         * @param	clickHandler 单击事件 (使用 event.currentTarget)
         */
        public function Button(upState:DisplayObject, overState:DisplayObject, downState:DisplayObject, disableState:DisplayObject, clickHandler:Function) 
        {
            _normalButton = new SimpleButton(upState, overState, downState, upState);
            _disableButton = disableState as Sprite;
            
            addChild(_normalButton);
            addChild(_disableButton);
            
            _clickHandler = clickHandler;
            
            enabled = true;
        }
        
        /**
         * 设置/获取 按钮可用状态
         */
        public function get enabled():Boolean 
        {
            return _enabled;
        }
        
        public function set enabled(value:Boolean):void 
        {
            _enabled = value;
            _normalButton.visible = value;
            _disableButton.visible = !value;
            if (value)
            {
                if (!this.hasEventListener(MouseEvent.CLICK))
                {
                    this.addEventListener(MouseEvent.CLICK, _clickHandler);
                }
            }
            else 
            {
                this.removeEventListener(MouseEvent.CLICK, _clickHandler);
            }
        }
        
    }

}