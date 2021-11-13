import 'dart:async';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:rogella_radio/models/myradio.dart';
import 'package:rogella_radio/utils/database_helper_two.dart';
import 'package:rogella_radio/utils/read_values.dart';

class ListenRadio extends StatefulWidget {
  MyRadio _myRadio;

  ListenRadio(this._myRadio);

  @override
  _ListenRadioState createState() => _ListenRadioState();
}

class _ListenRadioState extends State<ListenRadio>{
  IconData _favorite = Icons.star_border;
  bool _isProcess = false;
  bool _loadingFavoriteIcon = false;
  bool _firstPlay = true;
  bool _loadAds = false;

  var playerState = FlutterRadioPlayer.flutter_radio_paused;
  FlutterRadioPlayer _flutterRadioPlayer = new FlutterRadioPlayer();
  DatabaseHelperTwo dbHelperTwo = new DatabaseHelperTwo();

  @override
  void initState() {
    super.initState();
    Admob.initialize();
    _delayAds();
    _favoriteControl();
    _initFlutterRadio("false");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFE5E9EC), Color(0xFFC6CCD4)],
            )),
            alignment: Alignment.center,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            size: 28,
                            color: Color(ReadValues.getColor("dark_color")),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Card(
                        elevation: 6,
                        child: CachedNetworkImage(
                          alignment: Alignment.center,
                          imageUrl: widget._myRadio.favicon,
                          width: 150,
                          height: 150,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.black54),
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                              "assets/images/no_logo_radio.png",
                              fit: BoxFit.cover),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                        child: Text(
                          widget._myRadio.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(
                                ReadValues.getColor("dark_color"),
                              ),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 5.0, bottom: 5.0),
                        child: Text(
                          widget._myRadio.country,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(
                                ReadValues.getColor("dark_color"),
                              ),
                              fontSize: 16),
                        ),
                      ),
                      StreamBuilder<String>(
                          initialData: "",
                          stream: _flutterRadioPlayer.metaDataStream,
                          builder: (context, snapshot) {
                            RegExp _regExp = new RegExp('title="(.*?)"',
                                caseSensitive: true);
                            String title = "";
                            if (_regExp.stringMatch(snapshot.data) == null)
                              title = "";
                            else {
                              var temp = _regExp.allMatches(snapshot.data);
                              var temp2 = temp.elementAt(0);
                              title = temp2.group(1);
                            }

                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 5.0, bottom: 25.0),
                              child: Text(
                                title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(
                                      ReadValues.getColor("dark_color"),
                                    ),
                                    fontSize: 16),
                              ),
                            );
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _loadingFavoriteIcon
                              ? Align(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    if (!_isProcess) _updateFavorite();
                                  },
                                  child: CircleAvatar(
                                    maxRadius: 28,
                                    minRadius: 28,
                                    backgroundColor: Colors.black54,
                                    child: CircleAvatar(
                                      backgroundColor: Color(
                                          ReadValues.getColor(
                                              "content_background")),
                                      maxRadius: 24,
                                      child: Icon(
                                        _favorite,
                                        color: Color(
                                            ReadValues.getColor("dark_color")),
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                ),
                          StreamBuilder(
                              stream: _flutterRadioPlayer.isPlayingStream,
                              initialData: playerState,
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                String returnData = snapshot.data;
                                switch (returnData) {
                                  case FlutterRadioPlayer.flutter_radio_paused:
                                    return GestureDetector(
                                      onTap: () async {
                                        if (_firstPlay) {
                                          if ((await checkInternetConnection())) {
                                            await _flutterRadioPlayer.stop();
                                            await _flutterRadioPlayer.init(
                                                widget._myRadio.name,
                                                "Live",
                                                widget._myRadio.url_resolved,
                                                "true");
                                            setState(() {
                                              _firstPlay = false;
                                            });
                                          } else
                                            checkInternetConnectionDialog();
                                        } else {
                                          if ((await checkInternetConnection()))
                                            await _flutterRadioPlayer.play();
                                          else
                                            checkInternetConnectionDialog();
                                        }
                                      },
                                      child: CircleAvatar(
                                        minRadius: 40,
                                        maxRadius: 40,
                                        backgroundColor: Colors.black54,
                                        child: CircleAvatar(
                                          backgroundColor: Color(
                                              ReadValues.getColor(
                                                  "content_background")),
                                          maxRadius: 35,
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: Color(ReadValues.getColor(
                                                "dark_color")),
                                            size: 60,
                                          ),
                                        ),
                                      ),
                                    );
                                    break;
                                  case FlutterRadioPlayer.flutter_radio_playing:
                                    return GestureDetector(
                                      onTap: () async {
                                        await _flutterRadioPlayer.pause();
                                      },
                                      child: CircleAvatar(
                                        minRadius: 40,
                                        maxRadius: 40,
                                        backgroundColor: Colors.black54,
                                        child: CircleAvatar(
                                          backgroundColor: Color(
                                              ReadValues.getColor(
                                                  "content_background")),
                                          maxRadius: 35,
                                          child: Icon(
                                            Icons.pause,
                                            color: Color(ReadValues.getColor(
                                                "dark_color")),
                                            size: 60,
                                          ),
                                        ),
                                      ),
                                    );
                                    break;
                                  case FlutterRadioPlayer.flutter_radio_stopped:
                                    return GestureDetector(
                                      onTap: () async {
                                        if ((await checkInternetConnection()))
                                          await _flutterRadioPlayer.init(
                                              widget._myRadio.name,
                                              "Live",
                                              widget._myRadio.url_resolved,
                                              "true");
                                        else
                                          checkInternetConnectionDialog();
                                      },
                                      child: CircleAvatar(
                                        minRadius: 40,
                                        maxRadius: 40,
                                        backgroundColor: Colors.black54,
                                        child: CircleAvatar(
                                          backgroundColor: Color(
                                              ReadValues.getColor(
                                                  "content_background")),
                                          maxRadius: 35,
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: Color(ReadValues.getColor(
                                                "dark_color")),
                                            size: 60,
                                          ),
                                        ),
                                      ),
                                    );
                                    break;
                                  case FlutterRadioPlayer.flutter_radio_loading:
                                    return CircleAvatar(
                                      minRadius: 40,
                                      maxRadius: 40,
                                      backgroundColor: Colors.black54,
                                      child: CircleAvatar(
                                          backgroundColor: Color(
                                              ReadValues.getColor(
                                                  "content_background")),
                                          maxRadius: 35,
                                          child: CircularProgressIndicator()),
                                    );
                                  case FlutterRadioPlayer.flutter_radio_error:
                                    return GestureDetector(
                                      onTap: () async {
                                        if ((await checkInternetConnection()))
                                          await _flutterRadioPlayer.play();
                                        else
                                          checkInternetConnectionDialog();
                                      },
                                      child: CircleAvatar(
                                        minRadius: 40,
                                        maxRadius: 40,
                                        backgroundColor: Colors.black54,
                                        child: CircleAvatar(
                                          backgroundColor: Color(
                                              ReadValues.getColor(
                                                  "content_background")),
                                          maxRadius: 35,
                                          child: Icon(
                                            Icons.refresh,
                                            color: Color(ReadValues.getColor(
                                                "dark_color")),
                                            size: 60,
                                          ),
                                        ),
                                      ),
                                    );
                                    break;
                                  default:
                                    return GestureDetector(
                                      onTap: () async {
                                        if ((await checkInternetConnection()))
                                          await _flutterRadioPlayer.play();
                                        else
                                          checkInternetConnectionDialog();
                                      },
                                      child: CircleAvatar(
                                        minRadius: 40,
                                        maxRadius: 40,
                                        backgroundColor: Colors.black54,
                                        child: CircleAvatar(
                                          backgroundColor: Color(
                                              ReadValues.getColor(
                                                  "content_background")),
                                          maxRadius: 35,
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: Color(ReadValues.getColor(
                                                "dark_color")),
                                            size: 60,
                                          ),
                                        ),
                                      ),
                                    );
                                    break;
                                }
                              }),
                          GestureDetector(
                            onTap: () => _stopRadio(),
                            child: CircleAvatar(
                              minRadius: 28,
                              maxRadius: 28,
                              backgroundColor: Colors.black54,
                              child: CircleAvatar(
                                backgroundColor: Color(
                                    ReadValues.getColor("content_background")),
                                maxRadius: 24,
                                child: Icon(
                                  Icons.stop,
                                  color:
                                      Color(ReadValues.getColor("dark_color")),
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: _loadAds
                ? AdmobBanner(
                    adUnitId: AdmobBanner.testAdUnitId,
                    adSize: AdmobBannerSize.SMART_BANNER(context))
                : SizedBox(),
          )
        ],
      ),
    );
  }

  void _delayAds() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _loadAds = true;
    });
  }

  void _favoriteControl() async {
    setState(() {
      _loadingFavoriteIcon = true;
    });
    if ((await dbHelperTwo.favoriteControl(widget._myRadio)) == 0) {
      _favorite = Icons.star_border;
    } else {
      _favorite = Icons.star;
    }
    setState(() {
      _loadingFavoriteIcon = false;
    });
  }

  void _updateFavorite() async {
    setState(() {
      _isProcess = true;
    });
    String result = await dbHelperTwo.favoriteAddAndDelete(widget._myRadio);
    setState(() {
      if (result == "add") {
        _favorite = Icons.star;
      } else {
        _favorite = Icons.star_border;
      }
      _isProcess = false;
    });
  }

  _stopRadio() async {
    await _flutterRadioPlayer.stop();
  }

  void _initFlutterRadio(String whenStart) async {
    setState(() {
      _isProcess = true;
    });
    if ((await checkInternetConnection()))
      await _flutterRadioPlayer.init(widget._myRadio.name, "Live",
          widget._myRadio.url_resolved, whenStart);
    else
      checkInternetConnectionDialog();

    setState(() {
      _isProcess = false;
    });
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else
      return false;
  }

  void checkInternetConnectionDialog() {
    showDialog(
        context: context,
        child: AlertDialog(
            title: Text("Internet Connection"),
            content: Text("Please check internet connection."),
            actionsPadding: EdgeInsets.only(top: 4),
            actions: [
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close"),
                color: Colors.blueAccent,
              )
            ]));
  }
}
