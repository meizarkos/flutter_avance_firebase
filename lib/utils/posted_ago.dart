String timeAgo(int timestampMs) {
  final now = DateTime.now();
  final postTime = DateTime.fromMillisecondsSinceEpoch(timestampMs);
  final difference = now.difference(postTime);

  if (difference.inSeconds < 60) {
    return 'just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
  } else {
    return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
  }
}