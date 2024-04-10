import 'migrations/migration.dart';
import 'migrations/migration_v1.dart';

class SqliteMigrationFactpry {
  List<Migration> getCreateMigration() => [
        MigrationV1(),
      ];
  List<Migration> getUpgradeMigration() => [];
}
