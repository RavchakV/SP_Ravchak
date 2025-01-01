#include <windows.h>
#include <sstream>
#include <string>

std::string GetKeyboardLayoutName() {
    // Отримуємо ідентифікатор поточної розкладки клавіатури
    HKL layout = GetKeyboardLayout(0); // 0 означає поточний потік (поточне вікно)

    // Отримуємо мовний код (низьке слово) і код розкладки (високе слово)
    LANGID langId = LOWORD(layout);   // Отримуємо мовний ідентифікатор
    DWORD layoutId = HIWORD(layout);  // Отримуємо ідентифікатор розкладки

    // Отримуємо назву мови за допомогою функції GetLocaleInfo
    char language[LOCALE_NAME_MAX_LENGTH];
    GetLocaleInfoA(MAKELCID(langId, SORT_DEFAULT), LOCALE_SLANGUAGE, language, LOCALE_NAME_MAX_LENGTH);

    // Формуємо текст результату
    std::stringstream ss;
    ss << "Поточна мова: " << language << "\n";
    ss << "Код розкладки клавіатури: " << std::hex << layoutId;

    return ss.str();
}

int main() {
    std::string layoutInfo = GetKeyboardLayoutName();

    // Виводимо результат через MessageBox
    MessageBoxA(NULL, layoutInfo.c_str(), "Поточна розкладка клавіатури", MB_OK | MB_ICONINFORMATION);

    return 0;
}
