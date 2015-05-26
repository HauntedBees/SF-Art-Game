package {
	/**
	 * Shitty Fucking Art Game
	 * @author Sean Finch
	 * @version 27APR2011
	 */
	/*	Copyright © 2011 - 2015 Sean Finch

    This file is part of Shitty Fucking Art Game.

    bang is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    bang is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with bang.  If not, see <http://www.gnu.org/licenses>. */
	public class MirrorValue {
		private var keys:uint;
		private var click:Boolean;
		private var ang:Number;
		public function MirrorValue(k:uint, c:Boolean, a:Number) {
			keys = k;
			click = c;
			ang = a;
		}
		public function cleanUp():void {
			keys = 0;
			ang = 0;
		}
		public function gKey():uint {
			return keys;
		}
		public function gClick():Boolean {
			return click;
		}
		public function gAng():Number {
			return ang;
		}
	}
}