# configuracao do Wordpress
<?php
define( 'DB_NAME', 'nome_do_banco' );
define( 'DB_USER', 'usuario_do_banco' );
define( 'DB_PASSWORD', 'senha_do_banco' );
define( 'DB_HOST', 'localhost' );
define( 'DB_CHARSET', 'utf8' );

define( 'AUTH_KEY', 'coloque_aqui_uma_frase_aleatoria' );
define( 'SECURE_AUTH_KEY', 'coloque_aqui_outra_frase_aleatoria' );
define( 'LOGGED_IN_KEY', 'mais_uma_frase_aleatoria' );
define( 'NONCE_KEY', 'outra_frase_aleatoria' );
define( 'AUTH_SALT', 'aqui_vai_outra_frase' );
define( 'SECURE_AUTH_SALT', 'e_mais_uma_frase' );
define( 'LOGGED_IN_SALT', 'mais_uma_para_finalizar' );
define( 'NONCE_SALT', 'e_a_ultima_frase_aleatoria' );

$table_prefix = 'wp_';

define( 'WPLANG', '' );
define('WP_DEBUG', false);

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

require_once( ABSPATH . 'wp-settings.php' );