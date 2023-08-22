<?php
define("DB_NAME",				getenv("WORDPRESS_DB_NAME"));
define("DB_USER",				getenv("WORDPRESS_DB_USER"));
define("DB_PASSWORD",			getenv("WORDPRESS_DB_PASSWORD"));
define("DB_HOST",				getenv("WORDPRESS_DB_HOST") . ":3306");

//see https://api.wordpress.org/secret-key/1.1/salt/ for easy generation
define('AUTH_KEY',				'f-<Vu9<h$xbOx*!C +G@?R|Uim2(|2nk=RFqtXe9}GlO4O-+7s+o+$BGUS!P1EK?');
define('SECURE_AUTH_KEY',		'2?E8mi>:V7E{ qhLm/v$X4Ja,!N]sb#slQXW44(KpIR{R6%<Pozv<5iE0N1!MG*8');
define('LOGGED_IN_KEY',			'+Gz[MrF=$<w}nz,Y*.__~y#f>8TX3W|ug013LT7LcY6U|/50%t62:d+munu%Z;%4');
define('NONCE_KEY',				'>^ KMU@1cXRs]z1neUW>$QAr^M)>apyHF*W+h*Ui+L^t|v]7?&-tg>0@1wFc7?_S');
define('AUTH_SALT',				'%T*KCb%?4F>`Zlsc8+~|2)STOLmvGe)]EKMm1$,)1~c?QQ4X6.rFf _SZw3;K}-e');
define('SECURE_AUTH_SALT',		'6biFjMq!Oi()Gc:{4K=>n}nTde>L5W_-iD7&UrD>q({6H129Kb+lRpPD{<VQ3>ls');
define('LOGGED_IN_SALT',		'xap`{h(`OsfPIg8tY+s|J!Q&rMEQriICl-ve`6W6?D9CI[v94Q$s(,N!Ofvp}@$K');
define('NONCE_SALT',			'I)ojmuZO0M-JL[YR=M-~gG-+Fq+%ZIaw;eWx55a+OYts0CK+9(-v*mu&AtRTwP8W');

define("CONCATENATE_SCRIPTS",	false);

$table_prefix =					getenv("WORDPRESS_TABLE_PREFIX");

define("WP_DEBUG", true);
if (!defined("ABSPATH"))
	define("ABSPATH", __DIR__ . "/");

require_once ABSPATH . "wp-settings.php";