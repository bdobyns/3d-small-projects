// OpenScadFont

// Original Author: Steve Miller (avrgeek on Thingiverse)
// OpenSCAD League Gothic Font Module
// http://www.thingiverse.com/thing:6820

// Modified for OpenSCAD MakerBot Font Module
// Author: Matt Purvis (grokbeer on Thingiverse)
// http://www.thingiverse.com/thing:6844

/*

Usage:		fnt_str(chars, char_count, block_size, height)
Example:	fnt_str(["H","e","l","l","o","","W","o","r","l","d","!"],12,1,5);

After seeing the great work of tbuser and avrgeek I was inspired to create an OpenSCAD
module for the font used by MakerBot Industries.

The font itself is called Designer Block by K-Type (http://www.k-type.com/?p=296). It's
free for personal use but K-Type require a paid license for commercial use. I've licensed
this Thing under a non-commercial license to highlight this. If you own a license for the
font then feel free to contact me for a relicensed version of this Thing that you can
derive for commercial use.

I had hoped to extend avrgeek's code to provide proper support for variable-width fonts.
Unfortunately the limitations in the OpenSCAD language hampered my efforts but the
examples provided show how you can manually kern the text to get around this problem.

You'll see from the Character Test that some of the characters (G, H, T and ?) currently
fail to render. This is apparently due to a winding direction problem I've yet to fix.
For the MBI logo I've worked around it by carefully hacking a replacement T out of an I
and a hypen. :)

If there is interest in better font support for OpenSCAD I might look into some of the
scripting language interfaces that may be useful for generating OpenSCAD code that will
properly kern the selected font. As it stands you might be better off just typing up the
text in Inkscape and importing it into OpenSCAD as a DXF for linear extrusion.

I've included avrgeek's Customize.txt which contains basic instructions for porting new fonts.

I have yet to print anything using this font so I have no idea whether it will even work. :) 

*/

/*

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/; or, (b) send a letter
to Creative Commons, 171 2nd Street, Suite 300, San Francisco, California, 94105, USA.

*/

//Variables
fnt_directory="fnt-DesignerBlock/";

module fnt_str(chars,char_count, block_size, height) {
	//Block-size will be effectly ignored for now...may try to do something with it in the future
	char_width=17;
	echo(str("Total Width: ", char_width*char_count, "mm"));

	//Trans
	union() {
		for (count = [0:char_count-1]) {
			translate(v = [char_width,-(char_width/2)+count * char_width, 0])
				rotate([0,0,90]) fnt_char(chars[count], block_size, height);
		}
	}
}

module fnt_char(char, block_size, height, include_base) {
	//TODO: Adjust scaling factors, determine correct "block" size.
	scale_x=70;
	scale_y=70;

	if (char == "0") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"0.dxf"), height=height, convexity=10);
	} else if (char == "1") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"1.dxf"), height=height, convexity=10);
	} else if (char == "2") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"2.dxf"), height=height, convexity=10);
	} else if (char == "3") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"3.dxf"), height=height, convexity=10);
	} else if (char == "4") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"4.dxf"), height=height, convexity=10);
	} else if (char == "5") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"5.dxf"), height=height, convexity=10);
	} else if (char == "6") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"6.dxf"), height=height, convexity=10);
	} else if (char == "7") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"7.dxf"), height=height, convexity=10);
	} else if (char == "8") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"8.dxf"), height=height, convexity=10);
	} else if (char == "9") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"9.dxf"), height=height, convexity=10);
	} else if (char == "A") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"A.dxf"), height=height, convexity=10);
	} else if (char == "a") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"a-lower.dxf"), height=height, convexity=10);
	} else if (char == "&") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"ampersand.dxf"), height=height, convexity=10);
	} else if (char == "*") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"asterisk.dxf"), height=height, convexity=10);
	} else if (char == "@") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"at.dxf"), height=height, convexity=10);
	} else if (char == "\\") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"backslash.dxf"), height=height, convexity=10);
	} else if (char == "`") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"backtick.dxf"), height=height, convexity=10);
	} else if (char == "B") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"B.dxf"), height=height, convexity=10);
	} else if (char == "b") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"b-lower.dxf"), height=height, convexity=10);
	} else if (char == "^") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"caret.dxf"), height=height, convexity=10);
	} else if (char == "C") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"C.dxf"), height=height, convexity=10);
	} else if (char == ")") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"closepar.dxf"), height=height, convexity=10);
	} else if (char == "c") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"c-lower.dxf"), height=height, convexity=10);
	} else if (char == "D") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"D.dxf"), height=height, convexity=10);
	} else if (char == "d") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"d-lower.dxf"), height=height, convexity=10);
	} else if (char == "$") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"dollarsign.dxf"), height=height, convexity=10);
	} else if (char == "''") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"doublequote.dxf"), height=height, convexity=10);
	} else if (char == "=") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"=.dxf"), height=height, convexity=10);
	} else if (char == "_") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"_.dxf"), height=height, convexity=10);
	} else if (char == ",") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,",.dxf"), height=height, convexity=10);
	} else if (char == ":") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,":.dxf"), height=height, convexity=10);
	} else if (char == "!") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"!.dxf"), height=height, convexity=10);
	} else if (char == "[") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"[.dxf"), height=height, convexity=10);
	} else if (char == "]") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"].dxf"), height=height, convexity=10);
	} else if (char == "@") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"@.dxf"), height=height, convexity=10);
	} else if (char == "#") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"#.dxf"), height=height, convexity=10);
	} else if (char == "+") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"+.dxf"), height=height, convexity=10);
	} else if (char == "E") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"E.dxf"), height=height, convexity=10);
	} else if (char == "e") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"e-lower.dxf"), height=height, convexity=10);
	} else if (char == "F") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"F.dxf"), height=height, convexity=10);
	} else if (char == "f") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"f-lower.dxf"), height=height, convexity=10);
	} else if (char == "/") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"forwardslash.dxf"), height=height, convexity=10);
	} else if (char == "G") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"G.dxf"), height=height, convexity=10);
	} else if (char == "g") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"g-lower.dxf"), height=height, convexity=10);
	} else if (char == ">") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"greaterthan.dxf"), height=height, convexity=10);
	} else if (char == "#") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"hash.dxf"), height=height, convexity=10);
	} else if (char == "H") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"H.dxf"), height=height, convexity=10);
	} else if (char == "h") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"h-lower.dxf"), height=height, convexity=10);
	} else if (char == "-") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"hyphen.dxf"), height=height, convexity=10);
	} else if (char == "I") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"I.dxf"), height=height, convexity=10);
	} else if (char == "i") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"i-lower.dxf"), height=height, convexity=10);
	} else if (char == "J") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"J.dxf"), height=height, convexity=10);
	} else if (char == "j") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"j-lower.dxf"), height=height, convexity=10);
	} else if (char == "K") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"K.dxf"), height=height, convexity=10);
	} else if (char == "k") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"k-lower.dxf"), height=height, convexity=10);
	} else if (char == "L") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"L.dxf"), height=height, convexity=10);
	} else if (char == "<") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"lessthan.dxf"), height=height, convexity=10);
	} else if (char == "l") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"l-lower.dxf"), height=height, convexity=10);
	} else if (char == "M") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"M.dxf"), height=height, convexity=10);
	} else if (char == "m") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"m-lower.dxf"), height=height, convexity=10);
	} else if (char == "N") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"N.dxf"), height=height, convexity=10);
	} else if (char == "n") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"n-lower.dxf"), height=height, convexity=10);
	} else if (char == "O") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"O.dxf"), height=height, convexity=10);
	} else if (char == "o") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"o-lower.dxf"), height=height, convexity=10);
	} else if (char == "(") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"openpar.dxf"), height=height, convexity=10);
	} else if (char == "P") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"P.dxf"), height=height, convexity=10);
	} else if (char == "%") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"percent.dxf"), height=height, convexity=10);
	} else if (char == ".") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"period.dxf"), height=height, convexity=10);
	} else if (char == "|") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"pipe.dxf"), height=height, convexity=10);
	} else if (char == "p") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"p-lower.dxf"), height=height, convexity=10);
	} else if (char == "Q") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"Q.dxf"), height=height, convexity=10);
	} else if (char == "q") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"q-lower.dxf"), height=height, convexity=10);
	} else if (char == "?") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"question.dxf"), height=height, convexity=10);
	} else if (char == "R") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"R.dxf"), height=height, convexity=10);
	} else if (char == "r") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"r-lower.dxf"), height=height, convexity=10);
	} else if (char == "S") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"S.dxf"), height=height, convexity=10);
	} else if (char == "'") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"singlequote.dxf"), height=height, convexity=10);
	} else if (char == "s") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"s-lower.dxf"), height=height, convexity=10);
	} else if (char == "T") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"T.dxf"), height=height, convexity=10);
	} else if (char == "~") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"tilde.dxf"), height=height, convexity=10);
	} else if (char == "t") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"t-lower.dxf"), height=height, convexity=10);
	} else if (char == "U") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"U.dxf"), height=height, convexity=10);
	} else if (char == "u") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"u-lower.dxf"), height=height, convexity=10);
	} else if (char == "_") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"underscore.dxf"), height=height, convexity=10);
	} else if (char == "V") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"V.dxf"), height=height, convexity=10);
	} else if (char == "v") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"v-lower.dxf"), height=height, convexity=10);
	} else if (char == "W") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"W.dxf"), height=height, convexity=10);
	} else if (char == "w") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"w-lower.dxf"), height=height, convexity=10);
	} else if (char == "X") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"X.dxf"), height=height, convexity=10);
	} else if (char == "x") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"x-lower.dxf"), height=height, convexity=10);
	} else if (char == "Y") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"Y.dxf"), height=height, convexity=10);
	} else if (char == "y") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"y-lower.dxf"), height=height, convexity=10);
	} else if (char == "Z") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"Z.dxf"), height=height, convexity=10);
	} else if (char == "z") {
		scale([scale_x,scale_y,0]) linear_extrude(file=str(fnt_directory,"z-lower.dxf"), height=height, convexity=10);
	} else {
		echo (str("Unknown character: ", char));
	}
}

module fnt_test() {
	fnt_str(["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y","Z"],26,1,2);

	translate([25,0,0]) fnt_str(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"],26,1,2);

	translate([55,0,0]) fnt_str(["0","1","2","3","4","5","6","7","8","9","+","-",":",".",",","?","=","*","!","''","#","$","%","&","@","'"],26,1,2);

	translate([90,0,0]) fnt_str(["(",")","<",">","[","]","/","\\","_","|","^","`","~"],13,1,2);
}
