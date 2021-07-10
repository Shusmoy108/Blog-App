import 'package:blogapp/src/services/appexception.dart';
import 'package:blogapp/src/views/components/dialogue/dialoguehelper.dart';

class ErrorController {
  void handleError(error) {
    hideLoading();
    if (error is BadRequestException) {
      var message = error.message;
      DialogueHelper.showDialogue(message: message);
    } else if (error is FetchDataException) {
      var message = error.message;
      DialogueHelper.showDialogue(message: message);
    } else if (error is ApiNotRespondingException) {
      var message = error.message;
      DialogueHelper.showDialogue(message: message);
    }
  }

  void showLoading() {
    DialogueHelper.showLoading();
  }

  void hideLoading() {
    DialogueHelper.hideLoading();
  }
}
