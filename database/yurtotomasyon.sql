-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 09 Haz 2025, 03:22:48
-- Sunucu sürümü: 10.4.32-MariaDB
-- PHP Sürümü: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `yurtotomasyon`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bildirimler`
--

CREATE TABLE `bildirimler` (
  `id` int(11) NOT NULL,
  `ogrenci_id` int(11) DEFAULT NULL,
  `mesaj` text DEFAULT NULL,
  `tarih` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `bildirimler`
--

INSERT INTO `bildirimler` (`id`, `ogrenci_id`, `mesaj`, `tarih`) VALUES
(1, 44, 'Oda değişim talebiniz onaylandı! Yeni oda numaranız: 20', '2025-05-28 21:38:32'),
(2, 46, 'Oda değişim talebiniz onaylandı! Yeni oda numaranız: 1', '2025-05-28 21:40:28'),
(3, 46, 'Oda değişim talebiniz reddedildi! Sebep: sanane', '2025-05-28 21:41:57'),
(4, 46, 'İzin talebiniz reddedildi! Sebep: sanane', '2025-05-28 21:53:57'),
(5, 46, 'İzin talebiniz onaylandı! Tarihler: 2025-05-30 00:00:00 - 2025-05-31 00:00:00', '2025-05-28 21:54:14'),
(6, 46, 'İzin talebiniz onaylandı! Tarihler: 2025-05-30 00:00:00 - 2025-05-31 00:00:00', '2025-05-28 21:54:29'),
(7, 46, 'İzin talebiniz onaylandı! Tarihler: 2025-05-30 00:00:00 - 2025-05-31 00:00:00', '2025-05-28 21:54:29'),
(8, 46, 'İzin talebiniz reddedildi! Sebep: saa', '2025-05-28 21:57:00'),
(9, 46, 'İzin talebiniz onaylandı! Tarihler: 2025-05-30 00:00:00 - 2025-05-31 00:00:00', '2025-05-28 21:58:11'),
(10, 46, 'İzin talebiniz onaylandı! Tarihler: 2025-05-30 00:00:00 - 2025-05-31 00:00:00', '2025-05-28 22:11:18'),
(11, 17, 'Oda değişim talebiniz onaylandı! Yeni oda numaranız: 3', '2025-05-28 22:26:49'),
(12, 17, 'İzin talebiniz onaylandı! Tarihler: 2025-05-30 00:00:00 - 2025-05-31 00:00:00', '2025-05-28 22:30:19'),
(13, 17, 'Oda değişim talebiniz onaylandı! Yeni oda numaranız: 4', '2025-05-28 22:30:43'),
(14, 19, 'Oda değişim talebiniz onaylandı! Yeni oda numaranız: 4', '2025-05-29 17:22:41'),
(15, 17, 'Oda değişim talebiniz reddedildi! Sebep: sanane', '2025-05-29 17:25:34'),
(16, 17, 'İzin talebiniz onaylandı! Tarihler: 2025-05-30 00:00:00 - 2025-05-31 00:00:00', '2025-05-29 17:27:29');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bolumler`
--

CREATE TABLE `bolumler` (
  `bolum_id` int(11) NOT NULL,
  `bolum_adi` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `bolumler`
--

INSERT INTO `bolumler` (`bolum_id`, `bolum_adi`) VALUES
(1, 'Bilgisayar Programcılığı'),
(2, 'Elektrik'),
(3, 'İtfaiye'),
(4, 'İş Sağlığı Güvenliği'),
(5, 'Otobüs Kaptanlığı');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `duyurular`
--

CREATE TABLE `duyurular` (
  `duyuru_id` int(11) NOT NULL,
  `baslik` varchar(50) NOT NULL,
  `metin` varchar(200) NOT NULL,
  `tarih` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `duyurular`
--

INSERT INTO `duyurular` (`duyuru_id`, `baslik`, `metin`, `tarih`) VALUES
(17, 'Kayıt', 'Kayıt işlemleri yurtlarımızda belirtilen tarihlerde yapılacaktır. Lütfen başvuru tarihlerine dikkat ediniz.', '2025-05-13');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `izinler`
--

CREATE TABLE `izinler` (
  `izin_id` int(11) NOT NULL,
  `ogrenci_id` int(11) NOT NULL,
  `ogrenci_adi` varchar(100) NOT NULL,
  `izin_baslangic` datetime NOT NULL,
  `izin_bitis` datetime NOT NULL,
  `izin_sebebi` text NOT NULL,
  `talep_tarihi` datetime DEFAULT current_timestamp(),
  `durum` varchar(20) DEFAULT 'Beklemede',
  `red_sebebi` text DEFAULT NULL,
  `onay_tarihi` datetime DEFAULT NULL,
  `oda_no` int(11) NOT NULL,
  `izin_tipi` varchar(50) DEFAULT NULL,
  `yonetici_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `izinler`
--

INSERT INTO `izinler` (`izin_id`, `ogrenci_id`, `ogrenci_adi`, `izin_baslangic`, `izin_bitis`, `izin_sebebi`, `talep_tarihi`, `durum`, `red_sebebi`, `onay_tarihi`, `oda_no`, `izin_tipi`, `yonetici_id`) VALUES
(8, 17, 'kaan almacı', '2025-05-12 04:31:00', '2025-05-12 09:31:00', 'sa', '2025-05-12 02:31:23', 'Onaylandı', NULL, '2025-05-13 13:47:38', 1, NULL, NULL),
(9, 44, 'Hasan Eren Bostancıoğlu', '2025-05-13 13:56:00', '2025-05-15 13:00:00', 'gidiyom', '2025-05-13 13:57:06', 'Onaylandı', NULL, '2025-05-13 18:46:13', 16, NULL, NULL),
(10, 17, 'kaan almacı', '2025-05-13 18:44:00', '2025-05-14 18:45:00', 'Sakatlık', '2025-05-13 18:45:53', 'Onaylandı', NULL, '2025-05-13 18:46:19', 5, NULL, NULL),
(20, 46, 'merttt merttt', '2025-05-30 00:00:00', '2025-05-31 00:00:00', 'as', '2025-05-29 00:52:20', 'Onaylandı', NULL, NULL, 1, NULL, NULL),
(21, 46, 'merttt merttt', '2025-05-30 00:00:00', '2025-05-31 00:00:00', 'asma', '2025-05-29 00:52:28', 'Reddedildi', 'sanane', NULL, 1, NULL, NULL),
(22, 46, 'merttt merttt', '2025-05-30 00:00:00', '2025-05-31 00:00:00', 'as', '2025-05-29 00:56:43', 'Reddedildi', 'saa', NULL, 1, NULL, NULL),
(23, 46, 'merttt merttt', '2025-05-30 00:00:00', '2025-05-31 00:00:00', 'sa', '2025-05-29 00:58:08', 'Onaylandı', NULL, NULL, 1, NULL, NULL),
(24, 46, 'merttt merttt', '2025-05-30 00:00:00', '2025-05-31 00:00:00', 'sa', '2025-05-29 01:11:13', 'Onaylandı', NULL, NULL, 1, NULL, NULL),
(25, 17, 'kaan almacı', '2025-05-30 00:00:00', '2025-05-31 00:00:00', 'sanane', '2025-05-29 01:19:56', 'Onaylandı', NULL, NULL, 8, NULL, NULL),
(26, 17, 'kaan almacı', '2025-05-30 00:00:00', '2025-05-31 00:00:00', 'sananeae', '2025-05-29 01:21:48', 'Bekliyor', NULL, NULL, 8, NULL, NULL),
(27, 17, 'kaan almacı', '2025-05-30 00:00:00', '2025-05-31 00:00:00', 'ölüyoz', '2025-05-29 01:29:44', 'Onaylandı', NULL, NULL, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `log_talepler`
--

CREATE TABLE `log_talepler` (
  `log_id` int(11) NOT NULL,
  `talep_id` int(11) DEFAULT NULL,
  `ogrenci_id` int(11) DEFAULT NULL,
  `ogrenci_adi` varchar(255) DEFAULT NULL,
  `talep_tipi` varchar(50) DEFAULT NULL,
  `mevcut_oda_no` varchar(10) DEFAULT NULL,
  `hedef_oda_no` varchar(10) DEFAULT NULL,
  `talep_tarihi` datetime DEFAULT NULL,
  `durum` varchar(50) DEFAULT NULL,
  `onay_tarihi` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `log_talepler`
--

INSERT INTO `log_talepler` (`log_id`, `talep_id`, `ogrenci_id`, `ogrenci_adi`, `talep_tipi`, `mevcut_oda_no`, `hedef_oda_no`, `talep_tarihi`, `durum`, `onay_tarihi`) VALUES
(1, 18, 0, 'Oda Değişikliği', 'Oda Değişimi', '1', '', '2025-05-11 03:48:33', 'Onaylandı', '2025-05-11 03:48:33'),
(2, 18, 0, 'Oda Değişikliği', 'Oda Değişimi', '1', '', '2025-05-11 03:48:38', 'Onaylandı', '2025-05-11 03:48:38'),
(3, 23, 17, 'Oda Değişikliği', 'Oda Değişimi', '3', '8', '2025-05-11 03:53:05', 'Onaylandı', '2025-05-11 03:53:05'),
(4, 22, 17, 'Oda Değişikliği', 'Oda Değişimi', '3', '7', '2025-05-11 03:53:09', 'Onaylandı', '2025-05-11 03:53:09'),
(5, 21, 17, 'Oda Değişikliği', 'Oda Değişimi', '3', '6', '2025-05-11 03:53:21', 'Onaylandı', '2025-05-11 03:53:21'),
(6, 19, 0, 'Oda Değişikliği', 'Oda Değişimi', '4', '', '2025-05-11 03:50:49', 'Onaylandı', '2025-05-11 03:58:00'),
(7, 34, 0, 'Oda Değişikliği', 'Oda Değişimi', '5', '', '2025-05-11 03:58:59', 'Onaylandı', '2025-05-11 03:59:05'),
(8, 34, 0, 'Oda Değişikliği', 'Oda Değişimi', '5', '', NULL, 'Onaylandı', '2025-05-11 03:59:08'),
(9, 33, 0, 'Oda Değişikliği', 'Oda Değişimi', '9', '', '2025-05-11 03:58:57', 'Onaylandı', '2025-05-11 03:59:34'),
(10, 35, 17, 'Oda Değişikliği', 'Oda Değişimi', '6', '5', '2025-05-11 04:00:17', 'Onaylandı', '2025-05-11 04:00:17'),
(11, 32, 17, 'Oda Değişikliği', 'Oda Değişimi', '6', '8', '2025-05-11 04:00:20', 'Onaylandı', '2025-05-11 04:00:20'),
(12, 32, 17, 'Oda Değişikliği', 'Oda Değişimi', '6', '8', '2025-05-11 04:00:28', 'Onaylandı', '2025-05-11 04:00:28'),
(13, 31, 17, 'Oda Değişikliği', 'Oda Değişimi', '6', '7', '2025-05-11 04:00:36', 'Onaylandı', '2025-05-11 04:00:36'),
(14, 30, 17, 'Oda Değişikliği', 'Oda Değişimi', '6', '6', '2025-05-11 04:00:38', 'Onaylandı', '2025-05-11 04:00:38'),
(15, 29, 17, 'Oda Değişikliği', 'Oda Değişimi', '6', '5', '2025-05-11 04:00:39', 'Onaylandı', '2025-05-11 04:00:39'),
(16, 28, 17, 'Oda Değişikliği', 'Oda Değişimi', '6', '4', '2025-05-11 04:00:40', 'Onaylandı', '2025-05-11 04:00:40'),
(17, 27, 17, 'Oda Değişikliği', 'Oda Değişimi', '6', '3', '2025-05-11 04:00:41', 'Onaylandı', '2025-05-11 04:00:41'),
(18, 26, 17, 'Oda Değişikliği', 'Oda Değişimi', '6', '2', '2025-05-11 04:00:43', 'Onaylandı', '2025-05-11 04:00:43'),
(19, 25, 17, 'Oda Değişikliği', 'Oda Değişimi', '6', '1', '2025-05-11 04:00:45', 'Onaylandı', '2025-05-11 04:00:45'),
(20, 36, 43, 'Oda Değişikliği', 'Oda Değişimi', '16', '3', '2025-05-11 04:30:20', 'Onaylandı', '2025-05-11 04:30:20'),
(21, 38, 17, 'Oda Değişikliği', 'Oda Değişimi', '1', '5', '2025-05-13 13:47:11', 'Onaylandı', '2025-05-13 13:47:11'),
(22, 42, 17, 'Oda Değişikliği', 'Oda Değişimi', '5', '8', '2025-05-13 18:41:51', 'Onaylandı', '2025-05-13 18:41:51');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `oda`
--

CREATE TABLE `oda` (
  `oda_no` int(11) NOT NULL,
  `kapasite` int(11) NOT NULL,
  `doluluk` int(11) DEFAULT NULL,
  `bolum_id` int(11) DEFAULT NULL,
  `durum` enum('Boş','Dolu') DEFAULT 'Boş',
  `ozellikler` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `oda`
--

INSERT INTO `oda` (`oda_no`, `kapasite`, `doluluk`, `bolum_id`, `durum`, `ozellikler`) VALUES
(1, 5, 4, 1, 'Boş', NULL),
(2, 5, 0, 1, 'Boş', NULL),
(3, 5, 1, 1, 'Boş', NULL),
(4, 5, 2, 1, 'Boş', NULL),
(5, 5, 0, 1, 'Boş', NULL),
(6, 5, 5, 2, 'Boş', NULL),
(7, 5, 0, 2, 'Boş', NULL),
(8, 5, 0, 2, 'Boş', NULL),
(9, 5, 0, 2, 'Boş', NULL),
(10, 5, 0, 2, 'Boş', NULL),
(11, 5, 1, 3, 'Boş', NULL),
(12, 5, 0, 3, 'Boş', NULL),
(13, 5, 0, 3, 'Boş', NULL),
(14, 5, 0, 3, 'Boş', NULL),
(15, 5, 0, 3, 'Boş', NULL),
(16, 5, 2, 4, 'Boş', NULL),
(17, 5, 0, 4, 'Boş', NULL),
(18, 5, 0, 4, 'Boş', NULL),
(19, 5, 0, 4, 'Boş', NULL),
(20, 5, 1, 4, 'Boş', NULL),
(21, 5, 1, 5, 'Boş', NULL),
(22, 5, 0, 5, 'Boş', NULL),
(23, 5, 0, 5, 'Boş', NULL),
(24, 5, 0, 5, 'Boş', NULL),
(25, 5, 0, 5, 'Boş', NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `oda_talepleri`
--

CREATE TABLE `oda_talepleri` (
  `talep_id` int(11) NOT NULL,
  `ogrenci_id` int(11) NOT NULL,
  `mevcut_oda_no` int(11) NOT NULL,
  `hedef_oda_no` int(11) NOT NULL,
  `talep_tarihi` datetime DEFAULT current_timestamp(),
  `durum` varchar(20) DEFAULT 'Beklemede',
  `red_sebebi` text DEFAULT NULL,
  `onay_tarihi` datetime DEFAULT NULL,
  `talep_tipi` varchar(50) NOT NULL,
  `ogrenci_adi` varchar(100) NOT NULL,
  `islem_tarihi` datetime DEFAULT current_timestamp(),
  `yonetici_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ogrenciler`
--

CREATE TABLE `ogrenciler` (
  `ogrenci_id` int(11) NOT NULL,
  `Ad` varchar(50) NOT NULL,
  `Soyad` varchar(50) NOT NULL,
  `eposta` varchar(50) NOT NULL,
  `dogum_tarihi` date DEFAULT NULL,
  `sifre` varchar(64) NOT NULL,
  `bolum_id` int(11) DEFAULT NULL,
  `oda_no` int(11) DEFAULT NULL,
  `kullanici_adi` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `ogrenciler`
--

INSERT INTO `ogrenciler` (`ogrenci_id`, `Ad`, `Soyad`, `eposta`, `dogum_tarihi`, `sifre`, `bolum_id`, `oda_no`, `kullanici_adi`) VALUES
(16, 'kemal', 'kartal', 'kemal@gmail.com', '2002-04-22', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 4, 16, 'kemal'),
(17, 'kaan', 'almacı', 'kaan@gmail.com', '2000-05-26', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 1, 4, 'kaan'),
(19, 'Berke Kağan', 'İz', 'berke@gmail.com', '2000-03-16', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 1, 4, 'berke'),
(20, 'recep', 'kayabaşı', 'recep@gmail.com', '2000-03-21', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 5, 21, 'recep'),
(21, 'ramazan', 'hepcan', 'ramazan@gmail.com', '2003-03-21', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 2, 6, 'ramazan'),
(22, 'çetin', 'kalem', 'cetin@gmail.com', '2003-03-19', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 2, 6, 'çetin'),
(23, 'çağrı', 'keskin', 'cagri@gmail.com', '2001-03-19', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 2, 6, 'çağrı'),
(24, 'hüseyin', 'duman', 'huseyin@gmail.com', '2000-03-26', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 2, 6, 'hüseyin'),
(25, 'kerem', 'ateş', 'kerem@gmail.com', '2000-03-11', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 2, 6, 'kerem'),
(27, 'kuzey', 'barut', 'kuzey@gmail.com', '2000-02-11', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 1, 1, 'kuzey'),
(28, 'burak', 'solak', 'burak@gmail.com', '2000-02-22', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 1, 1, 'burak'),
(29, 'ekrem', 'uzun', 'ekrem@gmail.com', '2000-06-22', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 4, 16, 'ekrem'),
(33, 'beşir', 'tebeşir', 'besir@gmail.com', '2000-03-07', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 1, 2, 'beşir'),
(44, 'Hasan Eren', 'Bostancıoğlu', 'hsn37@gmail.com', '2005-01-05', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 4, 20, 'hsn08'),
(46, 'merttt', 'merttt', 'merttt@a.com', '2000-02-22', '12345', 1, 1, 'merttt'),
(47, 'nisaaa', 'nisaaa', 'nisaaa@a.com', '2000-02-22', '12345', 3, 11, 'nisaaa'),
(52, 'nisagg', 'nisagg', 'nisagg@gmail.com', '2000-02-22', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 1, 1, 'nisagg');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `onaylananlar`
--

CREATE TABLE `onaylananlar` (
  `id` int(11) NOT NULL,
  `ogrenci_id` int(11) NOT NULL,
  `ogrenci_adi` varchar(255) DEFAULT NULL,
  `talep_tipi` varchar(100) DEFAULT NULL,
  `mevcut_oda_no` int(11) DEFAULT NULL,
  `hedef_oda_no` int(11) DEFAULT NULL,
  `onay_tarihi` datetime DEFAULT current_timestamp(),
  `yonetici_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `reddedilenler`
--

CREATE TABLE `reddedilenler` (
  `id` int(11) NOT NULL,
  `ogrenci_id` int(11) NOT NULL,
  `ogrenci_adi` varchar(255) DEFAULT NULL,
  `talep_tipi` varchar(100) DEFAULT NULL,
  `mevcut_oda_no` int(11) DEFAULT NULL,
  `hedef_oda_no` int(11) DEFAULT NULL,
  `red_sebebi` varchar(255) DEFAULT NULL,
  `red_tarihi` datetime DEFAULT current_timestamp(),
  `yonetici_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yemekhane`
--

CREATE TABLE `yemekhane` (
  `yemek_id` int(11) NOT NULL,
  `Tarih` date NOT NULL,
  `Kahvalti` text NOT NULL,
  `Ogle` text NOT NULL,
  `Aksam` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `yemekhane`
--

INSERT INTO `yemekhane` (`yemek_id`, `Tarih`, `Kahvalti`, `Ogle`, `Aksam`) VALUES
(175, '2025-06-01', 'Menemen', 'Pilav ve Tavuk', 'Makarna'),
(176, '2025-06-02', 'Omlet', 'Kuru Fasulye', 'Karnıyarık'),
(177, '2025-06-03', 'Kaşarlı Tost', 'Tavuk Sote', 'Bulgur Pilavı'),
(178, '2025-06-04', 'Simit ve Peynir', 'Mercimek Çorbası', 'Izgara Köfte'),
(179, '2025-06-05', 'Sade Poğaça', 'Mantı', 'Zeytinyağlı Fasulye'),
(180, '2025-06-06', 'Sahanda Yumurta', 'Et Sote', 'Patlıcan Musakka'),
(181, '2025-06-07', 'Reçelli Ekmek', 'Kuru Köfte', 'Şehriye Çorbası'),
(182, '2025-06-08', 'Peynirli Börek', 'Tavuk Haşlama', 'Yoğurtlu Semizotu'),
(183, '2025-06-09', 'Açma ve Zeytin', 'Nohutlu Pilav', 'Patates Kızartması'),
(184, '2025-06-10', 'Sütlü Ekmek', 'Tavuk Şiş', 'Fırın Makarna'),
(185, '2025-06-11', 'Çikolatalı Krep', 'Et Haşlama', 'Pirinç Pilavı'),
(186, '2025-06-12', 'Kruvasan', 'Yoğurtlu Kabak', 'Karnıyarık'),
(187, '2025-06-13', 'Haşlanmış Yumurta', 'Kıymalı Börek', 'Tavuk Sote'),
(188, '2025-06-14', 'Kaşarlı Omlet', 'Zeytinyağlı Barbunya', 'Makarna'),
(189, '2025-06-15', 'Simit ve Çay', 'Tavuklu Pilav', 'Fırın Tavuk'),
(190, '2025-06-16', 'Peynirli Sandviç', 'Et Döner', 'Patates Püresi'),
(191, '2025-06-17', 'Reçelli Tost', 'Mercimek Çorbası', 'İçli Köfte'),
(192, '2025-06-18', 'Çay ve Kek', 'Yoğurtlu Semizotu', 'Kuru Fasulye'),
(193, '2025-06-19', 'Bal ve Kaymak', 'Fırın Tavuk', 'Şehriye Çorbası'),
(194, '2025-06-20', 'Zeytinli Açma', 'Tavuk Sote', 'Izgara Köfte'),
(195, '2025-06-21', 'Yumurtalı Ekmek', 'Pirinç Pilavı', 'Zeytinyağlı Enginar'),
(196, '2025-06-22', 'Menemen', 'Karnıyarık', 'Yoğurtlu Kabak'),
(197, '2025-06-23', 'Haşlanmış Yumurta', 'Nohutlu Pilav', 'Kuru Köfte'),
(198, '2025-06-24', 'Tahinli Ekmek', 'Tavuk Haşlama', 'Patlıcan Musakka'),
(199, '2025-06-25', 'Kruvasan', 'Et Sote', 'Fırın Makarna'),
(200, '2025-06-26', 'Sade Poğaça', 'Yoğurtlu Semizotu', 'Şehriye Çorbası'),
(201, '2025-06-27', 'Açma ve Çay', 'Tavuklu Pilav', 'Kıymalı Börek'),
(202, '2025-06-28', 'Sütlü Tost', 'Et Haşlama', 'Zeytinyağlı Fasulye'),
(203, '2025-06-29', 'Simit ve Peynir', 'Tavuk Şiş', 'Patates Püresi'),
(204, '2025-06-30', 'Kakaolu Kek', 'Yoğurtlu Kabak', 'Kuru Fasulye');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yoneticiler`
--

CREATE TABLE `yoneticiler` (
  `yonetici_id` int(11) NOT NULL,
  `kullanici_adi` varchar(50) NOT NULL,
  `sifre` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `yoneticiler`
--

INSERT INTO `yoneticiler` (`yonetici_id`, `kullanici_adi`, `sifre`) VALUES
(1, 'admin', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `bildirimler`
--
ALTER TABLE `bildirimler`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ogrenci_id` (`ogrenci_id`);

--
-- Tablo için indeksler `bolumler`
--
ALTER TABLE `bolumler`
  ADD PRIMARY KEY (`bolum_id`);

--
-- Tablo için indeksler `duyurular`
--
ALTER TABLE `duyurular`
  ADD PRIMARY KEY (`duyuru_id`);

--
-- Tablo için indeksler `izinler`
--
ALTER TABLE `izinler`
  ADD PRIMARY KEY (`izin_id`);

--
-- Tablo için indeksler `log_talepler`
--
ALTER TABLE `log_talepler`
  ADD PRIMARY KEY (`log_id`);

--
-- Tablo için indeksler `oda`
--
ALTER TABLE `oda`
  ADD PRIMARY KEY (`oda_no`);

--
-- Tablo için indeksler `oda_talepleri`
--
ALTER TABLE `oda_talepleri`
  ADD PRIMARY KEY (`talep_id`);

--
-- Tablo için indeksler `ogrenciler`
--
ALTER TABLE `ogrenciler`
  ADD PRIMARY KEY (`ogrenci_id`),
  ADD UNIQUE KEY `kullanici_adi` (`kullanici_adi`),
  ADD KEY `fk_bolum` (`bolum_id`),
  ADD KEY `fk_oda` (`oda_no`);

--
-- Tablo için indeksler `onaylananlar`
--
ALTER TABLE `onaylananlar`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `reddedilenler`
--
ALTER TABLE `reddedilenler`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `yemekhane`
--
ALTER TABLE `yemekhane`
  ADD PRIMARY KEY (`yemek_id`);

--
-- Tablo için indeksler `yoneticiler`
--
ALTER TABLE `yoneticiler`
  ADD PRIMARY KEY (`yonetici_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `bildirimler`
--
ALTER TABLE `bildirimler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Tablo için AUTO_INCREMENT değeri `duyurular`
--
ALTER TABLE `duyurular`
  MODIFY `duyuru_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Tablo için AUTO_INCREMENT değeri `izinler`
--
ALTER TABLE `izinler`
  MODIFY `izin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Tablo için AUTO_INCREMENT değeri `log_talepler`
--
ALTER TABLE `log_talepler`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Tablo için AUTO_INCREMENT değeri `oda_talepleri`
--
ALTER TABLE `oda_talepleri`
  MODIFY `talep_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- Tablo için AUTO_INCREMENT değeri `ogrenciler`
--
ALTER TABLE `ogrenciler`
  MODIFY `ogrenci_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- Tablo için AUTO_INCREMENT değeri `onaylananlar`
--
ALTER TABLE `onaylananlar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `reddedilenler`
--
ALTER TABLE `reddedilenler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `yemekhane`
--
ALTER TABLE `yemekhane`
  MODIFY `yemek_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=205;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `bildirimler`
--
ALTER TABLE `bildirimler`
  ADD CONSTRAINT `bildirimler_ibfk_1` FOREIGN KEY (`ogrenci_id`) REFERENCES `ogrenciler` (`ogrenci_id`);

--
-- Tablo kısıtlamaları `ogrenciler`
--
ALTER TABLE `ogrenciler`
  ADD CONSTRAINT `fk_bolum` FOREIGN KEY (`bolum_id`) REFERENCES `bolumler` (`bolum_id`),
  ADD CONSTRAINT `fk_oda` FOREIGN KEY (`oda_no`) REFERENCES `oda` (`oda_no`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
