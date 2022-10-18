# System mobilnej książeczki zdrowia zwierzęcia
Aplikacja została wykonana jako praca inżynierska na Polsko-Japońskiej Apademii Technik Komputerowych.
<br><br>
<p align="center">
	<img src="http://mgorzkowski.pl/wp-content/uploads/2022/10/Logo_PJATK-e1666095057768.png" alt="PJAIT logo" width="700">
</p>
<p align="center">
	Wydział Informatyki<br>
  Katedra Metod Programowania<br>
  Programowanie Aplikacji Biznesowych
</p>
<p align="center">
  <b>Michał Gorzkowski</b><br>
  Nr albumu s22006
</p>
<p align="center">
	Promotor: dr Krzysztof Barteczko<br>
</p>
<p align="center">
	Warszawa, lipiec 2022
</p>

## Streszczenie
Celem pracy inżynierskiej było stworzenie systemu mobilnego pozwalającego na przechowywanie informacji zdrowotnych dotyczących zwierząt domowych. System przeznaczony jest na telefony z systemem iOS i napisany został w języku Swift wykorzystując framework SwiftUI. Opera się o wzorzec projektowy MVVM oraz zewnętrzny serwis Firebase pozwalający na chmurowe gromadzenie informacji o użytkownikach i ich danych w czasie rzeczywistym. Założeniem systemu było umożliwienie właścicielom zwierząt przechowywania informacji na temat ich zwierząt w łatwy i szybko dostępny sposób.

## Spis treści
- <a href="https://github.com/MichalGorzkowski/petvet/blob/main/DOCUMENTATION-PL.md#główny-widok-aplikacji">Główny widok aplikacji</a>
- <a href="https://github.com/MichalGorzkowski/petvet/blob/main/DOCUMENTATION-PL.md#nadzorowanie-sesji-użytkownika">Sesje użytkownika</a>
- <a href="https://github.com/MichalGorzkowski/petvet/blob/main/DOCUMENTATION-PL.md#zarządzanie-przesyłaniem-zdjęcia-profilowego">Zdjęcie profilowe</a>
- <a href="https://github.com/MichalGorzkowski/petvet/blob/main/DOCUMENTATION-PL.md#zarządzanie-zwierzętami">Zwierzęta</a>
- <a href="https://github.com/MichalGorzkowski/petvet/blob/main/DOCUMENTATION-PL.md#zarządzanie-zakładkami">Zakładki aplikacji</a>
- <a href="https://github.com/MichalGorzkowski/petvet/blob/main/DOCUMENTATION-PL.md#zarządzanie-informacjami-zwierzęcia">Informacje o zwierzęciu</a>
- <a href="https://github.com/MichalGorzkowski/petvet/blob/main/DOCUMENTATION-PL.md#zarządzanie-szczepieniami">Szczepienia</a>
- <a href="https://github.com/MichalGorzkowski/petvet/blob/main/DOCUMENTATION-PL.md#zarządzanie-medykamentami">Medykamenty</a>
- <a href="https://github.com/MichalGorzkowski/petvet/blob/main/DOCUMENTATION-PL.md#zarządzanie-wizytami-i-zabiegami">Wizyty i zabiegi</a>
- <a href="https://github.com/MichalGorzkowski/petvet/blob/main/DOCUMENTATION-PL.md#zarządzanie-lecznicami">Mapa lecznic</a>
- <a href="https://github.com/MichalGorzkowski/petvet/blob/main/DOCUMENTATION-PL.md#zarządzanie-panelem-bocznym">Panel boczny</a>

## Implementacja
Opisywany w tej pracy System Mobilnej Książeczki Zdrowia Dla Zwierząt opiera się o wzorzec projektowy MVVM (Model-View-ViewModel). W tym dokumencie opisane zostały implementacje kluczowych części systemu wraz z ich kodami źródłowymi.

### Główny widok aplikacji
#### ContentView
Główną strukturą widoku aplikacji jest `ContentView`. Wykorzystując `AuthViewModel` sprawdza czy użytkownik jest zalogowany. Jeśli tak, pokazany zostaje widok `MainTabView`, który opisany jest w jednej z kolejnych sekcji. Jeśli użytkownik nie jest zalogowany, wyświetlony zostaje ekran logowania `LoginView`.

``` swift
Group {
  if viewModel.userSession == nil {
    LoginView()
  } else {
    MainTabView()
  }
}
```

### Nadzorowanie sesji użytkownika
#### LoginView, RegisterView, ForgotPasswordView
Nadzorowanie sesji użytkownika odbywa się z wykorzystaniem struktury widoków `LoginView`, `RegistrationView` oraz `ForgotPasswordView`. Każdy z tych widoków zawiera elementy UI odpowiadające za kształty, napisy, pola tekstowe i guziki. Poniżej pokazana została implementacja nagłówka oraz pól tekstowych najbardziej rozbudowanej struktury z powyższych – `RegistrationView`.

``` swift
TwoLineHeaderView(titleFirst: "Rozpocznij.", titleSecond: "Utwórz konto")
VStack(spacing: 40) { 
  CustomInputField(imageName: "envelope",
                   placeholderText: "Email",
                   prompt: viewModel.emailPrompt,
                   text: $viewModel.email)
  CustomInputField(imageName: "person",
                   placeholderText: "Login",
                   prompt: "",
                   text: $viewModel.username)
  CustomInputField(imageName: "person",
                   placeholderText: "Imię i nazwisko",
                   prompt: "",
                   text: $viewModel.fullname)
  CustomInputField(imageName: "lock",
                   placeholderText: "Hasło",
                   prompt: viewModel.passwordPrompt,
                   text: $viewModel.password,
                   isSecureField: true)
}
.padding(.horizontal, 32)
.padding(.top, 44)
```

Przycisk rejestracji jest nadzorowany przez klasę `SignUpViewModel`. Posiada on atrybut opacity, który pozwala na wyszarzenie przycisku, jeśli formularz nie został poprawnie uzupełniony. Atrybut disabled natomiast pozwala na całkowite wyłączenie przycisku z tego samego powodu, co razem daje użytkownikowi informację, że coś jest błędnie wypełnione. Sam guzik natomiast po wciśnięciu wykonuję akcję, którą w tym przypadku jest wywołanie metody `register()` w klasie `AuthViewModel`, której poświęcony zostanie jeden z kolejnych akapitów. Poniższy kod przedstawia przycisk z nadanymi stylami oraz wywołaniem omawianej funkcji.

``` swift
Button {
  authViewModel.register(withEmail: viewModel.email,
                         password: viewModel.password,
                         fullname: viewModel.fullname,
                         username: viewModel.username)
  //viewModel.cleanAfterSignUp() // clears the fields
} label: {
  Text("Zarejestruj się")
    .font(.headline)
    .foregroundColor(.white)
    .frame(width: 340, height: 50)
    .background(Color(.systemBlue))
    .clipShape(Capsule())
    .padding()
}
.opacity(viewModel.isSignUpComplete ? 1 : 0.6)
.disabled(!viewModel.isSignUpComplete)
.shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
```

Aby powyższe funkcje działały, potrzebne są odwołania do pozostałych plików, w których przechowywane są klasy odpowiedzialne za połączenie z bazą danych. Poniższy kod prezentuje sposób połączenia pliku `RegistrationView` z klasami `AuthViewModel` oraz `SignUpViewModel`.

``` swift
@EnvironmentObject var authViewModel: AuthViewModel
@ObservedObject var viewModel = SignUpViewModel()
```

#### SignUpViewModel
Zawartość wszystkich zmiennych struktury `RegistrationView` przechowywana jest w klasie `SignUpViewModel`. Poniższy kod ukazuje nazwy zmiennych oraz jedną z metod walidacji z wykorzystaniem wyrażenia regularnego.

``` swift
@Published var email = ""
@Published var username = ""
@Published var fullname = ""
@Published var password = ""

func isEmailValid() -> Bool {
  let emailTest = NSPredicate(format: "SELF MATCHES %@", "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0- 9]{1,3})(\\]?)$")
  return emailTest.evaluate(with: email)
}
```

Zmienne oznaczone jako `Published` pozwalają na aktualizację podłączonego widoku, gdy tylko zmieni się zawartość zmiennej. Pozwala to na aktualizowanie pola tekstowego w pliku `RegistrationView`.

#### AuthViewModel
Nadzorowanie sesji użytkownika odbywa się z wykorzystaniem serwisu Firebase, a dokładnie modułu Authentication. W tym celu została utworzona klasa `AuthViewModel`, odpowiedzialna za komunikację z serwisem Firebase. Odpowiednie metody służą do zalogowania, rejestracji, wylogowania, wgrania zdjęcia profilowego oraz wysłania wiadomości email z linkiem do zresetowania hasła. Poniższe kody przedstawiają wybrane z powyższych metod.

##### Logowanie
``` swift
func login(withEmail email: String, password: String) {
  Auth.auth().signIn(withEmail: email, password: password) { result, error in
    if let error = error { self.isLoginPasswordWrong = true return
  }
  guard let user = result?.user else { return } self.userSession = user
  self.fetchUser()
  }
}
```

##### Rejestracja
``` swift
func register(withEmail email: String,
              password: String,
              fullname: String,
              username: String) {
  Auth.auth().createUser(withEmail: email, password: password) { result, error in
    if let error = error { return }
    guard let user = result?.user else { return } self.tempUserSession = user
    let data = ["email": email,
                "username": username.lowercased(),
                "fullname": fullname,
                "uid": user.uid]
    Firestore.firestore().collection("users")
      .document(user.uid)
      .setData(data) { _ in
        self.didAuthenticateUser = true
      }
  }
}
```

##### Przypomnienie hasła
``` swift
func sendPasswordReset(withEmail email: String) {
  Auth.auth().sendPasswordReset(withEmail: email) { error in
    if let error = error { return
  }
}
```

Metoda `register()` odwołuje się do kolekcji `users`, w której zapisywane są dane użytkowników przekazane przez nich podczas rejestracji. Zachowane są przy tym kwestie bezpieczeństwa, ponieważ administrator nie ma podglądu na hasła użytkowników, a te podczas rejestracji są hashowane przez platformę Firebase.

### Zarządzanie przesyłaniem zdjęcia profilowego
#### ImageUploader

Przesyłanie zdjęcia profilowego do bazy danych odbywa się za pomocą oddzielnej struktury `ImageUploader`. Posiada ona metodę `uploadImage()`, która zamienia zdjęcie profilowe na format `JPEG` dokonująć kompresji. W strukturze jest zapisana ścieżka do której na końcu dopisywany zostaje nazwa pliku. Na tak przygotowanej ścieżje zostaje wywołana metoda `putData()` w celu przesłania pliku do bazy. Następnie włącza się metoda `downloadURL()` zwracająca adres `URL`, jaki został nadany przesłanemu zdjęciu. Poniższy kod przedstawia sposób implementacji struktury `ImageUploader`.

``` swift
struct ImageUploader {
  static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
    guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
    let filename = NSUUID().uuidString
    let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
    ref.putData(imageData, metadata: nil) { _, error in if let error = error { return }
    ref.downloadURL { imageUrl, _ in
      guard let imageUrl = imageUrl?.absoluteString else { return }
      completion(imageUrl) }
    }
  }
}
```
### Zarządzanie zwierzętami
#### ChangePetListView

Panel widoku zapisanych zwierząt zapisany jest w strukturze `ChangePetListView`. Widok posiada standardowe elementy UI, takiej jak nagłówek i guziki. Częścią główną widoku jest lista zwierząt zapisanych w systemie przez użytkownika. Składa się ona z wierszy zaimplementowanych w strukturze `ChangePetRowView`.<br><br>Elementem kluczowym dla szybkiego działania aplikacji mobilnej jest zaimplementowany w widoku `ScrollView` pozwalający na przewijanie elementów wewnątrz oraz zagnieżdżony w nim `LazyVStack`, który ładuje następne elementy, tuż przed momentem pojawienia się ich na ekranie, przez co urządzenie mobilne nie marnuje miejsca i mocy obliczeniowej na ładowanie pełnej listy od razu. Poniższy kod pokazuje sposób w jaki zostało to zaimplementowane.

``` swift
ScrollView {
  LazyVStack {
    ForEach(viewModel.pets) { pet in
      ChangePetRowView(pet: pet)
        .padding() Divider()
    }
  }
}
```

#### ChangePetViewModel

Widok `ChangePetListView` posiada swój `ViewModel`, w którym przechowywana jest lista wszystkich zwierząt dodanych do systemu. Ważną częścią `ChangePetViewModel` jest metoda `fetchUserPets()` odpowiedzialna za sprawdzenie, czy w bazie nie pojawiło się nowe zwierzę przypisane do id zalogowanego użytkownika. Poniższy kod przedstawią tą metodę.

``` swift
func fetchUserPets() {
  guard let uid = Auth.auth().currentUser?.uid else { return } 
  service.fetchPets(forUid: uid) { pets in
    self.pets = pets
  }
}
```

#### PetService

`ChangePetViewModel` odwołuje się do struktury typu `service`, która podobnie jak podczas nadzorowania sesji użytkownika odwołuje się do platformy Firebase. Strukturą tą jest `PetService`. Posiada ona metody takie jak:
- `uploadPet()` – odpowiedzialna za wgrywanie nowego zwierzęcia do bazy
- `fetchPets()` – odpowiedzialna za wyciąganie z bazy zwierząt między innymi w celu ich wyświetlenia na liście
- `setActive()` – odpowiedzialna za ustawienie aktywnego zwierzęcia
- `deletePet()` – odpowiedzialna za usuwanie zwierzęcia z bazy
- `getActivePetData()` – odpowiedzialna za wyciągnięcie z bazy zapisanych informacji o wybranym zwierzęciu

<p>Poniższy kod ukazuje implementację wybranych metody z powyższych.</p>

``` swift
func setActive(_ pet: Pet) {
  guard let uid = Auth.auth().currentUser?.uid else { return }
  guard let petId = pet.id else { return }
  
  Firestore.firestore().collection("users")
    .document(uid)
    .updateData(["currentPet": petId]) { _ in
      print("DEBUG: setActivePet func done")
    }
}

func getActivePetData(forPetId petId: String, completion: @escaping(Pet) -> Void) {
  Firestore.firestore().collection("pets")
    .document(petId)
    .getDocument { snapshot, _ in
      guard let snapshot = snapshot else { return }
      guard let pet = try? snapshot.data(as: Pet.self) else { return }
      completion(pet)
    }
}
```

#### NewPetView

Dodawanie nowego zwierzęcia odbywa się z wykorzystaniem struktury widoku `NewPetView`. Składa się on głównie z pól tekstowych oraz wyboru dat. Odwołują się one do klasy `UploadPetViewModel` w celu kontrolowania przepływu informacjami z pól tekstowych oraz wykonywania akcji. W klasie tej zastosowany został `DateFormatter` służący do przekonwertowania atrybutu typu `Date()` na ciąg znaków typu `String`. Poniższy kod pokazuje sposób jego implementacji.

``` swift
var dateFormatter: DateFormatter {
  let formatter = DateFormatter()
  formatter.dateStyle = .long
  formatter.locale = Locale(identifier: "pl-PL")
  return formatter
}
```

Atrybut `dateStyle` odpowiada za styl wyświetlania daty. W przypadku `.long` jest to numer dnia, pełna nazwa miesiąca oraz pełny rok. Atrybut `.locale` ustawia język wyjściowego ciągu znaków. W tym przypadku ustawiony został język polski (`pl-PL`).

### Zarządzanie zakładkami
#### MainTabView

Zakładki w aplikacji sterowane są za pomocą widoku `MainTabView`. Jedynym celem tego widoku jest zarządzanie zakładkami oraz monitorowanie, która jest aktualnie wyświetlana. Widok posiada tylko jedną zmienną `selectedIndex` przez co nie zastosowany został tutaj `ViewModel`. Jego zastosowanie wprowadziłoby niepotrzebną komplikację w kodzie. Za obsługę zakładek w aplikacji odpowiada element UI `TabView`. Za parament pobiera on indeks zakładki, którą należy pokazać. Jego zawartość stanowią instancje struktur pozostałych widoków. Po naciśnięciu każdego elementu w `TabView` zostaje wywołana funkcja `onTapGesture`. Zmienia ona wartość zmiennej `selectedIndex` na odpowiedni indeks. Identyfikacja elementów odbywa się z wykorzystaniem `tag()`, który również przypisany jest każdemu elementowi. Domyślnie ustawiona została środkowa zakładka z indeksem `2`.<br><br>
Dodatkowo każdy element posiada także `tabItem` pozwalający za ustalenie wyglądu zakładki. W przypadku niniejszego systemu zastosowane zostały ikony, tj. strzykawka dla zakładki szczepień czy tabletki dla zakładki medykamentów. Implementację `TabView` wykorzystanywanego w niniejszym projekcie przedstawia ponizszy kod.

``` swift
TabView(selection: $selectedIndex) { 
  VaccinationsListView()
    .onTapGesture { self.selectedIndex = 0 }
    .tabItem { Image(systemName: "eyedropper.halffull") }
    .tag(0)

  AntiParasitesListView()
    .onTapGesture { self.selectedIndex = 1 }
    .tabItem { Image(systemName: "pills") }
    .tag(1)

  DetailedInformationView()
    .onTapGesture { self.selectedIndex = 2 }
    .tabItem { Image(systemName: "house") }
    .tag(2)

  MedicalRecordsListView()
    .onTapGesture { self.selectedIndex = 3 }
    .tabItem { Image(systemName: "stethoscope") }
    .tag(3)

  ClinicsView()
    .onTapGesture { self.selectedIndex = 4 }
    .tabItem { Image(systemName: "map") }
    .tag(4)
}
```

### Zarządzanie informacjami zwierzęcia
#### DetailedInformationView, DetailedInformationViewModel

Zakładka z podstawowymi informacjami dotyczącymi aktywnego zwierzęcia jest główną zakładką apliakcji. Została ona zaimplementowana w strukturze `DetailedInformationView`. Za logikę odpowiada `DetailedInformationViewModel`. Widok informacji o aktywnym zwierzęciu składa się z kafelków na których wyświetlane są dane zwierzęcia. Przykład jednego elementu pokazuje poniższy kod.

```swift
VStack(spacing: 10) { 
  Text(viewModel.activePet!.breed)
    .font(.headline)
    .multilineTextAlignment(.center)
    .foregroundColor(Color(.darkGray))
  
  Image(systemName: "pawprint")
    .resizable()
    .scaledToFit()
    .frame(width: 50)
    .foregroundColor(Color(.systemBlue))
}
.frame(width: 130, height: 130)
```

`ViewModel` odpowiada tutaj za pobranie danych aktualnego zwierzęcia. Zostało to zaimplementowane poniżej.

``` swift
func getPetData() {
  authViewModel.fetchUser()
  guard let petId = authViewModel.currentUser?.currentPet else { return } 
  service.getActivePetData(forPetId: petId) { pet in
    self.activePet = pet
  }
}
```

### Zarządzanie szczepieniami
#### Vaccination, VaccinationView

Model szczepienia przechowywany jest w strukturze `Vaccination`. Widok zakładki ze szczepieniami składa się z dwóch elementów – widoku szczepienia przechowywanego w `VaccinationRowView` oraz widoku listy szczepień, który zaimplementowany został w pliku `VaccinationsListView`. Każdy z powyższych widoków zawiera swój `ViewModel`, są to odpowiedno `VaccinationRowViewModel` oraz `VaccinationsViewModel`. Pierwszy z nich odpowiada z kasowanie szczepienia. Służy do tego metoda `deleteVaccination()`. Odwołuje się ona do struktury typu `service`. Drugi `ViewModel` umożliwia pobranie danych o szczepieniach zwierzęcia, również wykorzystując strukturę typu `service`. Poniższy kod prezentuje sposób w jaki zostało utworzone powiązanie między `VaccinationsViewModel` a `VaccinationService`.

``` swift
private let service = VaccinationService()
private var currentUser: User?

func fetchUserVaccinations() {
  guard let uid = Auth.auth().currentUser?.uid else { return }
  fetchUser()
  guard let petId = currentUser?.currentPet else { return }
  if petId != nil {
    service.fetchVaccinations(forUid: uid, petId: petId) { vaccinations in
      self.vaccinations = vaccinations
    }
  }
}
```

### Zarządzanie medykamentami
#### AntiParasiteService

Widok listy medykamentów jest zbudowany w sposób analogiczny do widoku szczepień. Sposób implementacji pobierania danych z bazy z wykorzystaniem struktury `AntiParasiteService` został przedstawiony poniżej.

``` swift
func fetchAntiParasites(forUid uid: String,
                        petId: String,
                        completion: @escaping([AntiParasite]) -> Void) {
  Firestore.firestore().collection("anti_parasites")
    .whereField("petId", isEqualTo: petId)
    .getDocuments { snapshot, _ in
      guard let documents = snapshot?.documents else { return }
      let antiParasites = documents.compactMap({ try? $0.data(as: AntiParasite.self) })
      completion(antiParasites.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue() }))
    }
}

Komenda `Firestore.firestore()` z parametrem `collection` określa z której kolekcji danych w bazie danych mają zostać pobrane informacje. Dodatkowo, dane te są one mapowane do modelu, który przechowywany jest w strukturze `AntiParasite` aby ostatecznie mogły być posortowane według parametru określającego ich datę dodania do systemu w kolejności od ostatnio dodanych do tych, które zostały dodane dużo wcześniej.
```

### Zarządzanie wizytami i zabiegami
#### MedicalRecord, MedicalRecordService

Model wizyty/zabiegu przechowywany jest w strukturze `MedicalRecord`. Poniższy kod porezentuje implementację modelu.

``` swift
import FirebaseFirestoreSwift
import Firebase

struct MedicalRecord: Identifiable, Decodable {
  @DocumentID var id: String?
  
  let date: String
  let name: String
  let description: String
  let doctorsRecomendations: String
  
  let petId: String
  let timestamp: Timestamp
  let uid: String
  
  var user: User?
}
```

Struktura typu `service` odpowiedzialna za połączenie z bazą danych posiada wiele metod.

##### Dodanie rekordu do bazy
``` swift
func uploadMedicalRecord(date: String,
                         name: String,
                         description: String,
                         doctorsRecomendations: String,
                         petId: String,
                         completion: @escaping(Bool) -> Void) {
  guard let uid = Auth.auth().currentUser?.uid else { return }
  let data = ["uid": uid, 
              "date": date,
              "name": name,
              "description": description,
              "doctorsRecomendations": doctorsRecomendations,
              "petId": petId,
              "timestamp": Timestamp(date: Date())] as [String : Any]

  Firestore.firestore().collection("medical_records").document() .setData(data) { error in
    if let error = error {
      completion(false)
      return
    }
    completion(true) }
}
```

##### Ściągnięcie wszystkich rekordów z bazy
``` swift
func fetchMedicalRecords(completion: @escaping([MedicalRecord]) -> Void) {
  Firestore.firestore().collection("medical_records")
    .order(by: "timestamp", descending: true)
    .getDocuments { snapshot, _ in
      guard let documents = snapshot?.documents else { return }
      let medicalRecords = documents.compactMap({ try? $0.data(as: MedicalRecord.self) })
      completion(medicalRecords)
    }
}
```

##### Ściągnięcie rekordów użytkownika z bazy
``` swift
func fetchMedicalRecords(forUid uid: String,
                         completion: @escaping([MedicalRecord]) -> Void) {
  Firestore.firestore().collection("medical_records")
    .whereField("uid", isEqualTo: uid)
    .getDocuments { snapshot, _ in
      guard let documents = snapshot?.documents else { return }
      let medicalRecords = documents.compactMap({ try? $0.data(as: MedicalRecord.self) })
      completion(medicalRecords.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
    }
}
```

##### Ściągnięcie rekordów zwierzęcia z bazy
``` swift
func fetchMedicalRecords(forUid uid: String, 
                         petId: String,
                         completion: @escaping([MedicalRecord]) -> Void) {
  Firestore.firestore().collection("medical_records")
    .whereField("petId", isEqualTo: petId)
    .getDocuments { snapshot, _ in
      guard let documents = snapshot?.documents else { return }
      let medicalRecords = documents.compactMap({ try? $0.data(as: MedicalRecord.self) })
      completion(medicalRecords.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
    }
}
```

Metody `fetchMedicalRecords()` pozwalają na dostęp do danych wizyt i zabiegów na różne sposoby, między innymi przypisująć wizyty do zwierząt, ale również do użytkownika. Zostało to zaimplementowane z myślą o ewentualnym przyszłym rozwoju aplikacji.

### Zarządzanie lecznicami
Na ekran zakładki z mapą lecznic składają się trzy struktury widoków oraz jeden `ViewModel`. Dodatkowo system łączy się z bazą wykorzystując strukturę typu `service`, którą jest `ClinicService`. Strukturę zakładki można opisać warstwowo. Na widok mapy lecznic `ClinicsView` nałożony na stałe jest widok podglądu lecznicy `ClinicPreviewView`. Ponadto, gdy użytkownik otworzy informacje szczegółowe wybranej przez siebie lecznicy, oba powyższe widoki zostaną przysłonięte elementem UI typu `sheet` z widokiem szczegółów lecznicy `ClinicDetailView`. Model lecznicy przechowywany jest w strukturze `Clinic`.

#### ClinicsView
Struktura `ClinicsView` opiera się na elemencie UI `ZStack`, który pozwala na nakładanie na siebie innych elementów. Dzięki temu na element mapy nałożony został na górze nagłówek a na dole `ClinicPreviewView`. Poniższy kod prezentuje sposób implementacji mapy.

``` swift
Map(coordinateRegion: $viewModel.region,
    showsUserLocation: true,
    annotationItems: viewModel.clinics) { clinic in
  MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: clinic.coordinates[0],
                                                   longitude: clinic.coordinates[1])) {
    ClinicMapAnnotation()
    .scaleEffect(viewModel.currentClinic == clinic ? 1 : 0.7)
    .shadow(radius: 10)
    .onTapGesture { viewModel.updateRegion(clinic: clinic) }
  }
}
.onTapGesture { viewModel.currentClinic = nil }
```

Element UI `Map` przyjmuje za parametry `coordinateRegion`, `showsUserLocation` oraz `annotationItems`. Parametry te odpowiadają odpowiednio za region początkowy mapy oraz jej przybliżenie, pokazywanie na mapie lokalizacji użytkownika po wyrażeniu przez niego zgody, wyświetlanie na mapie pinezek. Za element pinezki odpowiada `MapAnnotation`. W powyższym kodzie źródłowym widać, że współrzędne geograficzne pobierane są z elementu listy zawierającej dane lecznic. Wygląd pinezki opisany jest w strukturze widoku `ClinicMapAnnotation`. Naciśnięcie na pinezkę wywołuję metodę w klasie `ClinicsViewModel`, która aktualizuje bieżący region mapy. Naciśnięcie w pusty obszar mapy resetuje wybrany obszar, co równocześnie wyłącza aktualny widok podglądu lecznicy.

#### ClinicPreviewView
Na widok `ClinicsView` na stałe nałożona jest grupa widoków `ClinicPreviewView`, z których maksymalnie jeden nie jest ukryty. Wywołanie metody zmieniającej region ustawia zmienną `currentClinic` w `ViewModelu` na aktualną lecznicę. Pozwala to decydować, który widok ma być włączony. Odbywa się to za pomocą standardowej funkcji warunkowej zamkniętej w nałożonych za siebie widokach. Poniższy kod pokazuje, jak zostało to rozwiązane.

``` swift
ZStack {
  ForEach(viewModel.clinics) { clinic in
    if viewModel.currentClinic == clinic {
      ClinicPreviewView(clinic: clinic)
        .shadow(color: Color.black.opacity(0.3), radius: 20)
        .padding()
        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
    }
  }
}
```

Struktura widoku podglądu lecznicy składa się z kilku prostych elementów UI. Na uwagę zasługuje przycisk umożliwiający wykonanie telefonu. Została tutaj zastosowana struktura `URL`, która zostaje utworzona z wykorzystaniem ciągu tekstu typu `String`. Numer telefonu pobierany jest z klasy `ViewModel`, formatowany a następnie wywoływana jest funkcja `open(url)` na obiekcie klasy `UIApplication`, która to obsługuje najważniejsze procesy przez cały cykl życia aplikacji. Implementacja powyższej funkcjonalności została zaprezentowana poniżej.

``` swift
Button {
  let phone = "tel://"
  let phoneNumberformatted = phone + clinic.phone
  guard let url = URL(string: phoneNumberformatted) else { return }
  
  UIApplication.shared.open(url)
} label: { 
  Text("Zadzwoń")
    .font(.headline)
    .frame(width: 125, height: 30)
}
.buttonStyle(.bordered)
```

#### ClinicsViewModel

Widok szczegółów lecznicy składa się z danych pobieranych z bazy. Są nimi nazwa, opis, lokalizacja, adres strony internetowej oraz logo. Widok jest otwierany poprzez zmianę atrybutu `sheetClinic` w klasie `ClinicsViewModel`. Przypisanie atrybutowi wartości `nil`, zamyka nakładkę.<br><br>
Jednym z elementów widoku szczegółów lecznicy jest statyczna mapa, w której tablica pinezek zawiera tylko jeden element a dane lokalizacji wprowadzone są z wykorzystaniem struktury `MKCoordinateRegion`, która składa się z dwóch kluczowych elementów, `center` typu `CLLocationCoordinate2D` oraz `span` typu `MKCoordinateSpan`. Pierwszy podaje długość i szerokość geograficzną, drugi określa różnicę w długości i szerokości na mapie – jej wielkość.<br><br>
Klasa `ClinicsViewModel` jest dość rozbudowana. Jej głównym zadaniem jest przechowywanie wszystkich dodanych do systemu lecznic poprzez ściągnięcie ich z bazy z wykorzystaniem struktury typu `service`. Odpowiada także za przechowywanie aktywnej – wybranej przez użytkownika – lecznicy oraz aktualizowanie regionu mapy.<br><br>
Ponad powyższe, zaimplementowane zostały tutaj metody realizujące przechwycenie obecnej lokalizacji użytkownika i naniesienie ją na mapę. Za tę funkcjonalność odpowiada `CLLocationManager`. Prosi on użytkownika o jednorazowe udostępnienie lokalizacji. Następnie wywoła się jedna z dwóch metod. Jeśli pobranie lokalizacji się powiedzie, lokalizacja zostanie zapisana i poprana przez metodę `locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])`. Jeśli natomiast popranie lokalizacji się nie uda uruchomiona zostanie metoda `locationManager(_ manager: CLLocationManager, didFailWithError error: Error)`. Pierwsza zaktualizuje region mapy, druga wyświetli błąd w konsoli. 

##### Poprawne pobranie lokalizacji

``` swift
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
  guard let latestLocation = locations.first else { return }
  DispatchQueue.main.async { self.region = MKCoordinateRegion( center: latestLocation.coordinate,
                                                               span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
  }
}
```

##### Niepoprawne pobranie lokalizacji

``` swift
func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
  print(error.localizedDescription)
}
```

##### Aktualizacja mapy

``` swift
func updateRegion(clinic: Clinic) { 
  withAnimation(.easeInOut) {
    region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: clinic.coordinates[0], longitude: clinic.coordinates[1]),
                                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    currentClinic = clinic
  }
}
```

### Zarządzanie panelem bocznym

Panel boczny zbudowany jest z dwóch struktur. `SideMenuView` zawiera w sobie między innymi elementy `SideMenuOptionRowView`. W górnej części panelu zostało umieszczone zdjęcie profilowe. Jest ono pobierane z bazy z wykorzystaniem adresu `URL` z elementu `AuthViewModel`. Zmianą adresu `URL` na obraz zajmuje się zewnętrzna biblioteka `Kingfisher`. Poniższe kod pokazuje przykładową implementację elementu UI wyświetlającego zdjęcie w zaokrąglonej ramce w rozmiarze `50x50 px`.

``` swift
import SwiftUI
import Kingfisher
struct SideMenuView: View {
  var body: some View {
    VStack {
      KFImage(URL(string: user.profileImageUrl))
      .resizable()
      .scaledToFill()
      .clipShape(Circle())
      .frame(width: 50, height: 50)
    }
  }
}
```
Pod zdjęciem profilowym znajduje się imię i nazwisko użytkownika oraz jego login. Z prawej strony loginu znajduje się licznik, który informuje o ilości zwierząt w bazie przypisanych do użytkownika. Następnym elementem jest lista przycisków odpowiadających za przejście do panelu wybierania aktywnego zwierzęcia oraz wylogowanie się. Zostały one zaimplementowane w sposób umożliwiający szybkie dodawanie nowych elementów listy. Odpowiada za to `Enum SideMenuViewModel`, w którym wypisane zostały poszczególne elementy. Są one wypisywane jeden po drugim.

#### SideMenuViewModel

``` swift
enum SideMenuViewModel: Int, CaseIterable {
  case pets
  case logout
  var title: String {
    switch self {
      case .pets: return "Wybierz zwierzę"
      case .logout: return "Wyloguj się"
    }
  }
  var imageName: String {
    switch self {
      case .pets: return "pawprint"
      case .logout: return "rectangle.portrait.and.arrow.right"
    }
  }
}
```

#### SideMenuView

``` swift
ForEach(SideMenuViewModel.allCases, id: \.rawValue) { viewModel in 
  if viewModel == .pets { 
    NavigationLink { 
      ChangePetListView()
    } label: { 
      SideMenuOptionRowView(viewModel: viewModel)
    }
  } else if viewModel == .logout {
    Button { 
      authViewModel.signOut()
    } label: { 
      SideMenuOptionRowView(viewModel: viewModel)
    }
  } else {
    SideMenuOptionRowView(viewModel: viewModel)
  }
}