enum TaskFilterEnum {
  today,
  tomorrow,
  week,
}

extension TaskFirlterDescription on TaskFilterEnum {
  String get description {
    switch (this) {
      case TaskFilterEnum.today:
        return "DE HOJE";
      case TaskFilterEnum.tomorrow:
        return "DE AMANHÂ";
      case TaskFilterEnum.week:
        return "DA SEMANA";
    }
  }
}
