import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../bloc/sdui_bloc.dart';
import '../widgets/component_renderer.dart';

/// Screen that renders server-driven UI
class SduiScreen extends StatelessWidget {
  final String screenId;

  const SduiScreen({
    super.key,
    required this.screenId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SduiBloc>()..add(LoadScreenConfig(screenId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SDUI Screen'),
          actions: [
            BlocBuilder<SduiBloc, SduiState>(
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    context.read<SduiBloc>().add(const RefreshScreen());
                  },
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<SduiBloc, SduiState>(
          builder: (context, state) {
            if (state is SduiLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SduiLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.screenConfig.title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    ...state.screenConfig.components.map(
                      (component) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ComponentRenderer(config: component),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is SduiError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${state.message}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<SduiBloc>().add(const RefreshScreen());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: Text('Ready to load screen'),
            );
          },
        ),
      ),
    );
  }
}
