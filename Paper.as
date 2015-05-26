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
	public class Paper {
		private var icon:MovieClip;
		private var _parent:DisplayObjectContainer;
		public function Paper(parent:DisplayObjectContainer) {
			_parent = parent;
			icon = new papers();
			icon.x += 240;
			icon.y += 95;
			icon.scaleX = 2;
			icon.scaleY = 2;
			var j:int = Math.floor(SelectionMemory.WriterLevels.length * Math.random());
			icon.gotoAndStop(SelectionMemory.WriterLevels[j]);
			SelectionMemory.WriterLevels.splice(j, 1);
			icon.rotation = -1 + 2 * Math.random();
			_parent.addChild(icon);
		}
		public function update():void {
			icon.scaleX -= 0.1;
			icon.scaleY -= 0.1;
		}
		public function cleanUp():void {
			_parent.removeChild(icon);
			icon = null;
		}
	}
}