// znet maps api
// 宅地図のズーム量を調整する定数
var DEFAULT_ZMAP_ZOOM_UPPER_LIMIT = 9;
var DEFAULT_ZMAP_ZOOM_LOWER_LIMIT = 4;
var DEFAULT_ZMAP_ZOOM_CONTROL = 1;
/** 
 * マップ表示
 * ※ブラウザ上に認証承認ID(ADI)cookie群が存在する前提
 */
function showZMapSelectPosition(map_id, zoom_rate, field_id, url) {
  toggleMap("z", map_id);
  initZMapSelectPosition(map_id, zoom_rate, field_id, url);
  map_initialized[map_id] = true;
}

function initZMapSelectPosition(map_id, zoom_rate, field_id, url) {
  // ログインしていなかったら処理終了
  if(ZntAuth.getStatus() != ZntAuth.STATUS_LOGIN) {
    return;
  }

  // マップ作成用パラメータ指定
  var w = '470';
  var h = '280';
  var opts = new ZntMapOptions();

  // 緯度経度を指定する
  opts.initPos = new ZntPoint(zmap_lng, zmap_lat);
  // 地図サイズを指定する
  opts.size = new ZntSize(w,h);
  // 地図倍率を指定する
  opts.initZoomLevel = zmap_zoom;
  // 地図表示モードを指定する
  opts.viewMode = zmap_view;
  // マウスドラッグモードを指定する
  opts.dragMode = Number(zmap_drag);
  // ８方向ボタンを指定する
  opts.scrollButton = true;
  // 虫めがねを指定する
  if(zmap_loupe == "1") {
    opts.loupe = true;
    opts.loupeOpen = true;
  } else if(zmap_loupe == "2") {
    opts.loupe = true;
    opts.loupeOpen = false;
  } else {
    opts.loupe = false;
  }
  // 広域ミニマップを指定する
  if(zmap_submap == "1") {
    opts.subMap = true;
    opts.subMapOpen = true;
  } else if(zmap_submap == "2") {
    opts.subMap = true;
    opts.subMapOpen = false;
  } else {
    opts.subMap = false;
  }

  //地図の初期化と表示
  var map = new ZntMap();
  map.initialize(document.getElementById(map_id), opts);
  var target = {map: map};

  // 初期表示時には入力済み地名をマーカで表示する
  var text_field = $("#"+field_id);
  var text_field_value = text_field.val().replace(/(\n|\r)+$/, '');
  if (text_field_value.length > 0) {
    var marker_bounds = null;
    var addresses = text_field_value.split("\n");
    var addresses_total = 0;
    addresses_total = addresses.length;
    for (var i = 0; i < addresses.length; i++) {
      if (i == 0){
        rect_Reset();
      }
      // 入力された住所にマーカをセットする
      addZMarker(addresses[i], target, marker_bounds, url, addresses_total);
    }
  }

  // クリックイベントリスナ登録
  target.map.addEventListener("click", function(event) {
    addClickedZAddress(event.pos, target, field_id, url);
  });
}

// 矩形範囲の変数
var x_max = 0;
var x_min = 0;
var y_max = 0;
var y_min = 0;
var ztmp_zoom = 0;
/**
 * マップにマーカを表示(発生場所入力用)
 */
function addZMarker(address, target, marker_bounds, url, addresses_total) {
  if (!address) return;

  // 検索オブジェクトと検索条件指定オブジェクトを生成する
  var sear = new ZntAddressSearch();
  var opts = new ZntAddressSearchSettings();
  // 検索ワードを指定する
  opts.freeWord = address;
  // 都道府県コードを指定する
  opts.prefCode = ""; // 全国
  // 行政単位コードを指定する
  opts.matchLv = "6"; // 6:枝版
  // 上限数を指定する
  opts.limit = "1";
  // 部品図を指定する
  opts.partMap = "false"; // false:含めない
  // 開始位置を指定する
  opts.startPos = "1";
  // 最大件数を設定する
  opts.maxCount = "1";

  sear.addEventListener("receive", function(r){
    var result = r.result;
    if (result.status == "30200000") {
      if (addresses_total > 1) {
      	// 取得地点にマーカをセット
        putMarker(target, result.itemsAddr[0].pos, url);
        // マップ表示をマーカ群を見渡せる範囲に拡張する
        // 矩形の変数の値が「0]なら初期値として一つめの発生場所の座標を設定する
        if (x_max == 0){
          x_max = result.itemsAddr[0].pos.x;
          x_min = result.itemsAddr[0].pos.x;
          y_max = result.itemsAddr[0].pos.y;
          y_min = result.itemsAddr[0].pos.y;
        } else {
          if (x_max < result.itemsAddr[0].pos.x){
            x_max = result.itemsAddr[0].pos.x;
          }
          if (x_min > result.itemsAddr[0].pos.x){
            x_min = result.itemsAddr[0].pos.x;
          }
          if (y_max < result.itemsAddr[0].pos.y){
            y_max = result.itemsAddr[0].pos.y;
          }
          if (y_min > result.itemsAddr[0].pos.y){
            y_min = result.itemsAddr[0].pos.y;
          }
        }
        marker_bounds = new ZntRect(new ZntPoint(x_min, y_min), new ZntPoint(x_max, y_max));
        target.map.moveToRect(marker_bounds, new ZntSize(20, 20));

        // マップ表示をマーカ群を見渡せる範囲に拡張する
        ztmp_zoom = target.map.getZoomLevel();
        if (ztmp_zoom > DEFAULT_ZMAP_ZOOM_UPPER_LIMIT) {
          ztmp_zoom = DEFAULT_ZMAP_ZOOM_UPPER_LIMIT;
          target.map.zoomTo(ztmp_zoom);
        } else if (ztmp_zoom < DEFAULT_ZMAP_ZOOM_LOWER_LIMIT) {
          ztmp_zoom = DEFAULT_ZMAP_ZOOM_LOWER_LIMIT;
          target.map.zoomTo(ztmp_zoom);
        } else {
        ztmp_zoom = ztmp_zoom - DEFAULT_ZMAP_ZOOM_CONTROL;
        target.map.zoomTo(ztmp_zoom);
        }
      } else if (addresses_total == 1){
      	// 取得地点にマーカをセット
        putMarker(target, result.itemsAddr[0].pos, url);
        // マーカが一つだけの時、マップ表示をマーカの位置に移動する
        target.map.moveTo(result.itemsAddr[0].pos);
      }	else {
        // 成功だけど結果0件
        console.log("no result retrieved.");
      }
    } else {
      console.log("ERROR:"+result.status);
    }
  }, 0);
  sear.search(opts);
}

/** 
 * 指定された地点にマーカをセットし、その地名を取得してテキストフィールドに追加(発生場所入力用)
 */
function addClickedZAddress(latlng, target, field_id, url) {
  // クリック地点の地名を取得
  var sear = new ZntAddressStringSearch();
  var opts = new ZntAddressStringSearchSettings();
  opts.pos = latlng;
  // マッチングさせる行政単を設定する
  opts.matchLv = 6; // 6： 枝番までの住所文字列を取得する。

  sear.addEventListener("receive", function(r){
    var result = r.result;
    switch(result.status){
    case "30400000":
      // クリック地点にマーカをセット
      putMarker(target, latlng, url);
      // クリック地点の地名をテキストフィールドに追加
      var text_field = $("#"+field_id);
      var text_field_value = text_field.val().replace(/(\n|\r)+$/, '');
      text_field.val(text_field_value.length>0 ? text_field_value+"\n"+result.address : result.address);
      break;
    case "30411009":
      alert("エリアを特定できません");
      break;
    default:
      console.log("ERROR:"+result.status);
      alert("エリアを特定できません");
      break;
   }
  }, 0);
  sear.search(opts);
}

function putMarker(target, latlng, url) {
  var marker_option;
  var marker_url;
  marker_url = url
  marker_opts = new ZntMarkerOptions();
  marker_opts.icon = marker_url + '/plugin_assets/lgdis/images/red-dot.png';
  marker_opts.visible = true;
  marker_opts.opacity = 1.0;
  marker_opts.zIndex = 0;
  marker_opts.iconOffset = new ZntPoint(2, -10); // 画像に応じたオフセット量を指定
  var marker = new ZntMarker(latlng, marker_opts);
  target.map.addGeometry(marker);
}

function rect_Reset() {
  // 前回の矩形の値をリセットする
  x_max = 0;
  x_min = 0;
  y_max = 0;
  y_min = 0;
  ztmp_zoom = 0;
}
