import 'package:flutter/material.dart';

class Recommended extends StatelessWidget {
  const Recommended({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Advice',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            const Text(
              'Follow these recommendations for best results.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '1.',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                Expanded(
                  child: Text(
                    'Choose images that clearly show your face. Blurry or dark images are not recommended.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '2.',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                Expanded(
                  child: Text(
                    'Avoid uploading images with people or objects in the background. Be sure to be the main attraction in the picture.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '3.',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                Expanded(
                  child: Text(
                    'Make sure you are alone in the picture. If you upload images with other people, the program may confuse you with someone else.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
