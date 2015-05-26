package {
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
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
	public class GamePlacard {
		private var _bgL:DisplayObjectContainer;
		private var _plL:DisplayObjectContainer;
		public var backing:MovieClip;
		private var state:int;
		private var pressZ:Sprite;
		private var timer:int;
		public function GamePlacard(bg:DisplayObjectContainer, ex:DisplayObjectContainer, mode:int) {
			_bgL = bg;
			_plL = ex;
			state = mode;
			timer = 60;
			switch(state) {
				case 4:
					backing = new howplay();
					break;
				case 3:
					backing = new opening();
					break;
				case 2:
					backing = new diary();
					var B:int = SelectionMemory.diaryEntries[Math.ceil(SelectionMemory.diaryEntries.length * Math.random())];
					var XI:int = SelectionMemory.diaryEntries.indexOf(B); 
					SelectionMemory.diaryEntries.splice(XI, 1);
					backing.gotoAndStop(B);
					break;
				default:
					backing = new titleCard();
					backing.gotoAndStop(SelectionMemory.day);
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.dunDun.play();
					}
					if (SelectionMemory.day != 5) {
						var BB:int = SelectionMemory.dayPlacardSlogans[Math.ceil(SelectionMemory.dayPlacardSlogans.length * Math.random())];
						var XII:int = SelectionMemory.dayPlacardSlogans.indexOf(BB); 
						SelectionMemory.dayPlacardSlogans.splice(XII, 1);
						backing.subtitle.gotoAndStop(BB);
					}
					break;
			}
			backing.x = 240 - 0.5;
			backing.y = 120;
			_bgL.addChild(backing);
			pressZ = new zbutton();
			pressZ.x = 480 + pressZ.width / 2;
			pressZ.y = 240 - pressZ.height / 2;
			_plL.addChild(pressZ);
		}
		public function BLASTSHEEP():void {
			backing.gotoAndPlay(328);
		}
		public function getState():int {
			return state;
		}
		public function getTimer():int {
			return timer;
		}
		public function cleanUp():void {
			_bgL.removeChild(backing);
			_plL.removeChild(pressZ);
			backing = null;
			pressZ = null;
		}
		public function update():void {
			if (state != 3) {
				if (timer > 0) {
					timer--;
				} else if (pressZ.x > (480 - pressZ.width / 2)) {
					pressZ.x -= 4;
				}
			}
		}
	}
}