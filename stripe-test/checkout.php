<?php
require 'vendor/autoload.php';

\Stripe\Stripe::setApiKey('sk_test_51RGz7xRSAITdUuT7lIyFOBvVascNlGVu2zc5y6ix9zZU1XfecKFhdYktIWQLzKBSP7hTm9dq61hPfxsCOWr4H0Bh00VoRRQiyT');

header('Content-Type: application/json');

$input = json_decode(file_get_contents("php://input"), true);
$tipo = $input["tipo"];

$YOUR_DOMAIN = 'http://localhost:3539/stripe-test'; //Esto habrá que cambiarlo

switch($tipo){
    case "mensual":
        $checkout_session = \Stripe\Checkout\Session::create([
            'payment_method_types' => ['card'],
            'mode' => 'subscription',
            'line_items' => [[
              'price' => "price_1RHL8VRSAITdUuT7RScwZ7GR",
              'quantity' => 1,
            ]],
            'success_url' => $YOUR_DOMAIN . "/successMensual.html",
            'cancel_url' => $YOUR_DOMAIN . "/cancelMensual.html",
          ]);
        break;
    case "anual":
        $checkout_session = \Stripe\Checkout\Session::create([
            'line_items' => [[
                'price_data' => [
                    'currency' => 'eur',
                    'product_data' => [
                        'name' => 'Suscripción anual',
                    ],
                    'unit_amount' => 15000,
                ],
                'quantity' => 1,
            ]],
            'mode' => 'payment',
            'success_url' => $YOUR_DOMAIN . '/successAnual.html',
            'cancel_url' => $YOUR_DOMAIN . '/cancelAnual.html',
        ]);
        break;
}

echo json_encode(['id' => $checkout_session->id]);
?>