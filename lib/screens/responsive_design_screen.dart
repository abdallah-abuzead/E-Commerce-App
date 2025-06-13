import 'package:ecommerce_admin_panel/app_container.dart';
import 'package:ecommerce_admin_panel/widgets/site_layout.dart';
import 'package:flutter/material.dart';

class ResponsiveDesignScreen extends StatelessWidget {
  const ResponsiveDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
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
    return Column(
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
            SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  AppContainer(
                    height: 150,
                    color: Colors.orange.withValues(alpha: 0.2),
                    child: const Center(child: Text('BOX 2')),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: AppContainer(
                          height: 150,
                          color: Colors.red.withValues(alpha: 0.2),
                          child: const Center(child: Text('BOX 3')),
                        ),
                      ),
                      SizedBox(width: 20),
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
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: AppContainer(
                height: 150,
                color: Colors.red.withValues(alpha: 0.2),
                child: const Center(child: Text('BOX 5')),
              ),
            ),
            SizedBox(width: 20),
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
    );
  }
}

class _Tablet extends StatelessWidget {
  const _Tablet();

  @override
  Widget build(BuildContext context) {
    return Column(
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
            SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  AppContainer(
                    height: 150,
                    color: Colors.orange.withValues(alpha: 0.2),
                    child: const Center(child: Text('BOX 2')),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: AppContainer(
                          height: 150,
                          color: Colors.red.withValues(alpha: 0.2),
                          child: const Center(child: Text('BOX 3')),
                        ),
                      ),
                      SizedBox(width: 20),
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
        SizedBox(height: 20),
        AppContainer(
          height: 150,
          color: Colors.red.withValues(alpha: 0.2),
          child: const Center(child: Text('BOX 5')),
        ),
        SizedBox(height: 20),
        AppContainer(
          height: 150,
          color: Colors.red.withValues(alpha: 0.2),
          child: const Center(child: Text('BOX 6')),
        ),
      ],
    );
  }
}

class _Mobile extends StatelessWidget {
  const _Mobile();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AppContainer(
          height: 320,
          color: Colors.blue.withValues(alpha: 0.2),
          child: const Center(child: Text('BOX 1')),
        ),
        SizedBox(height: 20),
        AppContainer(
          height: 150,
          color: Colors.orange.withValues(alpha: 0.2),
          child: const Center(child: Text('BOX 2')),
        ),
        SizedBox(height: 20),
        AppContainer(
          height: 150,
          color: Colors.red.withValues(alpha: 0.2),
          child: const Center(child: Text('BOX 3')),
        ),
        SizedBox(height: 20),
        AppContainer(
          height: 150,
          color: Colors.green.withValues(alpha: 0.2),
          child: const Center(child: Text('BOX 4')),
        ),
        SizedBox(height: 20),
        AppContainer(
          height: 150,
          color: Colors.red.withValues(alpha: 0.2),
          child: const Center(child: Text('BOX 5')),
        ),
        SizedBox(height: 20),
        AppContainer(
          height: 150,
          color: Colors.red.withValues(alpha: 0.2),
          child: const Center(child: Text('BOX 6')),
        ),
      ],
    );
  }
}
