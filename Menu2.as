package {
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.ID3Info;
	import flash.media.Sound;
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
	public class Menu2 {
		private var _bgL:DisplayObjectContainer;
		private var backing:MovieClip;
		private var state:int;
		private var musVal:int;
		private var playing:Boolean;
		private var curSound:Sound;
		public function Menu2(bg:DisplayObjectContainer) {
			_bgL = bg;
			backing = new bonusmenu();
			backing.gotoAndStop(1);
			backing.x = backing.width / 2;
			backing.y = backing.height / 2;
			_bgL.addChild(backing);
			state = 1;
			musVal = 0;
			playing = false;
		}
		public function cleanUp():void {
			_bgL.removeChild(backing);
			backing = null;
		}
		public function update(keys:uint):int {
			if (state == 1) {
				if (keys & 1) {
					return 1;
				} else if (keys & 2) {
					state = 10;
					backing.gotoAndStop(10);
				} else if (keys & 4) {
					state = 2;
					backing.gotoAndStop(2);
				} else if (keys & 8) {
					return 9;
				} else if (keys & 32) {
					state = 11;
					backing.gotoAndStop(11);
				} else if (keys & 512) {
					state = 12;
					backing.gotoAndStop(12);
					curSound = Sound(SelectionMemory.sHandler.entirety[musVal]);
					backing.ttitle.text = MusicArray(SelectionMemory.sHandler.entiretyTEXT[musVal]).title;
					backing.tartist.text = MusicArray(SelectionMemory.sHandler.entiretyTEXT[musVal]).artist;
					backing.ttrack.text = "TRACK: " + (musVal + 1)  + " OF 70";
					backing.tpercent.text = "[0%]";
					SelectionMemory.sHandler.MusicPlay.addEventListener(Event.SOUND_COMPLETE, soundEnd);
				} else if (keys & 16) {
					return 13;
				}
			} else if (state >= 2 && state <= 9) {
				if (keys & 1) {
					state -= 1;
					if (state <= 1) {
						state = 9;
					}
					backing.gotoAndStop(state);
				} else if (keys & 4) {
					state += 1;
					if (state >= 10) {
						state = 2;
					}
					backing.gotoAndStop(state);
				} else if (keys & 2) {
					if (state == 9) {
						state = 1;
						backing.gotoAndStop(1);
					} else {
						return state;
					}
				}
			} else if (state == 10) {
				if (keys & 4) {
					state = 1;
					backing.gotoAndStop(1);
				} else if (keys & 2) {
					return 10;
				} else if (keys & 1) {
					return 9;
				}
			} else if (state == 11) {
				if (keys & 1) {
					state = 1;
					backing.gotoAndStop(1)
				}
			} else if (state == 12) {
				if (keys & 1) {
					SelectionMemory.sHandler.MusicPlay.stop();
					var bb:int = 0;
					if (musVal <= 11 && musVal > 0) {
						bb = 99;
					}
					SelectionMemory.sHandler.MusicPlay = Sound(SelectionMemory.sHandler.entirety[musVal]).play(0, bb);
					SelectionMemory.sHandler.MPL = Sound(SelectionMemory.sHandler.entirety[musVal]).length;
					playing = true;
				} else if (keys & 2) {
					SelectionMemory.sHandler.MusicPlay.stop();
				}
				if (keys & 64) {
					musVal -= 1;
					if (musVal < 0) { musVal = SelectionMemory.sHandler.entirety.length - 1; }
					backing.ttitle.text = MusicArray(SelectionMemory.sHandler.entiretyTEXT[musVal]).title;
					backing.tartist.text = MusicArray(SelectionMemory.sHandler.entiretyTEXT[musVal]).artist;
					backing.ttrack.text = "TRACK: " + (musVal + 1)  + " OF 70";
				} else if (keys & 128) {
					musVal += 1;
					if (musVal >= SelectionMemory.sHandler.entirety.length) { musVal = 0; }
					backing.ttitle.text = MusicArray(SelectionMemory.sHandler.entiretyTEXT[musVal]).title;
					backing.tartist.text = MusicArray(SelectionMemory.sHandler.entiretyTEXT[musVal]).artist;
					backing.ttrack.text = "TRACK: " + (musVal + 1)  + " OF 70";
				}
				if (playing) {
					backing.tpercent.text = "[" + Math.round(100 * (SelectionMemory.sHandler.MusicPlay.position / SelectionMemory.sHandler.MPL)) + "%]";
				}
				if (keys & 256) {
					SelectionMemory.sHandler.MusicPlay.stop();
					SelectionMemory.sHandler.MusicPlay.removeEventListener(Event.SOUND_COMPLETE, soundEnd);
					state = 1;
					backing.gotoAndStop(1);
				}
			}
			return 0;
		}
		private function soundEnd(e:Event):void {
			playing = false;
			backing.tpercent.text = "[0%]";
		}
	}
}