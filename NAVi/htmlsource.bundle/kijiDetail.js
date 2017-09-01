function changeHtml(kijiHtml) {
//    alert(kijiHtml);
    $("body").html(kijiHtml);
    setTimeout(function() {
    
               }, 500);
//    $("body").html(kijiHtml);
    controlTagDescription();
    $('#pic_content').hide();
}

//========================
//  記事表示
//========================
function showKijiArea(isTateShow,viewAreaWidth,viewAreaHeight,fontSize) {
    
    
    // 縦
    if (isTateShow == 1) {
        $("#kiji_detail_area").removeClass('scroll');
        $("#kiji_detail_area").css("display", "none");
        $("#tate_kiji_detail_area").css("display", "block");
        $("#tate_kiji_detail_area").addClass('scroll');
        setKijiDetailSize_t(viewAreaWidth, viewAreaHeight);
    } else {
        $("#kiji_detail_area").css("display", "block");
        $("#kiji_detail_area").addClass('scroll');
        $("#tate_kiji_detail_area").css("display", "none");
        $("#tate_kiji_detail_area").removeClass('scroll');
        
        setKijiDetailSize(viewAreaWidth, viewAreaHeight);
    }
    
    // 文字サイズ変更
    changeFontSize(fontSize);
    
//    alert($("kiji_detail_honbun1").css("font-size"));
}
//========================
//  記事詳細 サイズ設定（横書）
//========================
function setKijiDetailSize(viewAreaWidth,viewAreaHeight)
{
    // imageをロード
    var imgObj = $("#kiji_detail_area #kphoto");
    var imgDiv = $("#kiji_detail_area #kiji_detail_img");
    
    if (imgObj.attr("src") == "" && imgObj.attr("srcPath") == "") {
        imgDiv.css("display", "none");
    }
    
    if (imgObj.attr("src") == "" && imgObj.attr("srcPath") != "") {
        imgObj.attr("src", imgObj.attr("srcPath"));
        imgDiv.css("display", "block");
    }
    
    viewAreaWidth = parseInt(viewAreaWidth);
    viewAreaHeight = parseInt(viewAreaHeight);
    
    $("#kiji_detail_area").css( "width", viewAreaWidth ).css( "height", viewAreaHeight );
    
    // タイトル
    var view_data_title = $("#kiji_detail_area .kiji_detail_title");
    var titleLineHeight = parseInt( view_data_title.css( "line-height" ) );
    var titlePadding = parseInt( view_data_title.css( "padding-top" ) ) + parseInt( view_data_title.css( "padding-bottom" ) );
    
    var titleHeight = parseInt(view_data_title.css("height")) + titlePadding;
    
    var kijiArea = $("#kiji_detail_area #ktext");
    kijiArea.css( "width", viewAreaWidth - 10).css( "height", viewAreaHeight - titleHeight);
    
    var kijiAreaPadding = parseInt( kijiArea.css( "padding-left" ) );
    
    var kiji_detail_honbun = $("#kiji_detail_area .kiji_detail_honbun");
    
    kiji_detail_honbun.css( "padding", 0 )
    .css( "margin", 0 )
    .css( "width", viewAreaWidth - kijiAreaPadding)
    .css( "height", "auto");
}

//===========================
//  記事詳細 サイズ設定（縦書）
//===========================
function setKijiDetailSize_t(viewAreaWidth, viewAreaHeight)
{
    viewAreaWidth = parseInt(viewAreaWidth);
    viewAreaHeight = parseInt(viewAreaHeight);
    
    // タイトル
    var view_data_title = $("#tate_kiji_detail_area #tate_kiji_detail_title");
    // 本文
    var kiji_detail_honbun_wrap = $("#kiji_detail_honbun_wrap");
    var kiji_detail_honbun = $("#tate_kiji_detail_area #kiji_detail_honbun");
    
    // imageをロード
    var imgObj = $("#tate_kiji_detail_area #tate_photo");
    var imgDiv = $("#tate_kiji_detail_area #tate_kiji_detail_img");
    
    if (imgObj.attr("src") == "" && imgObj.attr("srcPath") == "") {
        imgDiv.css("display", "none");
    }
    
    // 縦書き用クラス設定
    $("#tate_kiji_detail_area").css( "width", viewAreaWidth ).css( "height", viewAreaHeight -10);
    $("#tate_kiji_detail_area #kiji_detail").css( "width", viewAreaWidth ).css( "height", viewAreaHeight -10);
    
    //---------------------
    //  タイトルサイズ
    //---------------------
    var titleMargin = 5;
    var titleLineHeight = parseInt( view_data_title.css( "line-height" ) );
    var viewTitleHeight = viewAreaHeight - ( titleMargin * 2 );
    var viewTitleWidth = ( titleLineHeight * 2 );
    
    var spanSize = view_data_title.find( "span" ).size();
    if( spanSize > 0 )
    {
        viewTitleWidth += 5;
    }
    
    view_data_title.css( "height", viewTitleHeight );
    
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
    if( viewTitleWidth >= viewAreaWidth )
    {
        viewTitleWidth = viewAreaWidth - ( titleMargin * 2 );
        view_data_title.css( "width", viewTitleWidth );
        viewTitleWidth += ( titleMargin * 2 );
    }
    
    // カラム間幅
    var columnGap = kiji_detail_honbun_wrap.css("column-gap");
    if( columnGap == null || columnGap == "" )
    {
        columnGap = kiji_detail_honbun_wrap.css("-webkit-column-gap");
        if( columnGap == null || columnGap == "" )
        {
            columnGap = kiji_detail_honbun_wrap.css("-moz-column-gap");
        }
    }
    columnGap = parseInt( columnGap );
    
    //---------------------
    //  本文Wrap
    //---------------------
    var hwMarginRight = parseInt( kiji_detail_honbun_wrap.css( "margin-right" ) );
    var honbunWrapWidth = viewAreaWidth - viewTitleWidth - hwMarginRight;
    
    honbunWrapWidth = parseInt(honbunWrapWidth);
    
    //----------------------
    //  本文エリアサイズ
    //----------------------
    var hLineHeight = parseInt( kiji_detail_honbun.css("line-height") );
    var hMarginLeft = parseInt( kiji_detail_honbun.css("margin-left") );
    var hMarginRight = parseInt( kiji_detail_honbun.css("margin-right") );
    var hMarginTop = parseInt( kiji_detail_honbun.css("margin-top") );
    var hMarginBtm = parseInt( kiji_detail_honbun.css("margin-bottom") );
    
    var screenDansuu = parseInt($("#spanNum").val());
    if (viewAreaWidth > viewAreaHeight) {
        screenDansuu = 2;
    }
    var honbunAreaWidth = parseInt(viewAreaWidth - viewTitleWidth - hMarginLeft - hMarginRight - 5);
    var columnHeight = parseInt((viewAreaHeight - hMarginTop * screenDansuu - hMarginBtm - columnGap * (screenDansuu - 1)) / screenDansuu);
    
    // 段組設定
    kiji_detail_honbun_wrap.css( "column-width", columnHeight )
    .css( "-webkit-column-width", columnHeight )
    .css( "-moz-column-width", columnHeight + "px" )
    .css( "-o-column-width", columnHeight )
    .css( "-ms-column-width", columnHeight )
    .css( "width", honbunWrapWidth)
    .css( "height", viewAreaHeight);
    
    //----------------------
    //  縦書き設定
    //----------------------
    kiji_detail_honbun.css( "padding", 0 )
    .css( "height", columnHeight);
    
    if (imgObj.attr("src") == "" && imgObj.attr("srcPath") != "") {
        imgObj.attr("src", imgObj.attr("srcPath"));
        imgDiv.css("display", "block");
        
        imgObj.load(function(){
                    imgObj.css( "width", "auto").css( "height", columnHeight);
                    if (parseInt(imgObj.css( "width")) > honbunWrapWidth) {
                        imgObj.css( "width", honbunWrapWidth).css( "height", "auto");
                        imgObj.css( "padding-top", (columnHeight - parseInt(imgObj.css( "height"))) / 2);
                    }
                    
                    var detailWidth = parseInt(imgDiv.css("width")) + parseInt(kiji_detail_honbun.css( "width")) + parseInt($("#tate_paper_link_div").css("width")) + 5 * screenDansuu;
                    
                    if (honbunWrapWidth * screenDansuu > detailWidth) {
                        $("#spaceDiv").css("display", "block");
                        $("#spaceDiv").css("width", honbunWrapWidth * screenDansuu - detailWidth);
                    } else {
                        $("#spaceDiv").css("display", "none");
                    }
                });
    } else {
        $("#spaceDiv").css("display", "none");
    }
}

//========================
//  文字サイズ変更
//========================
function changeFontSize(fontSize) {
    $("div.kiji_detail_title1").css("font-size", parseFloat(fontSize) + 8).css("line-height", parseFloat(fontSize) + 5 + "px");
    $("div.kiji_detail_title2").css("font-size", parseFloat(fontSize) + 4).css("line-height", parseFloat(fontSize) + 5 + "px");
    $("div.kiji_detail_title3").css("font-size", parseFloat(fontSize)).css("line-height", parseFloat(fontSize) + 5 + "px");
    $("div.kiji_detail_title4").css("font-size", parseFloat(fontSize)).css("line-height", parseFloat(fontSize) + 5 + "px");

}

//========================
//  画像選択
//========================
function imageClick() {
    sendCommand("imageClick",document.getElementsByName("kijiindexno")[0].value);
}

//========================
//  画像選択
//========================
function linkImageClick() {
    sendCommand("linkImageClick","");
}

//========================
//  関連紙面load
//========================
function loadLinkImg(srcPath) {
    $("img.list_img").each( function() {
                           $(this).attr("src", srcPath);
                           });
    
    return false;
}
//========================
//  edit tags
//========================
function editTags(){
     sendCommand("editTags","");
}
//========================
//  edit description
//========================
function editDescription(){
    sendCommand("editDescription","");
}
//========================
//  control tag & description div show or hide
//========================
function controlTagDescription(){
    
    var detailTag = $('#type').val();
    
    if (detailTag == "TYPE_CLIP"){
        $('#tag').show();
        $('#description').show();
    }else {
        $('#tag').hide();
        $('#description').hide();
    }
}
function showPicOrText(type){
    if (type != null && type != ""){
        if (type == 'text') {
            $('#pic_content').hide();
            $('#pic_text_content').show();
        }else {
            $('#pic_content').show();
            $('#pic_text_content').hide();
        }
    }
}
function sendCommand(cmd,param){
    var url="naviapp:"+cmd+":"+param;
    document.location = url;
}
