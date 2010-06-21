/*
 * 	 gpColorSchemes - an AS3 Class
 * 	 @author Les Green
 * 	 Copyright (C) 2010 Intriguing Minds, Inc.
 *   Version 0.5
 * 
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   Demo and Documentation can be found at:   
 *   http://www.grasshopperpebbles.com
 *   
 */

package com.grasshopper.utils {
	
	public class gpColorSchemes {
		private var colorScheme:Object;
		private var colorName:String;
		private var reverse:Boolean;
		
		public function gpColorSchemes(c:String, r:Boolean = false) {
			colorScheme = new Object();
			colorName = c;
			reverse = r;
		}
		public function getColorScheme():Object {
			colorScheme.brdrSize = 1;
			switch (colorName) {
				case "gpGrey2" :
					colorScheme.ratio = [0, 255];
					colorScheme.bgColor = [0xFFFFFF, 0xAFAFAF];
					colorScheme.brdrColor = 0x9E9E9E;
					colorScheme.cAlphas = [1, 1];
					break;
				case "gpDarkGrey4" :
					colorScheme.ratio = [0, 126, 127, 255];
					colorScheme.bgColor = [0x000000, 0x7e7e7e, 0x656565, 0x606060];
					colorScheme.brdrColor = 0x585858;
					colorScheme.cAlphas = [1, 1, 1, 1];
					break;
				case "gpGoToPurple4" :
					colorScheme.ratio = [0, 125, 127, 255];
					colorScheme.bgColor = [0xa33ed4, 0x7e25cd, 0xa76add, 0x7d27ca];
					colorScheme.brdrColor = 0x6217a4;
					colorScheme.cAlphas = [1, 1, 1, 1];
					break;
				case "gpGoToGreen4" :
					colorScheme.ratio = [0, 125, 127, 255];
					colorScheme.bgColor = [0x77bf1b, 0x56aa1f, 0x8bcc63, 0x53aa20];
					colorScheme.brdrColor = 0x4d882b;
					colorScheme.cAlphas = [1, 1, 1, 1];
					break;	
				case "gpRed2" :
					colorScheme.ratio = [0, 255];
					colorScheme.bgColor = [0xb41b1b, 0xed5c5c];
					colorScheme.brdrColor = 0x880d0d;
					colorScheme.cAlphas = [1, 1];
					break;
				case "gpGrey2NoB" :
					colorScheme.ratio = [0, 255];
					colorScheme.bgColor = [0xcccccc, 0xffffff];
					colorScheme.brdrColor = '';
					colorScheme.cAlphas = [1, 1];
					break;
				case "gpLinkedBlue2" :
					colorScheme.ratio = [0, 255];
					colorScheme.bgColor = [0x006599, 0x2e8fc2];
					colorScheme.brdrColor = 0x00679e;
					colorScheme.cAlphas = [1, 1];
					break;
				case "gpLinkedGrey2" :
					colorScheme.ratio = [0, 255];
					colorScheme.bgColor = [0xe7e7e7, 0xffffff];
					colorScheme.brdrColor = '';
					colorScheme.cAlphas = [1, 1];
					break;	
				case "gpBlack2NoB" :
					colorScheme.ratio = [0, 255];
					colorScheme.bgColor = [0x000000, 0x494a4c];
					colorScheme.brdrColor = '';
					colorScheme.cAlphas = [1, 1];
					break;	
				case "gpPink3" :
					colorScheme.ratio = [0, 126, 255];
					colorScheme.bgColor = [0xdb34a4, 0xa80077, 0xc141a4];
					colorScheme.brdrColor = 0xae037b;
					colorScheme.cAlphas = [1, 1, 1];
					break;	
				case "gpWhite4" :
					colorScheme.ratio = [0, 127, 128, 255];
					colorScheme.bgColor = [0xf2f5f7, 0xe5ebee, 0xd7dee3, 0xf6f8f9];
					colorScheme.brdrColor = 0xadb9c2;
					colorScheme.cAlphas = [1, 1, 1, 1];
					break;
				case "gpOrange3" :
					colorScheme.ratio = [0, 128, 255];
					colorScheme.bgColor = [0xff7d00, 0xff7c00, 0xffa03c];
					colorScheme.brdrColor = 0xdc6b00;
					colorScheme.cAlphas = [1, 1, 1];
					break;
				case "gpBlack2" :
					colorScheme.ratio = [0, 255];
					colorScheme.bgColor = [0x000000, 0x7d7e7d];
					colorScheme.brdrColor = 0x000000;
					colorScheme.cAlphas = [1, 1];
					break;		
				case "gpBlue3" :
					colorScheme.ratio = [0, 127, 255];
					colorScheme.bgColor = [0x066caa, 0x008fc7, 0xc1dbe8];
					colorScheme.brdrColor = 0x0075b0;
					colorScheme.cAlphas = [1, 1, 1];
					break;
				case "gpWhiteGloss4" :
					colorScheme.ratio = [0, 130, 131, 255];
					colorScheme.bgColor = [0xf3f3f3, 0xe1e1e1, 0xf1f1f1, 0xffffff];
					colorScheme.brdrColor = 0xb3b3b3;
					colorScheme.cAlphas = [1, 1, 1, 1];
					break;	
				case "gpLightBlue2" :
					colorScheme.ratio = [0, 255];
					colorScheme.bgColor = [0x7fe0f8, 0xcef8ff];
					colorScheme.brdrColor = 0x499eb3;
					colorScheme.cAlphas = [1, 1];
					break;
				case "gpOrangeYellow2" :
					colorScheme.ratio = [0, 255];
					colorScheme.bgColor = [0xfeae31, 0xefe457];
					colorScheme.brdrColor = 0xb1770b;
					colorScheme.cAlphas = [1, 1];
					break;
				case "gpGreyBlue2" :
					colorScheme.ratio = [0, 255];
					colorScheme.bgColor = [0xcfe1ed, 0x7faaca];
					colorScheme.brdrColor = 0x758795;
					colorScheme.cAlphas = [1, 1];
					break;
				case "gpDarkBlack2" :
					colorScheme.ratio = [0, 255];
					colorScheme.bgColor = [0x000000, 0x45494d];
					colorScheme.brdrColor = 0x000000;
					colorScheme.cAlphas = [1, 1];
					break;
				case "gpPink4" :
					colorScheme.ratio = [0, 126, 127, 255];
					colorScheme.bgColor = [0xff7ad7, 0xfba6e1, 0xfd8ad7, 0xfbe8fc];
					colorScheme.brdrColor = 0xd957af;
					colorScheme.cAlphas = [1, 1, 1, 1];
					break;	
				case "gpGreyWhite4" :
					colorScheme.ratio = [0, 64, 130, 255];
					colorScheme.bgColor = [0xd6eaf7, 0xc2d4e0, 0xb5c6d0, 0xeff4f7];
					colorScheme.brdrColor = 0x9db0bc;
					colorScheme.cAlphas = [1, 1, 1, 1];
					break;
				case "gpBlueGrey4" :
					colorScheme.ratio = [0, 69, 129, 255];
					colorScheme.bgColor = [0x25548a, 0x4bb8f0, 0x3a83c2, 0xcfdce9];
					colorScheme.brdrColor = 0x065295;
					colorScheme.cAlphas = [1, 1, 1, 1];
					break;	
				case "gpGreen5" :
					colorScheme.ratio = [0, 57, 78, 149, 255];
					colorScheme.bgColor = [0xa1dc74, 0x6bc827, 0x58c10c, 0x76cc37, 0xade087];
					colorScheme.brdrColor = 0x419b00;
					colorScheme.cAlphas = [1, 1, 1, 1, 1];
					break;
				case "gpHunterGreen5" :
					colorScheme.ratio = [9, 129, 130, 236, 255];
					colorScheme.bgColor = [0x94c516, 0x8eb92a, 0x72aa00, 0xa8c732, 0xb9ce44];
					colorScheme.brdrColor = 0x679800;
					colorScheme.cAlphas = [1, 1, 1, 1, 1];
					break;	
				case "gpBlackGrey4" :
					colorScheme.ratio = [0, 127, 128, 255];
					colorScheme.bgColor = [0x000000, 0x0a0f0b, 0x6d7673, 0xafbdc0];
					colorScheme.brdrColor = 0x000000;
					colorScheme.cAlphas = [1, 1, 1, 1];
					break;	
				case "gpSkyLightBlue4" :
					colorScheme.ratio = [0, 127, 128, 255];
					colorScheme.bgColor = [0xb6dffd, 0xd8f0fc, 0xb9e2f6, 0xe0f3fa];
					colorScheme.brdrColor = 0x83bbd9;
					colorScheme.cAlphas = [1, 1, 1, 1];
					break;
				case "gpLightBlue4" :
					colorScheme.ratio = [0, 127, 128, 255];
					colorScheme.bgColor = [0xb1dbeb, 0x70ceef, 0x20b4e2, 0xb7dded];
					colorScheme.brdrColor = 0x15a4d0;
					colorScheme.cAlphas = [1, 1, 1, 1];
					break;
				case "gpLightBlue6" :
					colorScheme.ratio = [0, 61, 128, 129, 204, 255];
					colorScheme.bgColor = [0xbcf4fd, 0x87c2fb, 0x8fbff0, 0x6ba8e4, 0x91bae4, 0xb6e2fd];
					colorScheme.brdrColor = 0x3c81c4;
					colorScheme.cAlphas = [1, 1, 1, 1, 1, 1];
					break;		
				case "gpDarkBlue4" :
					colorScheme.ratio = [0, 131, 131, 255];
					colorScheme.bgColor = [0x82bcea, 0x2b89da, 0x1f7bca, 0x3c669c];
					colorScheme.brdrColor = 0x1e568f;
					colorScheme.cAlphas = [1, 1, 1, 1];
					break;
				case "gpWhiteGrey4" :
					colorScheme.ratio = [0, 127, 127, 255];
					colorScheme.bgColor = [0xffffff, 0xdbdbdb, 0xd1d1d1, 0xdcdcdc];
					colorScheme.brdrColor = 0xcccccc;
					colorScheme.cAlphas = [1, 1, 1, 1];
					break;	
				case "gpLimeGreen4" :
					colorScheme.ratio = [0, 127, 127, 255];
					colorScheme.bgColor = [0xdef246, 0xd1e637, 0xc3d825, 0xeaf2b1];
					colorScheme.brdrColor = 0xb4c91a;
					colorScheme.cAlphas = [1, 1, 1, 1];
					break;
				case "gpLightOrange4" :
					colorScheme.ratio = [0, 127, 127, 255];
					colorScheme.bgColor = [0xfbe29d, 0xfccd4d, 0xf8b500, 0xfcecc0];
					colorScheme.brdrColor = 0xdea303;
					colorScheme.cAlphas = [1, 1, 1, 1];
					break;	
				case "gpLilac6" :
					colorScheme.ratio = [0, 79, 135, 136, 204, 255];
					colorScheme.bgColor = [0xc1bfea, 0xc4c1ea, 0xd8d0ef, 0xcec7ec, 0xe2def5, 0xebe9f9];
					colorScheme.brdrColor = 0xb8b2db;
					colorScheme.cAlphas = [1, 1, 1, 1, 1, 1];
					break;
				case "gpRedWhite4" :
					colorScheme.ratio = [0, 126, 127, 255];
					colorScheme.bgColor = [0xFAD4DB, 0xEC748B, 0xC13A59, 0xA81230];
					colorScheme.brdrColor = 0x820F26;
					colorScheme.cAlphas = [1, 1, 1, 1];
					break;	
			}
			if (reverse) {
				var bg:Array = colorScheme.bgColor;
				bg.reverse();
				colorScheme.bgColor = bg;
			}
			return colorScheme;
		}
	}
	
}