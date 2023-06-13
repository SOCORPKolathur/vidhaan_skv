import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidebarx/sidebarx.dart';
import 'Secondpage.dart';
import 'main.dart';


class SidebarXExampleApp extends StatelessWidget {
  SidebarXExampleApp({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SidebarX Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        canvasColor: canvasColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: 46,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      home: Builder(
        builder: (context) {
          final isSmallScreen = MediaQuery.of(context).size.width < 600;
          return Scaffold(
            key: _key,
            appBar: isSmallScreen
                ? AppBar(
              backgroundColor: Color(0xffFFFFFF),
              leading: IconButton(
                onPressed: () {
                  // if (!Platform.isAndroid && !Platform.isIOS) {
                  //   _controller.setExtended(true);
                  // }
                  _key.currentState?.openDrawer();
                },
                icon: Icon(Icons.menu),
              ),
            )
                : null,
            drawer: ExampleSidebarX(controller: _controller),
            body: Row(
              children: [
                if (!isSmallScreen) ExampleSidebarX(controller: _controller),
                Expanded(
                  child: Center(
                    child: _ScreensExample(
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(color: Color(0xff9197B3)),
        selectedTextStyle: const TextStyle(color:Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),

        selectedItemDecoration: BoxDecoration(


          boxShadow: [
            BoxShadow(
              color: Color(0xff00A0E3),

            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Color(0xff989EB8),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color:  Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
        ),
      ),
     // footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Row(
              children: [
                Row(
                  children: [

                        Image.asset("assets/VIDHAAN.png",fit: BoxFit.cover,),


                    Text("Vidhaan",style: GoogleFonts.poppins(fontSize: 19,fontWeight: FontWeight.bold,color: Color(0xff0271C5)),)
                  ],
                )
              ],
            ),
          ),
        );
      },
      items: [
        SidebarXItem(

          label: 'Dashboard',
          icon:Icons.rectangle_outlined,


        ),
        SidebarXItem(
          icon: Icons.rectangle_outlined,
          label: 'Student',
        ),
        const SidebarXItem(
          icon: Icons.rectangle_outlined,
          label: 'Staff',
        ),
        const SidebarXItem(
          icon: Icons.rectangle_outlined,
          label: 'Fee Management',
        ),
         SidebarXItem(
           iconWidget: Container(child: Image.asset("assets/icons8.png",fit: BoxFit.cover,),
             width: 20,
             height: 20,
           ),

          label: 'Performance',
        ),
SidebarXItem(
          iconWidget: Container(child: Image.asset("assets/icons.png",fit: BoxFit.cover,),
            width: 20,
            height: 20,
          ),
          label: 'Important Notices',

        ),
        const SidebarXItem(
          icon: Icons.account_balance,
          label: 'Accounts',
        ),
        SidebarXItem(
          iconWidget: Container(child: Image.asset("assets/message.png",fit: BoxFit.cover,),
            width: 20,
            height: 20,
          ),

          label: 'Help',
        ),
       
        
        SidebarXItem(
          iconWidget:Row(
            children: [
              Container(
                //color: Colors.yellow,
                width: 50,
                height: 50,
                child: Image.asset("assets/Ellipse.png",fit: BoxFit.cover,),
                decoration: BoxDecoration( color: Colors.yellow,borderRadius: BorderRadius.circular(32)),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Text("Evano",style: GoogleFonts.poppins(fontWeight:FontWeight.bold,fontSize: 14),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 17.0),
                    child: Text("Project Manager",style: GoogleFonts.poppins(fontSize: 10,color: Color(0xff757575)),),
                  ),
                ],
              )
            ],
          )
        )
      ],
    );
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case 0:
            return Scaffold();
          case 1:
            return  LoginPage();
            case 2:
            return  Scaffold();
            case 3:
            return  Scaffold();
        case 4:
        return  Scaffold();
        case 5:
        return  Scaffold();
        case 6:
        return  Secondpage(); //accountspage
        case 7:
        return  Scaffold();
          default:
            return Text(
              "",
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}

Object _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return  LoginPage();
    case 2:
      return 'People';
    case 3:
      return 'Favorites';
    case 4:
      return 'Custom iconWidget';
    case 5:
      return 'Profile';
    case 6:
      return 'Settings';
    default:
      return 'Not found page';
  }
}

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFFF5F5F5);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Color(0xff9197B3);
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);