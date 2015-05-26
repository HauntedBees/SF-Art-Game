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
	public class GamePlatformer {
		protected var _darkBackgroundLayer:DisplayObjectContainer;
		protected var _backgroundLayer:DisplayObjectContainer;
		protected var _playerLightLayer:DisplayObjectContainer;
		protected var player:MovieClip;
		protected var wayBackground:MovieClip;
		protected var background:Sprite;
		protected var foreground:Sprite;
		protected var collisions:Sprite;
		protected var jumping:Boolean;
		protected var fallVelocity:Number;
		private var stepCount:int;
		protected var light:Sprite;
		protected var pan:Sprite;
		private var lightangle:int = 60;
		private var lpower:int = 480;
		protected var eye:Sprite;
		private var clickholding:Boolean;
		protected var showDark:Boolean;
		private var aAngle:Number;
		protected var onStairs:Boolean;
		protected var hasStairs:int;
		protected var stairFalling:Boolean;
		private var stairTimer:int;
		protected var haltControl:Boolean;
		public function GamePlatformer(bg:DisplayObjectContainer, np:DisplayObjectContainer, pl:DisplayObjectContainer) {
			haltControl = false;
			_darkBackgroundLayer = bg;
			onStairs = false;
			stairFalling = false;
			_backgroundLayer = np;
			_playerLightLayer = pl;
			jumping = false;
			aAngle = 0;
			fallVelocity = 0;
			stepCount = 0;
			player = new protagonist();
			player.gotoAndStop(1);
			_playerLightLayer.addChild(player);
			light = new Sprite();
			pan = new Sprite();
			eye = new cameraEye();
			if (SelectionMemory.day != 5) {
				_playerLightLayer.addChild(light);
				_backgroundLayer.mask = light;
				_playerLightLayer.addChild(eye);
				clickholding = false;
				eye.alpha = 0;
				showDark = false;
			}
			hasStairs = 0;
			onStairs = false;
			stairTimer = 0;
		}
		public function update(keys:uint, mouseX:int, mouseY:int, clicked:Boolean):int {
			if (player.scaleX > -10) {
				if (hasStairs == 1) {
					//if (wayBackground.x < 280 && wayBackground.x > 180) {
					if (wayBackground.x < 360 && wayBackground.x > 260) {
						onStairs = true;
					} else {
						onStairs = false;
					}
				} else if (hasStairs == 2) {
					//if (wayBackground.x < 75 && wayBackground.x > -10) {
					if (wayBackground.x < 155 && wayBackground.x > 70) {
						onStairs = true;
					} else {
						onStairs = false;
					}
				}
			} else {
				if (hasStairs == 1) {
					//if (wayBackground.x < 40 && wayBackground.x > -60) {
					if (wayBackground.x < 120 && wayBackground.x > 20) {
						onStairs = true;
					} else {
						onStairs = false;
					}
				} else if (hasStairs == 2) {
					if (wayBackground.x < -85	 && wayBackground.x > -170) {
					//if (wayBackground.x < -165	 && wayBackground.x > -250) {
						onStairs = true;
					} else {
						onStairs = false;
					}
				}
			}
			if (onStairs) {
				jumping = false;
				if (hasStairs == 1) {
					if (stairFalling) {
						player.x += 2.25;
						player.y += 2.75;
						stepCount += 10;
						aAngle += 20;
					} else if (keys & 2) {
						if (SelectionMemory.day != 5 && (aAngle > -125 || aAngle < -175)) {
							stairFalling = true;
							stairTimer = 60;
						} else {
							player.x -= 2.25;
							player.y -= 2.25;
							stepCount += 1;
						}
					} else if (keys & 4) {
						if (SelectionMemory.day != 5 && (aAngle > 65 || aAngle < 25)) {
							stairFalling = true;
							stairTimer = 60;
						} else {
							player.x += 2.25;
							player.y += 2.75;
							stepCount += 1;
						}
					}
				} else {
					if (stairFalling) {
						player.x -= 2.25;
						player.y += 2.75;
						stepCount += 10;
						aAngle -= 20;
					} else if (keys & 2) {
						if (SelectionMemory.day != 5 && (aAngle > 150 || aAngle < 110)) {
							stairFalling = true;
							stairTimer = 60;
						} else {
							player.x -= 2.25;
							player.y += 2.75;
							stepCount += 1;
						}
					} else if (keys & 4) {
						if (SelectionMemory.day != 5 && (aAngle < -50 || aAngle > -10)) {
							stairFalling = true;
							stairTimer = 60;
						} else {
							player.x += 2.25;
							player.y -= 2.25;
							stepCount += 1;
						}
					}
				}
			} else if (stairFalling) {
				stairTimer -= 1;
				if (stairTimer <= 0) {
					stairFalling = false;
				}
			} else {
				if (!haltControl) {
					if (keys & 2) {
						player.gotoAndStop(2);
						if (player.scaleX == 1) {
							aAngle = 180 - aAngle;
						}
						player.scaleX = -1;
						player.x -= 5;
						stepCount += 1;
					} else if (keys & 4) {
						player.gotoAndStop(2);
						if (player.scaleX == -1) {
							aAngle = 180 - aAngle;
						}
						player.scaleX = 1;
						player.x += 5;
						stepCount += 1;
					} else {
						player.gotoAndStop(1);
					}
					if (keys & 1) {
						if (!jumping) {
							if (!SelectionMemory.soundOff) {
								if (!SelectionMemory.soundOff) {
									SelectionMemory.sHandler.jump.play();
								}
							}
						}
						jumping = true;
						player.y -= 6;
					}
				}	
			}
			if (stepCount > 6 && !jumping) {
				stepCount = 0;
				if (!SelectionMemory.soundOff) {
					SelectionMemory.sHandler.step.play();
				}
			}
			if (jumping) {
				player.gotoAndStop(3);
				player.y += fallVelocity;
				fallVelocity += 0.25;
			}
			collisionsCheck();
			if (SelectionMemory.day != 5) {
				pan.graphics.clear();
				if (showDark) {
					pan.graphics.beginFill(0xffffcc);
					pan.graphics.moveTo(0, 0);
					pan.graphics.lineTo(480, 0);
					pan.graphics.lineTo(480, 240);
					pan.graphics.lineTo(0, 240);
					pan.graphics.lineTo(0, 0);
					pan.graphics.endFill();
				}
				light.graphics.clear();
				light.graphics.beginFill(0xffffcc);
				light.graphics.drawCircle(player.x, player.y, 20);
				light.graphics.endFill();
				light.graphics.beginFill(0xffffcc);
				light.graphics.moveTo(player.x, player.y - 10);
				var angleSet:Number = eye.rotation * Math.PI / 180;
				if (clicked && !clickholding) {
					clickholding = true;
					eye.alpha = 1;
					eye.x = mouseX;
					eye.y = mouseY;
					angleSet = Math.atan2(mouseY - player.y, mouseX - player.x);
					eye.rotation = angleSet * 180 / Math.PI;
				} else if (clickholding) {
					if (clicked) {
						eye.x = mouseX;
						eye.y = mouseY;
						angleSet = Math.atan2(mouseY - player.y, mouseX - player.x);
						eye.rotation = angleSet * 180 / Math.PI;
						aAngle = eye.rotation;
					} else {
						eye.alpha = 0;
						clickholding = false;
					}
					if (player.scaleX > 0) {
						if (eye.rotation < -90 || eye.rotation > 90) {
							showDark = true;
						} else {
							showDark = false;
						}
					} else {
						if (eye.rotation < -90 || eye.rotation > 90) {
							showDark = false;
						} else {
							showDark = true;
						}
					}
				}
				for (var i:int = 0; i <= lightangle; i += 5) {
					var ray_angle:Number = (aAngle - lightangle / 2 + i) * (Math.PI / 180);
					light.graphics.lineTo(player.x + lpower * Math.cos(ray_angle), player.y - 10 + lpower * Math.sin(ray_angle));
				}
				light.graphics.lineTo(player.x, player.y - 10);
				light.graphics.endFill();	
			}
			return otherThings(keys, mouseX, mouseY);
		}
		public function cleanUp():void {
			
		}
		protected function otherThings(keys:uint, mouseX:int, mouseY:int):int {
			return 0;
		}
		private function collisionsCheck():void {
			while (collisions.hitTestPoint(player.x, player.y + player.height / 2, true)) {
				player.y--;
				jumping = false;
				fallVelocity = 0;
			}
			while (collisions.hitTestPoint(player.x, player.y - player.height / 2, true)) {
				player.y++;
			}
			while (collisions.hitTestPoint(player.x - player.width / 2, player.y, true)) {
				player.x++;
			}
			while (collisions.hitTestPoint(player.x + player.width / 2, player.y, true)) {
				player.x--;
			}
		}
	}
}