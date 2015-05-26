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
	public class GameSpace {
		private var _layerBack:DisplayObjectContainer;
		private var _layerMidd:DisplayObjectContainer;
		private var _layerTopp:DisplayObjectContainer;
		private var background:Sprite;
		private var player:MovieClip;
		private var activeChunks:Array;
		private var Work:Sprite;
		private var timer:int;
		private var fadeToBlack:Sprite;
		public function GameSpace(bg:DisplayObjectContainer, md:DisplayObjectContainer, tp:DisplayObjectContainer) {
			_layerBack = bg;
			_layerMidd = md;
			_layerTopp = tp;
			activeChunks = [];
			background = new spacebg();
			background.y = -720;
			background.x = background.width / 2;
			_layerBack.addChild(background);
			player = new rocketShip();
			player.gotoAndStop(5);
			player.x = 240;
			player.y = 180;
			_layerTopp.addChild(player);
			timer = 0;
			Work = new employment();
			Work.x = player.x;
			Work.y = -Work.height;
			_layerTopp.addChild(Work);
			fadeToBlack = new pureBlack();
			fadeToBlack.x += fadeToBlack.width / 2;
			fadeToBlack.y += fadeToBlack.height / 2;
			fadeToBlack.alpha = 0;
			_layerTopp.addChild(fadeToBlack);
			SelectionMemory.space.getChunk(1, 9).render(_layerMidd, -75, -210);
			activeChunks.push(SelectionMemory.space.getChunk(1, 9));
		}
		public function cleanUp():void {
			for each(var c:Chunk in activeChunks) {
				c.derender(_layerMidd);
			}
			activeChunks = [];
			_layerTopp.removeChild(fadeToBlack);
			_layerTopp.removeChild(Work);
			_layerTopp.removeChild(player);
			fadeToBlack = null;
			Work = null;
			player = null;
			_layerBack.removeChild(background);
			background = null;
		}
		public function update(keys:uint):int {
			timer += 1;
			var dX:int = 0;
			if (keys & 1) {
				dX = 5;
			} else if (keys & 2) {
				dX = -5;
			}
			if (timer > 600) {
				Work.y += 1;
				if (Work.y > 150) {
					fadeToBlack.alpha += 0.025;
					if (fadeToBlack.alpha > 0.95) {
						return 1;
					}
				}
			}
			for each(var c:Chunk in activeChunks) {
				c.updateBlocks(player.x, player.y);
				var dY:int = 3;
				var update:int = c.shift(dX, dY);
				if (update > 0) {
					var A:int = SelectionMemory.space.findChunk(c);
					var cX:int = A % 3;
					var cY:int = (A - cX) / 3;
					if (update == 1) {
						cX += 1;
						if (cX >= 3) { cX = 0; }
						if (activeChunks.indexOf(SelectionMemory.space.getChunk(cX, cY)) == -1) {
							SelectionMemory.space.getChunk(cX, cY).render(_layerMidd, c.getCoords().x + 600, c.getCoords().y);
							activeChunks.push(SelectionMemory.space.getChunk(cX, cY));
						}
					} else if (update == 2) {
						cX -= 1;
						if (cX <= -1) { cX = 2; }
						if (activeChunks.indexOf(SelectionMemory.space.getChunk(cX, cY)) == -1) {
							SelectionMemory.space.getChunk(cX, cY).render(_layerMidd, c.getCoords().x - 600, c.getCoords().y);
							activeChunks.push(SelectionMemory.space.getChunk(cX, cY));
						}
					} else if (update == 4) {
						cY -= 1;
						if (cY < 0) { cY = 9; }
						if (activeChunks.indexOf(SelectionMemory.space.getChunk(cX, cY)) == -1) {
							SelectionMemory.space.getChunk(cX, cY).render(_layerMidd, c.getCoords().x, c.getCoords().y - 450);
							activeChunks.push(SelectionMemory.space.getChunk(cX, cY));
						}
					} else if (update == 5) {
						cX += 1;
						if (cX >= 3) { cX = 0; }
						if (activeChunks.indexOf(SelectionMemory.space.getChunk(cX, cY)) == -1) {
							SelectionMemory.space.getChunk(cX, cY).render(_layerMidd, c.getCoords().x + 600, c.getCoords().y);
							activeChunks.push(SelectionMemory.space.getChunk(cX, cY));
						}
						cX -= 1;
						if (cX <= -1) { cX = 2; }
						cY -= 1;
						if (cY < 0) { cY = 9; }
						if (activeChunks.indexOf(SelectionMemory.space.getChunk(cX, cY)) == -1) {
							SelectionMemory.space.getChunk(cX, cY).render(_layerMidd, c.getCoords().x, c.getCoords().y - 450);
							activeChunks.push(SelectionMemory.space.getChunk(cX, cY));
						}
						cX += 1;
						if (cX >= 3) { cX = 0; }
						if (activeChunks.indexOf(SelectionMemory.space.getChunk(cX, cY)) == -1) {
							SelectionMemory.space.getChunk(cX, cY).render(_layerMidd, c.getCoords().x - 600, c.getCoords().y - 450);
							activeChunks.push(SelectionMemory.space.getChunk(cX, cY));
						}
					} else if (update == 6) {
						cX -= 1;
						if (cX <= -1) { cX = 2; }
						if (activeChunks.indexOf(SelectionMemory.space.getChunk(cX, cY)) == -1) {
							SelectionMemory.space.getChunk(cX, cY).render(_layerMidd, c.getCoords().x + 600, c.getCoords().y);
							activeChunks.push(SelectionMemory.space.getChunk(cX, cY));
						}
						cX += 1;
						if (cX >= 3) { cX = 0; }
						cY -= 1;
						if (cY < 0) { cY = 9; }
						if (activeChunks.indexOf(SelectionMemory.space.getChunk(cX, cY)) == -1) {
							SelectionMemory.space.getChunk(cX, cY).render(_layerMidd, c.getCoords().x, c.getCoords().y - 450);
							activeChunks.push(SelectionMemory.space.getChunk(cX, cY));
						}
						cX -= 1;
						if (cX <= -1) { cX = 2; }
						if (activeChunks.indexOf(SelectionMemory.space.getChunk(cX, cY)) == -1) {
							SelectionMemory.space.getChunk(cX, cY).render(_layerMidd, c.getCoords().x + 600, c.getCoords().y - 450);
							activeChunks.push(SelectionMemory.space.getChunk(cX, cY));
						}
					} 
					if (update & 8) {
						var r:int = activeChunks.indexOf(c);
						activeChunks.splice(r, 1);
						c.derender(_layerMidd);
					}
				}
			}
			return 0;
		}
	}
}