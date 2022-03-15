<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use PHPMailer\PHPMailer\SMTP;

require '../PHPMailer/src/Exception.php';
require '../PHPMailer/src/PHPMailer.php';
require '../PHPMailer/src/SMTP.php';

class Correo
{
    public function __construct()
    {
    }
    public function EnviarCorreo($nombrepdf,$ruta,$asunto,$cuerpoCorreo)
    {
        $mail = new PHPMailer(true);
        try {
            chmod($ruta, 777);
            //Server settings
            //$mail->SMTPDebug = SMTP::DEBUG_SERVER;                      //Enable verbose debug output
            $mail->isSMTP();                                            //Send using SMTP
            $mail->Host       = 'smtp.gmail.com';                     //Set the SMTP server to send through
            $mail->SMTPAuth   = true;                                   //Enable SMTP authentication
            $mail->Username   = 'manuelcruz86@gmail.com';                     //SMTP username
            $mail->Password   = 'iznfacdctjmybgxo';                               //SMTP password
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;            //Enable implicit TLS encryption
            $mail->Port       = 465;                                    //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`

            //Recipients
            $mail->setFrom('manuelcruz86@gmail.com', 'Manuel');
            $mail->addAddress('itguatemala@sercogua.com');     //Add a recipient
            //$mail->addAddress('bizdeveloper@sercogua.com');               //Name is optional
            //$mail->addReplyTo('info@example.com', 'Information');
            //$mail->addCC('cc@example.com');
            //$mail->addBCC('bcc@example.com');

            //Attachments
            //$mail->addAttachment('/var/tmp/file.tar.gz');         //Add attachments
            $mail->addAttachment($ruta, $nombrepdf, 'base64', 'application/pdf');    //Optional name

            //Content
            $mail->isHTML(true);                                  //Set email format to HTML
            $mail->Subject = $asunto;
            $mail->Body    = $cuerpoCorreo;
            $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

            $mail->send();
            $json['mensaje'] = "Mensaje enviado";
            $json['estado'] = 1;
            return $json;
        } catch (Exception $e) {
            echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
        }
    }
}
