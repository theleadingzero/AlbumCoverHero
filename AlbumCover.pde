import java.util.Collection;

import de.umass.lastfm.*;



class AlbumCover 
{  
  Album album;    
  Album tmp;      
  String album_name;
  String artist;
  String api_key;
  
  int coverWidth;
  int coverHeight;

  PImage album_cover;
  
  Iterator<Album> iterator;
  Collection<Album> topAlbums;
  
  //---------------------------------------------
  // AlbumCover: Constructor - pass artist name and api key
  AlbumCover(String ar_name, String k)
  {
     api_key = k;
     artist = ar_name; 
     
     coverWidth = 300;
     coverHeight = 300;
     
     loadAlbums();
  }
  
  //---------------------------------------------
  // getCover: return the the album cover as a PImage
  PImage getCover()
  {
     return album_cover; 
  }
  
  //---------------------------------------------
  // getAlbumName: return the the album name as a string
  String getAlbumName()
  {
     return album_name;
  }
  
  //---------------------------------------------
  // getAlbumArtist: return the the artist name as a string
  String getAlbumArtist()
  {
      return artist;
  }
  
  //---------------------------------------------
  // loadAlbums: load the top albums of the artist from last.fm
  void loadAlbums()
  {
    topAlbums = Artist.getTopAlbums(artist, api_key);
      
    iterator = topAlbums.iterator();
  }
  
  //---------------------------------------------
  // setImageDimensions: set the dimensions of the image
  void setImageDimensions(int w,int h)
  {
     coverWidth = w;
     coverHeight = h;    
  }
  
  //---------------------------------------------
  // loadRandomAlbum: load the info of a random album from the artist
  void loadRandomAlbum()
  {
      
      int r = int(random(topAlbums.size()));
      
      for (int i = 0;i < r;i++)
      {
        if (iterator.hasNext())
        {
          tmp = iterator.next();
        }
        else
        {
          println("No more albums!!");
        }
      }
         
      getAlbumInfo(tmp.getArtist(),tmp.getName());
  }
  
  //---------------------------------------------
  // loadAlbum: load the info of the next album from the artist
  void loadAlbum()
  {
      if (iterator.hasNext())
      {
        tmp = iterator.next();
      }
      else
      {
        println("No more albums!!");
      }
      
      getAlbumInfo(tmp.getArtist(),tmp.getName());
  }

  //---------------------------------------------
  // getAlbumInfo: retrieve Album Metadata and cover image from last.fm
  void getAlbumInfo(String ar,String al)
  {
    // get the album as an Album object  
    album = Album.getInfo(ar,al,api_key); // get album info
    album_name = album.getName(); // get album name
  
    // get album cover
    
    String imageSize = "EXTRALARGE";  // set image size
  
    Set<ImageSize> s = album.availableSizes(); // get a set of available image sizes
    
    // if the set contains the image size we are looking for
    if (s.contains(ImageSize.valueOf(imageSize)))
    {   
       album_cover = loadImage(album.getImageURL(ImageSize.valueOf(imageSize)));
       
       album_cover.resize(coverWidth, coverHeight);
       loadPixels();  
    }
  }

}
