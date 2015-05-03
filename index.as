/**
Author : Andre Caetano 2015
Jinx Plugin
**/

import flash.text.*;

var $memPanel = function(){
	var w = 120,
	h = 45,
	margin=5,
	t = 0;
	var newTextField = function(){
		var myFormat:TextFormat = new TextFormat();
		myFormat.size = 12;
		myFormat.align = TextFormatAlign.LEFT;
		myFormat.font = $new('visitor').fontName;

		var myText = new TextField;
		myText.$set({
			defaultTextFormat:myFormat,
			embedFonts:true,
			antiAliasType:AntiAliasType.ADVANCED,
			text:"test test",
			selectable:false,
			textColor:0xFFFFFF,
			x:3,
			y:(13*(t+1))-22,
			alpha:0.9
		}).$add(panel);

		++t;
		return myText;
	}

	var panel = $new().$set({
		x:margin,
		y:(stage.stageHeight/2)-(h/2),
		mouseEnabled:false,
		mouseChildren:false
	}).$add();

	var bkg = (new Bitmap((new BitmapData(w,h,false,0x444444))));
	bkg.$set({alpha:0.75}).$add(panel);

	var rows = [];
	for(var i=0;i<3;i++) rows[i]=newTextField();

	var frames:int=0;
	var prevTimer:Number=0;
	var curTimer:Number=0;

	var childrenCount:int=0;
	function countDisplayList(container:DisplayObjectContainer):void {
		childrenCount+=container.numChildren;
		for (var i=0;i<container.numChildren;i++) if(container.getChildAt(i) is DisplayObjectContainer) countDisplayList(DisplayObjectContainer(container.getChildAt(i)));
	}

	stage.addEventListener(Event.ENTER_FRAME,function(){
		childrenCount=0;
		++frames;
		curTimer=getTimer();
		countDisplayList(stage);
		if(curTimer-prevTimer>=1000){
			rows[0].text="FPS: "+(Math.round(frames*1000/(curTimer-prevTimer)))+" / "+stage.frameRate;
			prevTimer=curTimer;
			frames=0;
		}

		rows[1].text="Memory: "+(Math.floor((System.totalMemory/1024)/10)/100);
		rows[2].text="Particles: "+childrenCount;
	});
}
