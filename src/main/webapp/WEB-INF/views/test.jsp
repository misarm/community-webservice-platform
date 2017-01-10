<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<title>2D OpenAPI 샘플</title> 
<!--  <SCRIPT type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?version=2.0&apiKey=86FDDF87-540C-3E51-AC07-6974538CB2A1"></SCRIPT>
-->

<script>


<!-- version : 2.0 --> 
var vworldUrl = 'http://map.vworld.kr';
var vworld2DCache = 'http://2d.vworld.kr:8895/2DCache';
var vworldBaseMapUrl = 'http://xdworld.vworld.kr:8080/2d';
var vworldStyledMapUrl = 'http://2d.vworld.kr:8895/stmap';
var vworldIsValid = 'false';
var vworldErrMsg = '등록하신 API Key와 URI가 일치하지 않습니다.';
var vworldApiKey = '37874123-F292-3A2B-A8E6-934A0D6472C8';
var vworld3DUrl = vworldUrl+'/js/sopMapInit.js.do';

var vw = vw || {};
vw.ol3 = {};
vw.ol3.BaseURLs = {
    vworldUrl: vworldUrl,
    vworld2DCache: vworld2DCache,
    vworldBaseMapUrl: vworldBaseMapUrl,
    vworldStyledMapUrl: vworldStyledMapUrl
};
var vworldVers = {
    OpenLayers: "3.10.1",
    Base: "201512",
    Hybrid: "201512",
    Satellite: "201301",
    Gray: "201512",
    Midnight: "201512",
    ServerMaxLevel: 18
};
vw.ol3.ExtUrls = {
    vmapcss: vw.ol3.BaseURLs.vworldUrl + "/css/ol3/vwmap.ol3.css",
    vmap23css: vw.ol3.BaseURLs.vworldUrl + "/css/vmap23.css",
    openlayers: vw.ol3.BaseURLs.vworldUrl + "/js/map/OpenLayers-" + vworldVers.OpenLayers + "/ol3.19.1.js",
    jqueryui: vw.ol3.BaseURLs.vworldUrl + "/jquery/ol3/jquery-ui.min.js",
    jquery: vw.ol3.BaseURLs.vworldUrl + "/jquery/ol3/jquery-1.11.3.min.js"
};
vw.ol3.MapUrls = {
    earth: vworld3DUrl + "?version=2.0&apiKey=" + vworldApiKey,
    base: vw.ol3.BaseURLs.vworldBaseMapUrl + "/Base/" + vworldVers.Base + "/",
    hybrid: vw.ol3.BaseURLs.vworldBaseMapUrl + "/Hybrid/" + vworldVers.Hybrid + "/",
    raster: vw.ol3.BaseURLs.vworldBaseMapUrl + "/Satellite/" + vworldVers.Satellite + "/",
    gray: vw.ol3.BaseURLs.vworldBaseMapUrl + "/gray/" + vworldVers.Gray + "/",
    midnight: vw.ol3.BaseURLs.vworldBaseMapUrl + "/midnight/" + vworldVers.Midnight + "/",
    tile2d: vw.ol3.BaseURLs.vworld2DCache + "/tile",
    print: vw.ol3.BaseURLs.vworldUrl +
        "/printMap.do",
    wms: vw.ol3.BaseURLs.vworld2DCache + "/gis/map/WMS?",
    wms2: vw.ol3.BaseURLs.vworld2DCache + "/gis/map/WMS2?",
    wfs: vw.ol3.BaseURLs.vworld2DCache + "/gis/map/WFS?",
    apiCheck: vw.ol3.BaseURLs.vworldUrl + "/check2DNum.do?key=" + vworldApiKey
};
vw.ol3.CommonFunc = {
    _trim: function(a) {
        return a.replace(/(^\s*)|(\s*$)/gi, "")
    },
    _getBrowser: function(a) {
        var b = !1,
            c = navigator.userAgent.toLowerCase();
        a = a.toLowerCase(); - 1 != c.indexOf(a) && (b = !0);
        return b
    },
    _browserName: function() {
        var a = navigator.userAgent.toLowerCase();
        return -1 != a.indexOf("edge") ? "Edge" : -1 != a.indexOf("chrome") ? "Chrome" : -1 != a.indexOf("opera") ? "Opera" : -1 != a.indexOf("staroffice") ? "Star Office" : -1 != a.indexOf("webtv") ? "WebTV" : -1 != a.indexOf("beonex") ? "Beonex" : -1 != a.indexOf("chimera") ? "Chimera" :
            -1 != a.indexOf("netpositive") ? "NetPositive" : -1 != a.indexOf("phoenix") ? "Phoenix" : -1 != a.indexOf("firefox") ? "Firefox" : -1 != a.indexOf("safari") ? "Safari" : -1 != a.indexOf("skipstone") ? "SkipStone" : -1 != a.indexOf("msie") || -1 != a.indexOf("trident") ? "Internet Explorer" : -1 != a.indexOf("netscape") ? "Netscape" : -1 != a.indexOf("mozilla/5.0") ? "Mozilla" : ""
    },
    _getElement: function(a) {
        return document.getElementById(a)
    },
    _createElement: function(a) {
        return window.document.createElement(a)
    },
    _append: function(a, b) {
        $(a).append($(b))
    },
    _firstChildByClassName: function(a) {
        a = window.document.getElementsByClassName(a);
        for (var b, c = 0; c < a.length; c++) b = a[0];
        return b
    },
    _getElementsByClassName: function(a) {
        return window.document.getElementsByClassName(a)
    },
    _setCss: function(a, b, c) {
        a = this._firstChildByClassName(a);
        this._css(a, b, c)
    },
    _css: function(a, b, c) {
        $(a).css(b, c)
    },
    _hover: function(a, b, c) {
        $(a).hover(b, c)
    },
    _show: function(a) {
        $(a).show()
    },
    _hide: function(a) {
        $(a).hide()
    },
    _attr: function(a, b, c) {
        $(a).attr(b, c)
    },
    _setClassName: function(a, b) {
        a.className =
            b
    },
    _removeClass: function(a, b) {
        $(a).removeClass(b)
    },
    _addClass: function(a, b) {
        $(a).addClass(b)
    },
    _remove: function(a) {
        $(a).remove()
    },
    _on: function(a, b, c) {
        $(a).on(b, c)
    },
    _un: function(a, b) {
        $(a).on(b)
    },
    _html: function(a, b) {
        $(a).html(b)
    },
    _click: function(a, b) {
        $(a).click(b)
    },
    _val: function(a, b, c) {
        $(a).val(b, c)
    },
    _getAttribute: function(a, b) {
        return $(a).attr(b)
    },
    _setAttribute: function(a, b, c) {
        $(a).attr(b, c)
    },
    _split: function(a, b) {
        return a.split("-")
    },
    _isDef: function(a) {
        return void 0 != a && null != a ? !0 : !1
    },
    _linkExtStyle: function(a) {
        var b =
            this._createElement("link");
        b.setAttribute("type", "text/css");
        b.setAttribute("href", a);
        b.setAttribute("rel", "stylesheet");
        document.getElementsByTagName("head")[0].appendChild(b);
        return !1
    },
    _getTimeStringhtml: function(a) {
        var b = parseInt(a / 60);
        a = parseInt(a % 60);
        return 0 != b && 0 != a ? "<strong class='num'>" + b + "</strong>\uc2dc\uac04<strong class='num'> " + a + "</strong>\ubd84" : 0 != b && 0 == a ? "<strong class='num'>" + b + "</strong>\uc2dc\uac04 " : 0 == b && 0 != a ? "<strong class='num'>" + a + "</strong>\ubd84" : "<strong class='num'>1</strong>\ubd84 \ubbf8\ub9cc"
    },
    _getTimeString: function(a) {
        var b = parseInt(a / 60);
        a = parseInt(a % 60);
        return 0 != b && 0 != a ? b + "\uc2dc\uac04 " + a + "\ubd84" : 0 != b && 0 == a ? b + "\uc2dc\uac04 " : 0 == b && 0 != a ? a + "\ubd84" : "1\ubd84 \ubbf8\ub9cc"
    },
    _commify: function(a) {
        var b = /(^[+-]?\d+)(\d{3})/;
        for (a += ""; b.test(a);) a = a.replace(b, "$1,$2");
        return a
    },
    _sleep: function(a) {
        for (var b = (new Date).getTime(), c = 0; 1E7 > c && !((new Date).getTime() - b > a); c++);
    },
    _loadExtLibs: function(a, b) {
        var c = "",
            e = "";
        null != a && 0 < a.length && (c = a.shift());
        if ("" != c) {
            0 < a.length && (e = a[0]);
            var d = this._createElement("script");
            d.setAttribute("type", "text/javascript");
            d.setAttribute("src", c);
            d.setAttribute("async", !1);
            d.onreadystatechange = function() {
                if ("loaded" == d.readyState || "complete" == d.readyState) "" != e ? (d.onreadystatechange = null, vw.ol3.CommonFunc._loadExtLibs(a, b)) : b()
            };
            d.onload = function() {
                "" != e ? (d.onload = null, vw.ol3.CommonFunc._loadExtLibs(a, b)) : b()
            };
            document.getElementsByTagName("head")[0].appendChild(d)
        }
        return !1
    },
    _ShimResize: function(a) {
        if (null == vw.ol3.CommonFunc._getElement(vw.vworldIDs.idmenu) || null == vw.ol3.CommonFunc._getElement(vw.vworldIDs.idmenu)) return !1;
        "on" == a && (vw.ol3.CommonFunc._getElement(vw.vworldIDs.idmenu).style.height = vw.ol3.CommonFunc._getElement(vw.vworldIDs.idshim).style.height = "132px", vw.ol3.CommonFunc._getElement(vw.vworldIDs.idmenu).style.opacity = vw.ol3.CommonFunc._getElement(vw.vworldIDs.idshim).style.opacity = 1, vw.ol3.CommonFunc._getElement(vw.vworldIDs.idmenu).style.filter = vw.ol3.CommonFunc._getElement(vw.vworldIDs.idshim).style.filter = "alpha(opacity=100)");
        "off" == a && (vw.ol3.CommonFunc._getElement(vw.vworldIDs.idmenu).style.height =
            vw.ol3.CommonFunc._getElement(vw.vworldIDs.idshim).style.height = "66px", vw.ol3.CommonFunc._getElement(vw.vworldIDs.idmenu).style.opacity = vw.ol3.CommonFunc._getElement(vw.vworldIDs.idshim).style.opacity = 1, vw.ol3.CommonFunc._getElement(vw.vworldIDs.idmenu).style.filter = vw.ol3.CommonFunc._getElement(vw.vworldIDs.idshim).style.filter = "alpha(opacity=100)")
    },
    _isIE: function() {
        return -1 != navigator.userAgent.indexOf("MSIE") || -1 != navigator.userAgent.indexOf("Trident") ? !0 : !1
    },
    _makeinvisible: function(a, b) {
        var c =
            vw.ol3.CommonFunc._getElement(a);
        null != c && (vw.ol3.CommonFunc._isIE() ? (c.style.height = "100%", 1 == b ? (c.style.display = "inline-block", c.style.visibility = "visible") : (c.style.display = "none", c.style.visibility = "hidden")) : 1 == b ? (c.style.height = "100%", c.style.visibility = "visible", c.style.display = "inline-block") : (c.style.height = "0px", c.style.visibility = "hidden"))
    },
    _isMobile: function() {
        try {
            var a = "iPhone;iPod;BlackBerry;Android;Windows CE;LG;MOT;SAMSUNG;SonyEricsson".split(";"),
                b;
            for (b in a)
                if (null != navigator.userAgent.toUpperCase().match(a[b].toUpperCase())) return !0;
            return !1
        } catch (c) {
            return !1
        }
    },
    _isNumber: function(a) {
        a = (a + "").replace(/^\s*|\s*$/g, "");
        return "" == a || isNaN(a) ? !1 : !0
    },
    _makeUniqeIds: function() {
        return Math.random().toString(36).substr(5, 10)
    }
};
</script>
<script src="http://map.vworld.kr/jquery/ol3/jquery-1.11.3.min.js"></script>
<script src="http://map.vworld.kr/jquery/ol3/jquery-ui.min.js"></script>
<script src="http://map.vworld.kr/js/map/OpenLayers-3.10.1/ol3.19.1.js"></script>
<script src="http://map.vworld.kr/js/map/chart/ol3/v2.raphael.js"></script>
<script src="http://map.vworld.kr/js/map/chart/ol3/v2.g.raphael.max.js"></script>
<script src="http://map.vworld.kr/js/map/chart/ol3/v2.g.bar.max.js"></script>
<script src="http://map.vworld.kr/js/map/chart/ol3/v2.g.pie.max.js"></script>
<script src="http://map.vworld.kr/js/vw.ol3.2DMapClassInit_v30.min.js"></script>
<script src="http://map.vworld.kr/js/sopMapInit.js.do?version=2.0&apiKey=37874123-F292-3A2B-A8E6-934A0D6472C8"></script>
<script src="http://map.vworld.kr/check2DNum.do?key=37874123-F292-3A2B-A8E6-934A0D6472C8"></script>
</head> 

<body>
<!-- width:800px;height:660px;left:0px;top:0px -->
		<div id="vmap" style="height:400px;width:90%;"></div>
	
	<script>
	
	var mapController;
    
	 vw.MapControllerOption = {
 			container : "vmap",
 			mapMode: "2d-map",
 			basemapType: vw.ol3.BasemapType.graphic,
 			controlDensity:  vw.ol3.DensityType.basic,
				interactionDensity: vw.ol3.DensityType.basic,
				controlsAutoArrange: true,
				homePosition: vw.ol3.CameraPosition,
				initPosition: vw.ol3.CameraPosition,
 		};
		
		mapController = new vw.MapController(vw.MapControllerOption); 
        
			 
	</script>

</body> 
</html>