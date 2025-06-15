import 'package:ecommerce_admin_panel/common/widgets/containers/app_container.dart';
import 'package:ecommerce_admin_panel/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';

import 'common/widgets/layouts/templates/site_layout_template.dart';

class ResponsiveDesignScreen extends StatelessWidget {
  const ResponsiveDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteLayoutTemplate(
      desktop: _DeskTop(),
      tablet: _Tablet(),
      mobile: _Mobile(),
    );
  }
}

class _DeskTop extends StatelessWidget {
  const _DeskTop();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.lg),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AppContainer(
                  height: 320,
                  color: Colors.blue.withValues(alpha: 0.2),
                  child: const Center(child: Text('BOX 1')),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    AppContainer(
                      height: 150,
                      color: Colors.orange.withValues(alpha: 0.2),
                      child: const Center(child: Text('BOX 2')),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: AppContainer(
                            height: 150,
                            color: Colors.red.withValues(alpha: 0.2),
                            child: const Center(child: Text('BOX 3')),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: AppContainer(
                            height: 150,
                            color: Colors.green.withValues(alpha: 0.2),
                            child: const Center(child: Text('BOX 4')),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: AppContainer(
                  height: 150,
                  color: Colors.red.withValues(alpha: 0.2),
                  child: const Center(child: Text('BOX 5')),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: AppContainer(
                  height: 150,
                  color: Colors.red.withValues(alpha: 0.2),
                  child: const Center(child: Text('BOX 6')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tablet extends StatelessWidget {
  const _Tablet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.lg),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AppContainer(
                  height: 320,
                  color: Colors.blue.withValues(alpha: 0.2),
                  child: const Center(child: Text('BOX 1')),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    AppContainer(
                      height: 150,
                      color: Colors.orange.withValues(alpha: 0.2),
                      child: const Center(child: Text('BOX 2')),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: AppContainer(
                            height: 150,
                            color: Colors.red.withValues(alpha: 0.2),
                            child: const Center(child: Text('BOX 3')),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: AppContainer(
                            height: 150,
                            color: Colors.green.withValues(alpha: 0.2),
                            child: const Center(child: Text('BOX 4')),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          AppContainer(
            height: 150,
            color: Colors.red.withValues(alpha: 0.2),
            child: const Center(child: Text('BOX 5')),
          ),
          const SizedBox(height: 20),
          AppContainer(
            height: 150,
            color: Colors.red.withValues(alpha: 0.2),
            child: const Center(child: Text('BOX 6')),
          ),
        ],
      ),
    );
  }
}

class _Mobile extends StatelessWidget {
  const _Mobile();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSizes.lg),
      children: [
        AppContainer(
          height: 320,
          color: Colors.blue.withValues(alpha: 0.2),
          child: const Center(child: Text('BOX 1')),
        ),
        const SizedBox(height: 20),
        AppContainer(
          height: 150,
          color: Colors.orange.withValues(alpha: 0.2),
          child: const Center(child: Text('BOX 2')),
        ),
        const SizedBox(height: 20),
        AppContainer(
          height: 150,
          color: Colors.red.withValues(alpha: 0.2),
          child: const Center(child: Text('BOX 3')),
        ),
        const SizedBox(height: 20),
        AppContainer(
          height: 150,
          color: Colors.green.withValues(alpha: 0.2),
          child: const Center(child: Text('BOX 4')),
        ),
        const SizedBox(height: 20),
        AppContainer(
          height: 150,
          color: Colors.red.withValues(alpha: 0.2),
          child: const Center(child: Text('BOX 5')),
        ),
        const SizedBox(height: 20),
        AppContainer(
          height: 150,
          color: Colors.red.withValues(alpha: 0.2),
          child: const Center(child: Text('BOX 6')),
        ),
      ],
    );
  }
}
