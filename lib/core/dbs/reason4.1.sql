-- MySQL dump 10.13  Distrib 5.5.9, for osx10.4 (i386)
--
-- Host: localhost    Database: reason
-- ------------------------------------------------------
-- Server version	5.5.9

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `URL_history`
--

DROP TABLE IF EXISTS `URL_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `URL_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` text NOT NULL,
  `page_id` int(11) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `deleted` enum('no','yes') NOT NULL DEFAULT 'no',
  PRIMARY KEY (`id`),
  FULLTEXT KEY `url` (`url`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `URL_history`
--

LOCK TABLES `URL_history` WRITE;
/*!40000 ALTER TABLE `URL_history` DISABLE KEYS */;
INSERT INTO `URL_history` VALUES (1,'/login/',75394,1166219492,'no');
/*!40000 ALTER TABLE `URL_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_link`
--

DROP TABLE IF EXISTS `admin_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_link` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `relative_to_reason_http_base` enum('true','false') DEFAULT NULL,
  `add_dynamic_site_id` enum('true','false') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_link`
--

LOCK TABLES `admin_link` WRITE;
/*!40000 ALTER TABLE `admin_link` DISABLE KEYS */;
INSERT INTO `admin_link` VALUES (38,'true',NULL),(3486,'true',NULL),(3496,'true',NULL),(3497,'true',NULL),(3498,'true',NULL),(3501,'true',NULL),(17685,'true',NULL),(34442,'true',NULL),(81327,'true',NULL),(109269,'true',NULL),(221355,'true',NULL),(221357,'true',NULL),(221359,'true',NULL),(221365,'true',NULL),(221372,'true',NULL),(240451,'true',NULL),(240452,'true',NULL),(240506,'',NULL),(240507,'',NULL),(240508,'',NULL),(240514,'true',NULL),(240533,NULL,NULL);
/*!40000 ALTER TABLE `admin_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `allowable_relationship`
--

DROP TABLE IF EXISTS `allowable_relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allowable_relationship` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `relationship_a` int(10) unsigned NOT NULL DEFAULT '0',
  `relationship_b` int(10) unsigned NOT NULL DEFAULT '0',
  `description` tinytext,
  `name` varchar(64) NOT NULL DEFAULT '',
  `connections` enum('one_to_many','many_to_many','many_to_one') DEFAULT NULL,
  `custom_associator` varchar(64) DEFAULT NULL,
  `display_name` tinytext,
  `required` enum('yes','no') DEFAULT NULL,
  `display_name_reverse_direction` tinytext,
  `directionality` enum('unidirectional','bidirectional') NOT NULL DEFAULT 'unidirectional',
  `description_reverse_direction` tinytext,
  `is_sortable` enum('yes','no') DEFAULT 'no',
  PRIMARY KEY (`id`),
  KEY `name_index` (`name`),
  KEY `relationship_a` (`relationship_a`),
  KEY `relationship_b` (`relationship_b`)
) ENGINE=MyISAM AUTO_INCREMENT=417 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allowable_relationship`
--

LOCK TABLES `allowable_relationship` WRITE;
/*!40000 ALTER TABLE `allowable_relationship` DISABLE KEYS */;
INSERT INTO `allowable_relationship` VALUES (1,1,2,'Type to table relationship.  This type of association specifies which tables to use with which types.','type_to_table','many_to_many','','Choose Entity Tables','no','Types that use this table','unidirectional','Types that use this table','no'),(2,3,1,'Site to Content Type - Which content types show up on which sites.','site_to_type','many_to_many','','Select available type(s)','no','Assign to site(s)','bidirectional','Sites that have access to this type','no'),(3,3,4,'Site to User - which users belong to which sites.','site_to_user','many_to_many','','Users','no','Sites to which this user has access','bidirectional','Sites to which this user has access','no'),(4,3,1,'site ownership of type data','owns','many_to_many','',NULL,'no',NULL,'unidirectional',NULL,'no'),(5,3,4,'site ownership of user data','owns','many_to_many','',NULL,'no',NULL,'unidirectional',NULL,'no'),(11,3,36,'site owns admin link','owns','many_to_many','',NULL,'no',NULL,'unidirectional',NULL,'no'),(8,3,36,'site to admin link','site_to_admin_link','many_to_many','','Admin links','no','Assign to site(s)','bidirectional','Sites with this admin link','no'),(9,3,2,'site owns entity table','owns','many_to_many','',NULL,'no',NULL,'unidirectional',NULL,'no'),(10,3,3,'site owns site data','owns','many_to_many','',NULL,'no',NULL,'unidirectional',NULL,'no'),(60,2812,2785,'view types associated with views','view_to_view_type','many_to_many','','View Type','no','views that use this view type','unidirectional','views that use this view type','no'),(57,3,2785,NULL,'owns',NULL,'',NULL,'no',NULL,'unidirectional',NULL,'no'),(21,3,88,NULL,'owns',NULL,'',NULL,'no',NULL,'unidirectional',NULL,'no'),(41,88,243,'Images associated with a news story','news_to_image','many_to_many','','Associate images with this post','no','Assign to news post(s)','bidirectional','News posts that use this image','yes'),(36,3,243,NULL,'owns',NULL,'',NULL,'no',NULL,'unidirectional',NULL,'no'),(59,3,2812,NULL,'owns',NULL,'',NULL,'no',NULL,'unidirectional',NULL,'no'),(61,2812,3,'Associate views to sites','view_to_site','many_to_many','','Assign to site(s)','no','Select available view(s)','bidirectional','Views that this site uses','no'),(62,2812,1,'Associate types with views','view_to_type','many_to_many','','Type','no','Views that use this type','unidirectional','Views that use this type','no'),(63,3,2820,NULL,'owns',NULL,'',NULL,'no',NULL,'unidirectional',NULL,'no'),(64,3,2823,NULL,'owns',NULL,'',NULL,'no',NULL,'unidirectional',NULL,'no'),(65,2812,2820,'Columns to be show in a view','view_columns','many_to_many','','','no','Views that use this field as a column','unidirectional','Views that use this field as a column','no'),(66,2812,2820,'Searchable Fields of a View','view_searchable_fields','many_to_many','','Searchable Fields','no','Views that allow searching on this field','unidirectional','Views that allow searching on this field','no'),(67,2820,2,'Link fields to their entity table.','field_to_entity_table','one_to_many','','Add to an Entity Table','no','Fields that are part of this table','unidirectional','Fields that are part of this table','no'),(74,3,3311,NULL,'owns',NULL,'',NULL,'no',NULL,'unidirectional',NULL,'no'),(75,3,3313,NULL,'owns',NULL,'',NULL,'no',NULL,'unidirectional',NULL,'no'),(78,3,3317,NULL,'owns',NULL,'',NULL,'no',NULL,'unidirectional',NULL,'no'),(79,3317,243,'Associate Minisite Pages with Images','minisite_page_to_image','many_to_many','','Place images on this page','no','Pages that use this image','unidirectional','Pages that use this image','yes'),(80,3317,3317,'minisite page hierarchy stuff','minisite_page_parent','one_to_many','parent_tree','Parent Page','yes','Children Pages','unidirectional','Children Pages','no'),(81,3,3379,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(82,3317,3379,'Association between pages and pulled quotes / text snippets','minisite_page_to_text_blurb','many_to_many','','Place Blurbs','no','Place on Pages','bidirectional','On Pages','yes'),(384,3,240412,NULL,'owns','many_to_one',NULL,NULL,'yes',NULL,'unidirectional',NULL,'no'),(84,3,3311,'Link CSS to Sites','site_to_css','many_to_many','hide this relationship from the Reason Admin','CSS Files','no','Sites that use this css','unidirectional','Sites that use this css','no'),(85,3,3861,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(86,3,3871,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(87,3861,3871,'Media Work has AV File as part or format','av_to_av_file','many_to_many','','Media Files','yes','Media Works','unidirectional','Media Works this Media File is part of','no'),(89,3,4264,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(90,4,4264,'User to Role','user_to_user_role','many_to_many','','User Roles','no','Users that have this role','unidirectional','Users that have this role','no'),(94,2823,243,'project to image','project_to_image','many_to_many','','Images','no','Projects that use this image','unidirectional','Projects that use this image','no'),(96,3,5397,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(97,3,1,'Site Shares Type','site_shares_type','many_to_many','','Shared types','no','Sites that share this type','unidirectional','Sites that share this type','no'),(98,3,1,'site borrows Type','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(99,3,2,'site borrows Entity Table','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(100,3,3,'site borrows Site','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(101,3,4,'site borrows User','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(102,3,36,'site borrows Admin Link','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(106,3,2785,'site borrows View Type','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(107,3,88,'site borrows News','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(116,3,243,'site borrows Image','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(120,3,2812,'site borrows View','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(121,3,2820,'site borrows Field','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(122,3,2823,'site borrows Project','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(125,3,3861,'site borrows Audio / Video','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(126,3,3311,'site borrows External CSS Url','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(127,3,3313,'site borrows Minisite Template','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(128,3,3317,'site borrows Page','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(129,3,3379,'site borrows Text Blurb','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(130,3,3871,'site borrows Audio / Video File','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(131,3,4264,'site borrows User Role','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(134,3,5397,'site borrows Faculty / Staff','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(138,3,5890,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(139,5890,5890,'Policy Archive Relationship','policy_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(140,3,5890,'site borrows Policy','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(141,3,5907,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(142,5907,5907,'Asset Archive Relationship','asset_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(143,3,5907,'site borrows Asset','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(144,5890,5890,'Policy Heirarchy Relationship','policy_parent','one_to_many','parent_tree','Parent Policy','yes','Policies that have chosen this one as their parent','unidirectional','Policies that have chosen this one as their parent','no'),(145,3,6564,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(146,6564,6564,'Issue Archive Relationship','issue_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(147,3,6564,'site borrows Issue','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(148,88,6564,'News to Issue','news_to_issue','many_to_many','','Assign this story to an issue','no','News items in this issue','unidirectional','News items in this issue','no'),(155,88,5907,'News to Asset','news_to_asset','many_to_many','','Make Links to Assets (PDFs, etc.)','no','News items that use this asset','unidirectional','News items that use this asset','no'),(156,3313,3311,'minisite template to external css','minisite_template_to_external_css','many_to_many','','','no','Apply to template(s)','bidirectional','Templates that use this CSS','no'),(157,5397,243,'Faculty / Staff to Image','faculty_staff_to_image','one_to_many','','Choose Faculty/Staff Photo','no','Faculty/Staff members with this image','unidirectional','Faculty/Staff members with this image','no'),(161,3317,3861,'Minisite Page to Media Work','minisite_page_to_av','many_to_many','','Place media on this page','no','Place work on page(s)','bidirectional','Pages this Media Work appears on','no'),(162,3,13993,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(163,13993,13993,'Bug Archive Relationship','bug_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(164,3,13993,'site borrows Bug','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(172,3317,5890,'Page to Policy','page_to_policy','many_to_many','','Policies','no','Page(s) on which this policy appears','unidirectional','Page(s) on which this policy appears','no'),(180,3,27618,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(181,27618,27618,'minutes Archive Relationship','minutes_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(182,3,27618,'site borrows minutes','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(187,3,31512,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(188,31512,31512,'Event Archive Relationship','event_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(189,3,31512,'site borrows Event','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(190,3,31518,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(191,31518,31518,'Category Archive Relationship','category_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(192,3,31518,'site borrows Category','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(193,31512,31518,'Event to Event Category','event_to_event_category','many_to_many','','Select Categories','yes','Events in this category','unidirectional','Events in this category','no'),(194,3,32296,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(195,32296,32296,'News Section Archive Relationship','news_section_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(196,3,32296,'site borrows News Section','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(197,88,32296,'News to News Section','news_to_news_section','many_to_many','','Assign to a News Section','no','News in this news section','unidirectional','News in this news section','no'),(198,3317,5907,'Page to Asset','page_to_asset','many_to_many','','Make Links to Assets (PDFs, etc.)','no','Pages on which this asset appears','bidirectional','Pages on which this asset appears','yes'),(199,88,31518,'News to Category','news_to_category','many_to_many','','Assign to Categories','no','News items in this category','bidirectional','News items in this category','no'),(200,3,33122,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(201,33122,33122,'Non-Reason Site Archive Relationship','non_reason_site_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(202,3,33122,'site borrows Non-Reason Site','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(207,6564,5907,'Issue to Asset','issue_to_asset','many_to_many','','Associate PDFs with this issue','no','Issues with which this asset is associated','unidirectional','Issues with which this asset is associated','no'),(214,3,41963,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(215,41963,41963,'Job Archive Relationship','job_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(216,3,41963,'site borrows Job','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(218,3,44321,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(219,44321,44321,'Form Archive Relationship','form_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(220,3,44321,'site borrows Form','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(221,3317,44321,'Associate Minisite Pages with Forms','page_to_form','many_to_many','','Associate a form with this page','no','Pages that use this form','unidirectional','Pages that use this form','no'),(235,3,54388,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(236,54388,54388,'Office/Department Archive Relationship','office_department_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(237,3,54388,'site borrows Office/Department','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(239,3,1,'Site Cannot Edit Type','site_cannot_edit_type','many_to_many','','Choose types this site cannot edit','no','Keep sites from editing this type','bidirectional','Sites that cannot edit this type','no'),(244,54388,31518,'office department to category','office_department_to_category','many_to_many','','Is Related To Topic / Category','no','Is Related To Office / Department','bidirectional','Offices/Depts in this category','no'),(245,13993,13993,'Task depends on Task','task_depends_on_task','many_to_many','','Tasks that must be completed for this task to be addressed','no','Tasks that depend on this task','unidirectional','Tasks that depend on this task','no'),(246,13993,2823,'bug to project','bug_to_project','many_to_many','','','no','Tasks that are part of this project','unidirectional','Tasks that are part of this project','no'),(247,41963,54388,'Job to Office/Department','job_to_office_department','many_to_many','','Office/Department(s)','no','Job postings for this office/department','unidirectional','Job postings for this office/department','no'),(248,1,2812,'Determines the default views for a particular type','type_to_default_view','many_to_many','','Default Views','no','Types that use this as a default view','unidirectional','Types that use this as a default view','no'),(249,31512,243,'Event to Image','event_to_image','many_to_many','','Images','no','Events that use this image','unidirectional','Events that use this image','yes'),(250,2823,54388,'identifies which office(s)/dept(s) are clients of a particular project','project_to_client_office_dept','many_to_many','','Clients','no','Projects of which this office/department is a client','unidirectional','Projects of which this office/department is a client','no'),(251,3,3,'Parent Site','parent_site','many_to_many','','Parent Site','no','Children Sites','unidirectional','Children Sites','no'),(252,3,60241,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(253,60241,60241,'FAQ Archive Relationship','faq_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(254,3,60241,'site borrows FAQ','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(255,60241,31518,'FAQ categorization','faq_to_category','many_to_many','','Assign to categories','no','FAQs that are assigned to this category','unidirectional','FAQs that are assigned to this category','no'),(262,3317,31518,'Page to Category relationship','page_to_category','many_to_many','','Choose Categories','no','Pages assigned to this category','unidirectional','Pages assigned to this category','yes'),(269,3,75398,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(270,75398,75398,'Site User Archive Relationship','site_user_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(271,3,75398,'site borrows Site User','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(272,3317,75398,'Page to User','page_to_site_user','many_to_many','','Assign Users that can edit this page','no','Page(s) this user can edit','unidirectional','Page(s) this user can edit','no'),(275,3,118606,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(276,118606,118606,'Project Type Archive Relationship','project_type_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(277,3,118606,'site borrows Project Type','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(278,2823,118606,'Project to Project Type','project_to_project_type','many_to_many','','Project Type','yes','Projects','unidirectional','Projects','no'),(279,2823,5907,'Project to asset','project_to_asset','many_to_many','','Assets','','Projects associated with this asset','unidirectional','Projects associated with this asset','no'),(283,3861,243,'Audio/Video to primary image','av_to_primary_image','one_to_many','','Choose image','no','Audio/Video items that use this as their primary image','unidirectional','Audio/Video items that use this as their primary image','no'),(299,3,136617,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(300,136617,136617,'Site Type Archive Relationship','site_type_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(301,3,136617,'site borrows Site Type','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(302,3,136617,'site_to_site_type','site_to_site_type','many_to_many','','Site To Site Type','yes','Sites which are of this site type','bidirectional','Sites which are of this site type','no'),(303,33122,136617,'non-reason site to site type','non_reason_site_to_site_type','many_to_many','','Choose site type','yes','Non-Reason sites that are of this site type','unidirectional','Non-Reason sites that are of this site type','no'),(304,3,153392,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(305,153392,153392,'Blog / Publication Archive Relationship','publication_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(306,3,153392,'site borrows Blog','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(307,3,153394,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(308,153394,153394,'Comment Archive Relationship','comment_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(309,3,153394,'site borrows Comment','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(310,3,153396,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(311,153396,153396,'Group Archive Relationship','group_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(312,3,153396,'site borrows Group','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(313,3317,153392,'Place a blog / publication','page_to_publication','one_to_many','','Place a blog / publication','no','Pages where this blog / publication has been placed','unidirectional','Pages where this blog / publication has been placed','no'),(314,88,153392,'News is part of blog / publication','news_to_publication','many_to_many','','Post this news item to a blog / publication','no','Manage Posts','bidirectional','Posts on this blog / publication','no'),(315,88,153394,'News item has comment','news_to_comment','many_to_many','','Comments made to this post','no','Post(s)','unidirectional','Post(s)','no'),(316,153392,153396,'publication to authorized posting group (i.e. who can post)','publication_to_authorized_posting_group','one_to_many','','Who is allowed to post?','yes','Blogs / Publications use this group to determine posting permissions','unidirectional','Blogs / Publications use this group to determine posting permissions','no'),(317,153392,153396,'publication to authorized commenting group (i.e. who can comment)','publication_to_authorized_commenting_group','one_to_many','','Who can comment?','yes','Blogs / Publications use this group to determine commenting permissions','unidirectional','Blogs / Publications use this group to determine commenting permissions','no'),(318,3,161656,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(319,161656,161656,'Theme Archive Relationship','theme_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(320,3,161656,'site borrows Theme','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(321,161656,243,'Primary Theme Image','theme_to_primary_image','one_to_many','','Primary Image','no','Theme(s)','unidirectional','Theme(s) that use this image as their primary image','no'),(322,161656,3311,'Theme uses CSS files','theme_to_external_css_url','many_to_many','','CSS Files','no','Apply to theme(s)','bidirectional','Themes that use this CSS file','no'),(323,3,161656,'Site theme selection','site_to_theme','one_to_many','','Choose a theme','yes','Sites that use this theme','unidirectional','Sites','no'),(324,136617,161656,'Themes available to site type','site_type_to_theme','many_to_many','','Themes available to sites of this type','no','Select site types that can choose this theme','bidirectional','Site types that can use this theme','no'),(325,161656,3313,'Theme uses template','theme_to_minisite_template','one_to_many','','Choose a template','yes','Themes that use this template','unidirectional','Themes','no'),(326,3,161656,'Site theme history','site_has_had_theme','many_to_many','','Theme History','no','Add to sites\' theme history','bidirectional','Sites that have had this theme','no'),(327,3,182075,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(328,182075,182075,'Registration Slot Archive Relationship','registration_slot_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(329,3,182075,'site borrows Registration Slot','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(330,31512,182075,'event type  to  registration slot type','event_type_to_registration_slot_type','many_to_one','','Add registration slots to this event','no','','unidirectional','','no'),(331,44321,153396,'Form to authorized viewing group (who can see the form)','form_to_authorized_viewing_group','one_to_many','','Choose group that can fill out the form','no','','unidirectional','','no'),(332,44321,153396,'Form to authorized result viewing group (who can see ALL results)','form_to_authorized_results_group','one_to_many','','Choose group that can see all results','no','','unidirectional','','no'),(333,88,243,'News to Teaser Image','news_to_teaser_image','one_to_many','','Associate Teaser Image','no','','unidirectional','','no'),(334,3317,3317,'Page Archive Relationship','minisite_page_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(335,3379,3379,'Text Blurb Archive Relationship','text_blurb_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(336,1,1,'Type Archive Relationship','type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(337,36,36,'Admin Link Archive Relationship','admin_link_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(338,88,88,'News / Post Archive Relationship','news_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(339,3,3,'Site Archive Relationship','site_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(342,2823,2823,'Project Archive Relationship','project_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(343,5397,5397,'Faculty / Staff Archive Relationship','faculty_staff_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(346,243,243,'Image Archive Relationship','image_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(349,3871,3871,'Audio / Video File Archive Relationship','av_file_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(352,2785,2785,'View Type Archive Relationship','view_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(353,3861,3861,'Audio / Video Archive Relationship','av_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(354,3313,3313,'Minisite Template Archive Relationship','minisite_template_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(355,3311,3311,'External CSS Url Archive Relationship','css_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(357,4,4,'User Archive Relationship','user_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(361,4264,4264,'User Role Archive Relationship','user_role_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(362,2,2,'Entity Table Archive Relationship','content_table_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(363,2820,2820,'Field Archive Relationship','field_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(364,2812,2812,'View Archive Relationship','view_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(365,243,31518,'image is part of category','image_to_category','many_to_many','','Assign to categories','no','Images','bidirectional','Images that are assigned to this category','no'),(366,3,3379,'Selects announcement blurb shown across entire site','site_to_announcement_blurb','many_to_many','','Announcement blurb(s)','no','Assign as announcement on sites','bidirectional','Assigned to these sites as an announcement','no'),(368,5907,153396,'Asset Access Permissions to Group','asset_access_permissions_to_group','one_to_many','','Limit access to this asset to a group','no','','unidirectional','','no'),(373,3,240350,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(374,240350,240350,' Audience Archive Relationship','audience_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(375,3,240350,'site borrows Audience','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(376,31512,240350,NULL,'event_to_audience','many_to_many',NULL,'Audiences','yes',NULL,'unidirectional',NULL,'no'),(377,60241,240350,NULL,'faq_to_audience','many_to_many',NULL,'Audiences','yes',NULL,'unidirectional',NULL,'no'),(378,153396,240350,NULL,'group_to_audience','many_to_many',NULL,'Audiences','no',NULL,'unidirectional',NULL,'no'),(379,3,240363,NULL,'owns',NULL,NULL,NULL,NULL,NULL,'unidirectional',NULL,'no'),(380,240363,240363,'HTML Editor Archive Relationship','html_editor_type_archive','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(381,3,240363,'site borrows Editor','borrows','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(382,3,240363,'site uses html editor','site_to_html_editor','one_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(383,4,240350,'user is a member of audience','user_to_audience','many_to_many',NULL,NULL,'no',NULL,'bidirectional',NULL,'yes'),(385,3,240412,NULL,'borrows','many_to_many',NULL,NULL,'no',NULL,'bidirectional',NULL,'no'),(386,240412,240412,NULL,'external_url_archive','many_to_one',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(387,3317,240412,'This relationship allows an external URL to be used as the feed source of an RSS parser/displayer','page_to_feed_url','one_to_many',NULL,'Set up feed to display','no',NULL,'unidirectional','Page(s) using this URL as the feed they display','no'),(388,6564,153392,'Issue to Publication','issue_to_publication','one_to_many',NULL,'Assign this issue to a publication','no',NULL,'unidirectional',NULL,'no'),(389,6564,243,'Issue to Image','issue_to_image','one_to_many',NULL,'Associate an image with this issue','no',NULL,'unidirectional',NULL,'no'),(390,6564,3379,'Issue to Text Blurb','issue_to_text_blurb','many_to_many',NULL,'Associate text blurbs with this issue','no',NULL,'unidirectional',NULL,'no'),(391,32296,153392,'News Section to Publication','news_section_to_publication','one_to_many',NULL,'Assign this section to a publication','no',NULL,'unidirectional',NULL,'no'),(392,32296,243,'News Section to Image','news_section_to_image','one_to_many',NULL,'Associate image with this news section','no',NULL,'unidirectional',NULL,'no'),(393,153392,88,'Publication to Featured Post','publication_to_featured_post','many_to_many',NULL,'Featured Posts','no','Feature on Publication(s)','bidirectional','Featured on Publication(s)','yes'),(394,31512,88,'Event to News / Post','event_to_news','many_to_many',NULL,'Associate with a News Item','no','Assign to event(s)','bidirectional','Events for this news items','yes'),(395,3317,153392,'Attach a related publication','page_to_related_publication','many_to_many',NULL,'Attach a related publication','no','Pages where this publication is a related publication','unidirectional','Pages where this publication is a related publication','yes'),(396,6564,240412,'Attaches CSS to a given issue','issue_to_css_url','many_to_many',NULL,'Issue CSS','no',NULL,'unidirectional',NULL,'yes'),(397,3,240461,NULL,'owns','many_to_one',NULL,NULL,'yes',NULL,'unidirectional',NULL,'no'),(398,3,240461,NULL,'borrows','many_to_many',NULL,NULL,'no',NULL,'bidirectional',NULL,'no'),(399,240461,240461,NULL,'classified_type_archive','many_to_one',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(400,3,240470,NULL,'owns','many_to_one',NULL,NULL,'yes',NULL,'unidirectional',NULL,'no'),(401,3,240470,NULL,'borrows','many_to_many',NULL,NULL,'no',NULL,'bidirectional',NULL,'no'),(402,240470,240470,NULL,'classified_category_type_archive','many_to_one',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(403,240461,240470,NULL,'classified_to_classified_category','many_to_many',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(404,5907,31518,'Asset to Category','asset_to_category','many_to_many',NULL,'Assign to Categories','no','Assets in this category','bidirectional','Assets in this category','yes'),(405,3,240471,NULL,'owns','many_to_one',NULL,NULL,'yes',NULL,'unidirectional',NULL,'no'),(406,3,240471,NULL,'borrows','many_to_many',NULL,NULL,'no',NULL,'bidirectional',NULL,'no'),(407,240471,240471,NULL,'quote_type_archive','many_to_one',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(408,3317,240471,'Association between page and quotes','page_to_quote','many_to_many',NULL,'Place Quotes','no','Place on Pages','bidirectional','Pages with this Quote','yes'),(409,240471,31518,'Asset to Category','quote_to_category','many_to_many',NULL,'Is About Topic / Category','no','Is Subject of Quote','bidirectional','Quotes in this category','yes'),(410,3317,153396,'Limits access to a group','page_to_access_group','one_to_many',NULL,'Restrict Access','no',NULL,'unidirectional','Pages that use this group for access restrictions','no'),(411,3,240517,NULL,'owns','many_to_one',NULL,NULL,'yes',NULL,'unidirectional',NULL,'no'),(412,3,240517,NULL,'borrows','many_to_many',NULL,NULL,'no',NULL,'bidirectional',NULL,'no'),(413,240517,240517,NULL,'feature_type_archive','many_to_one',NULL,NULL,'no',NULL,'unidirectional',NULL,'no'),(414,240517,243,'Feature to Image','feature_to_image','many_to_many',NULL,'Attach Image','no','Add to feature','bidirectional','Features using this image','no'),(415,240517,3861,'Feature to Media Work','feature_to_media_work','many_to_many',NULL,'Attach Media Work','no','Add to feature','bidirectional','Features using this media work','no'),(416,3317,240517,'Page to Feature','page_to_feature','many_to_many',NULL,'Attach Feature','no','Place feature on page','bidirectional','Featured on pages','yes');
/*!40000 ALTER TABLE `allowable_relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset`
--

DROP TABLE IF EXISTS `asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `file_name` varchar(128) DEFAULT NULL,
  `mime_type` varchar(32) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `file_type` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset`
--

LOCK TABLES `asset` WRITE;
/*!40000 ALTER TABLE `asset` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audience_integration`
--

DROP TABLE IF EXISTS `audience_integration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audience_integration` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `directory_service_value` tinytext,
  `directory_service` tinytext,
  `audience_filter` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audience_integration`
--

LOCK TABLES `audience_integration` WRITE;
/*!40000 ALTER TABLE `audience_integration` DISABLE KEYS */;
INSERT INTO `audience_integration` VALUES (240355,'student',NULL,NULL),(240356,'faculty',NULL,NULL),(240357,'staff',NULL,NULL),(240358,'alum',NULL,NULL),(240359,'public',NULL,NULL),(240360,'family',NULL,NULL),(240361,'prospect','ldap_carleton_prospects',NULL),(240362,'new_student','ldap_carleton,ldap_carleton_prospects','(|(ds_affiliation=student)(&(ds_affiliation=prospect)(|(carlProspectStatus=Deferred*)(carlProspectStatus=Deposit*))))');
/*!40000 ALTER TABLE `audience_integration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `av`
--

DROP TABLE IF EXISTS `av`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `av` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `av_type` enum('Audio','Video') DEFAULT NULL,
  `media_duration` tinytext,
  `media_size` tinytext,
  `media_quality` tinytext,
  `media_format` enum('Quicktime','Windows Media','Real','Flash','MP3','AIFF','Flash Video') DEFAULT NULL,
  `height` mediumint(8) unsigned DEFAULT NULL,
  `width` mediumint(8) unsigned DEFAULT NULL,
  `av_part_total` tinyint(4) DEFAULT NULL,
  `av_part_number` tinyint(4) DEFAULT NULL,
  `reason_managed_media` tinyint(1) DEFAULT NULL,
  `media_is_progressively_downloadable` enum('true','false') DEFAULT NULL,
  `media_is_streamed` enum('true','false') DEFAULT NULL,
  `media_md5_sum` tinytext,
  `media_size_in_bytes` int(11) DEFAULT NULL,
  `default_media_delivery_method` enum('progressive_download','streaming') DEFAULT NULL,
  `caption_url` tinytext,
  `audio_description_url` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `av`
--

LOCK TABLES `av` WRITE;
/*!40000 ALTER TABLE `av` DISABLE KEYS */;
/*!40000 ALTER TABLE `av` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bigger_chunk`
--

DROP TABLE IF EXISTS `bigger_chunk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bigger_chunk` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `bigger_content` mediumtext,
  `bigger_author` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bigger_chunk`
--

LOCK TABLES `bigger_chunk` WRITE;
/*!40000 ALTER TABLE `bigger_chunk` DISABLE KEYS */;
/*!40000 ALTER TABLE `bigger_chunk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog`
--

DROP TABLE IF EXISTS `blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `posts_per_page` tinyint(4) DEFAULT '12',
  `blog_feed_string` tinytext,
  `hold_posts_for_review` enum('yes','no') DEFAULT NULL,
  `publication_type` enum('Blog','Newsletter') DEFAULT NULL,
  `has_issues` enum('yes','no') DEFAULT NULL,
  `has_sections` enum('yes','no') DEFAULT NULL,
  `notify_upon_post` tinytext,
  `notify_upon_comment` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog`
--

LOCK TABLES `blog` WRITE;
/*!40000 ALTER TABLE `blog` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bug`
--

DROP TABLE IF EXISTS `bug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bug` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `priority` enum('Do It Now','High','Medium','Normal','Low') DEFAULT NULL,
  `assigned_to` varchar(128) DEFAULT NULL,
  `time_estimate` varchar(32) DEFAULT NULL,
  `bug_type` enum('Bug','Feature','Update','Enhancement','Other') DEFAULT NULL,
  `bug_state` enum('Assigned','In Planning','In Progress','In Testing','Ready To Go','Done','Cancelled','On Hold') DEFAULT NULL,
  `bug_owner` int(10) unsigned NOT NULL DEFAULT '0',
  `bug_client` tinytext,
  `project_scale` enum('small','medium','large') DEFAULT NULL,
  `project_initiation_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bug`
--

LOCK TABLES `bug` WRITE;
/*!40000 ALTER TABLE `bug` DISABLE KEYS */;
/*!40000 ALTER TABLE `bug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `slug` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chunk`
--

DROP TABLE IF EXISTS `chunk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chunk` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author` tinytext,
  `content` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=240533 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chunk`
--

LOCK TABLES `chunk` WRITE;
/*!40000 ALTER TABLE `chunk` DISABLE KEYS */;
INSERT INTO `chunk` VALUES (75394,'',''),(240342,'Matt Ryan','Default Page Locations: blue are available for module placement; grey areas are set by the template'),(208570,'','<p>Please login to complete this form</p>'),(220950,'nwhite','<p>Access to this file is restricted. Please login.</p>'),(240348,NULL,'<h3>Reason Administration Login</h3><p>Please login to access the Reason Administrative Interface</p>'),(240349,NULL,'<h3>Login Expired</h3><p>Your login has expired due to inactivity. Please login again.</p>'),(240448,'','<h3>Welcome to Reason 4 Beta 4</h3>\n<p>Visit <a href=\"http://reason.carleton.edu\">http://reason.carleton.edu</a>.</p>'),(240447,'','<p>Visit <a href=\"http://reason.carleton.edu/\">http://reason.carleton.edu</a> for the latest on Reason development.</p>'),(240450,'','<p>Visit <a href=\"http://reason.carleton.edu\">http://reason.carleton.edu</a> for the latest on Reason development.</p>'),(240449,'','<p>Visit <a href=\"http://reason.carleton.edu\">http://reason.carleton.edu</a> for the latest on Reason development.<br /></p>\n<br />\nVisit <a href=\"http://reason.carleton.edu\">http://reason.carleton.edu</a>.'),(240490,'','<p>Visit <a href=\"http://reason.carleton.edu\">http://reason.carleton.edu</a> for the latest on Reason development.</p>'),(240511,'','<p>Visit <a href=\"http://reason.carleton.edu/\">http://reason.carleton.edu</a> for the latest on Reason development.</p>'),(240516,'','<p>Visit <a href=\"http://reason.carleton.edu/\">http://reason.carleton.edu</a> for the latest on Reason development.</p>'),(240532,'','<p>Visit <a href=\"http://reason.carleton.edu/\">http://reason.carleton.edu</a> for the latest on Reason development.</p>');
/*!40000 ALTER TABLE `chunk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classified_table`
--

DROP TABLE IF EXISTS `classified_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classified_table` (
  `id` int(10) unsigned NOT NULL,
  `location` tinytext,
  `price` decimal(10,2) DEFAULT NULL,
  `classified_print_content` text,
  `classified_date_available` datetime DEFAULT NULL,
  `classified_duration_days` int(11) DEFAULT NULL,
  `classified_contact_email` tinytext,
  `display_contact_info` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classified_table`
--

LOCK TABLES `classified_table` WRITE;
/*!40000 ALTER TABLE `classified_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `classified_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_review`
--

DROP TABLE IF EXISTS `comment_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment_review` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `hold_comments_for_review` enum('yes','no') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_review`
--

LOCK TABLES `comment_review` WRITE;
/*!40000 ALTER TABLE `comment_review` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commenting_settings`
--

DROP TABLE IF EXISTS `commenting_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commenting_settings` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `commenting_state` enum('on','off') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commenting_settings`
--

LOCK TABLES `commenting_settings` WRITE;
/*!40000 ALTER TABLE `commenting_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `commenting_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `date_format`
--

DROP TABLE IF EXISTS `date_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_format` (
  `id` int(10) unsigned NOT NULL,
  `date_format` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `date_format`
--

LOCK TABLES `date_format` WRITE;
/*!40000 ALTER TABLE `date_format` DISABLE KEYS */;
/*!40000 ALTER TABLE `date_format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dated`
--

DROP TABLE IF EXISTS `dated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `datetime` (`datetime`)
) ENGINE=MyISAM AUTO_INCREMENT=240343 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dated`
--

LOCK TABLES `dated` WRITE;
/*!40000 ALTER TABLE `dated` DISABLE KEYS */;
INSERT INTO `dated` VALUES (240342,'0000-00-00 00:00:00');
/*!40000 ALTER TABLE `dated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `days_of_week`
--

DROP TABLE IF EXISTS `days_of_week`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `days_of_week` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `sunday` tinytext,
  `monday` tinytext,
  `tuesday` tinytext,
  `wednesday` tinytext,
  `thursday` tinytext,
  `friday` tinytext,
  `saturday` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `days_of_week`
--

LOCK TABLES `days_of_week` WRITE;
/*!40000 ALTER TABLE `days_of_week` DISABLE KEYS */;
/*!40000 ALTER TABLE `days_of_week` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `display_name`
--

DROP TABLE IF EXISTS `display_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `display_name` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `display_name` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=240536 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `display_name`
--

LOCK TABLES `display_name` WRITE;
/*!40000 ALTER TABLE `display_name` DISABLE KEYS */;
INSERT INTO `display_name` VALUES (3250,'Default View'),(3251,'List'),(3468,'List'),(3989,'Default'),(6301,'List'),(7435,'Tree'),(156572,'Default'),(140154,'Default'),(9440,'List'),(119825,'Default'),(27787,'List'),(22126,'list'),(22039,'List'),(13860,'Tree'),(13861,'List'),(14014,''),(14423,'list'),(35398,'Default Listing'),(36806,''),(57366,'Standard'),(240459,'List'),(240510,'Sections and Issues'),(240535,NULL);
/*!40000 ALTER TABLE `display_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `duration`
--

DROP TABLE IF EXISTS `duration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duration` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `duration` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `duration`
--

LOCK TABLES `duration` WRITE;
/*!40000 ALTER TABLE `duration` DISABLE KEYS */;
/*!40000 ALTER TABLE `duration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `duration_time`
--

DROP TABLE IF EXISTS `duration_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duration_time` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `hours` tinyint(4) DEFAULT NULL,
  `minutes` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `duration_time`
--

LOCK TABLES `duration_time` WRITE;
/*!40000 ALTER TABLE `duration_time` DISABLE KEYS */;
/*!40000 ALTER TABLE `duration_time` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity`
--

DROP TABLE IF EXISTS `entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext,
  `type` int(10) unsigned NOT NULL DEFAULT '0',
  `last_edited_by` int(10) unsigned NOT NULL DEFAULT '0',
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `unique_name` varchar(64) NOT NULL DEFAULT '',
  `state` enum('Pending','Live','Deleted','Archived') DEFAULT 'Pending',
  `creation_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `no_share` tinyint(1) DEFAULT '0',
  `new` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `type_index` (`type`),
  KEY `unique_name_index` (`unique_name`(10)),
  KEY `state` (`state`)
) ENGINE=MyISAM AUTO_INCREMENT=240537 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity`
--

LOCK TABLES `entity` WRITE;
/*!40000 ALTER TABLE `entity` DISABLE KEYS */;
INSERT INTO `entity` VALUES (1,'Type',1,240474,'2008-09-24 23:16:39','type','Live','0000-00-00 00:00:00',0,0,6),(2,'Entity Table',1,6,'2008-01-22 00:35:44','content_table','Live','0000-00-00 00:00:00',0,0,6),(3,'Site',1,6,'2006-12-15 21:46:10','site','Live','0000-00-00 00:00:00',0,0,6),(4,'User',1,6,'2006-12-12 23:48:02','user','Live','0000-00-00 00:00:00',0,0,6),(5,'MASTER ADMIN',3,240455,'2008-01-22 00:22:22','master_admin','Live','0000-00-00 00:00:00',0,0,240408),(6,'root',4,6,'2008-01-22 00:27:07','root','Live','0000-00-00 00:00:00',0,0,6),(7,'type',2,6,'2002-11-21 20:09:40','entity_table_type','Live','0000-00-00 00:00:00',0,0,6),(8,'site',2,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(38,'Allowable Relationship Manager',36,6,'2007-07-20 20:24:13','alrel_manager_admin_link','Live','0000-00-00 00:00:00',0,0,6),(37,'url',2,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(36,'Admin Link',1,6,'2006-09-27 17:48:55','admin_link','Live','0000-00-00 00:00:00',0,0,6),(3624,'default_sort',2820,6,'2006-09-27 17:48:55','','Live','2002-12-11 16:39:14',0,0,6),(79,'chunk',2,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(80,'dated',2,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(81,'image',2,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(82,'meta',2,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(83,'newstype',2,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(84,'press_release',2,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(86,'sortable',2,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(87,'status',2,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(88,'News / Post',1,240474,'2008-09-24 23:15:36','news','Live','0000-00-00 00:00:00',0,0,6),(243,'Image',1,6,'2006-12-15 21:46:10','image','Live','0000-00-00 00:00:00',0,0,6),(2787,'Tree',2785,6,'2006-09-27 17:48:55','tree_view','Live','0000-00-00 00:00:00',0,0,6),(2786,'List',2785,6,'2006-09-27 17:48:55','generic_lister','Live','0000-00-00 00:00:00',0,0,6),(2812,'View',1,6,'2006-09-27 17:48:55','view','Live','0000-00-00 00:00:00',0,0,6),(3229,'location',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3228,'contact_phone',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(2785,'View Type',1,6,'2006-09-27 17:48:55','view_type','Live','0000-00-00 00:00:00',0,0,6),(2820,'Field',1,6,'2006-09-27 17:48:55','field','Live','0000-00-00 00:00:00',0,0,6),(3231,'release_title',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3230,'release_number',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(2944,'field',2,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(2142,'show_hide',2,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(2823,'Project',1,6,'2006-09-27 17:48:55','project','Live','0000-00-00 00:00:00',0,0,6),(2830,'display_name',2,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3317,'Page',1,240495,'2010-04-07 21:56:37','minisite_page','Live','0000-00-00 00:00:00',0,0,6),(3247,'show_hide',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3246,'plasmature_type',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3245,'db_type',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3244,'testtesttest',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3243,'test_field',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3250,'Field Viewer',2812,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3237,'publish_end_date',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3236,'publish_start_date',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3251,'View View',2812,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3249,'display_name',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3235,'status',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3234,'sort_order',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3227,'contact_title',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3226,'contact_email',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3225,'contact_name',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3224,'news_type',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3223,'keywords',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3222,'description',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3221,'image_type',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3220,'size',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3219,'height',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3218,'width',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3217,'datetime',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3216,'content',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3215,'author',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3190,'html',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3179,'url',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3178,'primary_maintainer',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3177,'display_name_handler',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3176,'custom_deleter',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3175,'custom_content_lister_dev',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3174,'custom_content_lister',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3173,'custom_content_handler_dev',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3172,'custom_content_handler',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3311,'External CSS Url',1,6,'2006-09-27 17:48:55','css','Live','0000-00-00 00:00:00',0,0,6),(3313,'Minisite Template',1,6,'2006-09-27 17:48:55','minisite_template','Live','0000-00-00 00:00:00',0,0,6),(3323,'view_options',2,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3324,'column_order',2820,6,'2006-09-27 17:48:55','','Live','0000-00-00 00:00:00',0,0,6),(3379,'Text Blurb',1,6,'2006-09-27 17:48:55','text_blurb','Live','2002-11-26 19:13:59',0,0,6),(3468,'Image View',2812,6,'2006-09-27 17:48:55','standard_image_view','Live','2002-12-02 16:55:29',0,0,6),(3486,'Reason Stats',36,6,'2006-09-27 18:37:47','reason_stats_admin_link','Live','2002-12-03 17:13:28',0,0,6),(3496,'Delete Widowed Relationships',36,6,'2006-09-27 18:33:12','delete_widowed_relationships_admin_link','Live','2002-12-03 22:38:02',0,0,6),(3497,'Delete Headless Chickens',36,6,'2006-09-27 18:32:14','delete_headless_chickens_admin_link','Live','2002-12-03 22:57:49',0,0,6),(3498,'Delete Duplicate Relationships',36,6,'2006-09-27 18:30:56','delete_duplicate_relationships_admin_link','Live','2002-12-03 23:27:05',0,0,6),(3501,'Fix Amputees',36,6,'2006-09-27 18:34:01','fix_amputees_admin_link','Live','2002-12-04 00:10:35',0,0,6),(3585,'base_url',2820,6,'2006-09-27 17:48:55','','Live','2002-12-09 22:05:13',0,0,6),(3628,'page_node',2,6,'2006-09-27 17:48:55','','Live','2002-12-11 19:39:47',0,0,6),(3629,'url_fragment',2820,6,'2006-09-27 17:48:55','','Live','2002-12-11 19:40:22',0,0,6),(3861,'Media Work',1,6,'2006-09-27 17:48:55','av','Live','2003-01-02 21:03:38',0,0,6),(3862,'av',2,6,'2006-09-27 17:48:55','','Live','2003-01-02 21:04:47',0,0,6),(3863,'av_type',2820,6,'2006-09-27 17:48:55','','Live','2003-01-02 21:05:13',0,0,6),(3864,'media_duration',2820,6,'2006-09-27 17:48:55','','Live','2003-01-02 21:05:33',0,0,6),(3865,'media_size',2820,6,'2006-09-27 17:48:55','','Live','2003-01-02 21:05:50',0,0,6),(3866,'media_quality',2820,6,'2006-09-27 17:48:55','','Live','2003-01-02 21:06:06',0,0,6),(3867,'media_format',2820,6,'2006-09-27 17:48:55','','Live','2003-01-02 21:06:35',0,0,6),(3868,'height',2820,6,'2006-09-27 17:48:55','','Live','2003-01-02 21:06:50',0,0,6),(3870,'width',2820,6,'2006-09-27 17:48:55','','Live','2003-01-02 21:07:16',0,0,6),(3871,'Media File',1,6,'2006-09-27 17:48:55','av_file','Live','2003-01-02 21:07:47',0,0,6),(3989,'Default Project View',2812,6,'2006-09-27 17:48:55','','Live','2003-01-09 16:03:42',0,0,6),(4264,'User Role',1,6,'2006-09-27 17:48:55','user_role','Live','2003-01-14 23:24:38',0,0,6),(4265,'Administrator',4264,6,'2006-09-27 17:48:55','admin_role','Live','2003-01-14 23:26:42',0,0,6),(4266,'extra_head_content',2820,6,'2006-09-27 17:48:55','','Live','2003-01-14 23:29:38',0,0,6),(5390,'short_department_name',2820,6,'2006-09-27 17:48:55','','Live','2003-03-06 23:14:34',0,0,6),(5391,'department',2820,6,'2006-09-27 17:48:55','','Live','2003-03-06 23:14:51',0,0,6),(5392,'custom_page',2820,6,'2006-09-27 17:48:55','','Live','2003-03-06 23:15:09',0,0,6),(5397,'Faculty / Staff',1,6,'2006-12-15 21:46:10','faculty_staff','Live','2003-03-06 23:24:57',0,0,6),(5832,'num_per_page',2820,6,'2006-09-27 17:48:55','','Live','2003-04-01 21:08:58',0,0,6),(5833,'asset_directory',2820,6,'2006-09-27 17:48:55','','Live','2003-04-01 21:08:58',0,0,6),(5834,'plural_name',2820,6,'2006-09-27 17:48:55','','Live','2003-04-01 21:08:58',0,0,6),(5835,'custom_previewer',2820,6,'2006-09-27 17:48:55','','Live','2003-04-01 21:08:58',0,0,6),(5836,'finish_actions',2820,6,'2006-09-27 17:48:55','','Live','2003-04-01 21:08:58',0,0,6),(5837,'loki_default',2820,6,'2006-09-27 17:48:55','','Live','2003-04-01 21:08:58',0,0,6),(5890,'Policy',1,240515,'2011-07-06 20:35:58','policy_type','Live','2003-04-02 17:55:02',0,0,6),(5907,'Asset',1,6,'2006-09-27 17:48:55','asset','Live','2003-04-02 22:11:44',0,0,6),(5909,'asset',2,6,'2006-09-27 17:48:55','','Live','2003-04-02 22:15:12',0,0,6),(5910,'file_name',2820,6,'2006-09-27 17:48:55','','Live','2003-04-02 22:18:46',0,0,6),(5911,'mime_type',2820,6,'2006-09-27 17:48:55','','Live','2003-04-02 22:19:30',0,0,6),(5912,'file_size',2820,6,'2006-09-27 17:48:55','','Live','2003-04-02 22:20:11',0,0,6),(5913,'file_type',2820,6,'2006-09-27 17:48:55','','Live','2003-04-02 22:21:05',0,0,6),(6296,'list_styles',2,6,'2006-09-27 17:48:55','list_styles','Live','2003-04-08 20:09:59',0,0,6),(6298,'numbering_scheme',2820,6,'2006-09-27 17:48:55','numbering_scheme','Live','2003-04-08 20:15:29',0,0,6),(6301,'Policy List View',2812,6,'2006-09-27 17:48:55','','Live','2003-04-08 21:12:00',0,0,6),(6505,'numbered',2,6,'2006-09-27 17:48:55','numbered','Live','2003-04-10 16:09:49',0,0,6),(6506,'number',2820,6,'2006-09-27 17:48:55','number_field','Live','2003-04-10 16:10:56',0,0,6),(6555,'custom_sorter',2820,6,'2006-09-27 17:48:55','custom_sorter','Live','2003-04-10 18:53:08',0,0,6),(6564,'Issue',1,6,'2006-09-27 17:48:55','issue_type','Live','2003-04-10 20:19:16',0,0,6),(6582,'show_on_front_page',2820,6,'2006-09-27 17:48:55','','Live','2003-04-10 22:47:49',0,0,6),(6596,'is_adventure',2820,6,'2006-09-27 17:48:55','is_adventure','Live','2003-04-11 15:11:55',0,0,6),(6597,'brief_name',2820,6,'2006-09-27 17:48:55','adventure_brief_name','Live','2003-04-11 15:13:08',0,0,6),(6598,'duration',2820,6,'2006-09-27 17:48:55','adventure_duration','Live','2003-04-11 15:13:42',0,0,6),(7430,'Multiple Root Tree View',2785,6,'2006-09-27 17:48:55','','Live','2003-04-22 16:10:56',0,0,6),(7435,'Policy Multiple Root Node Tree',2812,6,'2006-09-27 17:48:55','','Live','2003-04-22 16:15:02',0,0,6),(9406,'New Default Minisite CSS',3311,240495,'2010-04-07 21:56:50','','Live','2003-05-27 21:42:05',0,0,6),(9440,'Site List View',2812,6,'2006-09-27 17:48:55','','Live','2003-05-28 20:24:40',0,0,6),(10204,'nav_display',2820,6,'2006-09-27 17:48:55','','Live','2003-06-06 19:33:19',0,0,6),(10205,'link_name',2820,6,'2006-09-27 17:48:55','','Live','2003-06-06 19:34:07',0,0,6),(13860,'Default Minisite Page Tree View',2812,6,'2006-09-27 17:48:55','default_minisite_page_tree_view','Live','2003-07-07 14:51:29',0,0,6),(13861,'Default Minisite Page List View',2812,6,'2006-09-27 17:48:55','default_minisite_page_list_view','Live','2003-07-07 14:51:29',0,0,6),(13993,'Task',1,6,'2006-12-15 21:46:10','bug','Live','2003-07-07 19:05:44',0,0,6),(13994,'bug',2,6,'2006-09-27 17:48:55','','Live','2003-07-07 19:06:54',0,0,6),(13997,'priority',2820,6,'2006-09-27 17:48:55','','Live','2003-07-07 19:10:03',0,0,6),(14005,'assigned_to',2820,6,'2006-09-27 17:48:55','','Live','2003-07-07 19:13:34',0,0,6),(14007,'time_estimate',2820,6,'2006-09-27 17:48:55','','Live','2003-07-07 19:14:04',0,0,6),(14008,'bug_type',2820,6,'2006-09-27 17:48:55','','Live','2003-07-07 19:14:43',0,0,6),(14014,'Webdev Bug Tracker View',2812,6,'2006-09-27 17:48:55','','Live','2003-07-07 19:19:15',0,0,6),(14023,'bug_state',2820,6,'2006-09-27 17:48:55','','Live','2003-07-07 19:38:06',0,0,6),(14287,'bug_owner',2820,6,'2006-09-27 17:48:55','','Live','2003-07-08 19:01:44',0,0,6),(14423,'Faculty / Staff',2812,6,'2006-09-27 17:48:55','fac_staff_view','Live','2003-07-09 14:57:20',0,0,6),(14981,'faculty_staff',2,6,'2006-09-27 17:48:55','','Live','2003-07-11 18:11:37',0,0,6),(15008,'affiliation',2820,6,'2006-09-27 17:48:55','','Live','2003-07-11 18:41:13',0,0,6),(15198,'site_state',2820,6,'2006-09-27 17:48:55','','Live','2003-07-11 21:06:02',0,0,6),(16159,'custom_post_deleter',2820,6,'2006-09-27 17:48:55','','Live','2003-07-21 16:38:12',0,0,6),(16867,'user',2,6,'2006-09-27 17:48:55','','Live','2003-07-23 18:11:46',0,0,6),(16868,'site_window_pref',2820,6,'2006-09-27 17:48:55','','Live','2003-07-23 18:12:03',0,0,6),(17685,'Update URLs',36,6,'2006-09-27 18:43:10','update_urls_admin_link','Live','2003-07-30 16:36:13',0,0,6),(240505,'New Default Minisite CSS',3311,6,'2006-09-27 17:48:55','','Archived','2003-05-27 21:42:05',0,0,6),(22039,'External CSS View',2812,6,'2006-09-27 17:48:55','','Live','2003-09-05 15:19:55',0,0,6),(22126,'General News View',2812,6,'2006-09-27 17:48:55','','Live','2003-09-05 17:09:26',0,0,6),(24931,'duration',2,6,'2006-09-27 17:48:55','','Live','2003-10-01 18:41:02',0,0,6),(24936,'duration',2820,6,'2006-09-27 17:48:55','','Live','2003-10-01 18:45:38',0,0,6),(27608,'minutes',2,6,'2006-09-27 17:48:55','','Live','2003-10-22 22:14:01',0,0,6),(27609,'minutes_status',2820,6,'2006-09-27 17:48:55','','Live','2003-10-22 22:15:04',0,0,6),(27610,'present_members',2820,6,'2006-09-27 17:48:55','','Live','2003-10-22 22:15:54',0,0,6),(27611,'location',2820,6,'2006-09-27 17:48:55','','Live','2003-10-22 22:16:51',0,0,6),(27612,'organization',2820,6,'2006-09-27 17:48:55','','Live','2003-10-22 22:17:33',0,0,6),(27613,'guests',2820,6,'2006-09-27 17:48:55','','Live','2003-10-22 22:18:06',0,0,6),(27614,'absent_members',2820,6,'2006-09-27 17:48:55','','Live','2003-10-22 22:18:30',0,0,6),(27615,'bigger_chunk',2,6,'2006-09-27 17:48:55','','Live','2003-10-22 22:19:13',0,0,6),(27616,'bigger_content',2820,6,'2006-09-27 17:48:55','','Live','2003-10-22 22:19:48',0,0,6),(27617,'bigger_author',2820,6,'2006-09-27 17:48:55','','Live','2003-10-22 22:20:12',0,0,6),(27618,'Minutes',1,6,'2006-09-27 17:48:55','minutes_type','Live','2003-10-22 22:20:49',0,0,6),(27787,'General Minutes View',2812,6,'2006-09-27 17:48:55','','Live','2003-10-23 23:34:02',0,0,6),(31486,'duration_time',2,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:29:42',0,0,6),(31487,'hours',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:30:39',0,0,6),(31488,'minutes',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:31:07',0,0,6),(240504,'Theme',1,6,'2007-07-20 20:15:33','theme_type','Archived','2005-11-09 22:20:19',0,0,6),(31490,'location',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:32:15',0,0,6),(31491,'event',2,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:35:18',0,0,6),(31492,'contact_username',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:35:38',0,0,6),(31493,'frequency',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:36:15',0,0,6),(31494,'week_of_month',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:36:57',0,0,6),(31495,'month_day_of_week',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:37:31',0,0,6),(31496,'sponsor',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:37:58',0,0,6),(31497,'contact_organization',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:38:18',0,0,6),(31498,'end_date',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:38:42',0,0,6),(31499,'term_only',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:39:07',0,0,6),(31500,'recurrence',2820,240493,'2008-10-08 20:31:33','','Live','2003-12-01 21:39:40',0,0,6),(31501,'dates',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:39:55',0,0,6),(31502,'last_occurence',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:40:13',0,0,6),(31503,'calendar_record',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:40:48',0,0,6),(31504,'days_of_week',2,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:41:23',0,0,6),(31505,'sunday',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:41:43',0,0,6),(31506,'monday',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:42:13',0,0,6),(31507,'tuesday',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:42:44',0,0,6),(31508,'wednesday',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:43:10',0,0,6),(31509,'thursday',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:43:42',0,0,6),(31510,'friday',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:44:05',0,0,6),(31511,'saturday',2820,6,'2006-09-27 17:48:55','','Live','2003-12-01 21:44:26',0,0,6),(31512,'Event',1,6,'2006-12-15 21:46:10','event_type','Live','2003-12-01 21:46:21',0,0,6),(31515,'category',2,6,'2006-09-27 17:48:55','','Live','2003-12-01 22:00:46',0,0,6),(240506,'Entity Info',36,240495,'2010-04-07 21:56:50','','Live','2010-04-07 21:56:50',0,0,240495),(31518,'Category',1,6,'2006-09-27 17:48:55','category_type','Live','2003-12-01 22:02:09',0,0,6),(32296,'News Section',1,6,'2008-01-22 00:25:53','news_section_type','Live','2003-12-11 19:40:16',0,0,6),(32328,'degrees',2820,6,'2006-09-27 17:48:55','','Live','2003-12-11 22:05:35',0,0,6),(33122,'Non-Reason Site',1,6,'2006-09-27 17:48:55','non_reason_site_type','Live','2003-12-18 17:44:08',0,0,6),(33304,'monthly_repeat',2820,6,'2006-09-27 17:48:55','monthly_repeat','Live','2003-12-19 20:11:20',0,0,6),(34442,'Move Entities Among Sites',36,6,'2006-09-27 18:35:52','move_entities_among_sites_admin_link','Live','2004-01-02 20:23:47',0,0,6),(34592,'names',2820,6,'2006-09-27 17:48:55','','Live','2004-01-04 05:11:05',0,0,6),(34593,'subtitle',2820,6,'2006-09-27 17:48:55','','Live','2004-01-04 05:12:12',0,0,6),(34594,'author_description',2820,6,'2006-09-27 17:48:55','','Live','2004-01-04 05:17:48',0,0,6),(35398,'Event View',2812,6,'2006-09-27 17:48:55','','Live','2004-01-09 17:31:23',0,0,6),(36089,'registration',2820,6,'2006-09-27 17:48:55','','Live','2004-01-16 00:35:32',0,0,6),(36806,'Non-Reason Site View',2812,6,'2006-09-27 17:48:55','','Live','2004-01-22 01:15:00',0,0,6),(37716,'ldap_cache',2,6,'2006-09-27 17:48:55','','Live','2004-01-28 21:06:16',0,0,6),(37717,'name_cache',2820,6,'2006-09-27 17:48:55','','Live','2004-01-28 21:06:58',0,0,6),(37718,'email_cache',2820,6,'2006-09-27 17:48:55','','Live','2004-01-28 21:07:37',0,0,6),(37719,'cache_last_updated',2820,6,'2006-09-27 17:48:55','','Live','2004-01-28 21:08:21',0,0,6),(37720,'username_cache',2820,6,'2006-09-27 17:48:55','','Live','2004-01-28 21:08:57',0,0,6),(39572,'author_description',2820,6,'2006-09-27 17:48:55','','Live','2004-02-09 07:45:12',0,0,6),(41962,'office',2820,6,'2006-09-27 17:48:55','office','Live','2004-02-24 22:52:12',0,0,6),(40592,'job',2,6,'2006-09-27 17:48:55','','Live','2004-02-16 21:36:21',0,0,6),(40598,'posting_start',2820,6,'2006-09-27 17:48:55','posting_start','Live','2004-02-16 21:42:59',0,0,6),(40599,'title_extension',2820,6,'2006-09-27 17:48:55','title_extension','Live','2004-02-16 21:43:34',0,0,6),(40654,'Contributor Only',4264,6,'2006-09-27 17:48:55','contribute_only_role','Live','2004-02-16 22:56:21',0,0,6),(41862,'position_start',2820,6,'2006-09-27 17:48:55','position_start','Live','2004-02-24 21:08:00',0,0,6),(41963,'Job',1,6,'2006-09-27 17:48:55','job','Live','2004-02-24 22:57:09',0,0,6),(42283,'custom_feed',2820,6,'2006-09-27 17:48:55','','Live','2004-02-26 21:08:16',0,0,6),(42284,'feed_url_string',2820,6,'2006-09-27 17:48:55','','Live','2004-02-26 21:08:52',0,0,6),(44321,'Form',1,6,'2006-09-27 17:48:55','form','Live','2004-03-16 16:55:22',0,0,6),(44322,'form',2,6,'2006-09-27 17:48:55','','Live','2004-03-16 16:57:19',0,0,6),(44324,'email_of_recipient',2820,6,'2006-09-27 17:48:55','','Live','2004-03-16 16:58:57',0,0,6),(44325,'thor_content',2820,6,'2006-09-27 17:48:55','','Live','2004-03-16 16:59:43',0,0,6),(44326,'thank_you_message',2820,6,'2006-09-27 17:48:55','','Live','2004-03-16 17:00:11',0,0,6),(44414,'other_base_urls',2820,6,'2006-09-27 17:48:55','','Live','2004-03-16 23:50:42',0,0,6),(46125,'Power User',4264,6,'2006-09-27 17:48:55','power_user_role','Live','2004-04-01 23:48:30',0,0,6),(50972,'tables',3313,6,'2006-12-12 23:48:02','','Live','2004-05-05 22:37:21',0,0,6),(54388,'Office/Department',1,6,'2006-09-27 17:48:55','office_department_type','Live','2004-06-01 22:23:55',0,0,6),(54389,'synchronization',2,6,'2006-09-27 17:48:55','','Live','2004-06-01 22:25:33',0,0,6),(54391,'office_department',2,6,'2006-09-27 17:48:55','','Live','2004-06-01 22:26:13',0,0,6),(54394,'sync_name',2820,6,'2006-09-27 17:48:55','','Live','2004-06-01 22:27:29',0,0,6),(54396,'office_department_code',2820,6,'2006-09-27 17:48:55','','Live','2004-06-01 22:28:33',0,0,6),(54398,'office_department_type',2820,6,'2006-09-27 17:48:55','','Live','2004-06-01 22:29:09',0,0,6),(55597,'tenure_track',2820,6,'2006-09-27 17:48:55','','Live','2004-06-09 21:50:46',0,0,6),(57366,'Offices and Departments Default View',2812,6,'2006-09-27 17:48:55','','Live','2004-06-22 23:00:16',0,0,6),(60241,'FAQ',1,6,'2006-09-27 17:48:55','faq_type','Live','2004-07-14 17:23:33',0,0,6),(75393,'Login',3,240455,'2008-01-22 00:22:22','site_login','Live','2004-10-05 02:52:50',0,0,240408),(75394,'Login',3317,6,'2006-09-27 17:48:55','page_login','Live','2004-10-05 02:53:35',0,0,6),(75398,'Site User',1,6,'2006-09-27 17:48:55','site_user_type','Live','2004-10-05 03:02:47',0,0,6),(81327,'Import Photos',36,6,'2006-09-27 18:35:01','import_photos_admin_link','Live','2004-11-02 17:15:25',0,0,6),(240342,'Default Page Locations',243,6,'2006-09-27 18:52:06','default_page_locations_image','Live','2006-09-27 18:50:36',0,0,6),(240344,'core',136617,6,'2006-09-27 18:57:39','core_site_type','Live','2006-09-27 18:57:03',0,0,6),(82481,'custom_url_handler',2820,6,'2006-09-27 17:48:55','','Live','2004-11-07 23:45:19',0,0,6),(89798,'use_page_caching',2820,6,'2006-09-27 17:48:55','','Live','2004-12-14 21:44:07',0,0,6),(122405,'job_category',2820,6,'2006-09-27 17:48:55','','Live','2005-06-28 18:55:03',0,0,6),(122403,'supervisor',2820,6,'2006-09-27 17:48:55','','Live','2005-06-28 18:54:39',0,0,6),(122401,'dept_charge_number',2820,6,'2006-09-27 17:48:55','','Live','2005-06-28 18:53:59',0,0,6),(122399,'break_job',2820,6,'2006-09-27 17:48:55','','Live','2005-06-28 18:53:21',0,0,6),(122397,'term_job',2820,6,'2006-09-27 17:48:55','','Live','2005-06-28 18:51:53',0,0,6),(102782,'bug_client',2820,6,'2006-09-27 17:48:55','','Live','2005-03-04 23:56:18',0,0,6),(109269,'Search Across All Reason Sites',36,6,'2006-09-27 18:42:27','find_across_sites_admin_link','Live','2005-04-08 23:32:46',0,0,6),(118606,'Project Type',1,6,'2006-09-27 17:48:55','project_type_type','Live','2005-06-03 19:41:25',0,0,6),(118627,'project_scale',2820,6,'2006-09-27 17:48:55','','Live','2005-06-03 19:52:25',0,0,6),(118704,'project_initiation_date',2820,6,'2006-09-27 17:48:55','','Live','2005-06-06 16:45:59',0,0,6),(119825,'Default Job View',2812,6,'2006-09-27 17:48:55','','Live','2005-06-16 15:01:23',0,0,6),(124306,'Page Tree',2785,6,'2006-09-27 17:48:55','','Live','2005-07-13 15:25:47',0,0,6),(198122,'original_image_format',2820,6,'2006-09-27 17:48:55','','Live','2006-04-01 18:23:00',0,0,6),(206501,'db_flag',2820,6,'2006-09-27 17:48:55','','Live','2006-04-28 19:38:40',0,0,6),(136617,'Site Type',1,230314,'2007-10-27 22:03:21','site_type_type','Live','2005-09-13 22:41:23',0,0,6),(139466,'av_part_total',2820,6,'2006-09-27 17:48:55','','Live','2005-09-21 18:04:59',0,0,6),(139468,'av_part_number',2820,6,'2006-09-27 17:48:55','','Live','2005-09-21 18:05:23',0,0,6),(140154,'Default Asset View',2812,6,'2006-09-27 17:48:55','','Live','2005-09-22 22:14:00',0,0,6),(149703,'ldap_created',2820,6,'2006-09-27 17:48:55','','Live','2005-09-29 18:44:40',0,0,6),(153366,'comment_review',2,6,'2006-09-27 17:48:55','','Live','2005-10-07 15:42:24',0,0,6),(153368,'commenting_settings',2,6,'2006-09-27 17:48:55','','Live','2005-10-07 15:42:56',0,0,6),(153370,'user_group',2,6,'2006-09-27 17:48:55','','Live','2005-10-07 15:43:14',0,0,6),(153372,'blog',2,6,'2006-09-27 17:48:55','','Live','2005-10-07 15:43:34',0,0,6),(153374,'hold_comments_for_review',2820,6,'2006-09-27 17:48:55','','Live','2005-10-07 15:44:10',0,0,6),(153376,'commenting_state',2820,6,'2006-09-27 17:48:55','','Live','2005-10-07 15:44:46',0,0,6),(153378,'require_authentication',2820,6,'2006-09-27 17:48:55','','Live','2005-10-07 15:45:25',0,0,6),(153380,'limit_authorization',2820,6,'2006-09-27 17:48:55','','Live','2005-10-07 15:45:56',0,0,6),(153382,'authorized_usernames',2820,6,'2006-09-27 17:48:55','','Live','2005-10-07 15:46:24',0,0,6),(153384,'arbitrary_ldap_query',2820,6,'2006-09-27 17:48:55','','Live','2005-10-07 15:46:54',0,0,6),(153388,'posts_per_page',2820,6,'2006-09-27 17:48:55','','Live','2005-10-07 15:47:53',0,0,6),(153390,'blog_feed_string',2820,6,'2006-09-27 17:48:55','','Live','2005-10-07 15:48:23',0,0,6),(153392,'Blog / Publication',1,6,'2007-07-20 20:16:04','publication_type','Live','2005-10-07 15:48:57',0,0,6),(153394,'Comment',1,6,'2006-09-27 17:48:55','comment_type','Live','2005-10-07 15:50:14',0,0,6),(153396,'Group',1,6,'2006-12-15 21:46:10','group_type','Live','2005-10-07 15:51:47',0,0,6),(156572,'Audio/Video File Default',2812,6,'2006-09-27 17:48:55','','Live','2005-10-19 19:51:22',0,0,6),(161656,'Theme',1,240495,'2010-04-07 21:56:50','theme_type','Live','2005-11-09 22:20:19',0,0,6),(162047,'allow_site_to_change_theme',2820,6,'2006-09-27 17:48:55','','Live','2005-11-11 00:29:45',0,0,6),(182052,'registration_slot',2,6,'2006-09-27 17:48:55','','Live','2006-02-01 20:03:59',0,0,6),(182058,'registrant_data',2820,6,'2006-09-27 17:48:55','','Live','2006-02-01 20:19:17',0,0,6),(182067,'registration_slot_capacity',2820,6,'2006-09-27 17:48:55','','Live','2006-02-01 20:29:46',0,0,6),(182069,'slot_description',2820,6,'2006-09-27 17:48:55','','Live','2006-02-01 20:30:29',0,0,6),(182075,'Registration Slot',1,6,'2006-09-27 17:48:55','registration_slot_type','Live','2006-02-01 20:33:51',0,0,6),(191710,'Unbranded',161656,6,'2006-09-27 18:18:04','unbranded_theme','Live','2006-03-04 14:20:06',0,0,6),(240318,'base_breadcrumbs',2820,6,'2006-09-27 17:48:55','','Live','2006-09-27 15:54:42',0,0,6),(195060,'Tableless 2 Unbranded',161656,6,'2006-09-27 18:18:22','tableless_2_unbranded_theme','Live','2006-03-17 15:56:43',0,0,6),(195062,'default',3313,6,'2006-12-12 23:48:02','','Live','2006-03-17 15:57:15',0,0,6),(195065,'Simplicity Blue',161656,6,'2006-12-12 23:48:02','opensource_reason_theme','Live','2006-03-17 15:57:36',0,0,6),(195066,'Tableless 3-Column Layout 1',3311,6,'2006-12-12 23:48:02','','Live','2006-03-17 15:57:55',0,0,6),(195069,'Simplicity Blue',3311,6,'2006-12-12 23:48:02','','Live','2006-03-17 16:00:45',0,0,6),(197558,'rights',2,6,'2006-09-27 17:48:55','','Live','2006-03-29 22:37:33',0,0,6),(197560,'media_work',2,6,'2006-09-27 17:48:55','','Live','2006-03-29 22:37:46',0,0,6),(197562,'rights_statement',2820,6,'2006-09-27 17:48:55','','Live','2006-03-29 22:38:00',0,0,6),(197564,'transcript_status',2820,6,'2006-09-27 17:48:55','','Live','2006-03-29 22:38:50',0,0,6),(197648,'reason_managed_media',2820,6,'2006-09-27 17:48:55','','Live','2006-03-30 00:26:10',0,0,6),(197650,'media_is_progressively_downloadable',2820,6,'2006-09-27 17:48:55','','Live','2006-03-30 00:26:58',0,0,6),(197652,'media_is_streamed',2820,6,'2006-09-27 17:48:55','','Live','2006-03-30 00:27:38',0,0,6),(197654,'media_md5_sum',2820,6,'2006-09-27 17:48:55','','Live','2006-03-30 00:28:01',0,0,6),(197656,'media_size_in_bytes',2820,6,'2006-09-27 17:48:55','','Live','2006-03-30 00:28:31',0,0,6),(197658,'default_media_delivery_method',2820,6,'2006-09-27 17:48:55','','Live','2006-03-30 00:29:13',0,0,6),(207189,'Unbranded Basic Blue',161656,6,'2006-09-27 18:18:48','unbranded_basic_blue_theme','Live','2006-05-01 20:49:38',0,0,6),(208570,'Form Login Message',3379,6,'2006-09-27 17:48:55','form_login_msg','Live','2006-05-04 18:42:30',0,0,6),(210576,'display_return_link',2820,6,'2006-09-27 17:48:55','','Live','2006-05-09 21:00:35',0,0,6),(218985,'magic_string_autofill',2820,6,'2006-09-27 17:48:55','','Live','2006-06-13 16:45:53',0,0,6),(219880,'admin_link',2,6,'2006-09-27 17:48:55','','Live','2006-06-14 21:10:39',0,0,6),(219882,'relative_to_reason_http_base',2820,6,'2006-09-27 17:48:55','','Live','2006-06-14 21:10:58',0,0,6),(220950,'Login to Access File',3379,6,'2006-09-27 17:48:55','login_to_access_file','Live','2006-06-19 16:45:57',0,0,6),(221355,'Remove Duplicate Entities',36,6,'2006-09-27 18:38:35','remove_duplicate_entities_admin_link','Live','2006-06-21 01:25:31',0,0,6),(221357,'Sample Pages for Each Page Type',36,6,'2006-09-27 18:41:29','sample_pages_for_each_page_type_admin_link','Live','2006-06-21 01:27:39',0,0,6),(221359,'Sample Content Listers/Managers for each Reason Type',36,6,'2006-09-27 18:39:42','get_type_listers_admin_link','Live','2006-06-21 01:33:02',0,0,6),(221365,'Sample Pages for Each Module',36,6,'2006-09-27 18:40:34','sample_pages_for_each_module_admin_link','Live','2006-06-21 01:41:39',0,0,6),(221372,'Page Type Information',36,6,'2006-09-27 18:36:41','view_page_type_info_admin_link','Live','2006-06-21 01:45:27',0,0,6),(230314,'causal_agent',4,6,'2006-09-27 17:48:55','','Live','2006-08-09 21:02:36',0,0,6),(236257,'media_publication_datetime',2820,6,'2006-09-27 17:48:55','','Live','2006-09-11 22:57:38',0,0,6),(240347,'show_submitted_data',2820,6,'2006-12-12 23:48:02','','Live','2006-10-22 00:58:45',0,1,6),(240348,'Reason Administration Login',3379,6,'2006-12-12 23:48:02','admin_login','Live','2006-10-22 01:00:40',0,1,6),(240349,'Login Expired',3379,6,'2006-12-12 23:48:02','expired_login','Live','2006-10-22 01:00:40',0,1,6),(240350,'Audience',1,6,'2006-10-22 01:05:05','audience_type','Live','2006-10-22 01:05:05',0,1,6),(240351,'audience_integration',2,6,'2006-10-22 01:05:05','','Live','2006-10-22 01:05:05',0,1,6),(240352,'directory_service_value',2820,6,'2006-12-12 23:48:02','','Live','2006-10-22 01:05:06',0,1,6),(240353,'directory_service',2820,6,'2006-12-12 23:48:02','','Live','2006-10-22 01:05:06',0,1,6),(240354,'audience_filter',2820,6,'2006-12-12 23:48:02','','Live','2006-10-22 01:05:06',0,1,6),(240355,'Students',240350,6,'2006-10-22 01:05:06','students_audience','Live','2006-10-22 01:05:06',0,1,6),(240356,'Faculty',240350,6,'2006-10-22 01:05:06','faculty_audience','Live','2006-10-22 01:05:06',0,1,6),(240357,'Staff',240350,6,'2006-10-22 01:05:06','staff_audience','Live','2006-10-22 01:05:06',0,1,6),(240358,'Alumni',240350,6,'2006-10-22 01:05:06','alumni_audience','Live','2006-10-22 01:05:06',0,1,6),(240359,'General Public',240350,6,'2006-10-22 01:05:06','public_audience','Live','2006-10-22 01:05:06',0,1,6),(240360,'Families',240350,6,'2006-10-22 01:05:06','families_audience','Live','2006-10-22 01:05:06',0,1,6),(240361,'Prospective Students',240350,6,'2006-10-22 01:05:06','prospective_students_audience','Live','2006-10-22 01:05:06',0,1,6),(240362,'New Students',240350,6,'2006-10-22 01:05:06','new_students_audience','Live','2006-10-22 01:05:06',0,1,6),(240363,'HTML Editor',1,6,'2006-12-12 23:48:02','html_editor_type','Live','2006-10-22 01:05:39',0,0,6),(240364,'html_editor',2,6,'2006-12-12 23:48:02','','Live','2006-10-22 01:05:40',0,1,6),(240365,'html_editor_filename',2820,6,'2006-12-12 23:48:02','','Live','2006-10-22 01:05:40',0,1,6),(240366,'Loki 1',240363,6,'2006-12-12 23:48:02','','Live','2006-10-22 01:05:40',0,1,6),(240367,'Loki 2',240363,6,'2006-12-12 23:48:02','','Live','2006-10-22 01:05:40',0,1,6),(240368,'TinyMCE',240363,6,'2006-12-12 23:48:02','','Live','2006-10-22 01:05:40',0,1,6),(240369,'user_surname',2820,6,'2006-12-12 23:48:02','','Live','2006-10-22 01:06:24',0,1,6),(240370,'user_given_name',2820,6,'2006-12-12 23:48:02','','Live','2006-10-22 01:06:24',0,1,6),(240371,'user_email',2820,6,'2006-12-12 23:48:02','','Live','2006-10-22 01:06:24',0,1,6),(240372,'user_phone',2820,6,'2006-12-12 23:48:02','','Live','2006-10-22 01:06:25',0,1,6),(240373,'user_password_hash',2820,6,'2006-12-12 23:48:02','','Live','2006-10-22 01:06:25',0,1,6),(240374,'user_authoritative_source',2820,6,'2006-12-12 23:48:02','','Live','2006-10-22 01:06:25',0,1,6),(240379,'external_css',2,6,'2006-12-12 23:48:02','','Live','2006-10-22 01:06:39',0,1,6),(240380,'css_relative_to_reason_http_base',2820,6,'2006-12-12 23:48:02','','Live','2006-10-22 01:06:39',0,1,6),(240387,'Simplicity Green',3311,6,'2006-12-12 23:48:02','','Live','2006-10-23 17:35:50',0,1,6),(240388,'Simplicity Green',161656,6,'2006-12-12 23:48:02','simplicity_green_theme','Live','2006-10-23 17:35:50',0,1,6),(240390,'ldap_group_filter',2820,6,'2006-12-12 22:56:14','','Live','2006-12-12 22:56:14',0,1,6),(240391,'ldap_group_member_fields',2820,6,'2006-12-12 22:56:14','','Live','2006-12-12 22:56:14',0,1,6),(240392,'group_has_members',2820,6,'2006-12-12 22:56:14','','Live','2006-12-12 22:56:14',0,1,6),(240412,'External Url',1,6,'2007-07-20 20:15:10','external_url','Live','2007-07-20 20:15:10',0,0,6),(240413,'external_url',2,6,'2007-07-20 20:15:10','','Live','2007-07-20 20:15:10',0,0,6),(240414,'url',2820,6,'2007-07-20 20:15:10','','Live','2007-07-20 20:15:10',0,0,6),(240415,'user_popup_alert_pref',2820,6,'2007-07-20 20:15:24','','Live','2007-07-20 20:15:24',0,0,6),(240416,'Theme',1,6,'2006-09-27 17:48:55','theme_type','Archived','2005-11-09 22:20:19',0,0,6),(240417,'Simplicity Tan',161656,6,'2007-07-20 20:15:33','simplicity_tan_theme','Live','2007-07-20 20:15:33',0,0,6),(240418,'Simplicity Tan',3311,6,'2007-07-20 20:15:33','','Live','2007-07-20 20:15:33',0,1,6),(240419,'Simplicity Grey',161656,6,'2007-07-20 20:15:33','simplicity_grey_theme','Live','2007-07-20 20:15:33',0,0,6),(240420,'Simplicity Grey',3311,6,'2007-07-20 20:15:33','','Live','2007-07-20 20:15:33',0,1,6),(240421,'Black Box',161656,6,'2007-07-20 20:15:33','black_box_theme','Live','2007-07-20 20:15:33',0,0,6),(240422,'Black Box',3311,6,'2007-07-20 20:15:33','','Live','2007-07-20 20:15:33',0,1,6),(240423,'Pedagogue Plum',161656,6,'2007-07-20 20:15:33','pedagogue_plum_theme','Live','2007-07-20 20:15:33',0,0,6),(240424,'Pedagogue Plum',3311,6,'2007-07-20 20:15:33','','Live','2007-07-20 20:15:33',0,1,6),(240425,'Gemstone Hematite',161656,6,'2007-07-20 20:15:33','gemstone_hematite_theme','Live','2007-07-20 20:15:33',0,0,6),(240426,'Gemstone Base',3311,6,'2007-07-20 20:15:33','','Live','2007-07-20 20:15:33',0,1,6),(240427,'Gemstone Ruby',161656,6,'2007-07-20 20:15:33','gemstone_ruby_theme','Live','2007-07-20 20:15:33',0,0,6),(240428,'Gemstone Ruby',3311,6,'2007-07-20 20:15:33','','Live','2007-07-20 20:15:33',0,1,6),(240429,'Gemstone Emerald',161656,6,'2007-07-20 20:15:33','gemstone_emerald_theme','Live','2007-07-20 20:15:33',0,0,6),(240430,'Gemstone Emerald',3311,6,'2007-07-20 20:15:33','','Live','2007-07-20 20:15:33',0,1,6),(240431,'Starbaby',161656,6,'2007-07-20 20:15:33','starbaby_theme','Live','2007-07-20 20:15:33',0,0,6),(240432,'Starbaby',3311,6,'2007-07-20 20:15:33','','Live','2007-07-20 20:15:33',0,1,6),(240433,'Editor',4264,6,'2007-07-20 20:15:33','editor_user_role','Live','2007-07-20 20:15:33',0,0,6),(240434,'Nobody Group',153396,6,'2007-07-20 20:15:50','nobody_group','Live','2007-07-20 20:15:50',0,1,6),(240435,'date_format',2,6,'2007-07-20 20:15:51','','Live','2007-07-20 20:15:51',0,0,6),(240436,'news_section',2,6,'2007-07-20 20:15:51','','Live','2007-07-20 20:15:51',0,0,6),(240437,'date_format',2820,6,'2007-07-20 20:15:51','','Live','2007-07-20 20:15:51',0,0,6),(240438,'hold_posts_for_review',2820,6,'2007-07-20 20:15:51','','Live','2007-07-20 20:15:51',0,0,6),(240439,'publication_type',2820,6,'2007-07-20 20:15:51','','Live','2007-07-20 20:15:51',0,0,6),(240440,'has_issues',2820,6,'2007-07-20 20:15:51','','Live','2007-07-20 20:15:51',0,0,6),(240441,'has_sections',2820,6,'2007-07-20 20:15:51','','Live','2007-07-20 20:15:51',0,0,6),(240442,'notify_upon_post',2820,6,'2007-07-20 20:15:51','','Live','2007-07-20 20:15:51',0,0,6),(240443,'notify_upon_comment',2820,6,'2007-07-20 20:15:51','','Live','2007-07-20 20:15:51',0,0,6),(240444,'posts_per_section_on_front_page',2820,6,'2007-07-20 20:15:51','','Live','2007-07-20 20:15:51',0,0,6),(240448,'What\'s New in Reason?',3379,6,'2007-07-20 20:20:58','whats_new_in_reason_blurb','Archived','2007-07-20 20:18:42',0,0,6),(240447,'Reason - A CMS for Higher Education',3379,240531,'2012-01-31 21:37:44','whats_new_in_reason_blurb','Live','2007-07-20 20:18:42',0,0,6),(240449,'Welcome to Reason 4 Beta 4',3379,6,'2007-07-20 20:22:23','whats_new_in_reason_blurb','Archived','2007-07-20 20:18:42',0,0,6),(240450,'Welcome to Reason 4 Beta 4',3379,6,'2007-07-20 20:22:53','whats_new_in_reason_blurb','Archived','2007-07-20 20:18:42',0,0,6),(240451,'Allowable Relationship Manager',36,6,'2007-07-20 20:23:44','alrel_manager_admin_link','Archived','0000-00-00 00:00:00',0,0,6),(240452,'Allowable Relationship Manager',36,6,'2007-07-20 20:24:13','alrel_manager_admin_link','Archived','0000-00-00 00:00:00',0,0,6),(240453,'Site',1,6,'2006-12-15 21:46:10','site','Archived','0000-00-00 00:00:00',0,0,6),(240454,'Site Type',1,6,'2006-09-27 17:48:55','site_type_type','Archived','2005-09-13 22:41:23',0,0,6),(240456,'Blog / Publication',1,6,'2007-07-20 20:16:04','publication_type','Archived','2005-10-07 15:48:57',0,0,6),(240457,'root',4,6,'2002-11-21 20:09:40','root','Archived','0000-00-00 00:00:00',0,0,6),(240458,'causal_agent',4,6,'2006-09-27 17:48:55','','Archived','2006-08-09 21:02:36',0,0,6),(240459,'Default Issue View',2812,6,'2008-01-22 00:25:53','','Live','2008-01-22 00:25:53',0,1,6),(240460,'News Section',1,6,'2006-09-27 17:48:55','news_section_type','Archived','2003-12-11 19:40:16',0,0,6),(240461,'Classified',1,6,'2008-01-22 00:26:08','classified_type','Live','2008-01-22 00:26:08',0,0,6),(240462,'classified_table',2,6,'2008-01-22 00:26:08','','Live','2008-01-22 00:26:08',0,0,6),(240463,'location',2820,6,'2008-01-22 00:26:08','','Live','2008-01-22 00:26:08',0,0,6),(240464,'price',2820,6,'2008-01-22 00:26:09','','Live','2008-01-22 00:26:09',0,0,6),(240465,'classified_print_content',2820,6,'2008-01-22 00:26:09','','Live','2008-01-22 00:26:09',0,0,6),(240466,'classified_date_available',2820,6,'2008-01-22 00:26:09','','Live','2008-01-22 00:26:09',0,0,6),(240467,'classified_duration_days',2820,6,'2008-01-22 00:26:09','','Live','2008-01-22 00:26:09',0,0,6),(240468,'classified_contact_email',2820,6,'2008-01-22 00:26:09','','Live','2008-01-22 00:26:09',0,0,6),(240469,'display_contact_info',2820,6,'2008-01-22 00:26:09','','Live','2008-01-22 00:26:09',0,0,6),(240470,'Classified Category',1,6,'2008-01-22 00:26:09','classified_category_type','Live','2008-01-22 00:26:09',0,0,6),(240471,'Quote',1,6,'2008-01-22 00:26:32','quote_type','Live','2008-01-22 00:26:32',0,0,6),(240472,'Entity Table',1,6,'2006-12-15 21:46:10','content_table','Archived','0000-00-00 00:00:00',0,0,6),(240473,'Page',1,6,'2006-12-15 21:46:10','minisite_page','Archived','0000-00-00 00:00:00',0,0,6),(240475,'use_custom_footer',2820,240474,'2008-09-24 23:10:58','','Live','2008-09-24 23:10:58',0,0,240474),(240476,'custom_footer',2820,240474,'2008-09-24 23:10:58','','Live','2008-09-24 23:10:58',0,0,240474),(240477,'Bedrich',161656,240474,'2008-09-24 23:15:12','bedrich_theme','Live','2008-09-24 23:15:12',0,1,240474),(240478,'bedrich',3313,240474,'2008-09-24 23:15:12','','Live','2008-09-24 23:15:12',0,1,240474),(240479,'bedrich',3311,240474,'2008-09-24 23:15:12','','Live','2008-09-24 23:15:12',0,1,240474),(240480,'News / Post',1,6,'2006-12-15 21:46:10','news','Archived','0000-00-00 00:00:00',0,0,6),(240481,'News / Post',1,240474,'2008-09-24 23:15:36','news','Archived','0000-00-00 00:00:00',0,0,6),(240482,'Authenticated Group',153396,240474,'2008-09-24 23:16:15','authenticated_group','Live','2008-09-24 23:16:15',0,0,240474),(240483,'is_editable',2820,240474,'2008-09-24 23:16:16','','Live','2008-09-24 23:16:16',0,0,240474),(240484,'thor_view',2820,240474,'2008-09-24 23:16:16','','Live','2008-09-24 23:16:16',0,0,240474),(240485,'allow_multiple',2820,240474,'2008-09-24 23:16:16','','Live','2008-09-24 23:16:16',0,0,240474),(240486,'email_submitter',2820,240474,'2008-09-24 23:16:16','','Live','2008-09-24 23:16:16',0,0,240474),(240487,'email_link',2820,240474,'2008-09-24 23:16:16','','Live','2008-09-24 23:16:16',0,0,240474),(240488,'email_data',2820,240474,'2008-09-24 23:16:16','','Live','2008-09-24 23:16:16',0,0,240474),(240489,'email_empty_fields',2820,240474,'2008-09-24 23:16:16','','Live','2008-09-24 23:16:16',0,0,240474),(240490,'Welcome to Reason 4 Beta 4',3379,6,'2007-07-20 20:22:53','whats_new_in_reason_blurb','Archived','2007-07-20 20:18:42',0,0,6),(240491,'Type',1,6,'2006-09-27 17:48:55','type','Archived','0000-00-00 00:00:00',0,0,6),(240492,'Login',3,240455,'2008-01-22 00:22:22','site_login','Archived','2004-10-05 02:52:50',0,0,240408),(240494,'repeat',2820,6,'2006-09-27 17:48:55','','Archived','2003-12-01 21:39:40',0,0,6),(240496,'Page',1,6,'2008-01-22 00:35:44','minisite_page','Archived','0000-00-00 00:00:00',0,0,6),(240497,'slug',2820,240495,'2010-04-07 21:56:41','','Live','2010-04-07 21:56:41',0,0,240495),(240498,'rating',2820,240495,'2010-04-07 21:56:41','','Live','2010-04-07 21:56:41',0,0,240495),(240499,'quote',2,240495,'2010-04-07 21:56:41','','Live','2010-04-07 21:56:41',0,0,240495),(240500,'rating',2820,240495,'2010-04-07 21:56:41','','Live','2010-04-07 21:56:41',0,0,240495),(240501,'domain',2820,240495,'2010-04-07 21:56:41','','Live','2010-04-07 21:56:41',0,0,240495),(240502,'caption_url',2820,240495,'2010-04-07 21:56:42','','Live','2010-04-07 21:56:42',0,0,240495),(240503,'audio_description_url',2820,240495,'2010-04-07 21:56:42','','Live','2010-04-07 21:56:42',0,0,240495),(240507,'Check For Updates',36,240495,'2010-04-07 21:56:50','','Live','2010-04-07 21:56:50',0,0,240495),(240508,'Review Changes',36,240495,'2010-04-07 21:56:50','','Live','2010-04-07 21:56:50',0,0,240495),(240509,'News Sections and Issues',2785,240495,'2010-04-07 22:02:20','','Live','2010-04-07 22:02:20',0,1,240495),(240510,'News Sections and Issues',2812,240495,'2010-04-07 22:02:20','','Live','2010-04-07 22:02:20',0,1,240495),(240511,'Reason - A CMS for Higher Education',3379,240495,'2010-04-07 22:13:16','whats_new_in_reason_blurb','Archived','2007-07-20 20:18:42',0,0,6),(240512,'core',136617,6,'2006-09-27 18:57:39','core_site_type','Archived','2006-09-27 18:57:03',0,0,6),(240514,'Orphan Manager',36,240513,'2010-04-08 22:28:08','','Live','2010-04-08 22:28:08',0,0,240513),(240516,'Reason - A CMS for Higher Education',3379,240515,'2011-07-06 20:35:36','whats_new_in_reason_blurb','Archived','2007-07-20 20:18:42',0,0,6),(240517,'Feature',1,240515,'2011-07-06 20:35:58','feature_type','Live','2011-07-06 20:35:58',0,0,240515),(240518,'feature',2,240515,'2011-07-06 20:35:58','','Live','2011-07-06 20:35:58',0,0,240515),(240519,'title',2820,240515,'2011-07-06 20:35:58','','Live','2011-07-06 20:35:58',0,0,240515),(240520,'text',2820,240515,'2011-07-06 20:35:58','','Live','2011-07-06 20:35:58',0,0,240515),(240521,'destination_url',2820,240515,'2011-07-06 20:35:58','','Live','2011-07-06 20:35:58',0,0,240515),(240522,'show_text',2820,240515,'2011-07-06 20:35:58','','Live','2011-07-06 20:35:58',0,0,240515),(240523,'crop_style',2820,240515,'2011-07-06 20:35:58','','Live','2011-07-06 20:35:58',0,0,240515),(240524,'bg_color',2820,240515,'2011-07-06 20:35:58','','Live','2011-07-06 20:35:58',0,0,240515),(240525,'Policy',1,6,'2006-09-27 17:48:55','policy_type','Archived','2003-04-02 17:55:02',0,0,6),(240526,'address',2820,240515,'2011-07-06 20:36:05','','Live','2011-07-06 20:36:05',0,0,240515),(240527,'latitude',2820,240515,'2011-07-06 20:36:05','','Live','2011-07-06 20:36:05',0,0,240515),(240528,'longitude',2820,240515,'2011-07-06 20:36:05','','Live','2011-07-06 20:36:05',0,0,240515),(240529,'css_media',2820,240515,'2011-07-06 20:36:13','','Live','2011-07-06 20:36:13',0,0,240515),(240530,'anonymous',4,5,'2011-07-06 20:36:13','','Live','2011-07-06 20:36:13',0,1,5),(240532,'Reason - A CMS for Higher Education',3379,240531,'2012-01-31 21:37:44','whats_new_in_reason_blurb','Archived','2007-07-20 20:18:42',0,0,6),(240533,'Admin Tools',36,240531,'2012-01-31 21:43:25','','Live','2012-01-31 21:43:25',0,0,240531),(240534,'add_dynamic_site_id',2820,240531,'2012-01-31 21:43:25','','Live','2012-01-31 21:43:25',0,0,240531),(240535,'List View with Duplicate',2812,240531,'2012-01-31 21:43:25','','Live','2012-01-31 21:43:25',0,0,240531),(240536,'List with Duplicate',2785,240531,'2012-01-31 21:43:25','','Live','2012-01-31 21:43:25',0,0,240531);
/*!40000 ALTER TABLE `entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity_lock`
--

DROP TABLE IF EXISTS `entity_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity_lock` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned NOT NULL,
  `field_name` tinytext NOT NULL,
  `allowable_relationship_id` int(11) NOT NULL,
  `allowable_relationship_direction` enum('left','right') DEFAULT NULL,
  `date_last_edited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_edited_by` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `entity_id` (`entity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_lock`
--

LOCK TABLES `entity_lock` WRITE;
/*!40000 ALTER TABLE `entity_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `entity_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `contact_username` tinytext,
  `frequency` tinyint(4) DEFAULT NULL,
  `week_of_month` tinyint(4) DEFAULT NULL,
  `month_day_of_week` enum('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') DEFAULT NULL,
  `sponsor` tinytext,
  `contact_organization` tinytext,
  `end_date` datetime DEFAULT NULL,
  `term_only` enum('yes','no') DEFAULT NULL,
  `recurrence` enum('none','daily','weekly','monthly','yearly') DEFAULT NULL,
  `dates` text,
  `last_occurence` date DEFAULT NULL,
  `calendar_record` int(11) DEFAULT NULL,
  `monthly_repeat` enum('semantic','numeric') DEFAULT NULL,
  `registration` enum('none','available','full') DEFAULT NULL,
  `location` tinytext,
  `address` tinytext,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `last_occurence` (`last_occurence`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_css`
--

DROP TABLE IF EXISTS `external_css`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_css` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `css_relative_to_reason_http_base` enum('true','false') DEFAULT NULL,
  `css_media` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_css`
--

LOCK TABLES `external_css` WRITE;
/*!40000 ALTER TABLE `external_css` DISABLE KEYS */;
INSERT INTO `external_css` VALUES (9406,'true',NULL),(195066,'true',NULL),(195069,'true',NULL),(240387,'true',NULL),(240418,'true',NULL),(240420,'true',NULL),(240422,'true',NULL),(240424,'true',NULL),(240426,'true',NULL),(240428,'true',NULL),(240430,'true',NULL),(240432,'true',NULL),(240479,'true',NULL),(240505,'',NULL);
/*!40000 ALTER TABLE `external_css` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_url`
--

DROP TABLE IF EXISTS `external_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_url` (
  `id` int(10) unsigned NOT NULL,
  `url` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_url`
--

LOCK TABLES `external_url` WRITE;
/*!40000 ALTER TABLE `external_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty_staff`
--

DROP TABLE IF EXISTS `faculty_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faculty_staff` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `affiliation` enum('faculty','staff','student') DEFAULT NULL,
  `degrees` tinytext,
  `ldap_created` enum('no','yes') NOT NULL DEFAULT 'no',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty_staff`
--

LOCK TABLES `faculty_staff` WRITE;
/*!40000 ALTER TABLE `faculty_staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `faculty_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feature`
--

DROP TABLE IF EXISTS `feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feature` (
  `id` int(10) unsigned NOT NULL,
  `title` tinytext,
  `text` text,
  `destination_url` tinytext,
  `show_text` tinyint(1) DEFAULT NULL,
  `crop_style` enum('fill','fit') DEFAULT NULL,
  `bg_color` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature`
--

LOCK TABLES `feature` WRITE;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field`
--

DROP TABLE IF EXISTS `field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `db_type` tinytext,
  `plasmature_type` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field`
--

LOCK TABLES `field` WRITE;
/*!40000 ALTER TABLE `field` DISABLE KEYS */;
INSERT INTO `field` VALUES (3324,'tinytext','text'),(3249,'tinytext',NULL),(3247,'enum(\'show\',\'hide\')',NULL),(3246,'tinytext',NULL),(3245,'tinytext',NULL),(3244,'tinyint(4)',NULL),(3243,'tinytext',NULL),(3237,'datetime',NULL),(3236,'datetime',NULL),(3235,'enum(\'pending\',\'published\')',NULL),(3234,'smallint(6) default \'32767\'',''),(3231,'tinytext',NULL),(3230,'tinytext',NULL),(3229,'tinytext',NULL),(3228,'tinytext',NULL),(3227,'tinytext',NULL),(3226,'tinytext',NULL),(3225,'tinytext',NULL),(3224,'enum(\'Kudos\',\'Press Release\',\'Athletics\',\'In The News\',\'Features\',\'Op-Ed\',\'Grants\',\'Conferences\')',''),(3223,'tinytext',NULL),(3222,'text',NULL),(3221,'tinytext',NULL),(3220,'mediumint(8) unsigned',NULL),(3219,'mediumint(8) unsigned',NULL),(3218,'mediumint(8) unsigned',NULL),(3217,'datetime',NULL),(3216,'text',NULL),(3215,'tinytext',NULL),(3190,'text',NULL),(3179,'tinytext',NULL),(3178,'varchar(32)',''),(3177,'tinytext',NULL),(3176,'tinytext',NULL),(3175,'tinytext',NULL),(3174,'tinytext',NULL),(3173,'tinytext',NULL),(3172,'tinytext',NULL),(3585,'varchar(128)',''),(3624,'tinytext',''),(3629,'varchar(128)',''),(3863,'enum( \'Audio\',\'Video\')',''),(3864,'tinytext',''),(3865,'tinytext',''),(3866,'tinytext',''),(3867,'enum(\'Quicktime\',\'Windows Media\',\'Real\',\'Flash\',\'MP3\',\'AIFF\')',''),(3868,'mediumint(8) unsigned',''),(240318,'text',''),(3870,'mediumint(8) unsigned',''),(4266,'text',''),(5390,'varchar(32)',''),(5391,'tinytext',''),(5392,'tinytext',''),(5832,'int(11)',NULL),(5833,'varchar(128)',NULL),(5834,'varchar(128)',NULL),(5835,'tinytext',NULL),(5836,'varchar(128)',NULL),(5837,'tinytext',''),(5910,'varchar(128)',''),(5911,'varchar(32)',''),(5912,'int',''),(5913,'varchar(10)',''),(6298,'enum( \'Uppercase Roman\',\'Lowercase Roman\',\'Uppercase Alpha\',\'Lowercase Alpha\',\'Decimal\')',''),(6506,'int',''),(6555,'tinytext',''),(6582,'enum(\'Yes\',\'No\')',''),(6596,'tinytext',''),(6597,'tinytext',''),(6598,'tinyint(3) unsigned',''),(10204,'enum(\'Yes\',\'No\')',''),(10205,'tinytext',''),(13997,'enum(\'Do It Now\',\'High\',\'Medium\',\'Normal\',\'Low\')',''),(14005,'varchar(128)',''),(14007,'varchar(32)',''),(14008,'enum(\'Bug\',\'Feature\',\'Update\',\'Enhancement\',\'Other\')',''),(14023,'enum(\'Assigned\',\'In Planning\',\'In Progress\',\'In Testing\',\'Ready To Go\',\'Done\',\'Cancelled\',\'On Hold\')',''),(14287,'int unsigned not null',''),(15008,'enum(\'faculty\',\'staff\',\'student\')',''),(15198,'enum(\'Live\',\'Not Live\') default \'Not Live\'',''),(16159,'varchar(128)',''),(16868,'enum(\'Same Window\',\'Popup Window\') default \'Popup Window\'',''),(24936,'smallint unsigned',''),(27609,'enum(\'pending\',\'published\')',''),(27610,'text',''),(27611,'tinytext',''),(27612,'tinytext',''),(27613,'text',''),(27614,'text',''),(27616,'mediumtext',''),(27617,'tinytext',''),(139468,'tinyint',''),(31487,'tinyint',''),(31488,'tinyint',''),(31490,'tinytext',''),(31492,'tinytext',''),(31493,'tinyint',''),(31494,'tinyint',''),(31495,'enum(\'Sunday\',\'Monday\',\'Tuesday\',\'Wednesday\',\'Thursday\',\'Friday\',\'Saturday\')',''),(31496,'tinytext',''),(31497,'tinytext',''),(31498,'datetime',''),(31499,'enum(\'yes\',\'no\')',''),(31500,'enum(\'none\',\'daily\',\'weekly\',\'monthly\',\'yearly\')',''),(31501,'text',''),(31502,'tinytext',''),(31503,'int(11)','hidden'),(31505,'tinytext','checkbox'),(31506,'tinytext','checkbox'),(31507,'tinytext','checkbox'),(31508,'tinytext','checkbox'),(31509,'tinytext','checkbox'),(31510,'tinytext','checkbox'),(31511,'tinytext','checkbox'),(32328,'tinytext','hidden'),(33304,'enum(\'semantic\',\'numeric\')','radio_no_sort'),(34592,'text','textarea'),(34593,'varchar(255)',''),(34594,'varchar(255)',''),(36089,'enum(\'none\',\'available\',\'full\')',''),(37717,'tinytext','hidden'),(37718,'tinytext','hidden'),(37719,'datetime','hidden'),(37720,'tinytext','hidden'),(39572,'varchar(255)',''),(40598,'date',''),(40599,'varchar(255)',''),(41862,'date',''),(41962,'tinytext',''),(42283,'tinytext',''),(42284,'tinytext',''),(44324,'tinytext',''),(44325,'text',''),(44326,'text',''),(44414,'tinytext',''),(54394,'tinytext',''),(54396,'tinytext',''),(54398,'enum(\'office\',\'department\')',''),(55597,'enum(\'yes\',\'no\')',''),(82481,'tinytext',''),(89798,'tinyint unsigned default 0',''),(102782,'tinytext',''),(118627,'enum(\'small\',\'medium\',\'large\')',''),(118704,'datetime',''),(122397,'tinytext','checkbox'),(122399,'tinytext','checkbox'),(122401,'tinytext',''),(122403,'tinytext',''),(122405,'enum(\'Faculty\', \'Staff\', \'Student\')',''),(139466,'tinyint',''),(149703,'enum(\'no\',\'yes\') NOT NULL DEFAULT \'no\'',''),(153374,'enum(\'yes\',\'no\')',''),(153376,'enum(\'on\',\'off\')',''),(153378,'enum(\'true\',\'false\')',''),(153380,'enum(\'true\',\'false\')',''),(153382,'text',''),(153384,'text',''),(153388,'tinyint DEFAULT 12',''),(153390,'tinytext',''),(162047,'enum(\'true\',\'false\') DEFAULT \'true\'',''),(182058,'text',''),(182067,'tinyint(4) unsigned',''),(182069,'text',''),(197562,'text',''),(197564,'enum(\'pending\',\'published\') DEFAULT \'pending\'',''),(197648,'bool',''),(197650,'enum(\'true\',\'false\')',''),(197652,'enum(\'true\',\'false\')',''),(197654,'tinytext','hidden'),(197656,'int',''),(197658,'enum(\'progressive_download\',\'streaming\')',''),(198122,'enum(\'slide\',\'print\',\'digital\')',''),(206501,'enum(\'yes\',\'no\')',''),(210576,'enum(\'yes\',\'no\')',''),(218985,'enum(\'none\',\'editable\',\'not_editable\') DEFAULT \'none\'',''),(219882,'enum(\'true\',\'false\')',''),(236257,'datetime','hidden'),(240347,'enum(\'yes\',\'no\')',NULL),(240352,'tinytext',NULL),(240353,'tinytext',NULL),(240354,'tinytext',NULL),(240365,'tinytext',NULL),(240369,'tinytext',NULL),(240370,'tinytext',NULL),(240371,'tinytext',NULL),(240372,'tinytext',NULL),(240373,'tinytext',NULL),(240374,'enum(\'reason\',\'external\')',NULL),(240380,'enum(\'true\',\'false\')',NULL),(240390,'text',NULL),(240391,'tinytext',NULL),(240392,'enum(\'true\',\'false\')',NULL),(240414,'tinytext',NULL),(240415,'enum(\'yes\',\'no\')',NULL),(240437,'tinytext',NULL),(240438,'enum(\'yes\',\'no\')',NULL),(240439,'enum(\'Blog\',\'Newsletter\')',NULL),(240440,'enum(\'yes\',\'no\')',NULL),(240441,'enum(\'yes\',\'no\')',NULL),(240442,'tinytext',NULL),(240443,'tinytext',NULL),(240444,'tinyint DEFAULT 2',NULL),(240463,'tinytext',NULL),(240464,'decimal(10,2)',NULL),(240465,'text',NULL),(240466,'datetime',NULL),(240467,'int',NULL),(240468,'tinytext',NULL),(240469,'boolean',NULL),(240475,'enum(\'yes\',\'no\')',NULL),(240476,'text',NULL),(240483,'enum(\"yes\",\"no\")',NULL),(240484,'tinytext',NULL),(240485,'enum(\"yes\",\"no\")',NULL),(240486,'enum(\"yes\",\"no\")',NULL),(240487,'enum(\"yes\",\"no\")',NULL),(240488,'enum(\"yes\",\"no\") DEFAULT \"yes\"',NULL),(240489,'enum(\"yes\",\"no\") DEFAULT \"yes\"',NULL),(240494,'enum(\'none\',\'daily\',\'weekly\',\'monthly\',\'yearly\')',''),(240497,'tinytext',NULL),(240498,'tinyint',NULL),(240500,'tinyint',NULL),(240501,'tinytext',NULL),(240502,'tinytext',NULL),(240503,'tinytext',NULL),(240519,'tinytext',NULL),(240520,'text',NULL),(240521,'tinytext',NULL),(240522,'boolean',NULL),(240523,'enum(\"fill\",\"fit\")',NULL),(240524,'varchar(6)',NULL),(240526,'tinytext',NULL),(240527,'double',NULL),(240528,'double',NULL),(240529,'tinytext',NULL),(240534,'enum(\'true\',\'false\')',NULL);
/*!40000 ALTER TABLE `field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form`
--

DROP TABLE IF EXISTS `form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `email_of_recipient` tinytext,
  `thor_content` text,
  `thank_you_message` text,
  `db_flag` enum('yes','no') DEFAULT NULL,
  `display_return_link` enum('yes','no') DEFAULT NULL,
  `magic_string_autofill` enum('none','editable','not_editable') DEFAULT 'none',
  `show_submitted_data` enum('yes','no') DEFAULT NULL,
  `is_editable` enum('yes','no') DEFAULT NULL,
  `thor_view` tinytext,
  `allow_multiple` enum('yes','no') DEFAULT NULL,
  `email_submitter` enum('yes','no') DEFAULT NULL,
  `email_link` enum('yes','no') DEFAULT NULL,
  `email_data` enum('yes','no') DEFAULT 'yes',
  `email_empty_fields` enum('yes','no') DEFAULT 'yes',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form`
--

LOCK TABLES `form` WRITE;
/*!40000 ALTER TABLE `form` DISABLE KEYS */;
/*!40000 ALTER TABLE `form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `html_editor`
--

DROP TABLE IF EXISTS `html_editor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `html_editor` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `html_editor_filename` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `html_editor`
--

LOCK TABLES `html_editor` WRITE;
/*!40000 ALTER TABLE `html_editor` DISABLE KEYS */;
INSERT INTO `html_editor` VALUES (240366,'loki_1.php'),(240367,'loki_2.php'),(240368,'tiny_mce.php');
/*!40000 ALTER TABLE `html_editor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `width` mediumint(8) unsigned DEFAULT NULL,
  `height` mediumint(8) unsigned DEFAULT NULL,
  `size` mediumint(8) unsigned DEFAULT NULL,
  `image_type` tinytext,
  `author_description` varchar(255) DEFAULT NULL,
  `original_image_format` enum('slide','print','digital') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=240343 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` VALUES (240342,499,378,9,'gif','','');
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job`
--

DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `posting_start` date DEFAULT NULL,
  `title_extension` varchar(255) DEFAULT NULL,
  `position_start` date DEFAULT NULL,
  `office` tinytext,
  `tenure_track` enum('yes','no') DEFAULT NULL,
  `term_job` tinytext,
  `break_job` tinytext,
  `dept_charge_number` tinytext,
  `supervisor` tinytext,
  `job_category` enum('Faculty','Staff','Student') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ldap_cache`
--

DROP TABLE IF EXISTS `ldap_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ldap_cache` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `name_cache` tinytext,
  `email_cache` tinytext,
  `cache_last_updated` datetime DEFAULT NULL,
  `username_cache` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ldap_cache`
--

LOCK TABLES `ldap_cache` WRITE;
/*!40000 ALTER TABLE `ldap_cache` DISABLE KEYS */;
INSERT INTO `ldap_cache` VALUES (5,'','','0000-00-00 00:00:00',''),(75393,'admin','webmaster@domain_name.domain','2012-01-31 15:32:59','admin'),(240492,' ','webmaster@carleton.edu','2008-09-24 18:10:11','admin');
/*!40000 ALTER TABLE `ldap_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `list_styles`
--

DROP TABLE IF EXISTS `list_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `list_styles` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `numbering_scheme` enum('Uppercase Roman','Lowercase Roman','Uppercase Alpha','Lowercase Alpha','Decimal') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `list_styles`
--

LOCK TABLES `list_styles` WRITE;
/*!40000 ALTER TABLE `list_styles` DISABLE KEYS */;
/*!40000 ALTER TABLE `list_styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_work`
--

DROP TABLE IF EXISTS `media_work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_work` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `transcript_status` enum('pending','published') DEFAULT 'pending',
  `media_publication_datetime` datetime DEFAULT NULL,
  `rating` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_work`
--

LOCK TABLES `media_work` WRITE;
/*!40000 ALTER TABLE `media_work` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_work` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meta`
--

DROP TABLE IF EXISTS `meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meta` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` text,
  `keywords` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=240506 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meta`
--

LOCK TABLES `meta` WRITE;
/*!40000 ALTER TABLE `meta` DISABLE KEYS */;
INSERT INTO `meta` VALUES (5,'',''),(9406,'',''),(240342,'Default Page Locations',''),(4265,NULL,NULL),(40654,'This role limits a user to creating, editing, and deleting pending items. The user cannot affect anything that is considered \"live\" by reason.',''),(46125,'Users with this role will be able to do more web-savvy things than a typical user, such as edit html, upload full-sized images, and things like that.','Power User, Edit HTML, Full-Size Images, Savvy'),(50972,'',''),(75393,'',''),(75394,'',''),(195062,'',''),(195066,'A generic three-column layout in css for the tableless2 template; based on the css for the library site.',''),(195069,'',''),(240387,NULL,NULL),(240418,NULL,NULL),(240420,NULL,NULL),(240422,NULL,NULL),(240424,NULL,NULL),(240426,NULL,NULL),(240428,NULL,NULL),(240430,NULL,NULL),(240432,NULL,NULL),(240433,NULL,NULL),(240478,NULL,NULL),(240479,NULL,NULL),(240492,'',''),(240505,'','');
/*!40000 ALTER TABLE `meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `minutes`
--

DROP TABLE IF EXISTS `minutes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `minutes` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `minutes_status` enum('pending','published') DEFAULT NULL,
  `present_members` text,
  `location` tinytext,
  `organization` tinytext,
  `guests` text,
  `absent_members` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `minutes`
--

LOCK TABLES `minutes` WRITE;
/*!40000 ALTER TABLE `minutes` DISABLE KEYS */;
/*!40000 ALTER TABLE `minutes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news_section`
--

DROP TABLE IF EXISTS `news_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news_section` (
  `id` int(10) unsigned NOT NULL,
  `posts_per_section_on_front_page` tinyint(4) DEFAULT '2',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news_section`
--

LOCK TABLES `news_section` WRITE;
/*!40000 ALTER TABLE `news_section` DISABLE KEYS */;
/*!40000 ALTER TABLE `news_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newstype`
--

DROP TABLE IF EXISTS `newstype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newstype` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `news_type` enum('Kudos','Press Release','Athletics','In The News','Features','Op-Ed','Grants','Conferences') DEFAULT NULL,
  `show_on_front_page` enum('Yes','No') DEFAULT NULL,
  `names` text,
  `subtitle` varchar(255) DEFAULT NULL,
  `author_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newstype`
--

LOCK TABLES `newstype` WRITE;
/*!40000 ALTER TABLE `newstype` DISABLE KEYS */;
/*!40000 ALTER TABLE `newstype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `numbered`
--

DROP TABLE IF EXISTS `numbered`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `numbered` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `numbered`
--

LOCK TABLES `numbered` WRITE;
/*!40000 ALTER TABLE `numbered` DISABLE KEYS */;
/*!40000 ALTER TABLE `numbered` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office_department`
--

DROP TABLE IF EXISTS `office_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `office_department` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `office_department_code` tinytext,
  `office_department_type` enum('office','department') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `office_department`
--

LOCK TABLES `office_department` WRITE;
/*!40000 ALTER TABLE `office_department` DISABLE KEYS */;
/*!40000 ALTER TABLE `office_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_cache_log`
--

DROP TABLE IF EXISTS `page_cache_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_cache_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `cache_key` tinytext,
  `action_type` tinytext,
  `extra1` tinytext,
  `extra2` mediumtext,
  `page_gen_time` mediumint(9) DEFAULT NULL,
  `user_agent` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_cache_log`
--

LOCK TABLES `page_cache_log` WRITE;
/*!40000 ALTER TABLE `page_cache_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `page_cache_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_cache_log_archive`
--

DROP TABLE IF EXISTS `page_cache_log_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_cache_log_archive` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `cache_key` tinytext,
  `action_type` tinytext,
  `extra1` tinytext,
  `extra2` mediumtext,
  `page_gen_time` mediumint(9) DEFAULT NULL,
  `user_agent` tinytext,
  PRIMARY KEY (`id`),
  KEY `dt_index` (`dt`),
  KEY `action_type_index` (`action_type`(10))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_cache_log_archive`
--

LOCK TABLES `page_cache_log_archive` WRITE;
/*!40000 ALTER TABLE `page_cache_log_archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `page_cache_log_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_node`
--

DROP TABLE IF EXISTS `page_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_node` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `url_fragment` varchar(128) DEFAULT NULL,
  `extra_head_content` text,
  `custom_page` tinytext,
  `nav_display` enum('Yes','No') DEFAULT NULL,
  `link_name` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_node`
--

LOCK TABLES `page_node` WRITE;
/*!40000 ALTER TABLE `page_node` DISABLE KEYS */;
INSERT INTO `page_node` VALUES (75394,'','','standalone_login_page_stripped','Yes','');
/*!40000 ALTER TABLE `page_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `press_release`
--

DROP TABLE IF EXISTS `press_release`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `press_release` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_name` tinytext,
  `contact_email` tinytext,
  `contact_title` tinytext,
  `contact_phone` tinytext,
  `location` tinytext,
  `release_number` tinytext,
  `release_title` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `press_release`
--

LOCK TABLES `press_release` WRITE;
/*!40000 ALTER TABLE `press_release` DISABLE KEYS */;
/*!40000 ALTER TABLE `press_release` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quote`
--

DROP TABLE IF EXISTS `quote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quote` (
  `id` int(10) unsigned NOT NULL,
  `rating` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quote`
--

LOCK TABLES `quote` WRITE;
/*!40000 ALTER TABLE `quote` DISABLE KEYS */;
/*!40000 ALTER TABLE `quote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_slot`
--

DROP TABLE IF EXISTS `registration_slot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registration_slot` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `registrant_data` text,
  `registration_slot_capacity` tinyint(4) unsigned DEFAULT NULL,
  `slot_description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_slot`
--

LOCK TABLES `registration_slot` WRITE;
/*!40000 ALTER TABLE `registration_slot` DISABLE KEYS */;
/*!40000 ALTER TABLE `registration_slot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relationship`
--

DROP TABLE IF EXISTS `relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relationship` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_a` int(10) unsigned NOT NULL DEFAULT '0',
  `entity_b` int(10) unsigned NOT NULL DEFAULT '0',
  `type` int(10) unsigned NOT NULL DEFAULT '0',
  `site` int(11) NOT NULL DEFAULT '0',
  `rel_sort_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entity_a_index` (`entity_a`),
  KEY `entity_b_index` (`entity_b`),
  KEY `type_index` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=559761 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationship`
--

LOCK TABLES `relationship` WRITE;
/*!40000 ALTER TABLE `relationship` DISABLE KEYS */;
INSERT INTO `relationship` VALUES (2,5,4,2,0,0),(3,5,3,2,0,0),(16,5,2,2,0,0),(5,5,1,2,0,0),(6,1,7,1,0,0),(7,3,8,1,0,0),(18,36,37,1,0,0),(19,5,36,2,0,0),(20,5,38,8,0,0),(13,5,1,4,0,0),(17,5,36,4,0,0),(23,5,5,10,0,0),(31,5,2,4,0,0),(32,5,3,4,0,0),(33,5,4,4,0,0),(34,5,6,5,0,0),(35,5,7,9,0,0),(36,5,8,9,0,0),(39,5,37,9,0,0),(40,5,38,11,0,0),(232,5,80,9,0,0),(231,5,79,9,0,0),(233,5,81,9,0,0),(234,5,82,9,0,0),(235,5,83,9,0,0),(236,5,84,9,0,0),(238,5,86,9,0,0),(239,5,87,9,0,0),(240,5,88,4,0,0),(241,88,79,1,0,0),(242,88,80,1,0,0),(243,88,82,1,0,0),(244,88,83,1,0,0),(245,88,84,1,0,0),(246,88,87,1,0,0),(8765,3317,79,1,0,0),(7379,5,2823,4,0,0),(7372,5,2820,2,0,0),(7368,5,2820,4,0,0),(7345,5,2812,2,0,0),(7344,5,2812,4,0,0),(454,5,243,4,0,0),(455,243,81,1,0,0),(7401,2812,2830,1,0,0),(7399,2823,82,1,0,0),(7293,5,2787,57,0,0),(7292,5,2786,57,0,0),(7291,5,2785,2,0,0),(7290,2785,37,1,0,0),(7289,5,2785,4,0,0),(8327,3250,3245,66,0,0),(676,243,79,1,0,0),(677,243,82,1,0,0),(7398,2823,79,1,0,0),(8404,5,3251,59,0,0),(7932,2812,86,1,0,0),(9758,3624,3323,67,0,0),(7397,5,2830,9,0,0),(8290,5,3243,63,0,0),(8292,5,3244,63,0,0),(8278,5,3237,63,0,0),(8274,5,3235,63,0,0),(8276,5,3236,63,0,0),(8272,5,3234,63,0,0),(8266,5,3231,63,0,0),(8262,5,3229,63,0,0),(8264,5,3230,63,0,0),(8258,5,3227,63,0,0),(8260,5,3228,63,0,0),(8254,5,3225,63,0,0),(8256,5,3226,63,0,0),(8250,5,3223,63,0,0),(8252,5,3224,63,0,0),(8246,5,3221,63,0,0),(8248,5,3222,63,0,0),(8242,5,3219,63,0,0),(8244,5,3220,63,0,0),(8238,5,3217,63,0,0),(8240,5,3218,63,0,0),(8234,5,3215,63,0,0),(8236,5,3216,63,0,0),(8302,5,3249,63,0,0),(8294,5,3245,63,0,0),(8650,3311,86,1,0,0),(8647,5,3313,2,0,0),(8644,5,3311,2,0,0),(8641,5,3311,4,0,0),(8148,5,3172,63,0,0),(8152,5,3174,63,0,0),(8154,5,3175,63,0,0),(8158,5,3177,63,0,0),(8162,5,3179,63,0,0),(8298,5,3247,63,0,0),(559677,9406,240505,355,0,0),(559676,5,240505,74,0,0),(8296,5,3246,63,0,0),(8646,5,3313,4,0,0),(8643,3311,37,1,0,0),(8150,5,3173,63,0,0),(8151,3174,7,67,0,0),(8156,5,3176,63,0,0),(8157,3177,7,67,0,0),(8160,5,3178,63,0,0),(8161,3179,37,67,0,0),(8184,5,3190,63,0,0),(8297,3247,2142,67,0,0),(8301,3249,2830,67,0,0),(8235,3216,79,67,0,0),(8239,3218,81,67,0,0),(8243,3220,81,67,0,0),(8247,3222,82,67,0,0),(8255,3226,84,67,0,0),(8259,3228,84,67,0,0),(8263,3230,84,67,0,0),(8275,3236,87,67,0,0),(8326,3250,2820,62,0,0),(8325,3250,5,61,0,0),(7653,5,2944,9,0,0),(8295,3246,2944,67,0,0),(8648,3313,82,1,0,0),(8642,3311,82,1,0,0),(8147,3172,7,67,0,0),(8149,3173,7,67,0,0),(8153,3175,7,67,0,0),(8155,3176,7,67,0,0),(9299,3178,8,67,0,0),(7654,2820,2944,1,0,0),(8328,3250,3246,66,0,0),(8233,3215,79,67,0,0),(8237,3217,80,67,0,0),(8241,3219,81,67,0,0),(8245,3221,81,67,0,0),(8249,3223,82,67,0,0),(8253,3225,84,67,0,0),(8257,3227,84,67,0,0),(8261,3229,84,67,0,0),(8265,3231,84,67,0,0),(8273,3235,87,67,0,0),(8277,3237,87,67,0,0),(8293,3245,2944,67,0,0),(8324,3250,2786,60,0,0),(8310,5,3250,59,0,0),(9166,3251,3234,66,0,0),(9165,3251,3249,65,0,0),(9164,3251,2812,62,0,0),(9163,3251,5,61,0,0),(4942,5,2142,9,0,0),(8666,5,3317,4,0,0),(8693,5,3323,9,0,0),(8694,3324,3323,67,0,0),(8695,5,3324,63,0,0),(8696,2812,3323,1,0,0),(8766,3317,82,1,0,0),(8767,3317,86,1,0,0),(9759,5,3624,63,0,0),(9259,5,3497,8,0,0),(9258,5,3497,11,0,0),(9257,5,3496,8,0,0),(9256,5,3496,11,0,0),(8906,5,3379,4,0,0),(8907,3379,79,1,0,0),(50890,14423,3216,66,0,0),(9551,5,3585,63,0,0),(9550,3585,8,67,0,0),(9162,3251,2786,60,0,0),(50888,14423,5397,62,0,0),(285069,3468,3223,66,0,0),(285068,3468,3222,66,0,0),(285067,3468,3215,66,0,0),(285066,3468,3217,65,0,0),(285065,3468,3215,65,0,0),(9141,5,3468,59,0,0),(9264,5,3501,8,0,0),(9263,5,3501,11,0,0),(9262,5,3498,8,0,0),(9261,5,3498,11,0,0),(9235,5,3486,11,0,0),(9236,5,3486,8,0,0),(110869,44414,8,67,0,0),(110868,5,44414,63,0,0),(9786,5,3629,63,0,0),(9785,3629,3628,67,0,0),(9784,5,3628,9,0,0),(9787,3317,3628,1,0,0),(10578,5,3861,4,0,0),(10579,3861,79,1,0,0),(10580,3861,80,1,0,0),(10581,3861,82,1,0,0),(10582,3861,2142,1,0,0),(10583,5,3862,9,0,0),(10584,3863,3862,67,0,0),(10585,5,3863,63,0,0),(10586,3864,3862,67,0,0),(10587,5,3864,63,0,0),(10588,3865,3862,67,0,0),(10589,5,3865,63,0,0),(10590,3866,3862,67,0,0),(10591,5,3866,63,0,0),(330475,3867,3862,67,0,0),(10593,5,3867,63,0,0),(10730,3868,3862,67,0,0),(10595,5,3868,63,0,0),(10729,3870,3862,67,0,0),(10597,5,3870,63,0,0),(10598,5,3871,4,0,0),(10599,3871,37,1,0,0),(10600,3871,3862,1,0,0),(10920,5,3989,59,0,0),(11019,36,86,1,0,0),(193370,3989,14023,66,0,0),(11497,5,4264,4,0,0),(11498,5,4264,2,0,0),(11499,5,4265,89,0,0),(11501,4266,3628,67,0,0),(11502,5,4266,63,0,0),(11628,3,82,1,0,0),(184897,9440,3178,66,0,0),(184896,9440,5837,66,0,0),(19863,3317,37,1,0,0),(14401,5,5390,63,0,0),(14402,5391,8,67,0,0),(14403,5,5391,63,0,0),(14404,5392,3628,67,0,0),(14405,5,5392,63,0,0),(14411,5,5397,4,0,0),(14412,5397,79,1,0,0),(184895,9440,3585,66,0,0),(15497,5,5832,63,0,0),(15498,5832,3323,67,0,0),(15499,5,5833,63,0,0),(15500,5833,8,67,0,0),(15501,5,5834,63,0,0),(15502,5834,7,67,0,0),(15503,5,5835,63,0,0),(15504,5835,7,67,0,0),(15505,5,5836,63,0,0),(15506,5836,7,67,0,0),(15507,5,5837,63,0,0),(144086,5837,8,67,0,0),(15643,5,5890,4,0,0),(15644,5890,82,1,0,0),(15645,5890,79,1,0,0),(15646,5890,80,1,0,0),(15647,5890,2142,1,0,0),(15648,5890,86,1,0,0),(15695,5,5907,4,0,0),(15696,5907,82,1,0,0),(15697,5907,79,1,0,0),(15699,5,5909,9,0,0),(15700,5907,5909,1,0,0),(15701,5,5910,63,0,0),(15702,5910,5909,67,0,0),(15703,5,5911,63,0,0),(15704,5911,5909,67,0,0),(15705,5,5912,63,0,0),(15706,5912,5909,67,0,0),(15707,5,5913,63,0,0),(15708,5913,5909,67,0,0),(23921,5,9440,59,0,0),(16508,5,6296,9,0,0),(16511,5,6298,63,0,0),(16512,6298,6296,67,0,0),(16513,5890,6296,1,0,0),(16522,5,6301,59,0,0),(31681,6301,2786,60,0,0),(16943,5,6505,9,0,0),(16944,5,6506,63,0,0),(16945,6506,6505,67,0,0),(17067,5,6555,63,0,0),(17068,6555,7,67,0,0),(17087,5,6564,4,0,0),(17089,6564,80,1,0,0),(17090,6564,2142,1,0,0),(17113,6564,6505,1,0,0),(17159,5,6582,63,0,0),(17160,6582,83,67,0,0),(17185,5,6596,63,0,0),(17187,5,6597,63,0,0),(17189,5,6598,63,0,0),(559353,5,240344,302,0,0),(559350,5,240344,299,0,0),(559347,5,240342,36,0,0),(19124,5,7430,57,0,0),(19134,5,7435,59,0,0),(31677,7435,7430,60,0,0),(23799,5,9406,74,0,0),(23814,5397,86,1,0,0),(184894,9440,15198,65,0,0),(184893,9440,3585,65,0,0),(25851,10205,3628,67,0,0),(25850,5,10205,63,0,0),(25849,10204,3628,67,0,0),(25848,5,10204,63,0,0),(27313,243,80,1,0,0),(31680,7435,5890,62,0,0),(31684,6301,5890,62,0,0),(32711,88,2142,1,0,0),(34353,5,13860,59,0,0),(56969,22126,3235,66,0,0),(34357,5,13861,59,0,0),(555567,13861,3216,66,0,0),(34724,5,13993,4,0,0),(34725,13993,79,1,0,0),(34726,13993,82,1,0,0),(34727,5,13994,9,0,0),(34728,13993,13994,1,0,0),(34733,13993,37,1,0,0),(34737,5,13997,63,0,0),(34741,13997,13994,67,0,0),(34756,5,14005,63,0,0),(34759,5,14007,63,0,0),(34760,14007,13994,67,0,0),(34761,5,14008,63,0,0),(34775,5,14014,59,0,0),(36819,14014,13997,66,0,0),(36818,14014,14008,66,0,0),(36817,14014,14023,66,0,0),(36816,14014,14005,66,0,0),(34809,5,14023,63,0,0),(36815,14014,13997,65,0,0),(36814,14014,14008,65,0,0),(36813,14014,14023,65,0,0),(36812,14014,14005,65,0,0),(36811,14014,13993,62,0,0),(35544,5,14287,63,0,0),(35545,14287,13994,67,0,0),(35899,5,14423,59,0,0),(138372,88,22126,248,0,0),(36809,14014,2786,60,0,0),(36843,14005,13994,67,0,0),(37121,5390,8,67,0,0),(56968,22126,3223,66,0,0),(56967,22126,3222,66,0,0),(56966,22126,3216,66,0,0),(56965,22126,3215,66,0,0),(56964,22126,3235,65,0,0),(56745,5,22126,59,0,0),(555566,13861,3317,62,0,0),(38009,5,14981,9,0,0),(38081,5,15008,63,0,0),(38090,5397,14981,1,0,0),(38499,5,15198,63,0,0),(38500,15198,8,67,0,0),(184892,9440,3,62,0,0),(110632,44326,44322,67,0,0),(40986,5,16159,63,0,0),(40987,16159,7,67,0,0),(110631,5,44326,63,0,0),(110630,44325,44322,67,0,0),(110629,5,44325,63,0,0),(110628,44324,44322,67,0,0),(110627,5,44324,63,0,0),(42760,5,16867,9,0,0),(42761,5,16868,63,0,0),(42762,16868,16867,67,0,0),(42763,4,16867,1,0,0),(110624,44321,44322,1,0,0),(110623,5,44322,9,0,0),(110621,5,44321,4,0,0),(44933,5,17685,11,0,0),(44934,5,17685,8,0,0),(45906,3224,83,67,0,0),(559679,5,240506,8,0,0),(559678,5,240506,11,0,0),(559308,6,4265,90,0,0),(559298,5,6,3,0,0),(559295,240318,8,67,0,0),(559294,5,240318,63,0,0),(50788,14423,2786,60,0,0),(285064,3468,243,62,0,0),(293683,13860,3223,66,0,0),(56400,5,22039,59,0,0),(56404,22039,2786,60,0,0),(56405,22039,5,61,0,0),(56406,22039,3311,62,0,0),(56407,22039,3179,65,0,0),(56963,22126,3217,65,0,0),(56962,22126,88,62,0,0),(138377,243,3468,248,0,0),(56859,22126,2786,60,0,0),(63841,5,24931,9,0,0),(63850,5,24936,63,0,0),(206458,24936,24931,67,0,0),(70314,5,27608,9,0,0),(70315,5,27609,63,0,0),(70316,27609,27608,67,0,0),(70317,5,27610,63,0,0),(70318,27610,27608,67,0,0),(70319,5,27611,63,0,0),(70320,27611,27608,67,0,0),(70321,5,27612,63,0,0),(70322,27612,27608,67,0,0),(70323,5,27613,63,0,0),(70324,27613,27608,67,0,0),(70325,5,27614,63,0,0),(70326,27614,27608,67,0,0),(70327,5,27615,9,0,0),(70328,5,27616,63,0,0),(70329,27616,27615,67,0,0),(70330,5,27617,63,0,0),(70331,27617,27615,67,0,0),(70332,5,27618,4,0,0),(70340,27618,27615,1,0,0),(70341,27618,27608,1,0,0),(70342,27618,82,1,0,0),(70343,27618,80,1,0,0),(70679,5,27787,59,0,0),(70692,27787,3223,66,0,0),(70691,27787,27609,65,0,0),(70690,27787,3217,65,0,0),(70689,27787,27618,62,0,0),(70687,27787,2786,60,0,0),(70712,15008,14981,67,0,0),(79815,5,31486,9,0,0),(79816,5,31487,63,0,0),(79817,31487,31486,67,0,0),(79818,5,31488,63,0,0),(79819,31488,31486,67,0,0),(559675,161656,240504,336,0,0),(79821,5,31490,63,0,0),(79822,31490,31491,67,0,0),(79823,5,31491,9,0,0),(79824,5,31492,63,0,0),(79825,31492,31491,67,0,0),(79826,5,31493,63,0,0),(79827,31493,31491,67,0,0),(79828,5,31494,63,0,0),(79829,31494,31491,67,0,0),(79830,5,31495,63,0,0),(79831,31495,31491,67,0,0),(79832,5,31496,63,0,0),(79833,31496,31491,67,0,0),(79834,5,31497,63,0,0),(79835,31497,31491,67,0,0),(79836,5,31498,63,0,0),(79837,31498,31491,67,0,0),(79838,5,31499,63,0,0),(79839,31499,31491,67,0,0),(79840,5,31500,63,0,0),(79841,31500,31491,67,0,0),(79842,5,31501,63,0,0),(79843,31501,31491,67,0,0),(79844,5,31502,63,0,0),(79845,31502,31491,67,0,0),(79846,5,31503,63,0,0),(79848,5,31504,9,0,0),(79849,5,31505,63,0,0),(79850,31505,31504,67,0,0),(79851,5,31506,63,0,0),(79852,31506,31504,67,0,0),(79853,5,31507,63,0,0),(79854,31507,31504,67,0,0),(79855,5,31508,63,0,0),(79856,31508,31504,67,0,0),(79857,5,31509,63,0,0),(79858,31509,31504,67,0,0),(79859,5,31510,63,0,0),(79860,31510,31504,67,0,0),(79861,5,31511,63,0,0),(79862,31511,31504,67,0,0),(79863,5,31512,4,0,0),(79864,31512,82,1,0,0),(79865,31512,80,1,0,0),(79866,31512,79,1,0,0),(79868,31512,2142,1,0,0),(559384,5,240363,2,0,0),(79870,31512,31486,1,0,0),(559674,5,240504,4,0,0),(79872,31512,31491,1,0,0),(79873,31512,31504,1,0,0),(79874,31512,37,1,0,0),(79877,5,31515,9,0,0),(559683,5,240508,8,0,0),(559682,5,240508,11,0,0),(559681,5,240507,8,0,0),(559680,5,240507,11,0,0),(79882,5,31518,4,0,0),(79883,31518,31515,1,0,0),(79884,31518,82,1,0,0),(293682,13860,3222,66,0,0),(293681,13860,3216,66,0,0),(80306,31503,31491,67,0,0),(81827,5,32296,4,0,0),(81828,32296,86,1,0,0),(81829,32296,82,1,0,0),(81917,5,32328,63,0,0),(81919,32328,14981,67,0,0),(82923,6564,82,1,0,0),(83919,5,33122,4,0,0),(83920,33122,82,1,0,0),(83921,33122,37,1,0,0),(83922,5,33122,2,0,0),(84371,5,33304,63,0,0),(84373,33304,31491,67,0,0),(559643,5,240491,4,0,0),(86321,5,34442,11,0,0),(86322,5,34442,8,0,0),(86820,5,34592,63,0,0),(86822,5,34593,63,0,0),(86823,34593,83,67,0,0),(86824,5,34594,63,0,0),(86826,34594,83,67,0,0),(86949,34592,83,67,0,0),(138409,27618,27787,248,0,0),(193369,3989,3215,66,0,0),(138416,2823,3989,248,0,0),(88961,5,35398,59,0,0),(311287,35398,31490,66,0,0),(311286,35398,3217,66,0,0),(311285,35398,31492,66,0,0),(311284,35398,31490,65,0,0),(311283,35398,3217,65,0,0),(90838,5,36089,63,0,0),(90839,36089,31491,67,0,0),(92437,33122,8,1,0,0),(92573,5,36806,59,0,0),(294599,36806,15198,65,0,0),(294598,36806,33122,62,0,0),(294597,36806,5,61,0,0),(294596,36806,2786,60,0,0),(94757,5,37716,9,0,0),(94758,5,37717,63,0,0),(94759,37717,37716,67,0,0),(94760,5,37718,63,0,0),(94761,37718,37716,67,0,0),(94762,5,37719,63,0,0),(94763,37719,37716,67,0,0),(94764,5,37720,63,0,0),(94765,37720,37716,67,0,0),(94766,3,37716,1,0,0),(96278,3234,86,67,0,0),(99161,5,39572,63,0,0),(99162,39572,81,67,0,0),(104841,41963,40592,1,0,0),(104840,41963,24931,1,0,0),(104839,41963,79,1,0,0),(104838,5,41963,4,0,0),(101598,5,40592,9,0,0),(101607,5,40598,63,0,0),(223391,40598,40592,67,0,0),(101609,5,40599,63,0,0),(101610,40599,40592,67,0,0),(104837,41962,40592,67,0,0),(104836,5,41962,63,0,0),(101745,5,40654,89,0,0),(293680,13860,3215,66,0,0),(293679,13860,3317,62,0,0),(104631,5,41862,63,0,0),(104643,41862,40592,67,0,0),(104842,41963,2142,1,0,0),(105588,5,42283,63,0,0),(105589,42283,7,67,0,0),(105590,5,42284,63,0,0),(105591,42284,7,67,0,0),(311282,35398,31512,62,0,0),(234283,14008,13994,67,0,0),(115052,4264,82,1,0,0),(115053,5,46125,89,0,0),(138399,13993,14014,248,0,0),(138392,5890,6301,248,0,0),(138391,5890,7435,248,0,0),(125940,5,50972,75,0,0),(134043,5,54388,4,0,0),(134044,54388,2142,1,0,0),(134045,5,54389,9,0,0),(134048,54388,54389,1,0,0),(134049,5,54391,9,0,0),(134052,54388,54391,1,0,0),(134055,5,54394,63,0,0),(134056,54394,54389,67,0,0),(134059,5,54396,63,0,0),(134060,54396,54391,67,0,0),(134063,5,54398,63,0,0),(134064,54398,54391,67,0,0),(138363,5397,14423,248,0,0),(555565,13861,2786,60,0,0),(285063,3468,2786,60,0,0),(136935,5,55597,63,0,0),(136936,55597,40592,67,0,0),(137962,31512,35398,248,0,0),(311281,35398,2786,60,0,0),(138355,3317,13860,248,0,0),(138356,3317,13861,248,0,0),(140918,5,57366,59,0,0),(140941,57366,54398,66,0,0),(140940,57366,54396,66,0,0),(140939,57366,54398,65,0,0),(140938,57366,54396,65,0,0),(140926,54388,57366,248,0,0),(140937,57366,54388,62,0,0),(141049,2823,80,1,0,0),(193368,3989,3234,65,0,0),(193367,3989,3217,65,0,0),(193366,3989,14023,65,0,0),(193365,3989,3215,65,0,0),(141050,2823,37,1,0,0),(233539,14023,13994,67,0,0),(147363,5,60241,4,0,0),(147364,60241,82,1,0,0),(147365,60241,80,1,0,0),(147366,60241,79,1,0,0),(149733,5907,80,1,0,0),(184891,9440,5,61,0,0),(184890,9440,2786,60,0,0),(168622,2823,13994,1,0,0),(182982,5,75393,10,0,0),(182984,75393,3317,2,0,0),(182985,75393,243,2,0,0),(182986,75393,3379,2,0,0),(182987,75393,75394,78,0,0),(484071,75394,75394,80,0,0),(182998,5,75398,4,0,0),(189554,2823,86,1,0,0),(293677,13860,124306,60,0,0),(193364,3989,2823,62,0,0),(193363,3989,2786,60,0,0),(196979,5,81327,11,0,0),(370621,156572,3867,66,0,0),(199554,5,82481,63,0,0),(199555,82481,8,67,0,0),(215849,5,89798,63,0,0),(215853,89798,8,67,0,0),(289230,122405,40592,67,0,0),(289229,5,122405,63,0,0),(289226,122403,40592,67,0,0),(289225,5,122403,63,0,0),(289222,122401,40592,67,0,0),(289221,5,122401,63,0,0),(289218,122399,40592,67,0,0),(289217,5,122399,63,0,0),(289214,122397,40592,67,0,0),(289213,5,122397,63,0,0),(245625,5,102782,63,0,0),(245626,102782,13994,67,0,0),(559383,5,240363,379,0,0),(259800,5,109269,11,0,0),(259803,5,109269,8,0,0),(281273,5,118606,4,0,0),(281307,5,118627,63,0,0),(281308,118627,13994,67,0,0),(281470,5,118704,63,0,0),(281471,118704,13994,67,0,0),(284137,5,119825,59,0,0),(284173,119825,3247,66,0,0),(284172,119825,3247,65,0,0),(284171,119825,40598,65,0,0),(284170,119825,41963,62,0,0),(284148,41963,119825,248,0,0),(284169,119825,2786,60,0,0),(294601,36806,3179,66,0,0),(293674,5,124306,57,0,0),(479222,5,206501,63,0,0),(479223,206501,44322,67,0,0),(322216,5,136617,4,0,0),(322219,5,136617,2,0,0),(559354,75393,240344,302,0,0),(329101,5,139466,63,0,0),(329102,139466,3862,67,0,0),(329105,5,139468,63,0,0),(329106,139468,3862,67,0,0),(329109,3871,82,1,0,0),(330664,5,140154,59,0,0),(330665,140154,2786,60,0,0),(330666,140154,5907,62,0,0),(330667,140154,5910,65,0,0),(330668,140154,5910,66,0,0),(330671,5907,140154,248,0,0),(343767,5,149703,63,0,0),(343768,149703,14981,67,0,0),(352232,5,153366,9,0,0),(352235,5,153368,9,0,0),(352238,5,153370,9,0,0),(352241,5,153372,9,0,0),(352244,5,153374,63,0,0),(352245,153374,153366,67,0,0),(352248,5,153376,63,0,0),(352249,153376,153368,67,0,0),(352252,5,153378,63,0,0),(352253,153378,153370,67,0,0),(352256,5,153380,63,0,0),(352257,153380,153370,67,0,0),(352260,5,153382,63,0,0),(352261,153382,153370,67,0,0),(352264,5,153384,63,0,0),(352265,153384,153370,67,0,0),(352272,5,153388,63,0,0),(352273,153388,153372,67,0,0),(352276,5,153390,63,0,0),(352277,153390,153372,67,0,0),(352280,5,153392,4,0,0),(352281,153392,153366,1,0,0),(352282,153392,153372,1,0,0),(352283,153392,82,1,0,0),(352286,5,153394,4,0,0),(352287,153394,79,1,0,0),(352288,153394,80,1,0,0),(352289,153394,2142,1,0,0),(352292,5,153396,4,0,0),(352293,153396,153370,1,0,0),(559382,5,240363,4,0,0),(352301,88,153368,1,0,0),(360200,5,156572,59,0,0),(360410,156572,3865,65,0,0),(360409,156572,3867,65,0,0),(360408,156572,3863,65,0,0),(360407,156572,139468,65,0,0),(360406,156572,3871,62,0,0),(360209,3871,156572,248,0,0),(360405,156572,2786,60,0,0),(371954,5,161656,4,0,0),(559305,5,207189,323,0,0),(559302,75393,207189,323,0,0),(372555,5,161656,2,0,0),(372896,9440,15198,66,0,0),(373279,5,162047,63,0,0),(373280,162047,8,67,0,0),(376637,5,243,2,0,0),(421768,5,182052,9,0,0),(421782,5,182058,63,0,0),(421784,182058,182052,67,0,0),(421805,5,182067,63,0,0),(421806,182067,182052,67,0,0),(421809,5,182069,63,0,0),(421812,182069,182052,67,0,0),(421820,5,182075,4,0,0),(421826,182075,182052,1,0,0),(422721,182075,86,1,0,0),(459969,198122,81,67,0,0),(459968,5,198122,63,0,0),(535433,5,230314,5,0,0),(444625,5,191710,318,0,0),(444626,191710,50972,325,0,0),(452760,5,195060,318,0,0),(452763,5,195062,75,0,0),(452766,195060,195062,325,0,0),(452769,5,195065,318,0,0),(452770,5,195066,74,0,0),(452776,195065,195066,322,0,0),(452777,195065,195062,325,0,0),(452778,5,195069,74,0,0),(452781,195065,195069,322,0,0),(458779,5,197558,9,0,0),(458782,5,197560,9,0,0),(458785,5,197562,63,0,0),(458786,197562,197558,67,0,0),(458789,5,197564,63,0,0),(458790,197564,197560,67,0,0),(458935,5,197648,63,0,0),(458936,197648,3862,67,0,0),(458939,5,197650,63,0,0),(458940,197650,3862,67,0,0),(458943,5,197652,63,0,0),(458944,197652,3862,67,0,0),(458947,5,197654,63,0,0),(458948,197654,3862,67,0,0),(458951,5,197656,63,0,0),(458952,197656,3862,67,0,0),(458955,5,197658,63,0,0),(458956,197658,3862,67,0,0),(458959,3861,197560,1,0,0),(458960,3861,197558,1,0,0),(480503,5,207189,318,0,0),(480504,207189,9406,322,0,0),(480505,207189,50972,325,0,0),(483753,5,3379,2,0,0),(483754,5,208570,81,0,0),(487421,5,210576,63,0,0),(487424,210576,44322,67,0,0),(508994,5,218985,63,0,0),(508995,218985,44322,67,0,0),(511219,5,219880,9,0,0),(511222,5,219882,63,0,0),(511223,219882,219880,67,0,0),(511226,36,219880,1,0,0),(513587,5,220950,81,0,0),(514329,5,81327,8,0,0),(514485,5,221355,11,0,0),(514486,5,221355,8,0,0),(514489,5,221357,11,0,0),(514490,5,221357,8,0,0),(514493,5,221359,11,0,0),(514494,5,221359,8,0,0),(514505,5,221365,11,0,0),(514517,5,221372,11,0,0),(514520,5,221372,8,0,0),(549711,5,236257,63,0,0),(549712,236257,197560,67,0,0),(556304,5,221365,8,0,0),(556780,136617,2142,1,0,0),(556783,136617,86,1,0,0),(559358,5,240347,63,0,0),(559359,240347,44322,67,0,0),(559360,5,240348,81,0,0),(559361,5,240349,81,0,0),(559362,5,240350,4,0,0),(559363,5,240350,373,0,0),(559364,240350,86,1,0,0),(559365,5,240350,2,0,0),(559366,5,240351,9,0,0),(559367,240350,240351,1,0,0),(559368,5,240352,63,0,0),(559369,240352,240351,67,0,0),(559370,5,240353,63,0,0),(559371,240353,240351,67,0,0),(559372,5,240354,63,0,0),(559373,240354,240351,67,0,0),(559374,5,240355,373,0,0),(559375,5,240356,373,0,0),(559376,5,240357,373,0,0),(559377,5,240358,373,0,0),(559378,5,240359,373,0,0),(559379,5,240360,373,0,0),(559380,5,240361,373,0,0),(559381,5,240362,373,0,0),(559385,5,240364,9,0,0),(559386,240363,240364,1,0,0),(559387,5,240365,63,0,0),(559388,240365,240364,67,0,0),(559389,5,240366,379,0,0),(559390,5,240367,379,0,0),(559391,5,240368,379,0,0),(559392,5,240369,63,0,0),(559393,240369,16867,67,0,0),(559394,5,240370,63,0,0),(559395,240370,16867,67,0,0),(559396,5,240371,63,0,0),(559397,240371,16867,67,0,0),(559398,5,240372,63,0,0),(559399,240372,16867,67,0,0),(559400,5,240373,63,0,0),(559401,240373,16867,67,0,0),(559402,5,240374,63,0,0),(559403,240374,16867,67,0,0),(559412,5,240379,9,0,0),(559413,3311,240379,1,0,0),(559414,5,240380,63,0,0),(559415,240380,240379,67,0,0),(559430,5,240387,74,0,0),(559431,5,240388,318,0,0),(559432,240388,240387,322,0,0),(559433,240388,195062,325,0,0),(559437,5,240390,63,0,0),(559438,240390,153370,67,0,0),(559439,5,240391,63,0,0),(559440,240391,153370,67,0,0),(559441,5,240392,63,0,0),(559442,240392,153370,67,0,0),(559482,5,240412,4,0,0),(559483,5,240413,9,0,0),(559484,240412,240413,1,0,0),(559485,5,240414,63,0,0),(559486,240414,240413,67,0,0),(559487,5,240415,63,0,0),(559488,240415,16867,67,0,0),(559489,5,240416,4,0,0),(559490,161656,240416,336,0,0),(559491,5,240417,318,0,0),(559492,240417,195062,325,0,0),(559493,5,240418,74,0,0),(559494,240417,240418,322,0,0),(559495,5,240419,318,0,0),(559496,240419,195062,325,0,0),(559497,5,240420,74,0,0),(559498,240419,240420,322,0,0),(559499,5,240421,318,0,0),(559500,240421,50972,325,0,0),(559501,5,240422,74,0,0),(559502,240421,240422,322,0,0),(559503,5,240423,318,0,0),(559504,240423,50972,325,0,0),(559505,5,240424,74,0,0),(559506,240423,240424,322,0,0),(559507,5,240425,318,0,0),(559508,240425,50972,325,0,0),(559509,5,240426,74,0,0),(559510,240425,240426,322,0,0),(559511,5,240427,318,0,0),(559512,240427,50972,325,0,0),(559513,5,240428,74,0,0),(559514,240427,240428,322,0,0),(559515,5,240429,318,0,0),(559516,240429,50972,325,0,0),(559517,5,240430,74,0,0),(559518,240429,240430,322,0,0),(559519,5,240431,318,0,0),(559520,240431,50972,325,0,0),(559521,5,240432,74,0,0),(559522,240431,240432,322,0,0),(559523,5,240433,89,0,0),(559524,230314,240433,90,0,0),(559525,5,240434,310,0,0),(559526,5,240435,9,0,0),(559527,153392,240435,1,0,0),(559528,5,240436,9,0,0),(559529,32296,240436,1,0,0),(559530,5,240437,63,0,0),(559531,240437,240435,67,0,0),(559532,5,240438,63,0,0),(559533,240438,153372,67,0,0),(559534,5,240439,63,0,0),(559535,240439,153372,67,0,0),(559536,5,240440,63,0,0),(559537,240440,153372,67,0,0),(559538,5,240441,63,0,0),(559539,240441,153372,67,0,0),(559540,5,240442,63,0,0),(559541,240442,153372,67,0,0),(559542,5,240443,63,0,0),(559543,240443,153372,67,0,0),(559544,5,240444,63,0,0),(559545,240444,240436,67,0,0),(559551,240447,240448,335,0,0),(559549,5,240447,81,0,0),(559550,5,240448,81,0,0),(559552,5,240449,81,0,0),(559553,240447,240449,335,0,0),(559554,5,240450,81,0,0),(559555,240447,240450,335,0,0),(559556,5,240451,11,0,0),(559557,38,240451,337,0,0),(559558,5,240452,11,0,0),(559559,38,240452,337,0,0),(559560,5,240453,4,0,0),(559561,3,240453,336,0,0),(559562,5,240454,4,0,0),(559563,136617,240454,336,0,0),(559567,5,240456,4,0,0),(559568,153392,240456,336,0,0),(559569,5,240457,5,0,0),(559570,6,240457,357,0,0),(559571,5,240458,5,0,0),(559572,230314,240458,357,0,0),(559573,5,240459,59,0,0),(559574,240459,2786,60,0,0),(559575,240459,3247,65,0,0),(559576,240459,3247,66,0,0),(559577,240459,3217,65,0,0),(559578,240459,3217,66,0,0),(559579,6564,240459,248,0,0),(559580,5,240460,4,0,0),(559581,32296,240460,336,0,0),(559582,5,240461,4,0,0),(559583,5,240462,9,0,0),(559584,240461,240462,1,0,0),(559585,5,240463,63,0,0),(559586,240463,240462,67,0,0),(559587,5,240464,63,0,0),(559588,240464,240462,67,0,0),(559589,5,240465,63,0,0),(559590,240465,240462,67,0,0),(559591,5,240466,63,0,0),(559592,240466,240462,67,0,0),(559593,5,240467,63,0,0),(559594,240467,240462,67,0,0),(559595,5,240468,63,0,0),(559596,240468,240462,67,0,0),(559597,5,240469,63,0,0),(559598,240469,240462,67,0,0),(559599,5,240470,4,0,0),(559600,240461,82,1,0,0),(559601,240461,79,1,0,0),(559602,240461,80,1,0,0),(559603,5,240471,4,0,0),(559604,240471,82,1,0,0),(559605,240471,79,1,0,0),(559606,5,240472,4,0,0),(559607,2,240472,336,0,0),(559608,5,240473,4,0,0),(559609,3317,240473,336,0,0),(559613,5,240475,63,0,0),(559614,240475,8,67,0,0),(559615,5,240476,63,0,0),(559616,240476,8,67,0,0),(559617,5,240477,318,0,0),(559618,5,240478,75,0,0),(559619,5,240479,74,0,0),(559620,240477,240479,322,0,0),(559621,240477,240478,325,0,0),(559622,5,240480,4,0,0),(559623,88,240480,336,0,0),(559624,5,240481,4,0,0),(559625,88,240481,336,0,0),(559626,5,240482,310,0,0),(559627,5,240483,63,0,0),(559628,240483,44322,67,0,0),(559629,5,240484,63,0,0),(559630,240484,44322,67,0,0),(559631,5,240485,63,0,0),(559632,240485,44322,67,0,0),(559633,5,240486,63,0,0),(559634,240486,44322,67,0,0),(559635,5,240487,63,0,0),(559636,240487,44322,67,0,0),(559637,5,240488,63,0,0),(559638,240488,44322,67,0,0),(559639,5,240489,63,0,0),(559640,240489,44322,67,0,0),(559641,5,240490,81,0,0),(559642,240447,240490,335,0,0),(559644,1,240491,336,0,0),(559646,5,240492,10,0,0),(559647,75393,240492,339,0,0),(559652,5,240494,63,0,0),(559653,31500,240494,363,0,0),(559658,5,240496,4,0,0),(559659,3317,240496,336,0,0),(559660,5,240497,63,0,0),(559661,240497,31515,67,0,0),(559662,5,240498,63,0,0),(559663,240498,197560,67,0,0),(559664,5,240499,9,0,0),(559665,240471,240499,1,0,0),(559666,5,240500,63,0,0),(559667,240500,240499,67,0,0),(559668,5,240501,63,0,0),(559669,240501,8,67,0,0),(559670,5,240502,63,0,0),(559671,240502,3862,67,0,0),(559672,5,240503,63,0,0),(559673,240503,3862,67,0,0),(559684,5,240509,57,0,0),(559685,5,240510,59,0,0),(559686,240510,240509,60,0,0),(559687,240510,88,62,0,0),(559688,240510,3235,65,0,0),(559689,240510,3235,66,0,0),(559690,5,240511,81,0,0),(559691,240447,240511,335,0,0),(559692,240344,240477,324,0,0),(559693,240344,240417,324,0,0),(559694,240344,240419,324,0,0),(559695,240344,240421,324,0,0),(559696,240344,240423,324,0,0),(559697,240344,240425,324,0,0),(559698,240344,240427,324,0,0),(559699,240344,240429,324,0,0),(559700,240344,240431,324,0,0),(559701,240344,195065,324,0,0),(559702,240344,240388,324,0,0),(559703,240344,207189,324,0,0),(559704,240344,195060,324,0,0),(559705,240344,191710,324,0,0),(559706,5,240512,299,0,0),(559707,240344,240512,300,0,0),(559712,5,240514,11,0,0),(559713,5,240514,8,0,0),(559718,5,240516,81,0,0),(559719,240447,240516,335,0,0),(559720,5,240517,4,0,0),(559721,5,240518,9,0,0),(559722,240517,240518,1,0,0),(559723,5,240519,63,0,0),(559724,240519,240518,67,0,0),(559725,5,240520,63,0,0),(559726,240520,240518,67,0,0),(559727,5,240521,63,0,0),(559728,240521,240518,67,0,0),(559729,5,240522,63,0,0),(559730,240522,240518,67,0,0),(559731,5,240523,63,0,0),(559732,240523,240518,67,0,0),(559733,5,240524,63,0,0),(559734,240524,240518,67,0,0),(559735,5,240525,4,0,0),(559736,5890,240525,336,0,0),(559737,5,240526,63,0,0),(559738,240526,31491,67,0,0),(559739,5,240527,63,0,0),(559740,240527,31491,67,0,0),(559741,5,240528,63,0,0),(559742,240528,31491,67,0,0),(559743,5,240529,63,0,0),(559744,240529,240379,67,0,0),(559745,5,240530,5,0,0),(559750,5,240532,81,0,0),(559751,240447,240532,335,0,0),(559752,5,240533,11,0,0),(559753,5,240533,8,0,0),(559754,5,240534,63,0,0),(559755,240534,219880,67,0,0),(559756,5,240535,59,0,0),(559757,5,240536,57,0,0),(559758,240535,240536,60,0,0),(559759,240535,44321,62,0,0),(559760,44321,240535,248,0,0);
/*!40000 ALTER TABLE `relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rights`
--

DROP TABLE IF EXISTS `rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rights` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `rights_statement` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rights`
--

LOCK TABLES `rights` WRITE;
/*!40000 ALTER TABLE `rights` DISABLE KEYS */;
/*!40000 ALTER TABLE `rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `show_hide`
--

DROP TABLE IF EXISTS `show_hide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `show_hide` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `show_hide` enum('show','hide') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=240513 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `show_hide`
--

LOCK TABLES `show_hide` WRITE;
/*!40000 ALTER TABLE `show_hide` DISABLE KEYS */;
INSERT INTO `show_hide` VALUES (240344,'hide'),(240512,'hide');
/*!40000 ALTER TABLE `show_hide` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site`
--

DROP TABLE IF EXISTS `site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `primary_maintainer` varchar(32) DEFAULT NULL,
  `base_url` varchar(128) DEFAULT NULL,
  `loki_default` tinytext,
  `short_department_name` varchar(32) DEFAULT NULL,
  `department` tinytext,
  `asset_directory` varchar(128) DEFAULT NULL,
  `site_state` enum('Live','Not Live') DEFAULT 'Not Live',
  `other_base_urls` tinytext,
  `custom_url_handler` tinytext,
  `use_page_caching` tinyint(3) unsigned DEFAULT '0',
  `allow_site_to_change_theme` enum('true','false') DEFAULT 'true',
  `base_breadcrumbs` text,
  `use_custom_footer` enum('yes','no') DEFAULT NULL,
  `custom_footer` text,
  `domain` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site`
--

LOCK TABLES `site` WRITE;
/*!40000 ALTER TABLE `site` DISABLE KEYS */;
INSERT INTO `site` VALUES (5,'admin','/masteradmin/','notables','','','asset','Not Live','','master admin needs no url handler!',0,'true','',NULL,NULL,NULL),(75393,'admin','/login/','default','','','asset','Live','','',0,'true','',NULL,NULL,NULL),(240492,'admin','/login/','default','','','asset','Live','','',0,'true','','','',NULL);
/*!40000 ALTER TABLE `site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sortable`
--

DROP TABLE IF EXISTS `sortable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sortable` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sort_order` smallint(6) DEFAULT '32767',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=240536 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sortable`
--

LOCK TABLES `sortable` WRITE;
/*!40000 ALTER TABLE `sortable` DISABLE KEYS */;
INSERT INTO `sortable` VALUES (3250,11),(3251,10),(3468,12),(3989,14),(38,NULL),(3486,NULL),(3496,NULL),(3497,NULL),(3498,NULL),(3501,NULL),(6301,35),(7435,15),(9406,9),(9440,27),(13860,39),(13861,40),(14014,16),(14423,17),(17685,NULL),(240344,32767),(22039,9),(22126,38),(27787,1),(34442,NULL),(35398,5),(36806,6),(57366,43),(75394,32767),(81327,32767),(109269,32767),(119825,32767),(140154,32767),(156572,32767),(195066,32767),(195069,32767),(221355,32767),(221357,32767),(221359,32767),(221365,32767),(221372,32767),(240355,32767),(240356,32767),(240357,32767),(240358,32767),(240359,32767),(240360,32767),(240361,32767),(240362,32767),(240387,32767),(240418,32767),(240420,32767),(240422,32767),(240424,32767),(240426,32767),(240428,32767),(240430,32767),(240432,32767),(240448,32767),(240449,32767),(240450,32767),(240451,0),(240452,0),(240459,32767),(240479,32767),(240490,32767),(240505,9),(240506,32767),(240507,32767),(240508,32767),(240510,32767),(240512,32767),(240514,32767),(240533,32767),(240535,32767);
/*!40000 ALTER TABLE `sortable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('pending','published') DEFAULT NULL,
  `publish_start_date` datetime DEFAULT NULL,
  `publish_end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `synchronization`
--

DROP TABLE IF EXISTS `synchronization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `synchronization` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `sync_name` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `synchronization`
--

LOCK TABLES `synchronization` WRITE;
/*!40000 ALTER TABLE `synchronization` DISABLE KEYS */;
/*!40000 ALTER TABLE `synchronization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_status`
--

DROP TABLE IF EXISTS `system_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dt` datetime DEFAULT NULL,
  `la_1_min` float DEFAULT NULL,
  `la_5_min` float DEFAULT NULL,
  `la_15_min` float DEFAULT NULL,
  `shell_users` int(10) unsigned DEFAULT NULL,
  `p_sleeping` int(10) unsigned DEFAULT NULL,
  `p_running` int(10) unsigned DEFAULT NULL,
  `p_zombie` int(10) unsigned DEFAULT NULL,
  `p_stopped` int(10) unsigned DEFAULT NULL,
  `c_user` float DEFAULT NULL,
  `c_system` float DEFAULT NULL,
  `c_nice` float DEFAULT NULL,
  `c_idle` float DEFAULT NULL,
  `m_av` int(10) unsigned DEFAULT NULL,
  `m_used` int(10) unsigned DEFAULT NULL,
  `m_free` int(10) unsigned DEFAULT NULL,
  `m_shrd` int(10) unsigned DEFAULT NULL,
  `m_buff` int(10) unsigned DEFAULT NULL,
  `s_av` int(10) unsigned DEFAULT NULL,
  `s_used` int(10) unsigned DEFAULT NULL,
  `s_free` int(10) unsigned DEFAULT NULL,
  `s_cached` int(10) unsigned DEFAULT NULL,
  `host` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_status`
--

LOCK TABLES `system_status` WRITE;
/*!40000 ALTER TABLE `system_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `custom_content_handler` tinytext,
  `custom_content_lister` tinytext,
  `custom_deleter` tinytext,
  `display_name_handler` tinytext,
  `plural_name` varchar(128) DEFAULT NULL,
  `custom_previewer` tinytext,
  `finish_actions` varchar(128) DEFAULT NULL,
  `custom_sorter` tinytext,
  `custom_post_deleter` varchar(128) DEFAULT NULL,
  `custom_feed` tinytext,
  `feed_url_string` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type`
--

LOCK TABLES `type` WRITE;
/*!40000 ALTER TABLE `type` DISABLE KEYS */;
INSERT INTO `type` VALUES (1,'type.php3','','','','Types','type.php','fix_amputees.php','','',NULL,NULL),(2,'entity_table.php3','','entity_table.php','','Entity Tables','','','','','',''),(3,'site.php3','','','','Sites','','update_rewrites_on_site_finish.php','','update_rewrites_on_site_deletion.php','',''),(4,'user.php3','','','','Users','user.php','',NULL,NULL,NULL,NULL),(36,'admin_link.php','','','','Admin Links','','','','','',''),(2785,'','','','','View Types','','',NULL,NULL,NULL,NULL),(88,'news.php3','','','','News / Posts','','','','','sitewide_news.php','posts'),(243,'image.php3','image_list.php3','','image.php3','Images','image_previewer.php','',NULL,NULL,NULL,NULL),(2812,'associator.php3','','','','Views','','',NULL,NULL,NULL,NULL),(2820,'field.php3','','field.php3','','Fields','','',NULL,NULL,NULL,NULL),(2823,'project.php3','','','','Projects','project.php','','project.php','','',''),(3861,'media_work.php3','','','','Media Works','','','','','',''),(3311,'','','','','External CSS Urls','','',NULL,NULL,NULL,NULL),(3313,'','','','','Minisite Templates','','',NULL,NULL,NULL,NULL),(3317,'minisite_page.php3','','minisite_page.php','','Pages','page.php','','page.php','update_rewrites.php','',''),(3379,'text_blurb.php3','','','','Text Blurbs','','','',NULL,NULL,NULL),(3871,'media_file.php3','','','','Media Files','media_file.php','','','','media_files.php','media_files'),(4264,'','','','','User Roles','','',NULL,NULL,NULL,NULL),(5397,'faculty_staff.php3','','','','Faculty / Staff','faculty_staff.php','','','','',''),(5890,'policy.php3','','','','Policies','','','policy.php','',NULL,NULL),(5907,'asset.php','','','','Assets','','update_rewrites.php',NULL,NULL,NULL,NULL),(6564,'issue.php3','','','','Issues','','','',NULL,NULL,NULL),(13993,'','','','','Tasks','','','','','',''),(27618,'minutes.php3',NULL,'','','Minutes','','','','',NULL,NULL),(31512,'event.php3',NULL,'','','Events','','','','','events.php','events'),(31518,'category.php3',NULL,'','','Categories','','','','','',''),(32296,'news_section.php',NULL,'','','News Sections','','','','',NULL,NULL),(33122,'non_reason_site.php3',NULL,'','','Non-Reason Sites','','','','',NULL,NULL),(41963,'job.php',NULL,'','','Jobs','','','','','jobs.php','jobs'),(44321,'thor.php3',NULL,'','','Forms','form.php','','','','',''),(54388,'offices_depts.php3',NULL,'','','Office/Departments','','','','','',''),(60241,'faq.php3',NULL,'','','FAQs','','','','','faqs.php','faq'),(75398,'site_user.php3',NULL,'','','Site Users','','','','','',''),(118606,'',NULL,'','','Project Types','','','','','',''),(136617,'site_type.php',NULL,'','','Site Types','','','','','',''),(153392,'blog.php',NULL,'','','Blogs / Publications','','update_rewrites.php','','','','blogs'),(153394,'comment.php3',NULL,'','','Comments','','','','','',''),(153396,'group.php3',NULL,'','','Groups','','','','','',''),(161656,'theme.php',NULL,'','','Themes','theme.php','','','','',''),(182075,'event_slot_registration.php',NULL,'','','Registration Slots','','','','','',''),(240350,NULL,NULL,NULL,NULL,'Audiences',NULL,NULL,NULL,NULL,NULL,NULL),(240363,'html_editor.php3',NULL,NULL,NULL,'HTML Editors',NULL,NULL,NULL,NULL,NULL,NULL),(240412,NULL,NULL,NULL,NULL,'External URLs',NULL,NULL,NULL,NULL,NULL,NULL),(240416,'','','','','Themes','','','','','',''),(240453,'site.php3','','','','Sites','','update_rewrites_on_site_finish.php','','update_rewrites_on_site_deletion.php','',''),(240454,'','','','','Site Types','','','','','',''),(240456,'blog.php','','','','Blogs / Publications','','update_rewrites.php','','','','blogs'),(240460,'','','','','News Sections','','','','','',''),(240461,'classified.php',NULL,NULL,NULL,'Classifieds',NULL,NULL,NULL,NULL,NULL,NULL),(240470,NULL,NULL,NULL,NULL,'Classified categories',NULL,NULL,NULL,NULL,NULL,NULL),(240471,'quote.php',NULL,NULL,NULL,'Quotes',NULL,NULL,NULL,NULL,NULL,NULL),(240472,'entity_table.php3','','entity_table.php3','','Entity Tables','','','','','',''),(240473,'minisite_page.php3','','minisite_page.php3','','Pages','page.php','update_rewrites.php','page.php','update_rewrites.php','',''),(240480,'news.php3','','','','News / Posts','','','','','news.php','news'),(240481,'news.php3','','','','News / Posts','','','','','news.php','posts'),(240491,'type.php3','','','','Types','type.php','','','','',''),(240496,'minisite_page.php3','','minisite_page.php','','Pages','page.php','update_rewrites.php','page.php','update_rewrites.php','',''),(240504,'theme.php','','','','Themes','','','','','',''),(240517,'feature.php',NULL,NULL,NULL,'Features',NULL,NULL,NULL,NULL,NULL,NULL),(240525,'policy.php3','','','','Policies','','','page.php','','','');
/*!40000 ALTER TABLE `type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url`
--

DROP TABLE IF EXISTS `url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `url` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url`
--

LOCK TABLES `url` WRITE;
/*!40000 ALTER TABLE `url` DISABLE KEYS */;
INSERT INTO `url` VALUES (38,'admin/?cur_module=AllowableRelationshipManager'),(2786,'default.php3'),(2787,'tree.php3'),(3486,'scripts/stats/stats.php'),(3496,'scripts/db_maintenance/delete_widowed_relationships.php'),(3497,'scripts/db_maintenance/delete_headless_chickens.php'),(3498,'scripts/db_maintenance/delete_duplicate_relationships.php'),(3501,'scripts/db_maintenance/amputees.php'),(7430,'multiple_root_tree.php'),(9406,'css/default_styles.css'),(17685,'scripts/urls/update_urls.php'),(34442,'scripts/move/move_entities_among_sites.php'),(75394,''),(81327,'scripts/import/import_photos.php'),(109269,'scripts/search/find_across_sites.php'),(124306,'page_tree.php3'),(195066,'css/tableless_layouts/three_column_1.css'),(195069,'css/simplicity/blue.css'),(221355,'scripts/db_maintenance/remove_duplicate_entities.php'),(221357,'scripts/developer_tools/get_page_types.php'),(221359,'scripts/developer_tools/get_type_listers.php'),(221365,'scripts/developer_tools/modules.php'),(221372,'scripts/page_types/view_page_type_info.php'),(240387,'css/simplicity/green.css'),(240418,'css/simplicity/tan.css'),(240420,'css/simplicity/grey.css'),(240422,'css/themes/black_box/black_box.css'),(240424,'css/themes/pedagogue/plum.css'),(240426,'css/themes/gemstone/gemstone.css'),(240428,'css/themes/gemstone/ruby/ruby.css'),(240430,'css/themes/gemstone/emerald/emerald.css'),(240432,'css/themes/starbaby/starbaby.css'),(240451,'reason/?cur_module=AllowableRelationshipManager'),(240452,'admin/?cur_module=AllowableRelationshipManager'),(240479,'css/bedrich/bedrich.css'),(240505,'/global_stock/css/default_styles.css'),(240506,'./?cur_module=EntityInfo'),(240507,'./?cur_module=VersionCheck'),(240508,'./?cur_module=ReviewChanges'),(240509,'sections_and_issues.php'),(240514,'scripts/db_maintenance/orphan_manager.php'),(240533,'?cur_module=AdminTools'),(240536,'list_with_duplicate.php');
/*!40000 ALTER TABLE `url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `site_window_pref` enum('Same Window','Popup Window') DEFAULT 'Popup Window',
  `user_surname` tinytext,
  `user_given_name` tinytext,
  `user_email` tinytext,
  `user_phone` tinytext,
  `user_password_hash` tinytext,
  `user_authoritative_source` enum('reason','external') DEFAULT NULL,
  `user_popup_alert_pref` enum('yes','no') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (6,'Popup Window','','','','','','external','no'),(230314,'Popup Window',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(240457,'Popup Window','','','','','','',''),(240458,'Popup Window','','','','','','',''),(240530,'Popup Window',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `require_authentication` enum('true','false') DEFAULT NULL,
  `limit_authorization` enum('true','false') DEFAULT NULL,
  `authorized_usernames` text,
  `arbitrary_ldap_query` text,
  `ldap_group_filter` text,
  `ldap_group_member_fields` tinytext,
  `group_has_members` enum('true','false') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group`
--

LOCK TABLES `user_group` WRITE;
/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
INSERT INTO `user_group` VALUES (240434,NULL,NULL,NULL,NULL,NULL,NULL,'false'),(240482,'true','false',NULL,NULL,NULL,NULL,'true');
/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `view_options`
--

DROP TABLE IF EXISTS `view_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `view_options` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `column_order` tinytext,
  `default_sort` tinytext,
  `num_per_page` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `view_options`
--

LOCK TABLES `view_options` WRITE;
/*!40000 ALTER TABLE `view_options` DISABLE KEYS */;
INSERT INTO `view_options` VALUES (3250,NULL,NULL,NULL),(3251,'',NULL,NULL),(3468,'id, name, author, datetime','',0),(3989,'id, datetime, name, bug_state, author, sort_order','last_modified, desc',0),(6301,'','',0),(156572,'','',0),(140154,'','',0),(7435,'','',0),(9440,'','',0),(119825,'','show_hide, ASC',0),(27787,'id, datetime, name, minutes_status','datetime, desc',0),(22126,'id, datetime, name, status','',0),(22039,'id, name, url','',0),(13860,'','',0),(13861,'','',0),(14014,'id,name,priority,bug_type,bug_state,assigned_to,last_modified','bug_state, asc',0),(14423,'id, name, sort_order, last_modified','sort_order, asc',0),(35398,'id, datetime, name, location','datetime, DESC',0),(36806,'','',0),(57366,'id, name, office_department_type, office_department_code','name, ASC',0),(240459,'id, name, datetime, show_hide, last_modified','datetime, desc',NULL),(240510,NULL,NULL,NULL),(240535,NULL,NULL,NULL);
/*!40000 ALTER TABLE `view_options` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-01-31 15:56:58
