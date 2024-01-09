class EmailRegistrationFailure {
  final String message;

  const EmailRegistrationFailure(
      [this.message = "Un error desconocido ha ocurrido"]);

  factory EmailRegistrationFailure.code(String code) {
    switch (code) {
      case "weak-password":
        return const EmailRegistrationFailure(
            "Entra una contraseña más segura");
      case "invalid-email":
        return const EmailRegistrationFailure(
            "Usa diferentes carácteres por favor");
      case "email-already-in-use":
        return const EmailRegistrationFailure(
            "Este correo ya está registrado. Inicia sesión");
      case "operation-not-allowed":
        return const EmailRegistrationFailure("Operación no permitida");
      case "user-disabled":
        return const EmailRegistrationFailure(
            "Este usuario ha sido desactivado. Contacta a soporte");
      default:
        return const EmailRegistrationFailure();
    }
  }
}
