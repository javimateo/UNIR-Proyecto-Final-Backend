-- ============================================================
--  Datos de prueba – Proyecto_Final_UNIR (tecnología)
-- ============================================================

USE Proyecto_Final_UNIR;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE valuations;
TRUNCATE TABLE reports;
TRUNCATE TABLE favorites;
TRUNCATE TABLE messages;
TRUNCATE TABLE conversations;
TRUNCATE TABLE item_photos;
TRUNCATE TABLE items;
TRUNCATE TABLE users;
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- USERS
-- Contraseña real de todos: "Password1!"
-- Hash bcrypt generado con rounds=10 (válido para bcrypt.compare)
-- ============================================================
INSERT INTO users (id, username, email, password_hash, avatar_url, role, status) VALUES
  (1, 'admin_laura',   'laura.admin@example.com',  '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://i.pravatar.cc/150?u=1',  'admin',     'active'),
  (2, 'mod_carlos',    'carlos.mod@example.com',   '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://i.pravatar.cc/150?u=2',  'moderator', 'active'),
  (3, 'user_sofia',    'sofia@example.com',        '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://i.pravatar.cc/150?u=3',  'user',      'active'),
  (4, 'user_miguel',   'miguel@example.com',       '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://i.pravatar.cc/150?u=4',  'user',      'active'),
  (5, 'user_elena',    'elena@example.com',        '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://i.pravatar.cc/150?u=5',  'user',      'active'),
  (6, 'user_pablo',    'pablo@example.com',        '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://i.pravatar.cc/150?u=6',  'user',      'active'),
  (7, 'user_ana',      'ana@example.com',          '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://i.pravatar.cc/150?u=7',  'user',      'active'),
  (8, 'user_jorge',    'jorge@example.com',        '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://i.pravatar.cc/150?u=8',  'user',      'active'),
  (9, 'user_marta',    'marta@example.com',        '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://i.pravatar.cc/150?u=9',  'user',      'active'),
  (10,'user_blocked',  'blocked@example.com',      '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL,                             'user',      'blocked');

-- ============================================================
-- ITEMS
-- category IDs (de BBDD.sql):
--   1=Portátiles raíz  10=Port.gaming  11=Port.ultrabook  12=Port.workstation
--   2=Sobremesa raíz   13=PCs completos  14=Procesadores  15=GPUs  16=Placas base  17=RAM
--                      18=Fuentes  19=Cajas  20=Refrigeración
--   3=Monitores
--   4=Almacenamiento raíz  21=SSD  22=HDD  23=Discos externos  24=USB/tarjetas
--   5=Periféricos raíz     25=Teclados  26=Ratones  27=Auriculares  28=Webcams  29=Impresoras
--   6=Smartphones raíz     30=Smartphones  31=Tablets  32=Accesorios móvil
-- brand IDs: 1=Apple 2=Samsung 3=ASUS 4=MSI 5=Lenovo 6=HP 7=Dell
--            8=Intel 9=AMD 10=NVIDIA 11=Corsair 12=Kingston 13=Seagate
--            14=WD 15=LG 16=Sony 17=Logitech 18=Razer
-- ============================================================
INSERT INTO items (id, user_id, category_id, brand_id, title, model, description, specs, price, item_condition, status) VALUES

  -- ── PORTÁTILES GAMING ──────────────────────────────────────
  (1,  3, 10, 4,  'MSI Raider GE76',               'GE76 12UHS',
   'Portátil gaming de alto rendimiento. Pantalla 17.3" 360Hz. Estado impecable.',
   '{"cpu":"Intel Core i9-12900H","ram":"32GB DDR5","storage":"1TB NVMe SSD","gpu":"RTX 3080 Ti 16GB","pantalla":"17.3 360Hz FHD","os":"Windows 11"}',
   1350.00, 'like_new', 'published'),

  (2,  4, 10, 3,  'ASUS ROG Strix G15',             'G513QM-HF113',
   'Ryzen 9 + RTX 3060. Muy buen estado, solo marcas mínimas en la carcasa.',
   '{"cpu":"AMD Ryzen 9 5900HX","ram":"16GB DDR4","storage":"512GB NVMe SSD","gpu":"RTX 3060 6GB","pantalla":"15.6 144Hz FHD","os":"Windows 11"}',
   850.00, 'good', 'published'),

  (3,  7, 10, 4,  'MSI Katana GF76',                'GF76 12UC',
   'Gaming de gama media, buen rendimiento para el precio. Teclado retroiluminado.',
   '{"cpu":"Intel Core i7-12650H","ram":"16GB DDR4","storage":"512GB NVMe SSD","gpu":"RTX 3050 Ti 4GB","pantalla":"17.3 144Hz FHD","os":"Windows 11"}',
   650.00, 'good', 'published'),

  (4,  8, 10, 6,  'HP OMEN 16',                     'OMEN 16-b1005ns',
   'Un año de uso. Excelente pantalla QHD. Incluye mochila HP.',
   '{"cpu":"Intel Core i7-12700H","ram":"16GB DDR5","storage":"1TB NVMe SSD","gpu":"RTX 3070 Ti 8GB","pantalla":"16 165Hz QHD","os":"Windows 11"}',
   900.00, 'like_new', 'published'),

  -- ── PORTÁTILES ULTRABOOK ───────────────────────────────────
  (5,  5, 11, 1,  'Apple MacBook Air M2',            'MLXW3Y/A',
   'Chip M2, color Midnight. Batería al 95%. Con caja y cargador MagSafe.',
   '{"cpu":"Apple M2 8 núcleos","ram":"8GB unificada","storage":"256GB SSD","pantalla":"13.6 Liquid Retina","os":"macOS Ventura"}',
   950.00, 'like_new', 'published'),

  (6,  6, 11, 5,  'Lenovo ThinkPad X1 Carbon Gen 11','X1C Gen11',
   'Ultrabook empresarial, teclado retroiluminado, huella dactilar. Poco uso.',
   '{"cpu":"Intel Core i7-1365U","ram":"16GB LPDDR5","storage":"512GB SSD","pantalla":"14 IPS 2.8K OLED","os":"Windows 11 Pro"}',
   1100.00, 'like_new', 'published'),

  (7,  9, 11, 7,  'Dell XPS 13 Plus',                '9320',
   'Diseño premium, pantalla OLED 13.4". Batería nueva.',
   '{"cpu":"Intel Core i7-1260P","ram":"16GB LPDDR5","storage":"512GB NVMe SSD","pantalla":"13.4 OLED 3.5K","os":"Windows 11"}',
   1050.00, 'good', 'published'),

  -- ── PORTÁTIL EN BORRADOR (no debe aparecer en listados públicos) ──
  (8,  3, 11, 1,  'MacBook Pro M3 (borrador)',        'MBP M3 14',
   'Pendiente de revisar antes de publicar.',
   '{"cpu":"Apple M3 Pro","ram":"18GB","storage":"512GB SSD","pantalla":"14.2 Liquid Retina XDR","os":"macOS Sonoma"}',
   1800.00, 'like_new', 'draft'),

  -- ── PROCESADORES ──────────────────────────────────────────
  (9,  3, 14, 8,  'Intel Core i9-13900K',             'BX8071513900K',
   'Procesador sin uso, desellado solo para comprobar pines. Socket LGA1700.',
   '{"nucleos":"24 (8P+16E)","frecuencia_base":"3.0 GHz","frecuencia_boost":"5.8 GHz","socket":"LGA1700","tdp":"125W"}',
   380.00, 'new', 'published'),

  (10, 4, 14, 9,  'AMD Ryzen 9 7950X',                '100-100000514WOF',
   'Usado 8 meses en build de workstation. Incluye disipador Noctua NH-D15.',
   '{"nucleos":"16","frecuencia_base":"4.5 GHz","frecuencia_boost":"5.7 GHz","socket":"AM5","tdp":"170W"}',
   480.00, 'good', 'published'),

  (11, 7, 14, 8,  'Intel Core i5-13600K',             'BX8071513600K',
   'Excelente relación calidad-precio. Socket LGA1700. Con pasta térmica nueva.',
   '{"nucleos":"14 (6P+8E)","frecuencia_base":"3.5 GHz","frecuencia_boost":"5.1 GHz","socket":"LGA1700","tdp":"125W"}',
   220.00, 'good', 'published'),

  (12, 8, 14, 9,  'AMD Ryzen 5 7600X',                '100-100000593WOF',
   'Ideal para gaming, muy eficiente. Sin uso, caja abierta para revisar.',
   '{"nucleos":"6","frecuencia_base":"4.7 GHz","frecuencia_boost":"5.3 GHz","socket":"AM5","tdp":"105W"}',
   180.00, 'new', 'published'),

  -- ── TARJETAS GRÁFICAS ────────────────────────────────────
  (13, 5, 15, 10, 'NVIDIA RTX 4080 ASUS ROG Strix',  'ROG-STRIX-RTX4080-O16G',
   'Comprada hace 6 meses. Sin minería. Funciona perfectamente.',
   '{"vram":"16GB GDDR6X","bus":"256-bit","tdp":"320W","conectores":"3x DP 1.4a, 1x HDMI 2.1"}',
   850.00, 'like_new', 'published'),

  (14, 6, 15, 4,  'MSI RTX 3070 Gaming X Trio',      'RTX 3070 GAMING X TRIO',
   'Tarjeta en buen estado. Drivers actualizados. Sin problemas de artefactos.',
   '{"vram":"8GB GDDR6","bus":"256-bit","tdp":"220W","conectores":"3x DP 1.4, 1x HDMI 2.1"}',
   380.00, 'good', 'published'),

  (15, 9, 15, 3,  'ASUS TUF Gaming RTX 4070',        'TUF-RTX4070-O12G',
   'Solo 3 meses de uso. Refrigeración excelente, muy silenciosa.',
   '{"vram":"12GB GDDR6X","bus":"192-bit","tdp":"200W","conectores":"3x DP 1.4a, 1x HDMI 2.1"}',
   580.00, 'like_new', 'published'),

  (16, 7, 15, 10, 'NVIDIA RTX 3060 Founders Edition','RTX 3060 FE',
   'Tarjeta de referencia NVIDIA. Sin minería, solo gaming casual.',
   '{"vram":"12GB GDDR6","bus":"192-bit","tdp":"170W","conectores":"3x DP 1.4, 1x HDMI 2.1"}',
   270.00, 'good', 'published'),

  -- ── MEMORIAS RAM ─────────────────────────────────────────
  (17, 3, 17, 11, 'Corsair Vengeance DDR5 32GB Kit', 'CMK32GX5M2B5600C36',
   'Kit 2x16GB DDR5-5600. Solo usado en un build de pruebas durante 2 semanas.',
   '{"capacidad":"32GB (2x16GB)","tipo":"DDR5","velocidad":"5600 MHz","latencia":"CL36","voltaje":"1.25V"}',
   110.00, 'like_new', 'published'),

  (18, 4, 17, 12, 'Kingston Fury Beast DDR4 16GB',   'KF432C16BBK2/16',
   'Kit 2x8GB DDR4-3200. Compatible con Intel y AMD. Perfil XMP activado.',
   '{"capacidad":"16GB (2x8GB)","tipo":"DDR4","velocidad":"3200 MHz","latencia":"CL16","voltaje":"1.35V"}',
   45.00, 'good', 'published'),

  -- ── MONITORES ────────────────────────────────────────────
  (19, 4, 3,  15, 'LG UltraWide 34WP65G-B',         '34WP65G-B',
   'Monitor 34" curvo. Panel IPS, 75Hz. Sin píxeles muertos.',
   '{"resolucion":"3440x1440 UWQHD","panel":"IPS","frecuencia":"75Hz","tiempo_respuesta":"5ms","hdr":"HDR10"}',
   320.00, 'good', 'published'),

  (20, 5, 3,  3,  'ASUS ProArt PA279CV',             'PA279CV',
   'Monitor profesional 4K calibrado de fábrica. DeltaE < 2. Poco uso.',
   '{"resolucion":"3840x2160 4K","panel":"IPS","frecuencia":"60Hz","tiempo_respuesta":"5ms","hdr":"DisplayHDR 400"}',
   450.00, 'like_new', 'published'),

  (21, 8, 3,  2,  'Samsung Odyssey G7 32"',          'LC32G75TQSRXEN',
   'Panel VA curvo 1000R. 240Hz. Ideal para gaming competitivo.',
   '{"resolucion":"2560x1440 QHD","panel":"VA Curvo","frecuencia":"240Hz","tiempo_respuesta":"1ms","hdr":"HDR600"}',
   420.00, 'good', 'published'),

  (22, 9, 3,  15, 'LG UltraGear 27GP850-B',         '27GP850-B',
   'Panel Nano IPS, 165Hz, compatible G-Sync y FreeSync.',
   '{"resolucion":"2560x1440 QHD","panel":"Nano IPS","frecuencia":"165Hz","tiempo_respuesta":"1ms","hdr":"HDR400"}',
   280.00, 'like_new', 'published'),

  -- ── SSD ──────────────────────────────────────────────────
  (23, 6, 21, 12, 'Kingston NV2 2TB NVMe',           'SNV2S/2000G',
   'SSD sin usar, en blíster original. M.2 2280 PCIe 4.0.',
   '{"capacidad":"2TB","interfaz":"NVMe PCIe 4.0 x4","lectura":"3500 MB/s","escritura":"2800 MB/s","formato":"M.2 2280"}',
   90.00, 'new', 'published'),

  (24, 7, 23, 16, 'Sony 1TB SSD Externo',            'SL-E1T',
   'SSD externo compacto. USB 3.2 Gen2. Incluye cable USB-C.',
   '{"capacidad":"1TB","interfaz":"USB 3.2 Gen2","lectura":"1050 MB/s","escritura":"1000 MB/s","formato":"Externo"}',
   70.00, 'like_new', 'published'),

  (25, 3, 22, 13, 'Seagate Barracuda 4TB',           'ST4000DM004',
   'HDD 3.5" para almacenamiento masivo. 7200 RPM. Sin sectores defectuosos.',
   '{"capacidad":"4TB","rpm":"7200","interfaz":"SATA III","formato":"3.5 pulgadas","cache":"256MB"}',
   55.00, 'good', 'published'),

  -- ── PERIFÉRICOS: TECLADOS ────────────────────────────────
  (26, 3, 25, 18, 'Razer BlackWidow V3 Pro',         'RZ03-03531600-R3M1',
   'Teclado mecánico inalámbrico. Switches Green. RGB funcionando.',
   '{"switches":"Razer Green Clicky","conexion":"Bluetooth / USB","retroiluminacion":"Chroma RGB","layout":"ES"}',
   100.00, 'good', 'published'),

  (27, 9, 25, 17, 'Logitech G915 TKL',               'G915 TKL',
   'Teclado inalámbrico de bajo perfil. Switches GL Tactile. Sin numpad.',
   '{"switches":"GL Tactile","conexion":"LIGHTSPEED / Bluetooth / USB","retroiluminacion":"RGB","layout":"ES","formato":"TKL"}',
   130.00, 'like_new', 'published'),

  -- ── PERIFÉRICOS: RATONES ─────────────────────────────────
  (28, 4, 26, 17, 'Logitech G Pro X Superlight 2',  'G Pro X Superlight 2',
   'Ratón ultraligero gaming. 63g. Sensor HERO 2. Con todos los accesorios.',
   '{"peso":"63g","sensor":"HERO 2 25600 DPI","conexion":"LIGHTSPEED inalámbrico","botones":"5"}',
   110.00, 'like_new', 'published'),

  (29, 8, 26, 18, 'Razer DeathAdder V3 HyperSpeed',  'DeathAdder V3 HS',
   'Ratón inalámbrico ergonómico. 64g. Ideal para palma grande.',
   '{"peso":"64g","sensor":"Razer Focus X 26000 DPI","conexion":"HyperSpeed inalámbrico","botones":"6"}',
   65.00, 'good', 'published'),

  -- ── PERIFÉRICOS: AURICULARES ─────────────────────────────
  (30, 5, 27, 16, 'Sony WH-1000XM5',                 'WH1000XM5/B',
   'Cancelación de ruido líder del mercado. Se venden por cambio de modelo.',
   '{"tipo":"Over-ear","anc":"Si","conexion":"Bluetooth 5.2 / jack 3.5mm","bateria":"30h","codec":"LDAC, AAC, SBC"}',
   220.00, 'like_new', 'published'),

  (31, 7, 27, 18, 'Razer BlackShark V2 Pro',         'BlackShark V2 Pro',
   'Auriculares gaming inalámbricos. THX Spatial Audio. Micrófono desmontable.',
   '{"tipo":"Over-ear","conexion":"HyperSpeed inalámbrico / USB","bateria":"70h","frecuencia":"12Hz-28kHz"}',
   120.00, 'good', 'published'),

  -- ── SMARTPHONES ──────────────────────────────────────────
  (32, 6, 30, 1,  'Apple iPhone 15 Pro 256GB',       'A3104',
   'Color titanio natural. Batería al 97%. Con funda y cristal templado.',
   '{"almacenamiento":"256GB","color":"Titanio natural","pantalla":"6.1 Super Retina XDR","chip":"A17 Pro","camara":"48MP Triple"}',
   900.00, 'like_new', 'published'),

  (33, 3, 30, 2,  'Samsung Galaxy S24 Ultra',        'SM-S928B',
   'Color negro titanio. Incluye S-Pen. Estado perfecto.',
   '{"almacenamiento":"256GB","color":"Negro titanio","pantalla":"6.8 Dynamic AMOLED 2X 120Hz","chip":"Snapdragon 8 Gen 3","camara":"200MP Quad"}',
   950.00, 'like_new', 'published'),

  (34, 9, 30, 1,  'Apple iPhone 14 128GB',           'MPVF3QL/A',
   'Color negro medianoche. Batería al 89%. Sin accesorios, solo cable.',
   '{"almacenamiento":"128GB","color":"Negro medianoche","pantalla":"6.1 Super Retina XDR","chip":"A15 Bionic","camara":"12MP Dual"}',
   550.00, 'good', 'published'),

  (35, 7, 31, 5,  'Lenovo Tab P12 Pro',              'TB-Q706F',
   'Tablet AMOLED 12.6". Incluye teclado y stylus. Como nueva.',
   '{"almacenamiento":"256GB","pantalla":"12.6 AMOLED 2K","chip":"Snapdragon 870","ram":"8GB","bateria":"10200mAh"}',
   480.00, 'like_new', 'published'),

  -- ── ARTÍCULO VENDIDO ─────────────────────────────────────
  (36, 4, 17, 11, 'Corsair DDR4 16GB (VENDIDO)',     'CMK16GX4M2B3200C16',
   'Kit vendido. Ya no disponible.',
   '{"capacidad":"16GB (2x8GB)","tipo":"DDR4","velocidad":"3200 MHz","latencia":"CL16"}',
   40.00, 'good', 'sold'),

  -- ── ARTÍCULOS PARA FLUJO DE MODERACIÓN ───────────────────
  (37, 6, 30, 1,  'iPhone robado (TEST)',             NULL,
   'Artículo de prueba para flujo de moderación — bajo revisión.',
   NULL, 1.00, 'poor', 'under_review'),

  (38, 4, 15, 10, 'GPU minada (TEST)',                NULL,
   'Artículo de prueba eliminado por moderación.',
   NULL, 1.00, 'poor', 'removed'),

  (39, 8, 14, 8,  'CPU dudosa (TEST)',                NULL,
   'Segundo artículo de prueba bajo revision moderacion.',
   NULL, 1.00, 'poor', 'under_review');

-- ============================================================
-- ITEM PHOTOS
-- ============================================================
INSERT INTO item_photos (item_id, url, sort_order) VALUES
  (1,  'https://picsum.photos/seed/msi_ge76_a/600/400',    0),
  (1,  'https://picsum.photos/seed/msi_ge76_b/600/400',    1),
  (2,  'https://picsum.photos/seed/asus_rog_a/600/400',    0),
  (3,  'https://picsum.photos/seed/msi_katana/600/400',    0),
  (4,  'https://picsum.photos/seed/hp_omen/600/400',       0),
  (5,  'https://picsum.photos/seed/macbook_m2_a/600/400',  0),
  (5,  'https://picsum.photos/seed/macbook_m2_b/600/400',  1),
  (6,  'https://picsum.photos/seed/thinkpad_x1/600/400',   0),
  (7,  'https://picsum.photos/seed/dell_xps13/600/400',    0),
  (9,  'https://picsum.photos/seed/i9_13900k/600/400',     0),
  (10, 'https://picsum.photos/seed/ryzen_7950x/600/400',   0),
  (11, 'https://picsum.photos/seed/i5_13600k/600/400',     0),
  (12, 'https://picsum.photos/seed/ryzen_7600x/600/400',   0),
  (13, 'https://picsum.photos/seed/rtx4080_a/600/400',     0),
  (13, 'https://picsum.photos/seed/rtx4080_b/600/400',     1),
  (14, 'https://picsum.photos/seed/rtx3070/600/400',       0),
  (15, 'https://picsum.photos/seed/rtx4070_a/600/400',     0),
  (15, 'https://picsum.photos/seed/rtx4070_b/600/400',     1),
  (16, 'https://picsum.photos/seed/rtx3060/600/400',       0),
  (17, 'https://picsum.photos/seed/corsair_ddr5/600/400',  0),
  (18, 'https://picsum.photos/seed/kingston_ddr4/600/400', 0),
  (19, 'https://picsum.photos/seed/lg_ultrawide/600/400',  0),
  (20, 'https://picsum.photos/seed/asus_proart/600/400',   0),
  (21, 'https://picsum.photos/seed/samsung_g7/600/400',    0),
  (22, 'https://picsum.photos/seed/lg_ultragear/600/400',  0),
  (23, 'https://picsum.photos/seed/kingston_nv2/600/400',  0),
  (24, 'https://picsum.photos/seed/sony_ssd/600/400',      0),
  (25, 'https://picsum.photos/seed/seagate_4tb/600/400',   0),
  (26, 'https://picsum.photos/seed/razer_bw_v3/600/400',   0),
  (27, 'https://picsum.photos/seed/logi_g915/600/400',     0),
  (28, 'https://picsum.photos/seed/logi_gpx2/600/400',     0),
  (29, 'https://picsum.photos/seed/razer_da_v3/600/400',   0),
  (30, 'https://picsum.photos/seed/sony_wh1000/600/400',   0),
  (31, 'https://picsum.photos/seed/razer_bs_v2/600/400',   0),
  (32, 'https://picsum.photos/seed/iphone15pro_a/600/400', 0),
  (32, 'https://picsum.photos/seed/iphone15pro_b/600/400', 1),
  (33, 'https://picsum.photos/seed/s24ultra_a/600/400',    0),
  (33, 'https://picsum.photos/seed/s24ultra_b/600/400',    1),
  (34, 'https://picsum.photos/seed/iphone14/600/400',      0),
  (35, 'https://picsum.photos/seed/lenovo_tab/600/400',    0);

-- ============================================================
-- CONVERSATIONS
-- ============================================================
INSERT INTO conversations (id, item_id, buyer_id, seller_id) VALUES
  (1,  1,  4, 3),   -- Miguel  → Sofia  (MSI Raider)
  (2,  5,  4, 5),   -- Miguel  → Elena  (MacBook M2)
  (3,  13, 6, 5),   -- Pablo   → Elena  (RTX 4080)
  (4,  30, 3, 5),   -- Sofia   → Elena  (Sony WH-1000XM5)
  (5,  32, 4, 6),   -- Miguel  → Pablo  (iPhone 15 Pro)
  (6,  14, 3, 6),   -- Sofia   → Pablo  (RTX 3070)
  (7,  9,  5, 3),   -- Elena   → Sofia  (Intel i9-13900K)
  (8,  19, 7, 4),   -- Ana     → Miguel (Monitor LG)
  (9,  33, 8, 3),   -- Jorge   → Sofia  (Galaxy S24 Ultra)
  (10, 2,  9, 4),   -- Marta   → Miguel (ASUS ROG G15)
  (11, 15, 3, 9),   -- Sofia   → Marta  (RTX 4070)
  (12, 22, 6, 9);   -- Pablo   → Marta  (LG UltraGear)

-- ============================================================
-- MESSAGES
-- ============================================================
INSERT INTO messages (conversation_id, sender_id, content, is_read, sent_at) VALUES
  -- Conv 1: Miguel ↔ Sofia (MSI Raider)
  (1, 4, '¡Hola! ¿Sigue disponible el MSI Raider?',                              TRUE,  '2026-05-10 09:00:00'),
  (1, 3, 'Sí, disponible. ¿Tienes alguna duda?',                                  TRUE,  '2026-05-10 09:15:00'),
  (1, 4, '¿Cuántas horas de batería tiene en uso normal?',                         TRUE,  '2026-05-10 09:20:00'),
  (1, 3, 'Unas 2-3 horas, es un gaming al fin y al cabo.',                         TRUE,  '2026-05-10 10:00:00'),
  (1, 4, 'Entendido. ¿Harías un poco de descuento si recojo en mano?',             FALSE, '2026-05-10 10:30:00'),

  -- Conv 2: Miguel ↔ Elena (MacBook M2)
  (2, 4, 'Buenas, ¿tiene algún arañazo en la pantalla?',                           TRUE,  '2026-05-11 11:00:00'),
  (2, 5, 'No, está perfecto. Siempre con protector.',                              TRUE,  '2026-05-11 11:30:00'),
  (2, 4, 'Genial. ¿Podría bajar a 900 euros?',                                    FALSE, '2026-05-11 11:45:00'),

  -- Conv 3: Pablo ↔ Elena (RTX 4080)
  (3, 6, 'Hola, ¿la tarjeta ha sido usada para minería?',                          TRUE,  '2026-05-12 17:00:00'),
  (3, 5, 'No, nunca. Solo gaming y edición de vídeo.',                             TRUE,  '2026-05-12 17:30:00'),
  (3, 6, 'Perfecto. ¿Tienes la caja original?',                                   TRUE,  '2026-05-12 18:00:00'),
  (3, 5, 'Sí, tengo caja, factura y todos los accesorios.',                        FALSE, '2026-05-12 18:15:00'),

  -- Conv 4: Sofia ↔ Elena (Sony WH-1000XM5) — sin respuesta
  (4, 3, '¿Funcionan bien los micrófonos para llamadas?',                          FALSE, '2026-05-13 10:00:00'),

  -- Conv 5: Miguel ↔ Pablo (iPhone 15 Pro)
  (5, 4, '¿Viene desbloqueado de operador?',                                       TRUE,  '2026-05-14 08:00:00'),
  (5, 6, 'Sí, completamente libre. Cualquier operador.',                           TRUE,  '2026-05-14 08:20:00'),
  (5, 4, '¿Lo tienes con Apple Care?',                                             FALSE, '2026-05-14 09:00:00'),

  -- Conv 6: Sofia ↔ Pablo (RTX 3070)
  (6, 3, '¿Cuántas horas de uso tiene la gráfica aproximadamente?',                TRUE,  '2026-05-15 19:00:00'),
  (6, 6, 'Difícil saberlo, pero calculo que unas 1500h. Nunca minería.',           FALSE, '2026-05-15 19:30:00'),

  -- Conv 7: Elena ↔ Sofia (Intel i9-13900K)
  (7, 5, '¿Tienes la caja original del procesador?',                               TRUE,  '2026-05-16 10:00:00'),
  (7, 3, 'Sí, caja y todos los accesorios incluidos.',                             TRUE,  '2026-05-16 10:20:00'),
  (7, 5, 'Perfecto. ¿Puedes enviar a Valencia?',                                   FALSE, '2026-05-16 11:00:00'),

  -- Conv 8: Ana ↔ Miguel (Monitor LG)
  (8, 7, 'Hola, ¿el monitor tiene píxeles muertos?',                               TRUE,  '2026-05-17 12:00:00'),
  (8, 4, 'Ninguno. Lo comprobé antes de publicar.',                                FALSE, '2026-05-17 12:30:00'),

  -- Conv 9: Jorge ↔ Sofia (Galaxy S24 Ultra)
  (9, 8, '¿Incluye el S-Pen original?',                                            FALSE, '2026-05-18 09:00:00'),

  -- Conv 10: Marta ↔ Miguel (ASUS ROG G15)
  (10, 9, 'Hola, ¿la pantalla tiene algún problema de backlight bleeding?',        TRUE,  '2026-05-19 15:00:00'),
  (10, 4, 'Mínimo, imperceptible en uso normal.',                                  TRUE,  '2026-05-19 15:30:00'),
  (10, 9, '¿Harías 800 euros?',                                                    FALSE, '2026-05-19 16:00:00'),

  -- Conv 11: Sofia ↔ Marta (RTX 4070)
  (11, 3, '¿Tienes temperatura máxima bajo carga?',                                FALSE, '2026-05-20 11:00:00'),

  -- Conv 12: Pablo ↔ Marta (LG UltraGear)
  (12, 6, 'Hola, ¿el monitor tiene entrada HDMI 2.1?',                             TRUE,  '2026-05-20 14:00:00'),
  (12, 9, 'Tiene HDMI 2.0 y DisplayPort 1.4.',                                    FALSE, '2026-05-20 14:15:00');

-- ============================================================
-- FAVORITES
-- ============================================================
INSERT INTO favorites (user_id, item_id) VALUES
  (4, 5),   -- Miguel  → MacBook M2
  (5, 13),  -- Elena   → RTX 4080
  (3, 1),   -- Sofia   → MSI Raider
  (6, 32),  -- Pablo   → iPhone 15 Pro
  (3, 30),  -- Sofia   → Sony WH-1000XM5
  (4, 33),  -- Miguel  → Galaxy S24 Ultra
  (5, 19),  -- Elena   → Monitor LG UltraWide
  (7, 2),   -- Ana     → ASUS ROG G15
  (7, 13),  -- Ana     → RTX 4080
  (8, 32),  -- Jorge   → iPhone 15 Pro
  (8, 6),   -- Jorge   → ThinkPad X1
  (9, 15),  -- Marta   → RTX 4070
  (9, 1),   -- Marta   → MSI Raider
  (3, 9),   -- Sofia   → Intel i9-13900K
  (4, 20);  -- Miguel  → ASUS ProArt

-- ============================================================
-- REPORTS
-- ============================================================
INSERT INTO reports (item_id, reporter_id, moderator_id, reason, status, moderator_note, created_at, resolved_at) VALUES
  -- Pendientes (para probar panel de moderación)
  (37, 3, NULL,
   'Creo que el IMEI está en lista negra. El dispositivo puede ser robado.',
   'pending', NULL, '2026-05-18 12:00:00', NULL),

  (39, 5, NULL,
   'El procesador parece estar dañado. Las fotos muestran pines doblados.',
   'pending', NULL, '2026-05-20 10:00:00', NULL),

  (33, 7, NULL,
   'El vendedor no responde y el precio parece demasiado bajo para ser real.',
   'pending', NULL, '2026-05-21 09:30:00', NULL),

  -- Resueltos (para probar historial de moderación)
  (38, 5, 2,
   'La GPU ha sido minada. Las fotos muestran señales claras de desgaste térmico.',
   'resolved_removed', 'Verificado: artefactos visuales confirmados. Artículo eliminado.', '2026-05-15 08:00:00', '2026-05-16 10:30:00'),

  (14, 4, 2,
   'Sospecho que la RTX 3070 ha sido minada.',
   'resolved_active', 'Revisión completada. El artículo es legítimo, sin evidencias de minería.', '2026-05-12 14:00:00', '2026-05-13 09:00:00'),

  (16, 9, 2,
   'Precio sospechosamente bajo para una RTX 3060.',
   'resolved_active', 'Precio razonable para el estado del artículo. No se toman acciones.', '2026-05-17 16:00:00', '2026-05-18 09:00:00');

-- ============================================================
-- VALUATIONS
-- ============================================================
INSERT INTO valuations (reviewer_id, reviewed_id, item_id, score, comment) VALUES
  (4, 3, 1,  5, 'Portátil tal como se describía. Vendedora muy atenta y envío rápido.'),
  (3, 5, 13, 4, 'La RTX llegó bien embalada. Funciona perfectamente, trato excelente.'),
  (5, 4, 2,  5, 'El ASUS ROG estaba impecable. Transacción perfecta.'),
  (6, 5, 30, 3, 'Los auriculares tenían un pequeño roce que no aparecía en las fotos.'),
  (4, 6, 32, 5, 'iPhone en perfecto estado. Pablo muy amable y puntual.'),
  (7, 4, 19, 4, 'Monitor llegó muy bien embalado. Imagen perfecta, sin píxeles muertos.'),
  (9, 4, 2,  5, 'ASUS ROG en perfecto estado. Miguel responde muy rápido.');
