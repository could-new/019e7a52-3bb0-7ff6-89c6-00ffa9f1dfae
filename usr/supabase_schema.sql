-- إعداد قاعدة بيانات منصة التجارة الإلكترونية متعددة البائعين

-- 1. جدول المتاجر (Merchants)
CREATE TABLE merchants (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    details TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. جدول المنتجات (Products)
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    merchant_id UUID REFERENCES merchants(id) ON DELETE CASCADE NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 3) NOT NULL, -- 3 decimal places for KWD (e.g., 1.500)
    image_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. جدول الطلبات (Orders)
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    merchant_id UUID REFERENCES merchants(id) ON DELETE CASCADE NOT NULL,
    customer_name VARCHAR(255) NOT NULL,
    total_amount DECIMAL(10, 3) NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending', -- 'Pending', 'Processing', 'Delivered'
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- تفعيل سياسات الأمان RLS (Row Level Security)

ALTER TABLE merchants ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

-- سياسات التجار (Merchants Policies)
-- يمكن للتاجر رؤية وتعديل المتجر الخاص به فقط
CREATE POLICY "Merchants can view their own store" 
ON merchants FOR SELECT 
USING (auth.uid() = user_id);

CREATE POLICY "Merchants can update their own store" 
ON merchants FOR UPDATE 
USING (auth.uid() = user_id);

-- سياسات المنتجات (Products Policies)
-- المنتجات مرئية للجميع (العملاء)
CREATE POLICY "Products are visible to everyone" 
ON products FOR SELECT 
USING (true);

-- يمكن للتاجر إضافة وتعديل وحذف منتجاته فقط
CREATE POLICY "Merchants can insert own products" 
ON products FOR INSERT 
WITH CHECK (merchant_id IN (SELECT id FROM merchants WHERE user_id = auth.uid()));

CREATE POLICY "Merchants can update own products" 
ON products FOR UPDATE 
USING (merchant_id IN (SELECT id FROM merchants WHERE user_id = auth.uid()));

CREATE POLICY "Merchants can delete own products" 
ON products FOR DELETE 
USING (merchant_id IN (SELECT id FROM merchants WHERE user_id = auth.uid()));

-- سياسات الطلبات (Orders Policies)
-- يمكن للعملاء إدراج طلبات جديدة
CREATE POLICY "Anyone can create orders" 
ON orders FOR INSERT 
WITH CHECK (true);

-- يمكن للتاجر رؤية وتحديث طلباته فقط
CREATE POLICY "Merchants can view own orders" 
ON orders FOR SELECT 
USING (merchant_id IN (SELECT id FROM merchants WHERE user_id = auth.uid()));

CREATE POLICY "Merchants can update own orders" 
ON orders FOR UPDATE 
USING (merchant_id IN (SELECT id FROM merchants WHERE user_id = auth.uid()));

-- ملاحظة التكامل مع المحفظة الذكية:
-- يمكن إضافة Trigger أو Webhook في Supabase يراقب جدول Orders.
-- عندما يتغير 'status' إلى 'Delivered'، يتم استدعاء API المحفظة الذكية
-- لاستقطاع عمولة المنصة وإضافة الرصيد المتبقي للتاجر.
