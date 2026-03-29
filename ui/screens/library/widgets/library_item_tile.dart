import 'package:flutter/material.dart';
import '../view_model/library_item_data.dart';

class LibraryItemTile extends StatefulWidget {
  const LibraryItemTile({
    super.key,
    required this.data,
    required this.isPlaying,
    required this.onTap,
    required this.onLikesChanged,
  });

  final LibraryItemData data;
  final bool isPlaying;
  final VoidCallback onTap;
  final Future<void> Function(int Likes) onLikesChanged;

  @override
  State<LibraryItemTile> createState() => _LibraryItemTileState();
}

class _LibraryItemTileState extends State<LibraryItemTile> {
  late int _likes;
  bool _isLikes = false;

  @override
  void initState() {
    super.initState();
    _likes = widget.data.song.likes;
  }

    Future<void> _toggleLike() async {

    setState(() {
      _isLikes = !_isLikes;
      if (_isLikes) {
        _likes++;
      } else {
        _likes--;
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
          onTap: widget.onTap,
          title: Text(widget.data.song.title),
          subtitle: Row(
            children: [
              Text("${widget.data.song.duration.inMinutes} mins"),
              SizedBox(width: 20),
              Text(widget.data.artist.name),
              SizedBox(width: 20),
              Text("$_likes likes"),
            ],
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.data.song.imageUrl.toString()),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.isPlaying ? "Playing" : "",
                style: TextStyle(color: Colors.amber),
              ),
              IconButton(
                onPressed: _toggleLike,
                icon: Icon(
                  _isLikes ? Icons.favorite : Icons.favorite_border,
                  color: _isLikes ? Colors.red : const Color(0xFF90CAF9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
