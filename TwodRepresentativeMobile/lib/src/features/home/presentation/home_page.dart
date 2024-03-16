import 'package:flutter/material.dart';

import 'package:auto_route/annotations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:twod_representative/src/features/home/presentation/home_page_controller.dart';
import 'package:twod_representative/src/shared/constants/app_sizes.dart';
import 'package:twod_representative/src/shared/extensions/dart_extensions.dart';
import 'package:twod_representative/src/shared/utils/formatter.dart';
import 'package:twod_representative/src/shared/utils/twod_utils.dart';
import 'package:twod_representative/src/shared/widgets/async_value_ui.dart';

@RoutePage()
class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      initialTwodLiveRequestProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    ref.listen(
      twodLiveProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final twodLiveState = ref.watch(twodLiveProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Twod (2D)'),
      ),
      body: switch (twodLiveState) {
        AsyncData(:final value) when value != null => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.p20,
              vertical: Sizes.p20,
            ),
            child: Column(
              children: [
                // live
                Container(
                  height: MediaQuery.sizeOf(context).height / 3,
                  width: MediaQuery.sizeOf(context).width,
                  padding: const EdgeInsets.symmetric(vertical: Sizes.p32),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade100,
                    border: Border.all(width: 1, color: Colors.purple),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(defaultCornerRadius),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        value.live.date,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Expanded(
                        child: Text(
                          getLatestTwodResultIfEmpty(
                            value.live.twod,
                            value.others,
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.sizeOf(context).width / 3),
                        ),
                      ),
                      Text(
                        'Updated at ${value.serverTime}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontSize: Sizes.p12,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Sizes.p20),
                // others
                Expanded(
                  child: ListView.builder(
                    itemCount: value.others.length,
                    itemBuilder: (context, index) {
                      final other = value.others[index];

                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            other.twod,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  fontSize: Sizes.p16,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        title: Text(
                          dateStringFromDate(other.stockDateTime.toDateTime()),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('SET: ${other.set}'),
                            const SizedBox(width: Sizes.p8),
                            Text('VALUE: ${other.value}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        AsyncLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
        _ => const SizedBox(),
      },
    );
  }
}
