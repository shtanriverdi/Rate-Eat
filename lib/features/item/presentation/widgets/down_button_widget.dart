import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/pepicons.dart';
import 'package:like_button/like_button.dart';
import 'package:micro_yelp/core/core.dart';

import '../../../authentication/data/repository/shared_preference.dart';
import '../../../authentication/presentation/login.dart';

class DownVoteButton extends StatefulWidget {
  final Function() downVoteFun;
  final String isVoted;
  final int count;

  const DownVoteButton({
    super.key,
    required this.downVoteFun,
    required this.isVoted,
    required this.count,
  });

  @override
  State<DownVoteButton> createState() => _VoteButtonState();
}

class _VoteButtonState extends State<DownVoteButton> {
  bool isliked = false;
  int likeCount = 0;

  @override
  Widget build(BuildContext context) {
    const double size = 20;
    likeCount = widget.count;
    isliked = (widget.isVoted == '0' || widget.isVoted == '1') ? false : true;

    return LikeButton(
      size: size,
      isLiked: isliked,
      likeCount: likeCount,
      likeBuilder: (isliked) {
        print(widget.isVoted);
        final color = isliked || widget.isVoted == '-1'
            ? MicroYelpColor.primaryColor
            : MicroYelpColor.bottomNavigationIconColor;
        return Iconify(
          Pepicons.triangle_down_filled,
          color: color,
        );
      },
      likeCountPadding: EdgeInsets.only(left: 4),
      countBuilder: (count, isLiked, text) {
        return Text(text,
            style: const TextStyle(fontSize: 20, color: Colors.black));
      },
      onTap: ((isLiked) async {
        print('====tabbed====');
        final token = await StorageService.getToken();
        final bool isLoggedIn = !(token == null);
        isliked = !isLiked;

        likeCount = isLiked ? likeCount + 1 : likeCount - 1;
        if (isLoggedIn) {
          widget.downVoteFun();
        } else {
          Navigator.pushNamed(context, LoginPage.route);
        }
        return !isLiked;
      }),
    );
  }
}
