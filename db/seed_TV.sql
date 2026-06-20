-- ============================================================
--  Seed data — Plataforma de compraventa de televisores
--  Ejecutar después de BBDD_TV.sql
-- ============================================================

USE proyecto_final_unir;

-- ------------------------------------------------------------
-- BRANDS
-- ------------------------------------------------------------
INSERT INTO brands (name, slug) VALUES
  ('Samsung',  'samsung'),
  ('LG',       'lg'),
  ('Sony',     'sony'),
  ('Xiaomi',   'xiaomi'),
  ('TCL',      'tcl'),
  ('Philips',  'philips'),
  ('Hisense',  'hisense'),
  ('Panasonic','panasonic');

-- ------------------------------------------------------------
-- CATEGORIES
-- ------------------------------------------------------------
INSERT INTO categories (name, slug) VALUES
  ('Pantallas pequeñas (hasta 32")',  'pantallas-pequenas'),
  ('Pantallas medianas (33" - 50")',  'pantallas-medianas'),
  ('Pantallas grandes (51" - 65")',   'pantallas-grandes'),
  ('Pantallas extra grandes (66"+)',  'pantallas-extra-grandes');

-- ------------------------------------------------------------
-- USERS  (contraseña para todos: "password" hasheada con bcrypt)
-- ------------------------------------------------------------
INSERT INTO users (username, email, password_hash, avatar_url, role, status) VALUES
  ('admin_laura',   'laura.admin@example.com',  '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://i.pravatar.cc/150?u=1',  'admin',     'active'),
  ('mod_carlos',    'carlos.mod@example.com',   '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://i.pravatar.cc/150?u=2',  'moderator', 'active'),
  ('user_sofia',    'sofia@example.com',         '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://i.pravatar.cc/150?u=3',  'user',      'active'),
  ('user_miguel',   'miguel@example.com',        '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://i.pravatar.cc/150?u=4',  'user',      'active'),
  ('user_elena',    'elena@example.com',         '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://i.pravatar.cc/150?u=5',  'user',      'active'),
  ('user_pablo',    'pablo@example.com',         '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://i.pravatar.cc/150?u=6',  'user',      'active'),
  ('user_ana',      'ana@example.com',           '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://i.pravatar.cc/150?u=7',  'user',      'active'),
  ('user_jorge',    'jorge@example.com',         '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://i.pravatar.cc/150?u=8',  'user',      'active'),
  ('user_marta',    'marta@example.com',         '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://i.pravatar.cc/150?u=9',  'user',      'active'),
  ('user_blocked',  'blocked@example.com',       '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL,                             'user',      'blocked'),
  ('user_ramon',    'ramon@example.com',         '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://i.pravatar.cc/150?u=11', 'user',      'active');

-- ------------------------------------------------------------
-- ITEMS
-- category_id: 1=pequeñas, 2=medianas, 3=grandes, 4=extra grandes
-- brand_id:    1=Samsung, 2=LG, 3=Sony, 4=Xiaomi, 5=TCL, 6=Philips, 7=Hisense
-- ------------------------------------------------------------
INSERT INTO items (id, user_id, category_id, brand_id, title, model, description, specs, price, item_condition, status) VALUES
  (1,  3, 1, 4, 'Xiaomi Smart TV F2 32"',      'L32M7-F2EN',    'Pantalla Fire TV integrada, resolución HD, sonido Dolby Audio y control por voz Alexa.',                   '{"pulgadas":"32","resolucion":"HD 720p","panel":"LED","smart_tv":"Fire TV","hdmi":"3","hdr":"No"}',              179.00, 'like_new',  'published'),
  (2,  4, 1, 1, 'Samsung T4305 32"',            'UE32T4305AKXXC','Smart TV ideal para cocina o dormitorio secundario. HDR y PurColor.',                                       '{"pulgadas":"32","resolucion":"FHD 1080p","panel":"LED","smart_tv":"Tizen","hdmi":"2","hdr":"HDR10"}',           195.00, 'good',      'published'),
  (3,  7, 1, 2, 'LG Smart TV 24" Monitor-TV',  '24TQ510S-WZ',   'Combo monitor y televisión con webOS22, color blanco, ideal para espacios reducidos.',                      '{"pulgadas":"24","resolucion":"HD 720p","panel":"LED-IPS","smart_tv":"webOS","hdmi":"1","hdr":"No"}',            120.00, 'good',      'published'),
  (4,  8, 1, 7, 'Hisense 32A4K',               '32A4K',         'Televisor básico con sistema VIDAA, modo juego y optimizador de color natural.',                            '{"pulgadas":"32","resolucion":"HD 720p","panel":"LED","smart_tv":"VIDAA","hdmi":"2","hdr":"No"}',                140.00, 'like_new',  'published'),
  (5,  5, 2, 1, 'Samsung Crystal UHD 43"',      'TU43CU7105',    'Procesador Crystal 4K, gran contraste. Un año de uso. Vendo por mudanza.',                                 '{"pulgadas":"43","resolucion":"4K UHD","panel":"LED","smart_tv":"Tizen","hdmi":"3","hdr":"HDR10+"}',             290.00, 'like_new',  'published'),
  (6,  6, 2, 2, 'LG NanoCell 50"',             '50NANO766QA',   'Colores puros gracias a NanoCell, Smart TV webOS 22 con perfiles de usuario.',                              '{"pulgadas":"50","resolucion":"4K UHD","panel":"NanoCell","smart_tv":"webOS","hdmi":"3","hdr":"HDR10 Pro"}',     360.00, 'like_new',  'published'),
  (7,  9, 2, 5, 'TCL 43" 4K Google TV',        '43P635',        'Diseño sin bordes metálico, Google TV con control por voz manos libres, Dolby Audio.',                     '{"pulgadas":"43","resolucion":"4K UHD","panel":"LED","smart_tv":"Google TV","hdmi":"3","hdr":"HDR10"}',          230.00, 'good',      'published'),
  (8,  3, 2, 1, 'Samsung OLED 48" (Borrador)', 'QE48S90C',      'Pendiente de verificar fotos del panel para descartar quemados antes de publicar.',                         '{"pulgadas":"48","resolucion":"4K UHD","panel":"OLED","smart_tv":"Tizen","hdmi":"4","hdr":"Quantum HDR"}',       890.00, 'like_new',  'draft'),
  (9,  3, 3, 3, 'Sony BRAVIA XR OLED 55"',     'XR-55A80L',     'Pantalla acústica, negros perfectos, perfecta para PlayStation 5 con HDMI 2.1.',                           '{"pulgadas":"55","resolucion":"4K UHD","panel":"OLED","smart_tv":"Google TV","hdmi":"4","hdr":"Dolby Vision"}',   1150.00,'new',       'published'),
  (10, 4, 3, 6, 'Philips Ambilight 65"',       '65PUS8517',     'Sistema Ambilight de 3 lados que ilumina la pared. Panel de gran nitidez.',                                 '{"pulgadas":"65","resolucion":"4K UHD","panel":"LED","smart_tv":"Android TV","hdmi":"4","hdr":"Dolby Vision"}',  620.00, 'good',      'published'),
  (11, 7, 3, 1, 'Samsung QLED 55"',            'QE55Q60B',      '100% Volumen de color con Quantum Dot. Estado impecable con caja original.',                                '{"pulgadas":"55","resolucion":"4K UHD","panel":"QLED","smart_tv":"Tizen","hdmi":"3","hdr":"HDR10+"}',            450.00, 'good',      'published'),
  (12, 8, 3, 2, 'LG OLED EVO 55"',            'OLED55C26LD',   'El mejor panel para gaming y cine, 120Hz nativos, procesador inteligente a9 Gen5.',                         '{"pulgadas":"55","resolucion":"4K UHD","panel":"OLED EVO","smart_tv":"webOS","hdmi":"4","hdr":"Dolby Vision IQ"}', 790.00,'new',       'published'),
  (13, 5, 4, 1, 'Samsung Neo QLED 75" 8K',     'QE75QN700B',    'Resolución 8K real con Mini LED. Comprada hace 6 meses. Una experiencia de cine.',                          '{"pulgadas":"75","resolucion":"8K UHD","panel":"Mini LED","smart_tv":"Tizen","hdmi":"4","hdr":"Quantum HDR 2000"}',1850.00,'like_new', 'published'),
  (14, 6, 4, 5, 'TCL 85" QLED 4K 144Hz',      '85C745',        'Gigante pantalla gaming con tasa de refresco alta, Full Array Local Dimming.',                              '{"pulgadas":"85","resolucion":"4K UHD","panel":"QLED","smart_tv":"Google TV","hdmi":"4","hdr":"Dolby Vision IQ"}',1100.00,'good',     'published'),
  (15, 9, 4, 7, 'Hisense 75" Mini-LED',        '75U7KQ',        'Tecnología Mini-LED ULED, 144Hz, ideal para salón grande. Sin marcas ni arañazos.',                        '{"pulgadas":"75","resolucion":"4K UHD","panel":"Mini-LED","smart_tv":"VIDAA","hdmi":"4","hdr":"HDR10+ Adaptive"}', 780.00,'like_new',  'published'),
  (16, 11,3, 3, 'Sony BRAVIA LED 65" 4K',      'KD-65X75K',     'Televisor impecable con Google TV. Muy poco uso, lo vendo con su mando original y patas.',                 '{"pulgadas":"65","resolucion":"4K UHD","panel":"LED","smart_tv":"Google TV","hdmi":"3","hdr":"HDR10"}',          540.00, 'like_new',  'published');

-- ------------------------------------------------------------
-- ITEM PHOTOS
-- ------------------------------------------------------------
INSERT INTO item_photos (item_id, url, is_main, sort_order) VALUES
  (1,  'https://via.placeholder.com/800x500?text=Xiaomi+32', TRUE,  0),
  (2,  'https://via.placeholder.com/800x500?text=Samsung+32', TRUE, 0),
  (3,  'https://via.placeholder.com/800x500?text=LG+24',      TRUE, 0),
  (4,  'https://via.placeholder.com/800x500?text=Hisense+32', TRUE, 0),
  (5,  'https://via.placeholder.com/800x500?text=Samsung+43', TRUE, 0),
  (6,  'https://via.placeholder.com/800x500?text=LG+50',      TRUE, 0),
  (7,  'https://via.placeholder.com/800x500?text=TCL+43',     TRUE, 0),
  (9,  'https://via.placeholder.com/800x500?text=Sony+55',    TRUE, 0),
  (10, 'https://via.placeholder.com/800x500?text=Philips+65', TRUE, 0),
  (11, 'https://via.placeholder.com/800x500?text=Samsung+55', TRUE, 0),
  (12, 'https://via.placeholder.com/800x500?text=LG+55',      TRUE, 0),
  (13, 'https://via.placeholder.com/800x500?text=Samsung+75', TRUE, 0),
  (14, 'https://via.placeholder.com/800x500?text=TCL+85',     TRUE, 0),
  (15, 'https://via.placeholder.com/800x500?text=Hisense+75', TRUE, 0),
  (16, 'https://via.placeholder.com/800x500?text=Sony+65',    TRUE, 0);

-- ------------------------------------------------------------
-- CONVERSATIONS
-- ------------------------------------------------------------
INSERT INTO conversations (item_id, buyer_id, seller_id) VALUES
  (1,  4, 3),
  (2,  4, 5),
  (5,  6, 5),
  (6,  3, 6),
  (9,  5, 3),
  (10, 9, 4),
  (12, 7, 8),
  (13, 3, 5);

-- ------------------------------------------------------------
-- MESSAGES
-- ------------------------------------------------------------
INSERT INTO messages (conversation_id, sender_id, content, is_read, sent_at) VALUES
  (1, 4, '¡Hola! ¿Sigue disponible la Xiaomi de 32"?',                              TRUE,  '2026-05-10 07:00:00'),
  (1, 3, 'Sí, disponible. ¿Tienes alguna duda?',                                     TRUE,  '2026-05-10 07:15:00'),
  (1, 4, '¿Viene con el sistema Fire TV fluido o se encalla en Netflix?',             TRUE,  '2026-05-10 07:20:00'),
  (1, 3, 'Va perfecto, está actualizado a la última versión del sistema.',            TRUE,  '2026-05-10 08:00:00'),
  (1, 4, '¿Harías un poco de descuento si recojo en mano?',                          FALSE, '2026-05-10 08:30:00'),
  (2, 4, 'Buenas, ¿tiene algún arañazo o golpe en la pantalla?',                     TRUE,  '2026-05-11 09:00:00'),
  (2, 5, 'No, está perfecta. Siempre colgada en pared sin peligro de niños.',        TRUE,  '2026-05-11 09:30:00'),
  (2, 4, '¿Podría bajar a 250 euros?',                                               FALSE, '2026-05-11 09:45:00'),
  (3, 6, 'Hola, ¿la pantalla ha sufrido quemados o tiene efecto fantasma?',          TRUE,  '2026-05-12 15:00:00'),
  (3, 5, 'No, nunca. Es un panel Mini LED, no sufre de retenciones térmicas.',       TRUE,  '2026-05-12 15:30:00'),
  (3, 6, '¿Conservas la caja original para transportarla?',                          TRUE,  '2026-05-12 16:00:00'),
  (3, 5, 'Sí, tengo la caja gigante, la factura y los dos mandos.',                  FALSE, '2026-05-12 16:15:00'),
  (4, 3, '¿Funcionan bien todos los LEDs traseros del sistema Ambilight?',           FALSE, '2026-05-13 08:00:00'),
  (5, 5, '¿Tiene puerto HDMI 2.1 para conectar la PlayStation 5 a 120Hz?',          TRUE,  '2026-05-14 06:00:00'),
  (5, 3, 'Sí, tiene 2 puertos HDMI 2.1 con soporte 4K a 120Hz.',                    FALSE, '2026-05-14 06:20:00'),
  (6, 9, 'Hola, ¿el panel tiene problemas de fugas de luz en las esquinas?',         TRUE,  '2026-05-19 13:00:00'),
  (6, 4, 'Mínimo, lo habitual en paneles LED básicos, imperceptible con luz.',       TRUE,  '2026-05-19 13:30:00'),
  (6, 9, '¿La dejarías en 580 euros?',                                               FALSE, '2026-05-19 14:00:00'),
  (7, 7, 'Hola, ¿la televisión tiene algún píxel muerto o vago?',                   TRUE,  '2026-05-17 10:00:00'),
  (7, 8, 'Ninguno. Pasé un test de colores antes de empaquetarla.',                  FALSE, '2026-05-17 10:30:00'),
  (8, 3, '¿Cuántos metros mide la caja de largo? Para ver si cabe en mi coche.',    TRUE,  '2026-05-20 09:00:00'),
  (8, 5, 'Mide casi 2 metros. Hace falta furgoneta para transportarla.',             FALSE, '2026-05-20 09:30:00');

-- ------------------------------------------------------------
-- REPORTS
-- ------------------------------------------------------------
INSERT INTO reports (item_id, reporter_id, moderator_id, reason, status, moderator_note, created_at, resolved_at) VALUES
  (13, 3, NULL, 'Intento de fraude. El vendedor pide el pago fuera de la plataforma mediante Bizum.',          'pending',          NULL,                                                                                                   '2026-05-18 10:00:00', NULL),
  (9,  5, NULL, 'Anuncio engañoso. Las fotos muestran una pantalla con el cristal líquido dañado.',            'pending',          NULL,                                                                                                   '2026-05-20 08:00:00', NULL),
  (14, 7, NULL, 'Precio falsificado. Indica 1100€ en el título pero en la descripción exige 1800€.',           'pending',          NULL,                                                                                                   '2026-05-21 07:30:00', NULL),
  (1,  5, 2,   'El artículo recibido no coincide. Es un modelo más antiguo sin Smart TV.',                     'resolved_removed', 'Verificado: el modelo publicado falsificaba el número de serie. Artículo eliminado.',                  '2026-05-15 06:00:00', '2026-05-16 08:30:00'),
  (12, 4, 2,   'Sospecho que las imágenes son robadas de internet y no corresponden al producto.',             'resolved_active',  'Revisión completada. El vendedor aportó fotos adicionales con papel firmado. Artículo legítimo.',      '2026-05-12 12:00:00', '2026-05-13 07:00:00'),
  (6,  9, 2,   'El precio es sospechosamente bajo para una LG NanoCell en ese estado.',                       'resolved_active',  'Precio competitivo pero razonable dado el desgaste visible en la carcasa trasera. Sin acciones.',      '2026-05-17 14:00:00', '2026-05-18 07:00:00');

-- ------------------------------------------------------------
-- FAVORITES
-- ------------------------------------------------------------
INSERT INTO favorites (user_id, item_id) VALUES
  (3, 1), (9, 1),
  (7, 2),
  (4, 5), (5, 6),
  (8, 6),
  (3, 9), (9, 9),
  (3, 10),
  (6, 12), (8, 12),
  (5, 13), (7, 13),
  (4, 14),
  (4, 15);

-- ------------------------------------------------------------
-- VALUATIONS
-- ------------------------------------------------------------
INSERT INTO valuations (reviewer_id, reviewed_id, item_id, score, comment) VALUES
  (4, 3, 1,  5, 'Televisión compacta tal como se describía. Vendedora muy atenta y puntual en el punto de encuentro.'),
  (3, 5, 13, 4, 'El pantallón de 75 pulgadas llegó con su embalaje original. Funciona perfecto y gran trato.'),
  (5, 4, 2,  5, 'La Samsung de 32" estaba impecable para la cocina. Transacción transparente.'),
  (6, 5, 5,  3, 'La televisión de 65" tenía un pequeño arañazo en el marco que omitió en la descripción.'),
  (4, 6, 12, 5, 'Panel OLED en perfecto estado, sin quemados. Pablo fue muy amable y me ayudó a cargarla.'),
  (7, 8, 6,  4, 'La LG de 50" venía muy bien protegida. Calidad de imagen perfecta, sin píxeles defectuosos.'),
  (9, 4, 2,  5, 'Todo perfecto. El televisor está nuevo y Miguel contestó a todas mis dudas técnicas al instante.');
