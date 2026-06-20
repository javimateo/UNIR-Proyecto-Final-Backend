-- ============================================================
--  Plataforma de compraventa de televisores de segunda mano
--  Schema MySQL — versión corregida
-- ============================================================

DROP DATABASE IF EXISTS proyecto_final_unir;

CREATE DATABASE proyecto_final_unir
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE proyecto_final_unir;

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
-- CATEGORIES
-- ------------------------------------------------------------
CREATE TABLE categories (
  id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name       VARCHAR(100) NOT NULL UNIQUE,
  slug       VARCHAR(100) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
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
  specs          JSON,
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
  is_main    BOOLEAN NOT NULL DEFAULT FALSE,
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
