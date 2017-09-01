
//========================
//  記事表示
//========================
var viewPattern;
function showKijiArea(displayNotesCount,isTateShow,width,height,myFontSize) {
    
    $("#viewpt_36_" + displayNotesCount).css("display", "none");
    $("#viewpt_36_" + displayNotesCount + "_t").css("display", "none");
    $("#tate_viewpt_36_" + displayNotesCount).css("display", "none");
    $("#tate_viewpt_36_" + displayNotesCount + "_t").css("display", "none");
    
    // 縦
    if (isTateShow == 1) {
        if (width>height) {
            viewPattern = "tate_viewpt_36_" + displayNotesCount + "_t";
        } else {
            viewPattern = "tate_viewpt_36_" + displayNotesCount;
        }
    } else {
        if (width>height) {
            viewPattern = "viewpt_36_" + displayNotesCount + "_t";
        } else {
            viewPattern = "viewpt_36_" + displayNotesCount;
        }
    }

    $("#" + viewPattern).css("display", "block");

    // 縦
    if (isTateShow == 1) {
        setViewSize_t(viewPattern, width, height, myFontSize);
    }else{
        setViewSize(viewPattern, width, height, myFontSize);
    }
}

//========================
//  VIEWサイズ設定（画像位置変更）
//========================
function setViewImg(viewId, isTateShow)
{
    // 画像位置変更
    $("#" + viewId + " img").each( function()
                                  {
                                  if ($(this).css( "display") == "none") {
                                  return;
                                  }
                                  var flg = ( Math.floor( Math.random() * 100 ) % 2 );
                                  if( flg == 1 )
                                  {
                                  $(this).css( "float", "left" );
                                  }
                                  
                                  var type = "y";
                                  // 画像表示サイズ設定
                                  if ($(this)[0].naturalWidth) {
                                    if ($(this)[0].naturalHeight > $(this)[0].naturalWidth) {
                                        type = "t";
                                    }
                                  }

                                  var img_parent = $(this).parents( "td:first" );
                                  var ptype = img_parent.attr( "type" );
                                  
                                  // 基準幅
                                  var baseWidth = parseInt( $("#" + viewId + " div.view_page:first").width() );
                                  var parentWidth = img_parent.width();
                                  
                                  // 1:縦-横, 2:縦-縦, 3:横-横, 4:横-縦
                                  var img_css = "view_data_img_1";
                                  var img_width = parentWidth;
                                  
                                  // 縦-縦
                                  if( ptype == "t" && type == "t" ) {
                                  img_css = "view_data_img_2";
                                  img_width = parentWidth * 0.5;
                                  }
                                  // 横-横
                                  else if( ptype == "y" && type == "y" ) {
                                  img_css = "view_data_img_3";
                                  img_width = parentWidth * 0.45;
                                  }
                                  // 横-縦
                                  else if( ptype == "y" && type == "t" ) {
                                  img_css = "view_data_img_4";
                                  img_width = parentWidth * 0.45;
                                  }
                                  else
                                  {
                                  img_width = parentWidth - 40;
                                  }

                                  // 縦
                                  if (isTateShow == 1) {
                                  var title=$(this).parents("div.kiji_info:first").find(".view_data_title:first");
                                  var titleWidth = parseInt(title.css("width"));
                                  
                                  if (img_width > parentWidth - titleWidth - 15) {
                                    img_width = parentWidth - titleWidth - 15;
                                  }
                                  }
                                  
                                  // クラス追加
                                  $(this).addClass( img_css );
                                  $(this).css( "width", img_width ).css( "height", "auto" );
                                  
                                  } );
    
}

//========================
//  VIEWサイズ設定（横書）
//========================
function setViewSize(viewId,viewAreaWidth,viewAreaHeight,fontSize)
{
    // 文字サイズ変更
    changeFontSize(viewId, fontSize);
    
    //-----------------------
    //  横用文字変換
    //-----------------------
    $("#sec_view span.rensuuji").each( function()
                                      {
                                      var tmpChar = $(this).attr( "zen_val" );
                                      $(this).removeClass( "tate_rensuuji" ).removeClass( "tate_rensuuji_ipad" );
                                      $(this).text( tmpChar );
                                      } );
    //	$("#sec_view span.tateChar").removeClass( "tate_transform" ).removeClass( "tate_transform_ipad" );
    
    // VIEWタイトル高さ
    var viewTitleHeight = 0;
    // VIEWページ高さ
    var viewPageHeight = viewAreaHeight - viewTitleHeight;
    
    // VIEWテーブル：幅設定
    $("#" + viewId + " div.view_page").css( "width", viewAreaWidth ).css( "height", viewPageHeight );;
    
    //---------------------
    //  ViewPt 高さ設定
    //---------------------
    $("#" + viewId + " div.view_page td[v_height]").each( function()
                                                         {
                                                         //------------------
                                                         //  部品情報
                                                         //------------------
                                                         // タイトル
                                                         var view_data_title = $(this).find( "div.view_data_title" );
                                                         // 本文
                                                         var view_data_honbun = $(this).find( "div.view_data_honbun" );
                                                         var view_data_honbun_txt = $(this).find( "div.view_data_honbun_txt" );
                                                         // 画像
                                                         var view_data_photo = $(this).find( "div.view_data_photo" );
                                                         // 記事詳細
                                                         var view_data_shimen_info = $(this).find( "div.view_data_shimen_info" );
                                                         
                                                         
                                                         //----------------------
                                                         //  設定情報 取得
                                                         //----------------------
                                                         // 設定(%)
                                                         var tdHeight = parseInt( $(this).attr("v_height") );
                                                         var tdWidth = parseInt( $(this).attr( "v_width" ) );
                                                         var setHeight = Math.floor( tdHeight * viewPageHeight / 100 - 1 );
                                                         var setTdWidth = Math.floor( tdWidth * viewAreaWidth / 100 - 1 );
                                                         
                                                         //-------------------
                                                         //  セルサイズ設定
                                                         //-------------------
                                                         $(this).css( "height", setHeight ).css( "width", setTdWidth );
                                                         $(this).find("div.kiji_info").css( "height", setHeight ).css( "width", setTdWidth );
                                                         
                                                         //---------------------
                                                         //  タイトルサイズ
                                                         //---------------------
                                                         var titleMargin = 5;
                                                         var titleLineHeight = parseInt( view_data_title.css( "line-height" ) );
                                                         var viewTitleWidth = setTdWidth - ( titleMargin * 2 );
                                                         var viewTitleHeight = ( titleLineHeight * 2 );
                                                         
                                                         view_data_title.css( "width", viewTitleWidth ).css( "margin", titleMargin );
                                                         viewTitleHeight = parseInt( view_data_title.css( "height" ) );
                                                         
                                                         /*20130212【追加】タイトル高さが0の時は自力で算出*/
                                                         if( viewTitleHeight == 0 ){
                                                         var titleFont = parseInt( view_data_title.css( "font-size" ) );  //フォントサイズ
                                                         var orgTitleWidth = parseInt( view_data_title.css( "width" ) );  //タイトル表示領域の高さ
                                                         var oneCount = parseInt( orgTitleWidth/titleFont );  //1行に入る文字数
                                                         var textCount = view_data_title.text().length;  //タイトルの文字数
                                                         var lineCount = parseInt( textCount/oneCount )+1;  //タイトルに必要な行数
                                                         var calcTitleHeight = lineCount*titleFont+( lineCount*2 );  //タイトルが使う幅
                                                         
                                                         viewTitleHeight = calcTitleHeight;
                                                         }
                                                         
                                                         /*20130212【追加】*/
                                                         
                                                         viewTitleHeight += ( titleMargin * 2 );
                                                         
                                                         //--------------------
                                                         //  記事詳細サイズ
                                                         //--------------------
                                                         var detailLineHeight = parseInt( view_data_shimen_info.css("line-height") );
                                                         var dMarginTop = parseInt( view_data_shimen_info.css("margin-top") );
                                                         var dMarginBtm = parseInt( view_data_shimen_info.css("margin-bottom") );
                                                         var detailHeight = detailLineHeight + dMarginTop + dMarginBtm;
                                                         
                                                         //----------------------
                                                         //  本文エリアサイズ
                                                         //----------------------
                                                         var hLineHeight = parseInt( view_data_honbun.css("line-height") );
                                                         var hMarginLeft = parseInt( view_data_honbun.css("margin-left") );
                                                         var hMarginRight = parseInt( view_data_honbun.css("margin-right") );
                                                         var hMarginTop = parseInt( view_data_honbun.css("margin-top") );
                                                         var hMarginBtm = parseInt( view_data_honbun.css("margin-bottom") );
                                                         //		var honbunAreaHeight = setHeight - viewTitleHeight - detailHeight - hMarginTop - hMarginBtm - 2;
                                                         
                                                         var honbunAreaHeight = setHeight - viewTitleHeight - detailHeight - 1;
                                                         var honbunAreaWidth = setTdWidth - hMarginLeft - hMarginRight;
                                                         var lineCnt = Math.floor( honbunAreaHeight / hLineHeight );
                                                         var newHonbunAreaHeight = lineCnt * hLineHeight;
                                                         var newMarginBtm = setHeight - viewTitleHeight - newHonbunAreaHeight - (detailHeight - dMarginTop);
                                                         //		view_data_honbun.css( "width", honbunAreaWidth ).css( "height", newHonbunAreaHeight ).css( "margin-bottom", newMarginBtm );
                                                         
                                                         view_data_honbun.css( "width", honbunAreaWidth ).css( "height", honbunAreaHeight );
                                                         view_data_honbun.css( "column-width", honbunAreaWidth )
                                                         .css( "-webkit-column-width", honbunAreaWidth )
                                                         .css( "-moz-column-width", honbunAreaWidth + "px" );
                                                         
                                                         view_data_honbun_txt.css( "padding", 0 )
                                                         .css( "margin", 0 )
                                                         .css( "height", honbunAreaHeight);
                                                         
                                                         view_data_shimen_info.css( "margin-top", -2 ).css( "width", setTdWidth );
                                                         
                                                         } );
    
    setViewImg(viewId, "0");
    setViewKijiClick(viewId);
}

//========================
//  VIEWサイズ設定(縦書)
//========================
function setViewSize_t(viewId,viewAreaWidth,viewAreaHeight,fontSize)
{
    // 文字サイズ変更
    changeFontSize(viewId, fontSize);
    
    //-----------------------
    //  縦用文字変換
    //-----------------------
    // 連数字
    var addClass = "tate_rensuuji";
    
    $("#sec_view span.rensuuji").each( function()
                                      {
                                      var tmpChar = $(this).attr( "han_val" ); //半角2ケタ以上の数字
                                      $(this).text( tmpChar ); //このspan内のテキストを全角数字から半角数字へ変更
                                      $(this).addClass( addClass );  //tate_rensuuji属性をクラスへ追加
                                      } );
    
    // サムネイルテーブル向き変更
    $("#" + viewId + " div.view_page").css( "float", "right" );
    $("#" + viewId + " div.view_page img").css( "float", "left" );
    
    var viewTitleHeight = 0;
    // VIEWページ高さ
    var viewPageHeight = viewAreaHeight - viewTitleHeight;
    
    //---------------------------
    //  記事サムネイル
    //---------------------------
    // VIEWページ サイズ設定
    $("#" + viewId + " div.view_page").css( "width", viewAreaWidth ).css( "height", viewPageHeight );
    
    //-----------------------
    //  ViewPt サイズ設定
    //-----------------------
    $("#" + viewId + " div.view_page td[v_height]").each( function()
                                                         {
                                                         //-----------------
                                                         //  設定情報取得
                                                         //-----------------
                                                         // 設定高さ(%)
                                                         var tdHeight = parseInt( $(this).attr("v_height") );
                                                         // 設定幅
                                                         var tdWidth = parseInt( $(this).attr( "v_width" ) );
                                                         // 再設定高さ
                                                         var setHeight = Math.floor( tdHeight * viewPageHeight / 100 - 1 );
                                                         // 再設定幅
                                                         var setTdWidth = Math.floor( tdWidth * viewAreaWidth / 100 - 1 );
                                                         
                                                         //-------------------
                                                         //  セルサイズ設定
                                                         //-------------------
                                                         $(this).css( "height", setHeight ).css( "width", setTdWidth );
                                                         $(this).find("div.kiji_info").css( "height", setHeight ).css( "width", setTdWidth );
                                                         
                                                         // タイトル
                                                         var view_data_title = $(this).find( "div.view_data_title" );
                                                         // 本文
                                                         var view_data_honbun = $(this).find( "div.view_data_honbun" );
                                                         // 本文
                                                         var view_data_honbun_txt = $(this).find( "div.view_data_honbun_txt" );                                                         // 画像
                                                         var view_data_photo = $(this).find( "div.view_data_photo" );
                                                         // 記事情報
                                                         var view_data_shimen_info = $(this).find( "div.view_data_shimen_info" );

                                                         //------------------------
                                                         //  縦書き用クラス設定
                                                         //------------------------
                                                         $(this).addClass( "taketori-writingmode-ttb taketori-atsign-ja-jp taketori-lang-ja-jp" );
                                                         view_data_title.addClass( "taketori-col" ).css( "float", "right" ).css( "height", setHeight );
                                                         view_data_honbun.addClass( "taketori-col" ).css( "float", "right" );
                                                         view_data_shimen_info.css( "font-family", "ヒラギノ" ).css( "float", "left" );
                                                         
                                                         //---------------------
                                                         //  タイトルサイズ
                                                         //---------------------
                                                         var titleMargin = 5;
                                                         var titleLineHeight = parseInt( view_data_title.css( "line-height" ) );
                                                         var viewTitleHeight = setHeight - ( titleMargin ) - 16;
                                                         var viewTitleWidth = ( titleLineHeight * 2 );
                                                         
                                                         var spanSize = view_data_title.find( "span" ).size();
                                                         if( spanSize > 0 )
                                                         {
                                                         viewTitleWidth += 5;
                                                         }
                                                         
                                                         view_data_title.css( "height", viewTitleHeight ).css( "margin-top", titleMargin );
                                                         //20130110
                                                         //実際のタイトルの大きさが0じゃなかったときは入れ替え。
                                                         var orgTitleWidth = parseInt( view_data_title.css( "width" ) );
                                                         if(orgTitleWidth != 0){
                                                         viewTitleWidth = orgTitleWidth;
                                                         }
                                                         else{
                                                         var titleFont = parseInt( view_data_title.css( "font-size" ) );  //フォントサイズ
                                                         var orgTitleHeight = parseInt( view_data_title.css( "height" ) );  //タイトル表示領域の高さ
                                                         var oneCount = parseInt( orgTitleHeight/titleFont );  //1行に入る文字数
                                                         var textCount = view_data_title.text().length;  //タイトルの文字数
                                                         var lineCount = parseInt( textCount/oneCount )+1;  //タイトルに必要な行数
                                                         var calcTitleWidth = lineCount*titleFont+( lineCount*2 );  //タイトルが使う幅
                                                         
                                                         viewTitleWidth = calcTitleWidth;
                                                         }
                                                         
                                                         viewTitleWidth += ( titleMargin * 2 );
                                                         if( viewTitleWidth >= setTdWidth )
                                                         {
                                                         viewTitleWidth = setTdWidth - ( titleMargin * 2 );
                                                         view_data_title.css( "width", viewTitleWidth );
                                                         viewTitleWidth += ( titleMargin * 2 );
                                                         }
                                                         
                                                         //--------------------
                                                         //  記事詳細サイズ
                                                         //--------------------
                                                         var detailLineHeight = parseInt( view_data_shimen_info.css("line-height") );
                                                         var dMarginTop = parseInt( view_data_shimen_info.css("margin-top") );
                                                         var dMarginBtm = parseInt( view_data_shimen_info.css("margin-bottom") );
                                                         var detailHeight = detailLineHeight + dMarginTop + dMarginBtm;
                                                         
                                                         //----------------------
                                                         //  本文エリアサイズ
                                                         //----------------------
                                                         var hLineHeight = parseInt( view_data_honbun.css("line-height") );
                                                         var hMarginLeft = parseInt( view_data_honbun.css("margin-left") );
                                                         var hMarginRight = parseInt( view_data_honbun.css("margin-right") );
                                                         var hMarginTop = parseInt( view_data_honbun.css("margin-top") );
                                                         var hMarginBtm = parseInt( view_data_honbun.css("margin-bottom") );
                                                         var honbunAreaWidth = setTdWidth - viewTitleWidth - hMarginLeft - hMarginRight - 2;
                                                         var honbunAreaHeight = setHeight - detailHeight - hMarginTop - hMarginBtm;
                                                         var lineCnt = Math.floor( honbunAreaWidth / hLineHeight );
                                                         //		honbunAreaWidth = lineCnt * hLineHeight;
                                                         view_data_honbun.css( "width", honbunAreaWidth ).css( "height", honbunAreaHeight );
                                                         view_data_honbun.css( "column-width", honbunAreaHeight )
                                                         .css( "-webkit-column-width", honbunAreaHeight )
                                                         .css( "-moz-column-width", honbunAreaHeight + "px" );
                                                         
                                                         view_data_honbun_txt.css( "padding", 0 )
                                                         .css( "margin", 0 )
                                                         .css( "height", honbunAreaHeight);
                                                         
                                                         // 記事詳細幅設定
                                                         
                                                         view_data_shimen_info.css( "width", setTdWidth );
                                                         
                                                         } );
    
    
    
    setViewImg(viewId, "1");
    setViewKijiClick(viewId);
    
}

//========================
//  文字サイズ変更
//========================
function changeFontSize(viewId,fontSize) {
    $("#" + viewId + " div.view_data_honbun_txt").css("font-size", parseFloat(fontSize) + "px").css("line-height", parseFloat(fontSize) + 5 + "px");
    $("#" + viewId + " div.view_data_title").css("font-size", parseFloat(fontSize) + 3 + "px").css("line-height", parseFloat(fontSize) + 5 + "px");
}

//========================
//  記事選択事件を設定
//========================
var timer;
var tapHoldFlg = 0;
var viewKijiClickFlg = 0;
function setViewKijiClick(viewId)
{
    var targetObj = $("#" + viewId + " div.kiji_info");
    var interval = 500;
    
    // イベント設定
    var clickEvent = "click";
    var startEvent = "touchstart";
    var moveEvent = "touchmove";
    var endEvent = "touchend";
    
    targetObj.unbind( startEvent ).bind( startEvent, function()
                                        {

                                        viewKijiClickFlg = 1;
                                        var thisObj = $(this);
                                        
                                        //-----------------------
                                        //  記事クリップ
                                        //-----------------------
                                        timer = setTimeout( function()
                                                           {
                                                           tapHoldFlg = 1;
                                                           
                                                           // 選択解除
                                                           if( thisObj.hasClass("clip_select"))
                                                           {
                                                           thisObj.removeClass( "clip_select" );
                                                           }
                                                           // 記事選択
                                                           else
                                                           {
                                                           thisObj.addClass( "clip_select" );
                                                           }
                                                           
                                                           }, interval );
                                        
                                        //------------------------
                                        //  ページスクロール
                                        //------------------------
                                        targetObj.unbind( moveEvent ).bind( moveEvent, function()
                                                                           {
                                                                           if( viewKijiClickFlg != 1 )
                                                                           {
                                                                           return;
                                                                           }
                                                                           
                                                                           // 初期化
                                                                           clearTimeout( timer );
                                                                           tapHoldFlg = 1;
                                                                           
                                                                           } );
                                        
                                        targetObj.unbind( endEvent ).bind( endEvent, function()
                                                                          {
                                                                          // 初期化
                                                                          clearTimeout( timer );

                                                                          if( tapHoldFlg == 0 )
                                                                          {
                                                                          targetObj.removeClass( "clip_select" );
                                                                          
                                                                          }
                                                                          
                                                                          // 初期化
                                                                          tapHoldFlg = 0;
                                                                          viewKijiClickFlg = 0;
                                                                          } );
                                        
                                        });
    
    //========================
    //  記事選択
    //========================
    targetObj.unbind( clickEvent ).bind( clickEvent, function() {
                                        sendCommand("noteClick",$(this).attr("indexNo"));
                                        });
    
    return;
}

//========================
//  選択した記事を取得
//========================
function getSelectedKiji() {
    var selectedKiji="";
    $("#" + viewPattern + " div.kiji_info").each( function() {
                                            if ($(this).hasClass("clip_select")) {
                                            selectedKiji = selectedKiji + $(this).attr("indexNo") + ",";
                                            }
                                                         });
    
    return selectedKiji;
}

//========================
//  APP Event
//========================
function sendCommand(cmd,param){
    var url="naviapp:"+cmd+":"+param;
    document.location = url;
}
