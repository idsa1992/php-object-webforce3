-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  mar. 22 août 2017 à 10:21
-- Version du serveur :  10.1.22-MariaDB
-- Version de PHP :  7.1.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `myshop`
--

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `idcategories` int(11) NOT NULL,
  `name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

CREATE TABLE `clients` (
  `idclients` int(11) NOT NULL,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `email` varchar(60) NOT NULL,
  `password` varchar(45) NOT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `civility` tinyint(4) DEFAULT '1',
  `isok` tinyint(4) DEFAULT '1',
  `avatar` varchar(255) DEFAULT 'https://www.shareicon.net/data/128x128/2015/12/14/207815_face_300x300.png',
  `date_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `clients_has_items`
--

CREATE TABLE `clients_has_items` (
  `clients_idclients` int(11) NOT NULL,
  `items_iditems` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `delivery`
--

CREATE TABLE `delivery` (
  `iddelivery` int(11) NOT NULL,
  `street` varchar(100) NOT NULL,
  `city` varchar(45) NOT NULL,
  `country` varchar(45) NOT NULL,
  `type` enum('Facturation','Livraisons') DEFAULT 'Livraisons',
  `clients_idclients` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `items`
--

CREATE TABLE `items` (
  `iditems` int(11) NOT NULL,
  `libelle` varchar(45) NOT NULL,
  `description` longtext NOT NULL,
  `code_item` varchar(45) NOT NULL,
  `stocks` smallint(5) DEFAULT NULL,
  `availabity` tinyint(4) NOT NULL DEFAULT '1',
  `price` float(3,2) NOT NULL,
  `categories_idcategories` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `items_has_type`
--

CREATE TABLE `items_has_type` (
  `items_iditems` int(11) NOT NULL,
  `type_idtype` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `orders`
--

CREATE TABLE `orders` (
  `idorders` int(11) NOT NULL,
  `num_order` varchar(45) NOT NULL,
  `date_order` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_send` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(5) NOT NULL DEFAULT '0',
  `clients_idclients` int(11) NOT NULL,
  `delivery_iddelivery` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `orders_has_items`
--

CREATE TABLE `orders_has_items` (
  `orders_idorders` int(11) NOT NULL,
  `items_iditems` int(11) NOT NULL,
  `qte` tinyint(5) NOT NULL,
  `price_final` float(3,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `payments`
--

CREATE TABLE `payments` (
  `idpayments` int(11) NOT NULL,
  `amount` float(3,2) NOT NULL,
  `type` enum('Bank','Stripe','Paypal') NOT NULL DEFAULT 'Bank',
  `currency` enum('Euro','Dollard') NOT NULL DEFAULT 'Euro',
  `rule` tinyint(4) NOT NULL,
  `date_rule` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `orders_idorders` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `pictures`
--

CREATE TABLE `pictures` (
  `idpictures` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `date_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `items_iditems` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `reviews`
--

CREATE TABLE `reviews` (
  `idreviews` int(11) NOT NULL,
  `note` varchar(45) NOT NULL,
  `commentaire` varchar(45) DEFAULT NULL,
  `date_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `items_iditems` int(11) NOT NULL,
  `clients_idclients` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `type`
--

CREATE TABLE `type` (
  `idtype` int(11) NOT NULL,
  `libeller` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`idcategories`);

--
-- Index pour la table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`idclients`);

--
-- Index pour la table `clients_has_items`
--
ALTER TABLE `clients_has_items`
  ADD PRIMARY KEY (`clients_idclients`,`items_iditems`),
  ADD KEY `fk_clients_has_items_items1_idx` (`items_iditems`),
  ADD KEY `fk_clients_has_items_clients1_idx` (`clients_idclients`);

--
-- Index pour la table `delivery`
--
ALTER TABLE `delivery`
  ADD PRIMARY KEY (`iddelivery`),
  ADD KEY `fk_delivery_clients1_idx` (`clients_idclients`);

--
-- Index pour la table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`iditems`),
  ADD KEY `fk_items_categories1_idx` (`categories_idcategories`);

--
-- Index pour la table `items_has_type`
--
ALTER TABLE `items_has_type`
  ADD PRIMARY KEY (`items_iditems`,`type_idtype`),
  ADD KEY `fk_items_has_type_type1_idx` (`type_idtype`),
  ADD KEY `fk_items_has_type_items1_idx` (`items_iditems`);

--
-- Index pour la table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`idorders`),
  ADD KEY `fk_orders_clients_idx` (`clients_idclients`),
  ADD KEY `fk_orders_delivery1_idx` (`delivery_iddelivery`);

--
-- Index pour la table `orders_has_items`
--
ALTER TABLE `orders_has_items`
  ADD PRIMARY KEY (`orders_idorders`,`items_iditems`),
  ADD KEY `fk_orders_has_items_items1_idx` (`items_iditems`),
  ADD KEY `fk_orders_has_items_orders1_idx` (`orders_idorders`);

--
-- Index pour la table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`idpayments`),
  ADD KEY `fk_payments_orders1_idx` (`orders_idorders`);

--
-- Index pour la table `pictures`
--
ALTER TABLE `pictures`
  ADD PRIMARY KEY (`idpictures`),
  ADD KEY `fk_pictures_items1_idx` (`items_iditems`);

--
-- Index pour la table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`idreviews`),
  ADD KEY `fk_reviews_items1_idx` (`items_iditems`),
  ADD KEY `fk_reviews_clients1_idx` (`clients_idclients`);

--
-- Index pour la table `type`
--
ALTER TABLE `type`
  ADD PRIMARY KEY (`idtype`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `idcategories` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `clients`
--
ALTER TABLE `clients`
  MODIFY `idclients` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `delivery`
--
ALTER TABLE `delivery`
  MODIFY `iddelivery` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `items`
--
ALTER TABLE `items`
  MODIFY `iditems` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `orders`
--
ALTER TABLE `orders`
  MODIFY `idorders` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `payments`
--
ALTER TABLE `payments`
  MODIFY `idpayments` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `idreviews` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `type`
--
ALTER TABLE `type`
  MODIFY `idtype` int(11) NOT NULL AUTO_INCREMENT;
--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `clients_has_items`
--
ALTER TABLE `clients_has_items`
  ADD CONSTRAINT `fk_clients_has_items_clients1` FOREIGN KEY (`clients_idclients`) REFERENCES `clients` (`idclients`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_clients_has_items_items1` FOREIGN KEY (`items_iditems`) REFERENCES `items` (`iditems`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `delivery`
--
ALTER TABLE `delivery`
  ADD CONSTRAINT `fk_delivery_clients1` FOREIGN KEY (`clients_idclients`) REFERENCES `clients` (`idclients`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `fk_items_categories1` FOREIGN KEY (`categories_idcategories`) REFERENCES `categories` (`idcategories`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `items_has_type`
--
ALTER TABLE `items_has_type`
  ADD CONSTRAINT `fk_items_has_type_items1` FOREIGN KEY (`items_iditems`) REFERENCES `items` (`iditems`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_items_has_type_type1` FOREIGN KEY (`type_idtype`) REFERENCES `type` (`idtype`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_clients` FOREIGN KEY (`clients_idclients`) REFERENCES `clients` (`idclients`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_orders_delivery1` FOREIGN KEY (`delivery_iddelivery`) REFERENCES `delivery` (`iddelivery`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `orders_has_items`
--
ALTER TABLE `orders_has_items`
  ADD CONSTRAINT `fk_orders_has_items_items1` FOREIGN KEY (`items_iditems`) REFERENCES `items` (`iditems`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_orders_has_items_orders1` FOREIGN KEY (`orders_idorders`) REFERENCES `orders` (`idorders`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payments_orders1` FOREIGN KEY (`orders_idorders`) REFERENCES `orders` (`idorders`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `pictures`
--
ALTER TABLE `pictures`
  ADD CONSTRAINT `fk_pictures_items1` FOREIGN KEY (`items_iditems`) REFERENCES `items` (`iditems`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_reviews_clients1` FOREIGN KEY (`clients_idclients`) REFERENCES `clients` (`idclients`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_reviews_items1` FOREIGN KEY (`items_iditems`) REFERENCES `items` (`iditems`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
