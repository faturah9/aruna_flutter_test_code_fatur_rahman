import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../blocs/news_bloc/news_cubit.dart';
import '../../datas/models/result_model.dart';
import '../../injection_container.dart';
import '../../routes/app_pages.dart';
import '../../widgets/shimmer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  initState() {
    super.initState();
    sl<NewsCubit>().getNews(
      search: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Aruna Code Test Fatur',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // title(),
          search(),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Divider(
              color: Color(0xFFF7F8FA),
              thickness: 8,
            ),
          ),
          // dropdown(),
          Expanded(child: listNews()),
        ],
      ),
    );
  }

  Widget listNews() {
    return BlocBuilder<NewsCubit, NewsState>(
      buildWhen: (previous, current) => previous.newsList != current.newsList,
      builder: (context, state) {
        if (state.newsList!.status == Status.LOADING &&
            state.newsList!.data == null) {
          return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.only(
                left: 16, right: 16, top: 8, bottom: 16.0),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
            itemBuilder: (context, index) {
              return _buildNewsShimmer(context);
            },
          );
        }
        if (state.newsList?.data == null) {
          return noData();
        } else if (state.newsList!.data!.isEmpty) {
          return noData();
        } else {
          return SmartRefresher(
            controller: refreshController,
            enablePullDown: true,
            enablePullUp: true,
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = const Text("pull up load",
                      style: TextStyle(fontSize: 12));
                } else if (mode == LoadStatus.loading) {
                  body = const CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = const Text("Load Failed!Click retry!",
                      style: TextStyle(fontSize: 12));
                } else if (mode == LoadStatus.canLoading) {
                  body = const Text("release to load more",
                      style: TextStyle(fontSize: 12));
                } else {
                  body = const Text("No more Data",
                      style: TextStyle(fontSize: 12));
                }
                return SizedBox(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            onLoading: () async {
              // await Future.delayed(const Duration(milliseconds: 1000));
              // Injector.resolve<KeanggotaanCubit>().getListAnggota(
              //   loadmore: true,
              // );
              refreshController.loadComplete();
            },
            onRefresh: () async {
              // await Future.delayed(const Duration(milliseconds: 1000));
              // Injector.resolve<KeanggotaanCubit>().getListAnggota();
              refreshController.refreshCompleted();
            },
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: state.newsList?.data?.length ?? 0,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemBuilder: (context, index) {
                final data = state.newsList?.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.newsDETAILPAGE,
                      arguments: {
                        'detail': state.newsList?.data![index],
                      },
                    ).then((value) {
                      if (value != null) {
                        sl<NewsCubit>().init();
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        data!.title ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildNewsShimmer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ShimmerWidget.rectangle(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.1),
    );
  }

  Widget noData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'res/graphics/List.svg',
          width: 80,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Tidak ada data',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        )
      ],
    );
  }

  Widget search() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: TextFormField(
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintText: 'Cari Berita',
            contentPadding: const EdgeInsets.fromLTRB(
              20,
              10,
              0,
              10,
            ),
            hintStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                30,
              ),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                30,
              ),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            fillColor: const Color(0xFFF7F8FA),
            filled: true,
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          onChanged: (value) {
            sl<NewsCubit>().getNews(
              search: value,
            );
          },
        ),
      ),
    );
  }
}
