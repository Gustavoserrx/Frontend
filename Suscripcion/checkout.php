<?php
require 'vendor/autoload.php';

\Stripe\Stripe::setApiKey('sk_test_51RGz7xRSAITdUuT7lIyFOBvVascNlGVu2zc5y6ix9zZU1XfecKFhdYktIWQLzKBSP7hTm9dq61hPfxsCOWr4H0Bh00VoRRQiyT');

header('Content-Type: application/json');

$input = json_decode(file_get_contents("php://input"), true);
$tipo = $input["tipo"];

$YOUR_DOMAIN = 'http://localhost:80/practicas/Suscripcion/suscripcion.html'; //Esto habrá que cambiarlo

switch($tipo){
    case "mensual":
        $checkout_session = \Stripe\Checkout\Session::create([
            'payment_method_types' => ['card'],
            'mode' => 'subscription',
            'line_items' => [[
              'price' => "price_1RImkvRSAITdUuT7v2dDJcyw",
              'quantity' => 1,
            ]],
            'success_url' => 'http://localhost:80/practicas/Suscripcion/comprobacion.html?session_id={CHECKOUT_SESSION_ID}',
            'cancel_url' => $YOUR_DOMAIN . "/problema.html",
          ]);
        break;
    case "anual":
        $checkout_session = \Stripe\Checkout\Session::create([
            'payment_method_types' => ['card'],
            'mode' => 'subscription',
            'line_items' => [[
              'price' => "price_1RImjfRSAITdUuT7lVWVmP6k",
              'quantity' => 1,
            ]],
            'success_url' => 'http://localhost:80/practicas/Suscripcion/comprobacion.html?session_id={CHECKOUT_SESSION_ID}',
            'cancel_url' => $YOUR_DOMAIN . "/problema.html",
          ]);
        break;
}

echo json_encode(['id' => $checkout_session->id]);
?>