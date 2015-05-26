package {
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
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
	public class TheQuery extends PlumbCore {
		private var jaw:Sprite;
		private var eye:MovieClip;
		private var health:int;
		private var queries:Array;
		private var shards:Array;
		private var lasersArray:Array;
		private var attackTimer:int;
		private var mouthTimer:int;
		private var mouthshooter:Sprite;
		public function TheQuery(parent:DisplayObjectContainer, pX:int, pY:int, BR:Boolean = false) {
			super(parent, pX, pY);
			if (BR) {
				jaw = new mJawBR();
				icon = new mHeadBR();
				eye = new mEyeBR();
			} else {
				jaw = new mJaw();
				icon = new mHead();
				eye = new mEye();
			}
			mouthshooter = new Sprite();
			icon.x = pX;
			icon.y = pY;
			jaw.x = pX - 7;
			jaw.y = pY + 15;
			eye.x = pX - 65.5;
			eye.y = pY - 32;
			eye.gotoAndStop(1);
			mouthshooter.x = pX - 96;
			mouthshooter.y = pY + 24;
			_parent.addChild(jaw);
			_parent.addChild(icon);
			_parent.addChild(eye);
			_parent.addChild(mouthshooter);
			health = 40;
			queries = [];
			shards = [];
			attackTimer = 0;
			mouthTimer = 0;
			lasersArray = [];
			for (var i:int = 0; i < 9; i++) {
				var q:Query = new Query(parent, pX - 170, i * 26, 1);
				queries.push(q);
				var qa:Query = new Query(parent, pX - 130, i * 26, 1);
				queries.push(qa);
			}
			for (var j:int = 0; j < 9; j++) {
				var qu:Query = new Query(parent, pX - 150, 13 + j * 26, -1);
				queries.push(qu);
			}
		}
		public override function cleanUp():void {
			for each(var U:Query in queries) {
				U.cleanUp();
			}
			queries = [];
			for each(var B:QueryShard in shards) {
				B.cleanUp();
			}
			shards = [];
			for each(var Z:QuestionLaser in lasersArray) {
				Z.cleanUp();
			}
			lasersArray = [];
			_parent.removeChild(icon);
			_parent.removeChild(jaw);
			_parent.removeChild(eye);
			_parent.removeChild(mouthshooter);
			health = 0;
			attackTimer = 0;
			mouthTimer = 0;
			jaw = null;
			eye = null;
			mouthshooter = null;
			icon = null;
		}
		public override function update(player:MovieClip = null, harpoons:Array = null, keys:uint = 0, click:Boolean = false, angee:Number = 0):int {
			var willPlayerHurt:int = 0;
			for each(var i:Harpoon in harpoons) {
				if (icon.hitTestObject(i.iconGet())) {
					health -= 1;
					SelectionMemory.sHandler.queries.stop();
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.qHurt[Math.floor(Math.random() * 3)].play();
					}
					i.removeMeFromThisWorld();
					if (eye.currentFrame < 21) {
						eye.gotoAndPlay(19);
					}
					jaw.rotation = -23;
					break;
				}
			}
			for each(var u:Query in queries) {
				var beep:int = u.update(player, harpoons);
				if (beep == 1) {
					var limit:int = 2 + Math.round(Math.random() * 3);
					for (var bl:int = 0; bl < limit; bl++) {
						var b:QueryShard = new QueryShard(_parent, u.loc.x, u.loc.y, 180 * Math.random(), bl + 1);
						shards.push(b);
					}
				}
				if (u.destroyMe()) {
					var rem:int = queries.indexOf(u);
					queries.splice(rem, 1);
					u.cleanUp();
				}
			}
			for each(var LASERBOOP:QuestionLaser in lasersArray) {
				willPlayerHurt += LASERBOOP.update(player, harpoons);
				if (LASERBOOP.destroyMe()) {
					var ram:int = lasersArray.indexOf(LASERBOOP);
					lasersArray.splice(ram, 1);
					LASERBOOP.cleanUp();
				}
			}
			for each(var bb:QueryShard in shards) {
				willPlayerHurt += bb.update(player, harpoons);
				if (bb.destroyMe()) {
					var rum:int = shards.indexOf(bb);
					shards.splice(rum, 1);
					bb.cleanUp();
				}
			}
			if (jaw.rotation < 0) {
				jaw.rotation += 0.5;
			}
			if (eye.currentFrame == 1 && Math.random() > 0.95) {
				eye.play();
			}
			if (Math.random() > 0.92 && attackTimer <= 0) {
				var B:int = Math.floor(Math.random() * 7);
				if (!SelectionMemory.soundOff) {
					SelectionMemory.sHandler.queries = SelectionMemory.sHandler.query[B].play();
				}
				var pPp:Point = _parent.globalToLocal(new Point(player.x, player.y));
				var X:Number = Math.atan2(pPp.y - mouthshooter.y, pPp.x - mouthshooter.x) * 180 / Math.PI;
				var LASER:QuestionLaser = new QuestionLaser(_parent, mouthshooter.x, mouthshooter.y, X);
				lasersArray.push(LASER);
				mouthTimer = 30 * ((Sound(SelectionMemory.sHandler.query[B]).length) / 1000);
				attackTimer = mouthTimer * 1.75;
			}
			if (mouthTimer > 0) {
				jaw.rotation = -23 * Math.random();
				mouthTimer -= 1;
			} else if (mouthTimer == 0) {
				mouthTimer = -1;
				jaw.rotation = 0;
			}
			if (attackTimer > 0) {
				attackTimer -= 1;
			}
			if (health <= 0) {
				destroy = true;
			}
			return willPlayerHurt;
		}
	}
}