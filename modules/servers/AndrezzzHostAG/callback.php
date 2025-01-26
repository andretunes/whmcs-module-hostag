<?php
/**
 *	HostAG WHMCS Server Provisioning version 1.0
 *
 *	@package     WHMCS
 *	@copyright   Andrezzz
 *	@link        https://www.andrezzz.pt
 *	@author      André Antunes <andreantunes@andrezzz.pt>
 */

if (empty($_POST)) {
    exit(header('Location: https://www.andrezzz.pt'));
}

require_once '..' . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'init.php';
require_once ROOTDIR . DIRECTORY_SEPARATOR . 'includes' . DIRECTORY_SEPARATOR . 'modulefunctions.php';
require_once ROOTDIR . DIRECTORY_SEPARATOR . 'modules' . DIRECTORY_SEPARATOR . 'servers' . DIRECTORY_SEPARATOR . 'AndrezzzHostAG' . DIRECTORY_SEPARATOR . 'AndrezzzHostAG.php';

use WHMCS\Database\Capsule;

$_POST = array_map('html_entity_decode', $_POST);

$domain = ($_POST['action'] == 'delivery') ? 'ORDER-' . $_POST['order_id'] : 'SERVER-' . $_POST['server_id'];
$service = Capsule::table('tblhosting')->where('domain', $domain)->first();
$server = Capsule::table('tblservers')->where('id', $service->server)->first();

if (!$service) exit(header('Location: https://www.andrezzz.pt'));

$rawSig = '';
ksort($_POST, SORT_STRING);

foreach ($_POST as $key => $value) {
    if ($key === 'sig') continue;
    $rawSig .= $value;
}

$rawSig .= hash('sha512', decrypt($server->password));
$signature = hash('sha256', $rawSig);

if ($_POST['sig'] != $signature) exit(header('Location: https://www.andrezzz.pt'));

switch ($_POST['action']) {
    case 'delivery':
        $params = array(
            'serverusername' => $server->username,
            'serverpassword' => decrypt($server->password),
            'action' => 'Label',
            'label' => 'WHMCS ' . $service->id,
            'domain' => 'SERVER-' . $_POST['server_id'],
        );
        AndrezzzHostAG_API($params);

        if (gettype($_POST['ips']) !== 'array') $_POST['ips'] = json_decode($_POST['ips']);
        $_POST['ips'] = array_column($_POST['ips'], 'ip');
        
        Capsule::table('tblhosting')->where('id', $service->id)->update(array(
            'domain' => 'SERVER-' . $_POST['server_id'],
            'username' => $_POST['username'],
            'password' => encrypt($_POST['root']),
            'dedicatedip' => $_POST['ips'][0],
            'assignedips' => !array_shift($_POST['ips']) ?: implode('\n', $_POST['ips']),
        ));
        break;
    
    case 'cancel':
        $extraParams = array(
            'callback' => true
        );
        
        modulecallfunction('Terminate', $service->id, $extraParams);
        break;
    
    case 'suspend':
        $extraParams = array(
            'callback' => true,
            'suspendreason' => $_POST['reason']
        );
        
        modulecallfunction('Suspend', $service->id, $extraParams);
        break;
    
    case 'unsuspend':
        $extraParams = array(
            'callback' => true
        );
        
        modulecallfunction('Unsuspend', $service->id, $extraParams);
        break;
    
    case 'reinstall':
        Capsule::table('tblhosting')->where('id', $service->id)->update(array(
            'password' => encrypt($_POST['root']),
        ));
        break;

    default:
        exit(header('Location: https://www.andrezzz.pt'));
        break;
}
