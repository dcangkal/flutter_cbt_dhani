import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt_dhani/core/extensions/build_context_ext.dart';
import 'package:flutter_cbt_dhani/presentation/home/bloc/content/content_bloc.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/custom_scaffold.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  void initState() {
    context.read<ContentBloc>().add(const ContentEvent.getContentById('5'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: const Text('Help'),
      body: BlocBuilder<ContentBloc, ContentState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return const Center(
              child: Text('Error'),
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }, success: (content) {
            return ListView(
              children: [
                content.data[0].image.isEmpty
                    ? Assets.images.menu.aboutUs.image()
                    : CachedNetworkImage(
                        imageUrl: content.data[0].image,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        width: context.deviceWidth,
                        height: 470,
                        fit: BoxFit.cover,
                      ),
                // Assets.images.menu.aboutUs.image(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    content.data[0].content,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            );
          });
        },
      ),
    );
  }
}
