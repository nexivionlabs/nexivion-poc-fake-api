# Nexivion Flutter PoC - Ürün Listeleme Modülü

## 📋 Proje Hakkında

Bu proje, Nexivion için hazırlanmış bir Flutter PoC (Proof of Concept) çalışmasıdır. Fake Store API kullanarak ürünleri listeyen, arama, filtreleme ve pagination özellikleri bulunan modern bir mobil uygulama geliştirilmiştir.

**Öne Çıkan Özellikler:**
- 💉 **Otomatik Dependency Injection** (get_it + injectable + code generation)
- 🌐 **Proaktif Network Monitoring** (connectivity_plus ile bağlantı durumu takibi)
- 🏗️ **Clean Architecture** (MVVM + Service Layer)
- 🔄 **Otomatik Recovery** (Bağlantı geri geldiğinde otomatik veri yükleme)

## 🎯 Özellikler

### ✅ Temel Özellikler
- **Ürün Listeleme**: Grid layout ile ürün kartları
- **Arama Fonksiyonu**: Ürün adı, açıklama ve kategoriye göre gerçek zamanlı arama
- **Kategori Filtreleme**: Bottom sheet ile kategori seçimi ve filtreleme
- **Ürün Detay**: Detaylı ürün görüntüleme sayfası
- **Pagination**: Sonsuz scroll ile sayfalama
- **Pull-to-Refresh**: Yukarıdan aşağı çekerek yenileme
- **Network Monitoring**: İnternet bağlantı durumu takibi ve otomatik recovery
- **Loading State**: Yüklenme durumu göstergesi
- **Error State**: Hata durumunda kullanıcı dostu mesajlar ve yeniden deneme
- **Empty State**: Sonuç bulunamadığında bilgilendirici ekran

### 🔧 Teknik Özellikler
- **State Management**: Provider pattern
- **Dependency Injection**: get_it + injectable ile otomatik DI
- **API İletişimi**: Dio HTTP client
- **Network Monitoring**: connectivity_plus ile internet bağlantı kontrolü
- **Temiz Mimari**: Feature-based klasör yapısı
- **Debouncing**: Arama için 300ms debounce
- **Error Handling**: Kapsamlı hata yönetimi
- **Responsive Design**: Farklı ekran boyutlarına uyumlu
- **Code Generation**: build_runner ile otomatik kod üretimi

## 🏗️ Mimari

### Klasör Yapısı

```
lib/
├── core/
│   ├── init/
│   │   ├── injection.dart            # DI konfigürasyonu
│   │   └── injection.config.dart     # Auto-generated DI dosyası
│   ├── service/
│   │   └── network_checker.dart      # İnternet bağlantı kontrolü servisi
│   ├── product/
│   │   ├── main_appbar.dart          # Tekrar kullanılabilir AppBar
│   │   ├── main_back_btn.dart        # Geri butonu widget'ı
│   │   ├── main_btn.dart             # Tekrar kullanılabilir Button
│   │   ├── main_image_builder.dart   # Görsel yönetimi widget'ı
│   │   ├── main_layout.dart          # Temel layout widget'ı
│   │   └── main_search_bar.dart      # Arama barı widget'ı
│   └── util/
│       ├── api_constant/
│       │   └── api_constant.dart     # API sabitleri
│       ├── app_color/
│       │   └── app_color.dart        # Renk paleti
│       ├── app_constant/
│       │   ├── app_assets.dart       # Asset yolları
│       │   └── app_constant.dart     # Uygulama sabitleri
│       ├── app_txt_style/
│       │   └── app_txt_style.dart    # Text stilleri
│       ├── extension/
│       │   ├── context_extension.dart # Context extension'ları
│       │   └── string_extension.dart  # String extension'ları
│       ├── network/
│       │   └── base_api.dart         # API base class (Dio wrapper)
│       └── routing/
│           └── app_route.dart        # Route yönetimi
├── feature/
│   ├── home/
│   │   ├── model/
│   │   │   └── product_model.dart    # Product model
│   │   ├── service/
│   │   │   └── product_service.dart  # Product API servisi
│   │   ├── view/
│   │   │   ├── home_view.dart        # Ana sayfa
│   │   │   └── widget/
│   │   │       ├── empty_state.dart       # Boş durum widget'ı
│   │   │       ├── error_state.dart       # Hata durumu widget'ı
│   │   │       ├── filter_bottom_sheet.dart # Kategori filtre bottom sheet
│   │   │       └── product_card.dart      # Ürün kartı widget'ı
│   │   └── view_model/
│   │       └── home_view_model.dart  # Ana sayfa view model
│   └── product_detail/
│       └── view/
│           └── product_detail_view.dart # Ürün detay sayfası
└── main.dart                          # Uygulama giriş noktası
```

### Kullanılan Mimari Pattern

#### MVVM (Model-View-ViewModel)
- **Model**: `Product`, `Rating` - Veri modelleri
- **View**: `HomeView` ve widget'lar - UI katmanı
- **ViewModel**: `HomeViewModel` - İş mantığı ve state yönetimi

#### Clean Architecture Prensipleri
- **Separation of Concerns**: Her katman kendi sorumluluğuna sahip
- **Dependency Injection**: Provider ile dependency injection
- **Single Responsibility**: Her sınıf tek bir sorumluluğa sahip

## 🚀 Kullanılan Teknolojiler

### Paketler
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8

  # State Management
  provider: ^6.1.5+1

  # Network
  dio: ^5.9.0
  connectivity_plus: ^6.1.0

  # Dependency Injection
  get_it: ^8.0.3
  injectable: ^2.5.0

  # UI
  flutter_svg: ^2.2.3

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0

  # Code Generation
  build_runner: ^2.4.14
  injectable_generator: ^2.6.2
```

## 💉 Dependency Injection

Proje, **get_it** ve **injectable** paketlerini kullanarak otomatik dependency injection sağlar.

### Yapılandırma

#### 1. DI Setup (`lib/core/init/injection.dart`)

```dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

/// Global service locator instance
final getIt = GetIt.instance;

/// Initialize dependency injection
@InjectableInit()
Future<void> configureDependencies() async => getIt.init();
```

#### 2. Main.dart'ta Initialization

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await configureDependencies();

  runApp(const MyApp());
}
```

### Kayıtlı Servisler

Aşağıdaki servisler DI container'a otomatik olarak kaydedilir:

#### 1. **NetworkChecker** (`@lazySingleton`)
```dart
@lazySingleton
class NetworkChecker {
  // İnternet bağlantı durumu kontrolü
  Future<bool> get hasConnection async { ... }
  Stream<bool> get onConnectivityChanged { ... }
}
```
- Tek instance oluşturulur (singleton)
- İlk çağrıldığında initialize edilir (lazy)
- connectivity_plus kullanır

#### 2. **ApiBase** (`@lazySingleton`)
```dart
@lazySingleton
class ApiBase {
  // HTTP istekleri için Dio wrapper
  Future<Response> get(String path, ...) async { ... }
  Future<Response> post(String path, ...) async { ... }
}
```
- Dio instance yönetimi
- Request/Response interceptors
- Merkezi error handling

#### 3. **ProductService** (`@lazySingleton`)
```dart
@lazySingleton
class ProductService {
  final ApiBase _apiBase;

  ProductService(this._apiBase); // Constructor injection

  Future<List<Product>> fetchProducts() async { ... }
}
```
- ApiBase dependency'si otomatik inject edilir
- Product API operasyonları

#### 4. **HomeViewModel** (`@injectable` / factory)
```dart
@injectable
class HomeViewModel extends ChangeNotifier {
  final ProductService _productService;
  final NetworkChecker _networkChecker;

  HomeViewModel(this._productService, this._networkChecker);
}
```
- Her çağrıda yeni instance oluşturulur (factory)
- ProductService ve NetworkChecker inject edilir
- State management için ChangeNotifier

### Servisleri Kullanma

#### Provider ile ViewModel Injection
```dart
ChangeNotifierProvider<HomeViewModel>(
  create: (_) => getIt<HomeViewModel>(),
  child: MaterialApp(...)
)
```

#### Widget İçinde Kullanım
```dart
final viewModel = context.watch<HomeViewModel>();
```

#### Direkt Servis Erişimi
```dart
final networkChecker = getIt<NetworkChecker>();
final apiBase = getIt<ApiBase>();
```

### Code Generation

DI konfigürasyonunu güncellemek için:

```bash
# Tek seferlik build
dart run build_runner build --delete-conflicting-outputs

# Watch mode (dosya değişikliklerini izler)
dart run build_runner watch --delete-conflicting-outputs
```

Bu komut `injection.config.dart` dosyasını otomatik oluşturur.

## 🌐 Network Connection Monitoring

Proje, **connectivity_plus** paketi kullanarak internet bağlantı durumunu sürekli izler.

### NetworkChecker Servisi

`lib/core/service/network_checker.dart` dosyası, bağlantı kontrolü için merkezi servis sağlar:

```dart
@lazySingleton
class NetworkChecker {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<bool>? _connectivitySubscription;

  /// Anlık bağlantı durumu kontrolü
  Future<bool> get hasConnection async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result.isNotEmpty && !result.contains(ConnectivityResult.none);
    } catch (e) {
      return false;
    }
  }

  /// Bağlantı değişikliklerini dinle
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.map((results) {
      return results.isNotEmpty && !results.contains(ConnectivityResult.none);
    });
  }

  /// Dinleyiciyi başlat
  void startListening(Function(bool isConnected) onChanged) {
    _connectivitySubscription = onConnectivityChanged.listen(onChanged);
  }

  /// Dinleyiciyi durdur
  void dispose() {
    _connectivitySubscription?.cancel();
  }
}
```

### HomeViewModel'de Kullanımı

#### 1. Initialization
```dart
@injectable
class HomeViewModel extends ChangeNotifier {
  final NetworkChecker _networkChecker;
  bool _isConnected = true;

  Future<void> initialize() async {
    // İlk bağlantı kontrolü
    _isConnected = await _networkChecker.hasConnection;

    if (!_isConnected) {
      _errorMessage = 'İnternet bağlantınızı kontrol ediniz';
      notifyListeners();
      return;
    }

    // Bağlantı değişikliklerini dinle
    _networkChecker.startListening(_onNetworkChanged);

    await fetchProducts();
  }
}
```

#### 2. Network Change Handler
```dart
void _onNetworkChanged(bool isConnected) {
  _isConnected = isConnected;

  if (!isConnected) {
    _errorMessage = 'İnternet bağlantınızı kontrol ediniz';
  } else {
    _errorMessage = null;
    if (_allProducts.isEmpty) {
      fetchProducts(); // Bağlantı geri geldiğinde otomatik yenile
    }
  }
  notifyListeners();
}
```

#### 3. API İsteklerinde Kontrol
```dart
Future<void> fetchProducts() async {
  // Her API isteği öncesi kontrol
  _isConnected = await _networkChecker.hasConnection;

  if (!_isConnected) {
    _errorMessage = 'İnternet bağlantınızı kontrol ediniz';
    _isLoading = false;
    notifyListeners();
    return;
  }

  // Bağlantı varsa API isteği yap
  final products = await _productService.fetchProducts();
  // ...
}
```

#### 4. Cleanup
```dart
@override
void dispose() {
  _networkChecker.dispose(); // Listener'ı temizle
  super.dispose();
}
```

### Özellikler

- **Proaktif Monitoring**: Bağlantı değişiklikleri anlık olarak tespit edilir
- **Otomatik Recovery**: Bağlantı geri geldiğinde otomatik veri yükleme
- **Kullanıcı Bildirimi**: Bağlantı yoksa kullanıcıya anlaşılır mesaj gösterilir
- **API Koruması**: API istekleri öncesi bağlantı kontrolü yapılır

## 📱 Ekranlar

### Ana Sayfa (Home View)
- **AppBar**: Başlık ve arama barı
- **Grid Layout**: 2 sütunlu ürün listesi
- **Product Card**:
  - Ürün görseli
  - Kategori badge'i
  - Ürün adı
  - Fiyat
  - Rating (yıldız)
- **Loading Indicator**: Alt kısımda pagination loading
- **Search Results Info**: Arama sonuç sayısı

### State Yönetimi Akışı

```
HomeView (UI)
    ↓
HomeViewModel (State Management)
    ↓  ↓
    │  └─→ NetworkChecker (Connectivity Monitoring)
    │           ↓
    │      connectivity_plus
    ↓
ProductService (Business Logic)
    ↓
ApiBase (Network Layer - Dio)
    ↓
Fake Store API
```

### Dependency Flow

```
getIt (Service Locator)
    ├─→ NetworkChecker (@lazySingleton)
    ├─→ ApiBase (@lazySingleton)
    ├─→ ProductService (@lazySingleton)
    │       └─→ requires ApiBase
    └─→ HomeViewModel (@injectable)
            ├─→ requires ProductService
            └─→ requires NetworkChecker
```

## 🔄 Özellik Detayları

### Arama Fonksiyonu
- Debounced search (300ms)
- Ürün adı, açıklama ve kategoriye göre filtreleme
- Gerçek zamanlı sonuç güncelleme
- Arama sonuç sayısı gösterimi
- "Aramayı Temizle" butonu

### Kategori Filtreleme
- Bottom sheet ile kategori seçimi
- API'den dinamik kategori listesi
- Seçili kategori badge gösterimi
- "Filtreyi Temizle" butonu
- Kategori değiştiğinde otomatik API çağrısı

### Pagination
- Simüle edilmiş pagination (API'nin tüm ürünleri döndürmesi nedeniyle)
- Sayfa başına 10 ürün
- %80 scroll'da otomatik yeni sayfa yükleme
- Loading indicator ile kullanıcı bilgilendirmesi

### Error Handling
- **Network hataları**: İnternet bağlantısı kontrolü
- **Connectivity monitoring**: Bağlantı durumu takibi
- **Timeout hataları**: 30 saniye timeout
- **Server hataları**: 4xx, 5xx status code'ları
- **Kullanıcı dostu mesajlar**: Türkçe hata mesajları
- **"Tekrar Dene" butonu**: Başarısız işlemleri yeniden deneme
- **Otomatik recovery**: Bağlantı geri geldiğinde otomatik yükleme

## 🎨 UI/UX Özellikleri

### Renk Paleti
- **Primary**: #2563EB (Mavi)
- **Success**: #10B981 (Yeşil)
- **Error**: #EF4444 (Kırmızı)
- **Warning**: #F59E0B (Turuncu)

### Design System
- Material Design 3
- Responsive layout
- Consistent spacing (8px grid)
- Shadow ve elevation kullanımı
- Smooth transitions

## 🔧 Kurulum ve Çalıştırma

### Gereksinimler
- Flutter SDK (>=3.10.1)
- Dart SDK
- Android Studio / Xcode (platform bağımlı)

### Adımlar

1. **Projeyi klonlayın**
```bash
git clone [repository-url]
cd poc_project_fake_api
```

2. **Bağımlılıkları yükleyin**
```bash
flutter pub get
```

3. **DI Code Generation çalıştırın**
```bash
dart run build_runner build --delete-conflicting-outputs
```

4. **Uygulamayı çalıştırın**
```bash
flutter run
```

5. **APK oluşturma (Release)**
```bash
flutter build apk --release
```

APK dosyası: `build/app/outputs/flutter-apk/app-release.apk`

## 📊 API Kullanımı

### Base URL
```
https://fakestoreapi.com
```

### Endpoints
- `GET /products` - Tüm ürünleri getir
- `GET /products?limit=10&skip=0` - Pagination ile ürünler
- `GET /products/{id}` - Tek ürün detayı
- `GET /products/categories` - Kategorileri getir
- `GET /products/category/{category}` - Kategoriye göre ürünler

## 🧪 Test Senaryoları

### Manuel Test Checklist
- [ ] Uygulama açılışta ürünleri yüklüyor mu?
- [ ] Arama çalışıyor mu?
- [ ] Pagination çalışıyor mu?
- [ ] Pull-to-refresh çalışıyor mu?
- [ ] Kategori filtreleme çalışıyor mu?
- [ ] İnternet kapalıyken hata mesajı gösteriliyor mu?
- [ ] "Tekrar Dene" butonu çalışıyor mu?
- [ ] Arama boş sonuç verdiğinde doğru mesaj gösteriliyor mu?
- [ ] Loading state'ler düzgün çalışıyor mu?
- [ ] İnternet bağlantısı kesildikten sonra tekrar geldiğinde otomatik yükleme yapıyor mu?
- [ ] Dependency Injection doğru çalışıyor mu?
- [ ] NetworkChecker servisi bağlantı değişikliklerini tespit ediyor mu?

## 💡 Geliştirme Notları

### Best Practices
- ✅ Clean Code prensipleri uygulandı
- ✅ SOLID prensipleri takip edildi
- ✅ DRY (Don't Repeat Yourself) prensibi uygulandı
- ✅ Meaningful isimlendirme kullanıldı
- ✅ Dependency Injection ile loose coupling sağlandı
- ✅ Code generation ile boilerplate kod azaltıldı
- ✅ Error handling kapsamlı yapıldı
- ✅ Loading states yönetildi
- ✅ User feedback sağlandı
- ✅ Network monitoring ile proaktif hata yönetimi
- ✅ Service layer ile business logic separation

### Performans Optimizasyonları
- **Debounced search**: 300ms debounce ile gereksiz API çağrılarını önler
- **Lazy loading**: Pagination ile sayfa sayfa veri yükleme
- **Lazy Singleton**: Servisler ilk kullanımda initialize edilir
- **Cached network images**: Görsellerin önbelleklenmesi
- **Const constructors**: Gereksiz widget rebuilding'i önler
- **Proactive network check**: API isteği öncesi bağlantı kontrolü
- **Stream-based monitoring**: Efficient connectivity tracking

## 🔮 Gelecek Geliştirmeler

Proje genişletilebilir yapıda tasarlandı. Olası geliştirmeler:

- [x] Ürün detay sayfası
- [x] Kategoriye göre filtreleme
- [x] Dependency Injection (get_it + injectable)
- [x] Network connection monitoring
- [ ] Favorilere ekleme (local storage)
- [ ] Sıralama seçenekleri (fiyat, rating, vb.)
- [ ] Dark mode desteği
- [ ] Offline support (local caching - Hive/SharedPreferences)
- [ ] Unit ve integration testleri
- [ ] CI/CD pipeline
- [ ] Çoklu dil desteği (i18n)
- [ ] Sepet işlevselliği

## 👨‍💻 Geliştirici

Bu proje, modern Flutter development best practices kullanılarak senior seviyede geliştirilmiştir.

### Kullanılan Teknikler
- **Provider** state management
- **Dependency Injection** (get_it + injectable)
- **Code Generation** (build_runner + injectable_generator)
- **Network Monitoring** (connectivity_plus)
- **Service Layer Architecture**
- **MVVM Pattern**
- **Lazy Singleton Pattern**
- **Factory Pattern**
- **Stream-based Connectivity Monitoring**
- **Constructor Injection**
- **Responsive Design**
- **Error Boundary Pattern**
- **Debouncing**
- **Infinite Scrolling**
- **Proactive Error Handling**

## 📄 Lisans

Bu proje Nexivion için PoC çalışması olarak geliştirilmiştir.

---

**Not**: Proje gerçek bir production uygulaması gibi tasarlanmış ve geliştirilmiştir. Kod kalitesi, mimari yapı ve user experience önceliklendirilmiştir.

## 🔑 Önemli Notlar

### Dependency Injection
- Yeni servis eklerken `@lazySingleton` veya `@injectable` annotation'ı kullanın
- Constructor injection tercih edin
- Her değişiklikten sonra `build_runner` çalıştırın
- `injection.config.dart` dosyası commit edilmelidir

### Network Monitoring
- `NetworkChecker` dispose edilmeyi unutmayın
- API istekleri öncesi `hasConnection` kontrolü yapın
- Bağlantı değişikliklerini dinlerken `startListening` kullanın
- ViewModel dispose edilirken `_networkChecker.dispose()` çağrısı yapın

### Code Generation
- Yeni injectable class ekledikten sonra:
  ```bash
  dart run build_runner build --delete-conflicting-outputs
  ```
- Development sırasında watch mode kullanabilirsiniz:
  ```bash
  dart run build_runner watch
  ```
