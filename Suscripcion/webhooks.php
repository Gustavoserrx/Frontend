<?php

require 'vendor/autoload.php';

// 2. Configura tu clave secreta de Stripe
\Stripe\Stripe::setApiKey('sk_test_51RGz7xRSAITdUuT7lIyFOBvVascNlGVu2zc5y6ix9zZU1XfecKFhdYktIWQLzKBSP7hTm9dq61hPfxsCOWr4H0Bh00VoRRQiyT');
$endpoint_secret = 'whsec_8a9e565bb3a39c517085ee3cff7baa6376ac655704175a2aaf0a20b9b4fbbb94';

// 4. Lee el cuerpo de la petición y la cabecera de firma
$payload    = @file_get_contents('php://input');
$sig_header = $_SERVER['HTTP_STRIPE_SIGNATURE'];

try {
    $event = \Stripe\Webhook::constructEvent($payload, $sig_header, $endpoint_secret);
} catch (\UnexpectedValueException $e) {
    http_response_code(400);
    exit('Payload inválido');
} catch (\Stripe\Exception\SignatureVerificationException $e) {
    http_response_code(400);
    exit('Firma inválida');
}

// 6. Maneja sólo el evento que nos interesa
if ($event->type === 'payment_intent.succeeded') {
    error_log("hola buenas que tal");

    $paymentIntent = $event->data->object;
    $payment_intent_id = $paymentIntent->id;
    $customer_id = $paymentIntent->customer;

    $customer = \Stripe\Customer::retrieve($paymentIntent->customer);
    $email = $customer->email;

    $sessions = \Stripe\Checkout\Session::all([
        'payment_intent' => $payment_intent_id,
        'limit' => 1
    ]);
    
    if (count($sessions->data) > 0) {
        $session_id = $sessions->data[0]->id;
    }


    try{
     //Llamada a la BBDD
     $conexion = new mysqli("localhost", "root", "", "pruebas_proyecto");

     if($conexion->connect_error){
         die("Error de conexión " . $conexion->connect_error);
     }

     $query_update_id = "UPDATE usuarios SET stripe_id = ? WHERE email = ?;";
     $stmt_update_id = $conexion->prepare($query_update_id);
     $stmt_update_id->bind_param("ss", $customer_id, $email);

     try{
         $stmt_update_id->execute();
         if ($stmt_update_id->affected_rows === 0){
             $stmt_update_id->close();
             error_log("Buenas");
             throw new Exception("Movidon");
         }
     }
     catch(mysqli_sql_exception $e){
         $stmt_update_id->close();
         throw $e;
     }

     $stmt_update_id->close();
     
     $estado = "exito";
     $query_exito_pago = "INSERT INTO pagos_stripe (session_id, estado, payment_intent_id) VALUES (?, ?, ?);";
     $stmt_exito_pago = $conexion->prepare($query_exito_pago);
     $stmt_exito_pago->bind_param("sss", $session_id, $estado, $payment_intent_id);
     $stmt_exito_pago->execute();
     $stmt_exito_pago->close();
     $conexion->close();
     

 }catch(Exception $e){

     \Stripe\Refund::create([
         'payment_intent' => $payment_intent_id
     ]);
     $estado = "fallido";
     error_log("Por aquí vamos");
     $query_failed_pago = "INSERT INTO pagos_stripe (session_id, estado, payment_intent_id) VALUES (?, ?, ?);";
     $stmt_failed_pago = $conexion->prepare($query_failed_pago);
     $stmt_failed_pago->bind_param("sss", $session_id, $estado, $payment_intent_id);
     $stmt_failed_pago->execute();
     $stmt_failed_pago->close();
     $conexion->close();
 }
 

}

// 7. Responde 200 para que Stripe considere el Webhook procesado
http_response_code(200);
echo 'Webhook procesado correctamente';