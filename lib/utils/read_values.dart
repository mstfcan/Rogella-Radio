import 'dart:ui';

class ReadValues{

  static final ReadValues _instance=ReadValues._internal();

  factory ReadValues(){
    return _instance;
  }

  ReadValues._internal();

  static Map<String,int> _colors={
    "header":0xFF6c63FF,
    "search_icon_bg":0xFF333333,
    "filter_button":0xFFFFFFFF,
    "filter_button_text":0xFF333333,
    "content_background":0xFFE5E9EC,
    "search_input_bg":0xFFFFFFFF,
    "dark_color":0xFF3F3D56
  };

  static List<List<Color>> _gradientColors = [
    [Color(0xFFff9a9e), Color(0xFFfad0c4)],
    [Color(0xFFffecd2), Color(0xFFfcb69f)],
    [Color(0xFFff9a9e), Color(0xFFfecfef)],
    [Color(0xFFa1c4fd), Color(0xFFc2e9fb)],
    [Color(0xFFcfd9df), Color(0xFFe2ebf0)],
    [Color(0xFFfdfbfb), Color(0xFFebedee)],
    [Color(0xFFf5f7fa), Color(0xFFc3cfe2)],
    [Color(0xFF667eea), Color(0xFF764ba2)],
    [Color(0xFFfdfcfb), Color(0xFFe2d1c3)],
    [Color(0xFF89f7fe), Color(0xFF66a6ff)],
    [Color(0xFF48c6ef), Color(0xFF6f86d6)],
    [Color(0xFFfeada6), Color(0xFFf5efef)],
    [Color(0xFFa3bded), Color(0xFF6991c7)],
    [Color(0xFF13547a), Color(0xFF80d0c7)],//--
    [Color(0xFF93a5cf), Color(0xFFe4efe9)],
    [Color(0xFF434343), Color(0xFF000000)],//--
    [Color(0xFF93a5cf), Color(0xFFe4efe9)],
    [Color(0xFFff758c), Color(0xFFff7eb3)],
    [Color(0xFF868f96), Color(0xFF596164)],
    [Color(0xFFc79081), Color(0xFFdfa579)],
    [Color(0xFF09203f), Color(0xFF537895)],//--
    [Color(0xFF96deda), Color(0xFF50c9c3)],
    [Color(0xFF29323c), Color(0xFF485563)],//--
    [Color(0xFFee9ca7), Color(0xFFffdde1)],
    [Color(0xFF1e3c72), Color(0xFF2a5298)],//--
    [Color(0xFFffc3a0), Color(0xFFffafbd)],
    [Color(0xFFB7F8DB), Color(0xFF50A7C2)],
    [Color(0xFF2E3192), Color(0xFF1BFFFF)],//--
    [Color(0xFFD4145A), Color(0xFFFBB03B)],//--
    [Color(0xFF009245), Color(0xFFFCEE21)],//--
    [Color(0xFF662D8C), Color(0xFFED1E79)],//--
    [Color(0xFFEE9CA7), Color(0xFFFFDDE1)],
    [Color(0xFF614385), Color(0xFF516395)],//--
    [Color(0xFF02AABD), Color(0xFF00CDAC)],
    [Color(0xFFFF5F6D), Color(0xFFFFC371)],
    [Color(0xFF11998E), Color(0xFF38EF7D)],//--
    [Color(0xFFC6EA8D), Color(0xFFFE90AF)],
    [Color(0xFFEA8D8D), Color(0xFFA890FE)],
    [Color(0xFFD8B5FF), Color(0xFF1EAE98)],
    [Color(0xFFFF61D2), Color(0xFFFE9090)],
    [Color(0xFFBFF098), Color(0xFF6FD6FF)],
    [Color(0xFF4E65FF), Color(0xFF92EFFD)],
    [Color(0xFFA9F1DF), Color(0xFFFFBBBB)],
    [Color(0xFFC33764), Color(0xFF1D2671)],//--
    [Color(0xFF93A5CF), Color(0xFFE4EfE9)],
    [Color(0xFF868F96), Color(0xFF596164)],//--
    [Color(0xFF09203F), Color(0xFF537895)],//--
    [Color(0xFFFFECD2), Color(0xFFFCB69F)],
    [Color(0xFFA1C4FD), Color(0xFFC2E9FB)],
    [Color(0xFF764BA2), Color(0xFF667EEA)],//--
  ];

  static int getColor(String key){
    return _colors[key];
  }

  static List<Color> getGradientColor(int index){
    return _gradientColors[index];
  }

  static int getGradiendColorListCount(){
    return _gradientColors.length;
  }

}