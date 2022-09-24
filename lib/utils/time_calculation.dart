class TimeCalculation{
  static String  getTimeDiff(DateTime createdDate){
    DateTime now = DateTime.now();
    Duration timedDiff = now.difference(createdDate);
    if(timedDiff.inHours<=1){
      return '방금 전';
    } else if(timedDiff.inHours <= 24) {
      return '${timedDiff.inHours}시간 전';;
    } else {
      return '${timedDiff.inDays}일 전';
    }
  }
}