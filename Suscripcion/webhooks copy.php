<?php
require 'vendor/autoload.php';

\Stripe\Stripe::setApiKey('sk_test_51RGz7xRSAITdUuT7lIyFOBvVascNlGVu2zc5y6ix9zZU1XfecKFhdYktIWQLzKBSP7hTm9dq61hPfxsCOWr4H0Bh00VoRRQiyT');

$input = @file_get_contents("php://input");
$event = null;

try {
    $sig_header = $_SERVER['HTTP_STRIPE_SIGNATURE'];
    $endpoint_secret = 'whsec_8a9e565bb3a39c517085ee3cff7baa6376ac655704175a2aaf0a20b9b4fbbb94';
    $event = \Stripe\Webhook::constructEvent(
        $input, $sig_header, $endpoint_secret
    );
} catch(\UnexpectedValueException $e) {
    http_response_code(400);
    echo 'Invalid payload';
    exit();
} catch(\Stripe\Exception\SignatureVerificationException $e) {
    http_response_code(400);
    echo 'Invalid signature';
    exit();
}

switch ($event->type) {
    case 'checkout.session.completed':
        try{
        $session = $event->data->object;
        $checkoutSesh = \Stripe\Checkout\Session::retrieve([
            'id' => $session->id,
            'expand' => ['customer', 'invoice', 'payment_intent']
        ]);


        $subscription = \Stripe\Subscription::retrieve($checkoutSesh->subscription);
        $invoice = \Stripe\Invoice::retrieve($subscription->latest_invoice);
        $paymentIntent = $invoice->payment_intent;  

        $customer = $checkoutSesh->customer;
        $stripeId = $customer->id;
        $email = $customer->email;
        $sessionId = $session->id;

        //Llamada a la BBDD
            $conexion = new mysqli("localhost", "root", "", "pruebas_proyecto");

            if($conexion->connect_error){
                die("Error de conexión " . $conexion->connect_error);
            }

            $query_update_id = "UPDATE usuarios SET stripe_id = ? WHERE email = ?;";
            $stmt_update_id = $conexion->prepare($query_update_id);
            $stmt_update_id->bind_param("ss", $stripeId, $email);

            try{
                $stmt_update_id->execute();
                if ($stmt_update_id->affected_rows === 0){
                    $stmt_update_id->close();
                    error_log("He llegado aquí");
                    throw new Exception("Movidon");
                }
            }
            catch(mysqli_sql_exception $e){
                $stmt_update_id->close();
                throw $e;
            }

            $stmt_update_id->close();
            
            $estado = "exito";
            $query_exito_pago = "INSERT INTO pagos_stripe (session_id, estado) VALUES (?, ?);";
            $stmt_exito_pago = $conexion->prepare($query_exito_pago);
            $stmt_exito_pago->bind_param("ss", $sessionId, $estado);
            $stmt_exito_pago->execute();
            $stmt_exito_pago->close();
            $conexion->close();
            

        }catch(Exception $e){

            \Stripe\Refund::create([
                'payment_intent' => $paymentIntentId
            ]);
            error_log("Y ahora aquí");
            $estado = "fallido";
            $query_failed_pago = "INSERT INTO pagos_stripe (session_id, estado) VALUES (?, ?);";
            $stmt_failed_pago = $conexion->prepare($query_failed_pago);
            $stmt_failed_pago->bind_param("ss", $sessionId, $estado);
            $stmt_failed_pago->execute();
            $stmt_failed_pago->close();
            $conexion->close();
        }
        break;
    } 
    http_response_code(200);
        ?>