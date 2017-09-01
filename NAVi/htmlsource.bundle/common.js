//=======================
//  日付変換
//========================
function dateToViewDate( dateStr, youbiFlg )
{
	// 「/」削除
	dateStr = dateStr.replace( /[\/-]/g, "" );
	if( dateStr.length < 8 )
	{
		return dateStr;
	}

	// YYYY
	var yyyy = dateStr.substring( 0, 4 );
	// MM
	var mm = dateStr.substring( 4, 6 );
	// DD
	var dd = dateStr.substring( 6, 8 );
	// 返却文字列
	var retStr = "";

	if( youbiFlg != null && youbiFlg == 1 )
	{
		// Date型変換
		var nDate = new Date( yyyy, mm - 1, dd );;

		// 曜日取得
		var youbiList = new Array( "日","月","火","水","木","金","土" );
		var youbi = nDate.getDay();
		var yobiStr = "(" + youbiList[ youbi ] + ")";

		retStr = yyyy + "/" + mm + "/" + dd + " " + yobiStr;
	}
	else
	{
		retStr = yyyy + "/" + mm + "/" + dd;
	}

	return retStr;
}

//=======================
//日付変換(年がない)
//========================
function dateToViewDate2( dateStr, youbiFlg )
{
	// 「/」削除
	dateStr = dateStr.replace( /[\/-]/g, "" );
	if( dateStr.length < 8 )
	{
		return dateStr;
	}

	// YYYY
	var yyyy = dateStr.substring( 0, 4 );
	// MM
	var mm = dateStr.substring( 4, 6 );
	// DD
	var dd = dateStr.substring( 6, 8 );
	// 返却文字列
	var retStr = "";

	if( youbiFlg != null && youbiFlg == 1 )
	{
		// Date型変換
		var nDate = new Date( yyyy, mm - 1, dd );;

		// 曜日取得
		var youbiList = new Array( "日","月","火","水","木","金","土" );
		var youbi = nDate.getDay();
		var yobiStr = "(" + youbiList[ youbi ] + ")";

		retStr = mm + "月" + dd + "日" + yobiStr;
	}
	else
	{
		retStr = mm + "月" + dd + "日";
	}

	return retStr;
}

//========================
//検索用日付取得
//========================
function dateToYYYYMMDD2( date )
{
	var y = date.getFullYear();
	var m = date.getMonth() + 1;

	if (m < 10) {
		m = "0" + m;
	}
	var d = date.getDate();
	if (d < 10) {
		d = "0" + d;
	}
	var dateStr = y.toString() + m + d;
	return dateStr;
}
//=======================
//  日付変換
//========================
function dateToInputDate( dateStr )
{
	// 「/」削除
	dateStr = dateStr.replace( /[\/-]/g, "" );
	if( dateStr.length < 8 )
	{
		return dateStr;
	}

	// YYYY
	var yyyy = dateStr.substring( 0, 4 );
	// MM
	var mm = dateStr.substring( 4, 6 );
	// DD
	var dd = dateStr.substring( 6, 8 );
	// 返却文字列
	var retStr = "";

	retStr = yyyy + "-" + mm + "-" + dd;

	return retStr;
}
//========================
//  検索用日付取得
//========================
function dateToYYYYMMDD( dateStr )
{
	// ｢/｣削除
	dateStr = dateStr.replace( /[\/-]/g, "" );

	return dateStr.substring( 0, 8 );
}

//-------------------
//  UserAgent取得
//-------------------
var userAgent = navigator.userAgent;
//=====================
//  iPad判定
//=====================
function isiPad()
{
	if( userAgent.indexOf("iPad") != -1 )
	{
		return true;
	}
	return false;
}

//=====================
//Android判定
//=====================
function isAndroid()
{
	if( userAgent.indexOf("Android") != -1 )
	{
		return true;
	}
	return false;
}

//=====================
//iPhone、iPod判定
//=====================
function isiPhone()
{
	if( userAgent.indexOf("iPhone") != -1 || userAgent.indexOf("iPod") != -1)
	{
		return true;
	}
	return false;
}

//=====================
//Androidの携帯判定
//=====================
function isAndroidPhone()
{
	if( isAndroid() && userAgent.indexOf("Mobile") != -1 )
	{
		return true;
	}
	return false;
}

//=====================
//WinPhone判定
//=====================
function isWinPhone()
{
	if( userAgent.match(/windows mobile/i) === "windows mobile" )
	{
		return true;
	}
	return false;
}
//=====================
//WinPhone判定
//=====================
function isMac()
{
	if( isPC() && userAgent.indexOf("Mac") != -1 )
	{
		return true;
	}
	return false;
}

//=====================
//  PC判定
//=====================
function isPC()
{
	if( isAndroid() )
	{
		return false;
	}
	else if( isiPhone() )
	{
		return false;
	}
	else if( isiPad() )
	{
		return false;
	}
	else if( isWinPhone() )
	{
		return false;
	}
	return true;
}

//=========================
//画面幅 取得
//=========================
function getScreenWidth()
{
	var screenWidth = window.innerWidth||document.documentElement.clientWidth;

	return screenWidth;
}
//=========================
//画面高さ 取得
//=========================
function getScreenHeight()
{
	var screenHeight = window.innerHeight||document.documentElement.clientHeight;
	return screenHeight;
}