package {
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
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
	public class SmokeBlaster {
		private var smokes:Array;
		private var pX:int;
		private var pY:int;
		private var pW:int;
		private var pH:int;
		private var _parent:DisplayObjectContainer
		public function SmokeBlaster(parent:DisplayObjectContainer, x:int, y:int, w:int, h:int) {
			_parent = parent;
			pX = x;
			pY = y;
			pW = w;
			pH = h;
			smokes = [];
		}
		public function cleanUp():void {
			for each(var s:MovieClip in smokes) {
				_parent.removeChild(s);
				s = null;
			}
			smokes = [];
			pX = 0;
			pY = 0;
			pW = 0;
			pH = 0;
		}
		public function update():void {
			if (Math.random() > 0.75) {
				var smokeBall:MovieClip = new smokeCloud();
				smokeBall.x = pX - pW / 2 + Math.random() * pW;
				smokeBall.y = pY - pH / 2 + Math.random() * pH;
				_parent.addChild(smokeBall);
				smokes.push(smokeBall);
			}
		}
	}
}