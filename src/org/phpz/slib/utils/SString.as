package org.phpz.slib.utils 
{
	/**
     * ...
     * @author Seven Yu
     */
    public final class SString 
    {
        
        public static const FULL_PLACE_BEFORE:String = 'before';
        public static const FULL_PLACE_AFTER:String = 'after';
        
        
        /**
         * 用指定字符填充字符串到指定长度
         * @param	str  要被填充的字符串
         * @param	len  目标长度
         * @param	char 填充字符
         * @return  填充结果
         */
        public static function fill(str:String, len:uint, char:String = ' ', place:String = FULL_PLACE_BEFORE):String
        {
            var plus:String = new Array(len+1).join(char);
            return FULL_PLACE_BEFORE == place ? plus + str : str + plus;
        }
        
        /**
         * 
         * @param	string
         * @return
         */
        public static function ltrim(string:String):String
        {
            return string.replace(/^\s+/, '');
        }
        
        
        /**
         * 
         * @param	string
         * @return
         */
        public static function rtrim(string:String):String
        {
            return string.replace(/\s+$/, '');
        }
        
        /**
         * 
         * @param	string
         * @return
         */
        public static function trim(string:String):String
        {
            return string.replace(/^\s+|\s+$/g, '');
        }
        
        /**
         * trim2
         * @param	string
         * @param	search  默认为去除空白符, 可以其他任意字符
         * @return
         */
        public static function trim2(string:String, search:String = '\\s'):String
        {
            var reg:RegExp = new RegExp('^(?:' + search + ')+|(?:' + search + ')+$', 'g');
            if (string)
            {
                return string.replace(reg, '');
            }
            else
            {
                return '';
            }
        }
        
        /**
         * 格式化字符串
         * format('This {0} a {1}.', 'is', 'test');
         * // return This is a test.
         * @param	format     格式
         * @param	... items  替换项
         * @return  格式化后的字符串
         */
        public static function format(format:String, ... items):String
        {
            var reg:RegExp;
            for (var i:int = 0, len:int = items.length; i < len; i++) 
            {
                format = format.replace(new RegExp('\\{' + i + '\\}', 'g'), items[i]);
            }
            return format;
        }
        
    }

}