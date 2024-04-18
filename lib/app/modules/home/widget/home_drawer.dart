import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';

import '../../../core/auth/auth_provider.dart';
import '../../../core/ui/messages.dart';
import '../../../core/ui/theme_extensions.dart';
import '../../../services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');
  HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              children: [
                Selector<AuthProviderq, String>(
                  selector: (context, authProvider) {
                    return authProvider.user?.photoURL ??
                        "https://miro.medium.com/v2/resize:fit:1400/1*g09N-jl7JtVjVZGcd-vL2g.jpeg";
                  },
                  builder: (_, value, __) => CircleAvatar(
                    backgroundImage: NetworkImage(value),
                    radius: 30,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<AuthProviderq, String>(
                      selector: (context, authProvider) {
                        return authProvider.user?.displayName ??
                            "Nome nao informado";
                      },
                      builder: (_, value, __) => Text(
                        value,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            title: const Text("Alterar Nome"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Alterar nome"),
                  content: TextField(
                    onChanged: (value) => nameVN.value = value,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "Concelar",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (nameVN.value.isEmpty) {
                          Messages.of(context).showError("Nome obrigatorio");
                        } else {
                          Loader.show(context);
                          context
                              .read<UserService>()
                              .updateDisplayName(nameVN.value);
                          Loader.hide();
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("Alterar"),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Sair"),
            onTap: () => context.read<AuthProviderq>().logout(),
          ),
        ],
      ),
    );
  }
}
