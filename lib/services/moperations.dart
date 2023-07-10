import 'package:spotify_app/services/spotify_api.dart';

import '../models/music.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Create a FirebaseStorage instance

class MOperations{

  List<String> audioUrls;

  MOperations(this.audioUrls);

  List<Music> getMusic() {
    return <Music>[
      Music('Old Town Road', 'https://th.bing.com/th/id/OIP.an3jDaJmM6sJUKWQ2FFN4gHaEK?pid=ImgDet&rs=1',
          'Lil Nas X',
          audioUrls[0]),
      Music('Unholy','https://c-fa.cdn.smule.com/smule-gg-uw1-s-5/arr/c1/fb/3bc8f5f5-d37e-4e37-b31c-54329718079f_256.jpg',
          'Sam Smith',
           audioUrls[1]),
      Music('Look At Me', 'https://m.media-amazon.com/images/I/81hEkC8ZuBL._CR0,204,1224,1224_UX256.jpg',
          'XXXtentacion',
          audioUrls[2]),
      Music('Remedy For Broken Heart', 'https://m.media-amazon.com/images/I/81hEkC8ZuBL._CR0,204,1224,1224_UX256.jpg',
          'XXXtentacion',
          audioUrls[3]),
    ];
  }
}