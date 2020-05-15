# opencv_histogram_equality

This library help to check two image histogram equality.

> Supported Platforms
>
> - IOS


## How to Use

```yaml
# add this line to your dependencies
opencv_histogram_equality: ^0.0.1
```

```dart
import 'package:opencv_histogram_equality/opencv_histogram_equality.dart';
```

```dart
    ByteData first = await rootBundle.load('assets/images/cup.jpg');
    ByteData second = await rootBundle.load('assets/images/cup2.jpg');

    OpencvHistogramEquality()
        .similarity(first.buffer.asUint8List(), second.buffer.asUint8List());
```
