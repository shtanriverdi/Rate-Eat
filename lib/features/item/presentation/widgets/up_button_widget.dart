import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:like_button/like_button.dart';
import 'package:micro_yelp/core/core.dart';

import '../../../authentication/data/repository/shared_preference.dart';
import '../../../authentication/presentation/login.dart';

class UpVoteButton extends StatefulWidget {
  final Function() upVoteFun;
  final String isVoted;
  final int count;

  const UpVoteButton({
    super.key,
    required this.upVoteFun,
    required this.isVoted,
    required this.count,
  });

  @override
  State<UpVoteButton> createState() => _VoteButtonState();
}

class _VoteButtonState extends State<UpVoteButton> {
  bool isliked = false;
  int likeCount = 0;

  @override
  Widget build(BuildContext context) {
    const double size = 15;
    likeCount = widget.count;
    isliked = (widget.isVoted == '0' || widget.isVoted == '-1') ? false : true;

    return LikeButton(
      size: size,
      isLiked: isliked,
      likeCount: likeCount,
      likeBuilder: (isliked) {
        print(widget.isVoted);
        final color = isliked || widget.isVoted == '1'
            ? MicroYelpColor.primaryColor
            : MicroYelpColor.bottomNavigationIconColor;
        return Iconify(
          Fluent.triangle_32_filled,
          color: color,
        );
      },
      likeCountPadding: EdgeInsets.only(left: 4),
      countBuilder: (count, isLiked, text) {
        return Text(text,
            style: const TextStyle(fontSize: 20, color: Colors.black));
      },
      onTap: ((isLiked) async {
        final token = await StorageService.getToken();
        final bool isLoggedIn = !(token == null);
        isliked = !isLiked;

        likeCount = isLiked ? likeCount - 1 : likeCount + 1;
        if (isLoggedIn) {
          widget.upVoteFun();
        } else {
          Navigator.pushNamed(context, LoginPage.route);
        }
        return !isLiked;
      }),
    );
  }
}
