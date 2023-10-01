
import 'package:flutter/cupertino.dart';
import 'package:getx_bloc/the_content.dart';
import 'package:getx_bloc/views/the_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogDetailPage extends StatefulWidget {
  final SliderItem sliderItem;

  const BlogDetailPage({super.key, required this.sliderItem});

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        middle: Text(
          widget.sliderItem.theHeadline,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: CupertinoColors.systemTeal,
          ),
        ),
        // trailing: IconButton(
        //   onPressed: () {},
        //   icon: Icon(
        //     Icons.bookmark_border,
        //     color: Colors.blueGrey.shade900,
        //   ),
        // ),
      ),
      // : TheAppBar(
      //   title: '',
      //   actions: [
      //     //BookmarkButton(),
      //
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(
      //         Icons.bookmark_border,
      //         color: Colors.blueGrey.shade900,
      //       ),
      //     ),
      //   ],
      // ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        widget.sliderItem.theHeadline,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.systemCyan,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          widget.sliderItem.theArt,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, diam sit amet aliquet ultricies, nisl nunc ultricies nunc,"
                        " vitae aliquam nunc nisl eu nisl. Sed vitae nisl eget nisl aliquam aliquam. Donec euismod, nisl eget aliquam aliquam,"
                        " nisl nunc ultricies nunc, vitae aliquam nunc nisl eu nisl. Sed vitae nisl eget nisl aliquam aliquam. Donec euismod,"
                        " nisl eget aliquam aliquam, nisl nunc ultricies nunc, vitae aliquam nunc nisl eu nisl. Sed vitae nisl eget nisl aliquam aliquam."
                        " Donec euismod, nisl eget aliquam aliquam, nisl nunc ultricies nunc, vitae aliquam nunc nisl eu nisl."
                        " Sed vitae nisl eget nisl aliquam aliquam. Donec euismod, nisl eget aliquam aliquam, nisl nunc ultricies nunc, vitae aliquam nunc nisl eu nisl."
                        " Sed vitae nisl eget nisl aliquam aliquam. Donec euismod, nisl eget aliquam aliquam, nisl nunc ultricies nunc, vitae aliquam nunc nisl eu nisl. "
                        "Sed vitae nisl "
                        "eget nisl aliquam aliquam. Donec euismod, nisl eget aliquam aliquam, nisl nunc ultricies nunc, vitae aliquam nunc nisl eu nisl. "
                        "Sed vitae nisl eget nisl aliquam aliquam. Donec euismod, nisl eget aliquam aliquam, nisl nunc ultricies nunc, vitae aliquam nunc nisl eu nisl.",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ),

          ],
        ),

      ),
    );
  }
}
