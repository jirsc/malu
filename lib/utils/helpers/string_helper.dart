///Returns a boolean if the passed [value] is empty or not.
bool isEmpty({required String value}) {
  try {
    // ignore: unnecessary_null_comparison
    if (value != null) {
      if (value.isEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  } catch (ex) {
    //Print muna sa ngayon kasi on dev phase pa.
    //Dapat talaga nakalagay ito sa isang log file.
    print(ex.toString());
    throw Exception("Error while checking the value: $ex");
  }
}
