import 'package:flutter/material.dart';
import 'package:gradient_like_css/gradient_like_css.dart';
import 'package:project_temperature/src/models/data_model.dart';
import 'package:project_temperature/src/pages/home_page/controller/home_controller.dart';
import 'package:project_temperature/src/repositories/data_repository_imp.dart';
import 'package:project_temperature/src/widgets/indicator_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DateTime date = DateTime.now();
  final HomeController _controller = HomeController(DataRepositoryImp());

  @override
  Widget build(BuildContext context) {
    String newDay = _controller.dayWeek(date.weekday);
    String newMonth = _controller.monther(date.month);
    return GestureDetector(
      onTap: () {
        setState(() {
          FocusScope.of(context).unfocus;
          if (!_controller.isEnable) {
            _controller.isEnable = !_controller.isEnable;
            _controller.textEditingController.text = '';
          }
        });
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: _controller.isEnable
              ? Text(
                  _controller.city.isEmpty
                      ? ''
                      : _controller.city[0].toUpperCase() +
                          _controller.city.substring(1),
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Poppins-regular',
                      fontWeight: FontWeight.bold),
                )
              : TextField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  autofocus: true,
                  controller: _controller.textEditingController,
                  textInputAction: TextInputAction.search,
                  onEditingComplete: () {
                    setState(() {
                      _controller.city = _controller.textEditingController.text;
                      _controller.isEnable = !_controller.isEnable;
                      _controller.textEditingController.text = '';
                    });
                  },
                ),
          leading: _controller.isEnable
              ? IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _controller.isEnable = !_controller.isEnable;
                    });
                  },
                )
              : Container(),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            !_controller.isEnable
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _controller.city =
                            _controller.textEditingController.value.text;
                        _controller.isEnable = !_controller.isEnable;
                        _controller.textEditingController.text = '';
                      });
                    },
                    icon: const Icon(Icons.search),
                  )
                : Container()
          ],
        ),
        body: Container(
          height: double.maxFinite,
          decoration: BoxDecoration(
              gradient: linearGradient(180, ['#62B8F6', '#2C79C1'])),
          child: FutureBuilder<DataModel>(
            future: _controller.getData(_controller.city),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 60),
                        child: Image.asset(
                          _controller.getIcon(snapshot.data!.weather[0].main),
                          height: MediaQuery.of(context).size.height * 0.39,
                          width: MediaQuery.of(context).size.width * 0.9,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$newDay  |  $newMonth ${date.day}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins-light',
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 30),
                        child: Text(
                          '${snapshot.data!.main.temp.toStringAsFixed(0)}°',
                          style: const TextStyle(
                              fontSize: 64,
                              color: Colors.white,
                              fontFamily: 'Poppins-regular',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        snapshot.data!.weather[0].description[0].toUpperCase() +
                            snapshot.data!.weather[0].description.substring(1),
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'Poppins-light',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      const Divider(
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                          color: Colors.white),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IndicatorWidget(
                            leading: Image.asset('assets/images/arrow.png'),
                            title:
                                '${snapshot.data!.wind.speed.toStringAsFixed(0)} km/h',
                            subtitle: 'Wind',
                          ),
                          IndicatorWidget(
                            leading: Image.asset('assets/images/cloud.png'),
                            title:
                                '${snapshot.data!.wind.speed.toStringAsFixed(0)} %',
                            subtitle: 'Chance of rain',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IndicatorWidget(
                            leading:
                                Image.asset('assets/images/thermometer.png'),
                            title: '${snapshot.data!.main.pressure} mbar',
                            subtitle: 'Pressure',
                            paddingLeft:
                                MediaQuery.of(context).size.width * 0.02,
                          ),
                          IndicatorWidget(
                            paddingRight:
                                MediaQuery.of(context).size.width * 0.10,
                            leading: Image.asset('assets/images/drop.png'),
                            title: '${snapshot.data!.main.humidity} %',
                            subtitle: 'Humidity',
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Poppins-light',
                        fontWeight: FontWeight.bold),
                  ),
                );
              }
              return const Center(
                  child: CircularProgressIndicator(color: Colors.white));
            },
          ),
        ),
      ),
    );
  }
}
