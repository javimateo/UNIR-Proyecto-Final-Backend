-- ============================================================
--  Plataforma de compraventa de tecnología de segunda mano
--  Schema MySQL
-- ============================================================

DROP DATABASE IF EXISTS Proyecto_Final_UNIR;

CREATE DATABASE Proyecto_Final_UNIR
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE Proyecto_Final_UNIR;

-- ------------------------------------------------------------
-- BRANDS
-- ------------------------------------------------------------
CREATE TABLE brands (
  id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name       VARCHAR(100) NOT NULL UNIQUE,
  slug       VARCHAR(100) NOT NULL UNIQUE,
  logo_url   VARCHAR(500),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ------------------------------------------------------------
-- CATEGORIES (jerárquicas: parent_id NULL = categoría raíz)
-- ------------------------------------------------------------
CREATE TABLE categories (
  id        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  parent_id INT UNSIGNED NULL,
  name      VARCHAR(100) NOT NULL,
  slug      VARCHAR(100) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- ------------------------------------------------------------
-- USERS
-- ------------------------------------------------------------
CREATE TABLE users (
  id            INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  username      VARCHAR(50)  NOT NULL UNIQUE,
  email         VARCHAR(150) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  avatar_url    VARCHAR(500),
  role          ENUM('user', 'moderator', 'admin') NOT NULL DEFAULT 'user',
  status        ENUM('active', 'blocked', 'deleted') NOT NULL DEFAULT 'active',
  created_at    DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ------------------------------------------------------------
-- ITEMS
-- ------------------------------------------------------------
CREATE TABLE items (
  id             INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id        INT UNSIGNED NOT NULL,
  category_id    INT UNSIGNED NOT NULL,
  brand_id       INT UNSIGNED,
  title          VARCHAR(150) NOT NULL,
  model          VARCHAR(150),
  description    TEXT,
  specs          JSON,                          -- ej: {"ram":"16GB","storage":"512GB SSD"}
  price          DECIMAL(10, 2) NOT NULL,
  item_condition ENUM('new', 'like_new', 'good', 'fair', 'poor') NOT NULL,
  status         ENUM('draft', 'published', 'under_review', 'removed', 'sold') NOT NULL DEFAULT 'draft',
  created_at     DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at     DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id)     REFERENCES users(id)      ON DELETE CASCADE,
  FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT,
  FOREIGN KEY (brand_id)    REFERENCES brands(id)     ON DELETE SET NULL
);

-- ------------------------------------------------------------
-- ITEM PHOTOS
-- ------------------------------------------------------------
CREATE TABLE item_photos (
  id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  item_id    INT UNSIGNED NOT NULL,
  url        VARCHAR(500) NOT NULL,
  sort_order TINYINT UNSIGNED DEFAULT 0,
  FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- CONVERSATIONS
-- ------------------------------------------------------------
CREATE TABLE conversations (
  id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  item_id    INT UNSIGNED NOT NULL,
  buyer_id   INT UNSIGNED NOT NULL,
  seller_id  INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_conversation (item_id, buyer_id),
  FOREIGN KEY (item_id)   REFERENCES items(id) ON DELETE CASCADE,
  FOREIGN KEY (buyer_id)  REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (seller_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- MESSAGES
-- ------------------------------------------------------------
CREATE TABLE messages (
  id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  conversation_id INT UNSIGNED NOT NULL,
  sender_id       INT UNSIGNED NOT NULL,
  content         TEXT NOT NULL,
  is_read         BOOLEAN NOT NULL DEFAULT FALSE,
  sent_at         DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE,
  FOREIGN KEY (sender_id)       REFERENCES users(id)         ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- REPORTS
-- ------------------------------------------------------------
CREATE TABLE reports (
  id             INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  item_id        INT UNSIGNED NOT NULL,
  reporter_id    INT UNSIGNED NOT NULL,
  moderator_id   INT UNSIGNED,
  reason         VARCHAR(255) NOT NULL,
  status         ENUM('pending', 'resolved_active', 'resolved_removed') NOT NULL DEFAULT 'pending',
  moderator_note TEXT,
  created_at     DATETIME DEFAULT CURRENT_TIMESTAMP,
  resolved_at    DATETIME,
  FOREIGN KEY (item_id)      REFERENCES items(id) ON DELETE CASCADE,
  FOREIGN KEY (reporter_id)  REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (moderator_id) REFERENCES users(id) ON DELETE SET NULL
);

-- ------------------------------------------------------------
-- FAVORITES
-- ------------------------------------------------------------
CREATE TABLE favorites (
  id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id    INT UNSIGNED NOT NULL,
  item_id    INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_favorite (user_id, item_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- VALUATIONS
-- ------------------------------------------------------------
CREATE TABLE valuations (
  id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  reviewer_id INT UNSIGNED NOT NULL,
  reviewed_id INT UNSIGNED NOT NULL,
  item_id     INT UNSIGNED NOT NULL,
  score       TINYINT UNSIGNED NOT NULL CHECK (score BETWEEN 1 AND 5),
  comment     TEXT,
  created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_valuation (reviewer_id, item_id),
  FOREIGN KEY (reviewer_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (reviewed_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (item_id)     REFERENCES items(id) ON DELETE CASCADE
);

-- ============================================================
--  Seed: marcas
-- ============================================================
INSERT INTO brands (name, slug) VALUES
  ('Apple',        'apple'),
  ('Samsung',      'samsung'),
  ('ASUS',         'asus'),
  ('MSI',          'msi'),
  ('Lenovo',       'lenovo'),
  ('HP',           'hp'),
  ('Dell',         'dell'),
  ('Intel',        'intel'),
  ('AMD',          'amd'),
  ('NVIDIA',       'nvidia'),
  ('Corsair',      'corsair'),
  ('Kingston',     'kingston'),
  ('Seagate',      'seagate'),
  ('Western Digital', 'western-digital'),
  ('LG',           'lg'),
  ('Sony',         'sony'),
  ('Logitech',     'logitech'),
  ('Razer',        'razer');

-- ============================================================
--  Seed: categorías jerárquicas
-- ============================================================

-- Raíz
INSERT INTO categories (id, parent_id, name, slug) VALUES
  (1,  NULL, 'Portátiles',            'portatiles'),
  (2,  NULL, 'Sobremesa y componentes','sobremesa-componentes'),
  (3,  NULL, 'Monitores',             'monitores'),
  (4,  NULL, 'Almacenamiento',        'almacenamiento'),
  (5,  NULL, 'Periféricos',           'perifericos'),
  (6,  NULL, 'Smartphones y tablets', 'smartphones-tablets'),
  (7,  NULL, 'Fotografía y vídeo',    'fotografia-video'),
  (8,  NULL, 'Redes y conectividad',  'redes'),
  (9,  NULL, 'Otros',                 'otros');

-- Portátiles
INSERT INTO categories (parent_id, name, slug) VALUES
  (1, 'Portátiles gaming',      'portatiles-gaming'),
  (1, 'Portátiles ultrabook',   'portatiles-ultrabook'),
  (1, 'Portátiles workstation', 'portatiles-workstation');

-- Sobremesa y componentes
INSERT INTO categories (parent_id, name, slug) VALUES
  (2, 'PCs completos',          'pcs-completos'),
  (2, 'Procesadores',           'procesadores'),
  (2, 'Tarjetas gráficas',      'tarjetas-graficas'),
  (2, 'Placas base',            'placas-base'),
  (2, 'Memorias RAM',           'memorias-ram'),
  (2, 'Fuentes de alimentación','fuentes-alimentacion'),
  (2, 'Cajas y torres',         'cajas-torres'),
  (2, 'Refrigeración',          'refrigeracion');

-- Almacenamiento
INSERT INTO categories (parent_id, name, slug) VALUES
  (4, 'SSD',                    'ssd'),
  (4, 'HDD',                    'hdd'),
  (4, 'Discos externos',        'discos-externos'),
  (4, 'Memorias USB y tarjetas','usb-tarjetas');

-- Periféricos
INSERT INTO categories (parent_id, name, slug) VALUES
  (5, 'Teclados',               'teclados'),
  (5, 'Ratones',                'ratones'),
  (5, 'Auriculares y sonido',   'auriculares'),
  (5, 'Webcams',                'webcams'),
  (5, 'Impresoras y escáneres', 'impresoras');

-- Smartphones y tablets
INSERT INTO categories (parent_id, name, slug) VALUES
  (6, 'Smartphones',            'smartphones'),
  (6, 'Tablets',                'tablets'),
  (6, 'Accesorios móvil',       'accesorios-movil');
