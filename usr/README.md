# منصة التجارة الإلكترونية متعددة البائعين

منصة متكاملة تدعم تعدد التجار مع التركيز على فصل البيانات بناءً على معرّف التاجر `merchant_id`.

## الميزات
* **هيكلة البيانات**: استخدام `merchant_id` لفصل المنتجات والطلبات باستخدام سياسات Supabase RLS.
* **لوحة تحكم التاجر**: واجهة خاصة لكل تاجر تعرض إيراداته ومنتجاته مع دعم عملة الدينار الكويتي (KWD).
* **واجهة العميل**: تصفح المنتجات عبر "العلامات التجارية/المتاجر".
* **العملة**: التنسيق الكامل بـ الدينار الكويتي `0.000 KWD`.
* **دعم اللغة**: واجهة التطبيق تدعم اللغة العربية من اليمين لليسار بالكامل (RTL).

## الإعداد والتشغيل
1. قم بإنشاء مشروع Supabase ورفع ملف `supabase_schema.sql` لتنفيذ الجداول وسياسات الحماية (RLS).
2. قم بتثبيت التبعيات باستخدام `flutter pub get`.
3. قم بتشغيل التطبيق باستخدام `flutter run`.

## About CouldAI
This app was generated with [CouldAI](https://could.ai), an AI app builder for cross-platform apps that turns prompts into real native iOS, Android, Web, and Desktop apps with autonomous AI agents that architect, build, test, deploy, and iterate production-ready applications.
