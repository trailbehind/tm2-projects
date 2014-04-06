// Languages: name (local), name_en, name_fr, name_es, name_de
@name: '[name_en]';

// Common Colors //
@water: #CFE8F8;
@road_red: #E92F41;
@contour_line: #B76536;
@contour_text_halo: #ffffff;

Map {
  background-color:#fff;
}

#contour {
	line-width:.5;
  	line-color: lighten(@contour_line, 20%);
  [index=5],[index=10] {
    line-width:1;
    line-color:@contour_line;
    text-face-name: 'Source Sans Pro Bold';
    text-name:'[ele]';
  	text-size:10;
  	text-placement:line;
  	text-fill:@contour_line;
  	text-halo-fill:@contour_text_halo;
  	text-halo-radius:2;
  	text-min-distance:100;
  	text-max-char-angle-delta : 20;
  }
}

#landcover {
  [class='wood'] {
	  polygon-fill:#D7F8B3;
  }
  [class='scrub'] {
  	polygon-fill: #ECF5E9; 
  }
}

// Political boundaries //

#admin [maritime != 1]{
  line-join: round;
  line-color: #bbe;
  // Countries
  [admin_level=2] {
    line-width: 1.4;
    [zoom>=6] { line-width: 2; }
    [zoom>=8] { line-width: 4; }
    [disputed=1] { line-dasharray: 4,4; }
  }
  // States / Provices / Subregions
  [admin_level>=3] {
    line-width: 0.4;
    line-dasharray: 10,3,3,3;
    [zoom>=6] { line-width: 1; }
    [zoom>=8] { line-width: 2; }
    [zoom>=12] { line-width: 3; }
  }
}


// Places //

#country_label[zoom>=3] {
  text-name: @name;
  text-face-name: 'Source Sans Pro Bold';
  text-wrap-width: 100;
  text-wrap-before: true;
  text-fill: #66a;
  text-size: 12;
  [zoom>=3][scalerank=1],
  [zoom>=4][scalerank=2],
  [zoom>=5][scalerank=3],
  [zoom>=6][scalerank>3] {
    text-size: 14;
  }
  [zoom>=4][scalerank=1],
  [zoom>=5][scalerank=2],
  [zoom>=6][scalerank=3],
  [zoom>=7][scalerank>3] {
    text-size: 16;
  }
}

#country_label_line {
  line-color: #324;
  line-opacity: 0.05;
}

#place_label {
  [type='city'][zoom<=15] {
    text-name: @name;
    text-face-name: 'Source Sans Pro Semibold';
    text-fill: #444;
    text-size: 16;
    text-wrap-width: 100;
    text-wrap-before: true;
    [zoom>=10] { text-size: 18; }
    [zoom>=12] { text-size: 24; }
  }
  [type='town'][zoom<=17] {
    text-name: @name;
    text-face-name: 'Source Sans Pro Regular';
    text-fill: #333;
    text-size: 14;
    text-wrap-width: 100;
    text-wrap-before: true;
    [zoom>=10] { text-size: 16; }
    [zoom>=12] { text-size: 20; }
  }
  [type='village'] {
    text-name: @name;
    text-face-name: 'Source Sans Pro Regular';
    text-fill: #444;
    text-size: 12;
    text-wrap-width: 100;
    text-wrap-before: true;
    [zoom>=12] { text-size: 14; }
    [zoom>=14] { text-size: 18; }
  }
  [type='hamlet'],
  [type='suburb'],
  [type='neighbourhood'] {
    text-name: @name;
    text-face-name: 'Source Sans Pro Regular';
    text-fill: #666;
    text-size: 12;
    text-wrap-width: 100;
    text-wrap-before: true;
    [zoom>=14] { text-size: 14; }
    [zoom>=16] { text-size: 16; }
  }
}


// Water Features //

#water {
  polygon-fill: @water;
  polygon-gamma: 0.6;
}

#water_label {
  [zoom<=13][area>10000],  // automatic area filtering @ low zooms
  [zoom>=14]{
    text-name: @name;
    text-face-name: 'Source Sans Pro Italic';
    text-fill: darken(@water, 30%);
    text-size: 13;
    text-wrap-width: 100;
    text-wrap-before: true;
  }
}

#waterway {
  [type='river'],
  [type='canal'] {
    line-color: @water;
    line-width: 0.5;
    [zoom>=12] { line-width: 1; }
    [zoom>=14] { line-width: 2; }
    [zoom>=16] { line-width: 3; }
  }
  [type='stream'] {
    line-color: @water;
    line-width: 0.5;
    [zoom>=14] { line-width: 1; }
    [zoom>=16] { line-width: 2; }
    [zoom>=18] { line-width: 3; }
  }
}


// Landuse areas //

//#landuse {
//  [class='park'] { polygon-fill: #FBDCEB;}
//}

#area_label {
  [class='park'] {
    [zoom<=13],  // automatic area filtering @ low zooms
    [zoom>=14][area>500000],
    [zoom>=16][area>10000],
    [zoom>=17] {
      text-name: @name;
      text-face-name: 'Source Sans Pro Italic';
      text-fill: darken(@park, 50%);
      text-size: 13;
      text-wrap-width: 100;
      text-wrap-before: true;
    }
  }
}

// Roads & Railways //
@outline_roads:10;

#tunnel { opacity: 0.5; }

#road[zoom > 5],
#tunnel[zoom >5],
#bridge[zoom > 5] {
  ['mapnik::geometry_type'=2] {
    line-color: black;
    line-width: 1;
    
    [class='motorway'][zoom>@outline_roads]  {
    	::outline {
        	line-color: @road_red;
          	line-width: 1.5;
      	}
      	line-width:3;
      	line-color:black;
    }
    [class='street'],
    [class='street_limited']{
      line-width:1;
      }
    
     [class='main'][zoom>@outline_roads] {
       ::outline {
          line-color: white;
          line-width: 1.5;
      }
         line-width:3;
         line-color:black;
    }

    [class='service'],
    [class='driveway']{
     	line-color:#555555;
     }
    
    [class ='path'] { //trail
      line-dasharray:4,2;
      line-width:2;
    }
  }
}

#building[zoom >= 14] {
  polygon-fill:black;
  }