import 'package:flutter/material.dart';
import '../../../model/artist/artist.dart';

class ArtistTile extends StatefulWidget {
  const ArtistTile({super.key, required this.artist});

  final Artist artist;

  @override
  State<ArtistTile> createState() => _ArtistTileState();
}

class _ArtistTileState extends State<ArtistTile> {
  bool _isLiked = false;
  late int _likes;

  @override
  void initState() {
    super.initState();
    _likes = 0;
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) {
        _likes++; // increase
      } else {
        _likes--; // decrease
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          title: Text(widget.artist.name),
          subtitle: Text("$_likes likes"),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.artist.imageUrl.toString()),
          ),
          trailing: IconButton(
            onPressed: _toggleLike,
            icon: Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border,
              color: _isLiked ? Colors.red : const Color(0xFF90CAF9),
            ),
          ),
        ),
      ),
    );
  }
}
