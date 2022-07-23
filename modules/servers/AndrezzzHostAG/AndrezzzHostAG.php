<?php
/**
 *	HostAG WHMCS Server Provisioning version 1.0
 *
 *	@package     WHMCS
 *	@copyright   Andrezzz
 *	@link        https://www.andrezzz.pt
 *	@author      André Antunes <andreantunes@andrezzz.pt>
 */

if (!defined('WHMCS')) {
    exit(header('Location: https://www.andrezzz.pt'));
}

use WHMCS\Config\Setting;
use WHMCS\Database\Capsule;

function AndrezzzHostAG_API(array $params) {
    $url = 'https://www.host.ag/api/v1/';
    $data = [];
    $method = '';

    switch ($params['action']) {
        case 'User Info':
            $url .= 'user';
            $method .= 'GET';
            break;

        case 'Packages':
            $url .= 'packages';
            $method .= 'GET';
            break;

        case 'Disks':
            $url .= 'disks';
            $method .= 'GET';
            break;
            
        case 'Bandwidth':
            $url .= 'bandwidth';
            $method .= 'GET';
            break;

        case 'Addons':
            $url .= 'addons';
            $method .= 'GET';
            break;
           
        case 'Operating Systems - Order':
            $url .= 'os';
            $method .= 'GET';
            break;
           
        case 'Order':
            $url .= 'order';
            $method .= 'POST';
            
            $service = Capsule::table('tblhosting')->where('id', $params['serviceid'])->first();
            $billingCycles = array(
                'Monthly' => 1,
                'Quarterly' => 3,
                'Semi-Annually' => 6,
                'Annually' => 12,
            );

            $disks = array();
            $addonid = AndrezzzHostAG_GetOption($params, 'addonid');

            for ($i = 1; $i < 5; $i++) {
                $diskid = AndrezzzHostAG_GetOption($params, 'disk' . $i . 'id');
                if ($diskid == 0) continue;

                $disks[] = $diskid;
            };

            $data += array(
                'package' => AndrezzzHostAG_GetOption($params, 'packageid'),
                'ram' => AndrezzzHostAG_GetOption($params, 'ram'),
                'os' => AndrezzzHostAG_GetOption($params, 'osid'),
                'bandwidth' => AndrezzzHostAG_GetOption($params, 'bandwidthid'),
                'disk' => (count($disks) === 1) ? $disks[0] : $disks,
                'addon' => ($addonid !== 0) ? $addonid : '',
                'billing_term' => $billingCycles[$service->billingcycle] ?? 1,
                'ips' => AndrezzzHostAG_GetOption($params, 'ips'),
                'raid' => AndrezzzHostAG_GetOption($params, 'raid'),
                'notify_url' => Setting::getValue('SystemURL') . '/modules/servers/AndrezzzHostAG/callback.php',
            );
            break;

        case 'Server':
            $url .= 'server/' . str_replace('SERVER-', '', $params['domain']);
            $method .= 'GET';
            break;

        case 'IPs':
            $url .= 'server/' . str_replace('SERVER-', '', $params['domain']) . '/ips';
            $method .= 'GET';
            break;

        case 'ReverseDNS':
            $url .= 'reverse-dns/' . $params['ip'];
            $method .= 'POST';

            $data += array(
                'reversedns' => $params['reversedns']
            );
            break;

        case 'Operating Systems':
            $url .= 'server/' . str_replace('SERVER-', '', $params['domain']) . '/os';
            $method .= 'GET';
            break;

        case 'Graphs':
            $url .= 'graph/' . str_replace('SERVER-', '', $params['domain']);
            $method .= 'POST';

            $data += array(
                'interval' => $params['interval'],
                'width' => $params['width'],
                'height' => $params['height'],
                'format' => $params['format'],
            );
            break;

        case 'Reboot':
            $url .= 'server/' . str_replace('SERVER-', '', $params['domain']) . '/action/reboot';
            $method .= 'POST';
            break;

        case 'PowerUp':
            $url .= 'server/' . str_replace('SERVER-', '', $params['domain']) . '/action/start';
            $method .= 'POST';
            break;

        case 'PowerDown':
            $url .= 'server/' . str_replace('SERVER-', '', $params['domain']) . '/action/stop';
            $method .= 'POST';
            break;

        case 'Cancel':
            $url .= 'server/' . str_replace('SERVER-', '', $params['domain']) . '/action/cancel';
            $method .= 'POST';
            break;

        case 'Cancel':
            $url .= 'server/' . str_replace('SERVER-', '', $params['domain']) . '/action/stop-cancellation';
            $method .= 'POST';
            break;

        case 'KVM':
            $url .= 'server/' . str_replace('SERVER-', '', $params['domain']) . '/action/kvm';
            $method .= 'POST';

            $data += array(
                'ip' => $params['ip'],
            );
            break;

        case 'KVM Destory Session':
            $url .= 'server/' . str_replace('SERVER-', '', $params['domain']) . '/action/kvm-destroy';
            $method .= 'POST';

            $data += array(
                'session_id' => $params['session_id'],
            );
            break;

        case 'Reinstall':
            $url .= 'server/' . str_replace('SERVER-', '', $params['domain']) . '/action/reinstall';
            $method .= 'POST';

            $data += array(
                'os' => $params['os'],
            );
            break;

        case 'Stop-Reinstall':
            $url .= 'server/' . str_replace('SERVER-', '', $params['domain']) . '/action/stop-reinstall';
            $method .= 'POST';
            break;
        
        case 'Label':
            $url .= 'server/' . str_replace('SERVER-', '', $params['domain']) . '/action/label';
            $method .= 'POST';

            $data += array(
                'val' => $params['label'],
            );
            break;

        case 'Disable':
            $url .= 'server/' . str_replace('SERVER-', '', $params['domain']) . '/action/disable';
            $method .= 'POST';
            break;

        case 'Enable':
            $url .= 'server/' . str_replace('SERVER-', '', $params['domain']) . '/action/enable';
            $method .= 'POST';
            break;

        default:
            throw new Exception('Invalid action: ' . $params['action']);
            break;
    }

    $curl = curl_init();
    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_CUSTOMREQUEST, $method);
    curl_setopt($curl, CURLOPT_TIMEOUT, 5);
    curl_setopt($curl, CURLOPT_FOLLOWLOCATION, 1);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($curl, CURLOPT_POSTREDIR, CURL_REDIR_POST_301);
    curl_setopt($curl, CURLOPT_SSLVERSION, CURL_SSLVERSION_TLSv1_2);
    curl_setopt($curl, CURLOPT_USERAGENT, 'Andrezzz - HostAG WHMCS');
    curl_setopt($curl, CURLOPT_HTTPHEADER, array('X_API_USER: ' . $params['serverusername'], 'X_API_KEY:  ' . $params['serverpassword']));

    if ($method === 'POST' || $method === 'PATCH') {
        curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($data));
    }

    $responseData = curl_exec($curl);
    $statusCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
    
    $responseData = json_decode($responseData, true);

    if ($statusCode === 0) throw new Exception('cURL Error: ' . curl_error($curl));

    curl_close($curl);

    logModuleCall(
        'Andrezzz - HostAG',
        $url,
        !empty($data) ? json_encode($data) : '',
        print_r($responseData, true)
    );

    if (isset($responseData['status']) && $responseData['status'] === 0) throw new Exception($responseData['result']);

    return $responseData['result'];
}

function AndrezzzHostAG_Error($func, $params, Exception $err) {
    logModuleCall('Andrezzz - HostAG', $func, $params, $err->getMessage(), $err->getTraceAsString());
}

function AndrezzzHostAG_MetaData() {
    return array(
        'DisplayName' => 'Andrezzz - HostAG',
        'APIVersion' => '1.1',
        'RequiresServer' => true,
    );
}

function AndrezzzHostAG_ConfigOptions() {
    $os = array();
    $packages = array();
    $bandwidths = array();
    $disks = array();
    $addons = array(
        0 => 'None'
    );

    if (basename($_SERVER['SCRIPT_NAME'], '.php') === 'configproducts' && $_REQUEST['action'] === 'module-settings') {
        $id = (int) $_REQUEST['id'];

        $product = Capsule::table('tblproducts')->where('id', $id)->first();
        $servergroup = Capsule::table('tblservergroupsrel')->where('groupid', $product->servergroup)->first();
        if (!$servergroup) return;
        
        $server = Capsule::table('tblservers')->where('id', $servergroup->serverid)->first();
    
        $params = array(
            'serverusername' => $server->username,
            'serverpassword' => decrypt($server->password),
        );

        $params['action'] = 'Packages';
        $packagesList = AndrezzzHostAG_API($params);
    
        foreach ($packagesList as $package) {
            $packages += array(
                $package['id'] => $package['name'] . ' (€' . $package['price'] . ' EUR)'
            );
        }
    
        $params['action'] = 'Operating Systems - Order';
        $operatingSystems = AndrezzzHostAG_API($params);
    
        foreach ($operatingSystems as $operatingSystem) {
            $os += array(
                $operatingSystem['id'] => $operatingSystem['name'] . ' (€' . $operatingSystem['price'] . ' EUR)'
            );
        }

        $params['action'] = 'Bandwidth';
        $bandwidthList = AndrezzzHostAG_API($params);
    
        foreach ($bandwidthList as $bandwidth) {
            $bandwidths += array(
                $bandwidth['id'] => $bandwidth['name'] . ' (€' . $bandwidth['price'] . ' EUR)'
            );
        }

        $params['action'] = 'Disks';
        $disksList = AndrezzzHostAG_API($params);
    
        foreach ($disksList as $disk) {
            $disks += array(
                $disk['id'] => $disk['name'] . ' (€' . $disk['price'] . ' EUR)'
            );
        }

        $params['action'] = 'Addons';
        $addonsList = AndrezzzHostAG_API($params);
    
        foreach ($addonsList as $addon) {
            $addons += array(
                $addon['id'] => $addon['name'] . ' (€' . $bandwidth['price'] . ' EUR)'
            );
        }
    }
    
    return array(
        'packageid' => array(
            'FriendlyName' => 'Package',
            'Description' => 'The Package desired (Configurable option: packageid).',
            'Type' => 'dropdown',
            'Options' => $packages,
        ),
        'ram' => array(
            'FriendlyName' => 'RAM',
            'Description' => 'The RAM desired (Configurable option: ram).',
            'Type' => 'text',
            'Size' => '25',
            'Default' => '8',
        ),
        'osid' => array(
            'FriendlyName' => 'Operating System',
            'Description' => 'The Operating System desired (Configurable option: osid).',
            'Type' => 'dropdown',
            'Options' => $os,
        ),
        'ips' => array(
            'FriendlyName' => 'Extra IPs',
            'Description' => 'The Extra IPs desired (Configurable option: ips).',
            'Type' => 'text',
            'Size' => '25',
            'Default' => '0',
        ),
        'bandwidthid' => array(
            'FriendlyName' => 'Bandwidth',
            'Description' => 'The Bandwidth desired (Configurable option: bandwidthid).',
            'Type' => 'dropdown',
            'Options' => $bandwidths,
        ),
        'raid' => array(
            'FriendlyName' => 'Raid',
            'Description' => 'The Extra IPs desired (Configurable option: raid).',
            'Type' => 'text',
            'Size' => '25',
            'Default' => '1',
        ),
        'disk1id' => array(
            'FriendlyName' => 'Disk 1',
            'Description' => 'The Disk 1 desired (Configurable option: disk1id).',
            'Type' => 'dropdown',
            'Options' => $disks,
        ),
        'disk2id' => array(
            'FriendlyName' => 'Disk 2',
            'Description' => 'The Disk 2 desired (Configurable option: disk2id).',
            'Type' => 'dropdown',
            'Options' => $disks += [0 => 'None'],
        ),
        'disk3id' => array(
            'FriendlyName' => 'Disk 3',
            'Description' => 'The Disk 3 desired (Configurable option: disk3id).',
            'Type' => 'dropdown',
            'Options' => $disks += [0 => 'None'],
        ),
        'disk4id' => array(
            'FriendlyName' => 'Disk 4',
            'Description' => 'The Disk 4 desired (Configurable option: disk4id).',
            'Type' => 'dropdown',
            'Options' => $disks += [0 => 'None'],
        ),
        'addonid' => array(
            'FriendlyName' => 'Addon',
            'Description' => 'The Addon desired (Configurable option: addonid).',
            'Type' => 'dropdown',
            'Options' => $addons,
        ),
    );
}

function AndrezzzHostAG_GetOption(array $params, $id, $default = NULL) {
    $options = AndrezzzHostAG_ConfigOptions();

    $friendlyName = $options[$id]['FriendlyName'];

    if (isset($params['configoptions'][$friendlyName]) && $params['configoptions'][$friendlyName] !== '') {
        return $params['configoptions'][$friendlyName];
    } else if (isset($params['configoptions'][$id]) && $params['configoptions'][$id] !== '') {
        return $params['configoptions'][$id];
    } else if (isset($params['customfields'][$friendlyName]) && $params['customfields'][$friendlyName] !== '') {
        return $params['customfields'][$friendlyName];
    } else if (isset($params['customfields'][$id]) && $params['customfields'][$id] !== '') {
        return $params['customfields'][$id];
    }

    $found = false;
    $i = 0;
    
    foreach ($options as $key => $value) {
        $i++;
        if ($key === $id) {
            $found = true;
            break;
        }
    }

    if ($found && isset($params['configoption' . $i]) && $params['configoption' . $i] !== '') {
        return $params['configoption' . $i];
    }

    return $default;
}

function AndrezzzHostAG_TestConnection(array $params) {
    $err = '';

    try {
        $params['action'] = 'User Info';
        AndrezzzHostAG_API($params);
    } catch(Exception $e) {
        AndrezzzHostAG_Error(__FUNCTION__, $params, $e);
        $err = 'Received the error: ' . $e->getMessage() . ' Check module debug log for more detailed error.';
    }

    return [
        'success' => $err === '',
        'error' => $err,
    ];
}

function AndrezzzHostAG_CreateAccount(array $params) {
    try {
        $params['action'] = 'Order';
        $order = AndrezzzHostAG_API($params);

        Capsule::table('tblhosting')->where('id', $params['serviceid'])->update(array(
            'domain' => 'ORDER-' . $order['order_id'],
        ));
    } catch(Exception $err) {
        AndrezzzHostAG_Error(__FUNCTION__, $params, $err);
        return 'Received the error: ' . $err->getMessage() . ' Check module debug log for more detailed error.';
    }
    
    return 'success';
}

function AndrezzzHostAG_SuspendAccount(array $params) {
    try {
        if ($params['callback']) return 'success';

        $params['action'] = 'Disable';
        AndrezzzHostAG_API($params);
    } catch(Exception $err) {
        AndrezzzHostAG_Error(__FUNCTION__, $params, $err);
        return 'Received the error: ' . $err->getMessage() . ' Check module debug log for more detailed error.';
    }

    return 'success';
}

function AndrezzzHostAG_UnsuspendAccount(array $params) {
    try {
        if ($params['callback']) return 'success';

        $params['action'] = 'Enable';
        AndrezzzHostAG_API($params);
    } catch(Exception $err) {
        AndrezzzHostAG_Error(__FUNCTION__, $params, $err);
        return 'Received the error: ' . $err->getMessage() . ' Check module debug log for more detailed error.';
    }

    return 'success';
}

function AndrezzzHostAG_TerminateAccount(array $params) {
    try {
        if (!$params['callback']) {
            $params['action'] = 'Cancel';
            AndrezzzHostAG_API($params);
        }
        
        Capsule::table('tblhosting')->where('id', $params['serviceid'])->update(array(
            'username' => '',
            'password' => '',
            'dedicatedip' => '',
            'assignedips' => '',
        ));
    } catch(Exception $err) {
        AndrezzzHostAG_Error(__FUNCTION__, $params, $err);
        return 'Received the error: ' . $err->getMessage() . ' Check module debug log for more detailed error.';
    }

    return 'success';
}

// function AndrezzzHostAG_ChangePassword(array $params) {
//     try {
//         AndrezzzHostAG_API($params);
//     } catch(Exception $err) {
//         AndrezzzHostAG_Error(__FUNCTION__, $params, $err);
//         return 'Received the error: ' . $err->getMessage() . ' Check module debug log for more detailed error.';
//     }

//     return 'success';
// }

// function AndrezzzHostAG_ChangePackage(array $params) {
//     try {
//         $params['action'] = 'Upgrade';
//         AndrezzzHostAG_API($params);
//     } catch(Exception $err) {
//         AndrezzzHostAG_Error(__FUNCTION__, $params, $err);
//         return 'Received the error: ' . $err->getMessage() . ' Check module debug log for more detailed error.';
//     }

//     return 'success';
// }

function AndrezzzHostAG_PowerUp(array $params) {
    try {
        AndrezzzHostAG_API($params);
    } catch(Exception $err) {
        AndrezzzHostAG_Error(__FUNCTION__, $params, $err);
        return 'Received the error: ' . $err->getMessage() . ' Check module debug log for more detailed error.';
    }

    return 'success';
}

function AndrezzzHostAG_PowerDown(array $params) {
    try {
        AndrezzzHostAG_API($params);
    } catch(Exception $err) {
        AndrezzzHostAG_Error(__FUNCTION__, $params, $err);
        return 'Received the error: ' . $err->getMessage() . ' Check module debug log for more detailed error.';
    }

    return 'success';
}

function AndrezzzHostAG_Reboot(array $params) {
    try {
        AndrezzzHostAG_API($params);
    } catch(Exception $err) {
        AndrezzzHostAG_Error(__FUNCTION__, $params, $err);
        return 'Received the error: ' . $err->getMessage() . ' Check module debug log for more detailed error.';
    }

    return 'success';
}

function AndrezzzHostAG_ClientAreaAPI(array $params) {
    try {
        $action = App::getFromRequest('api');
        $actions = array('Server', 'IPs', 'ReverseDNS', 'Operating Systems', 'Graphs', 'Reboot', 'PowerUp', 'PowerDown', 'Cancel', 'Stop-Cancellation', 'KVM', 'KVM Destroy Session', 'Reinstall', 'Stop-Reinstall');
        $results = array('status' => 'success');

        if (in_array($action, $actions)) {
            foreach ($_POST as $key => $value) {
                $params[$key] = $value;
            }

            $params['action'] = $action;
            $result = AndrezzzHostAG_API($params);
            $results = array_merge($results, is_array($result) ? $result : array('result' => $result));

            return array('jsonResponse' => $results);
        } else {
            throw new Exception('Action not found');
        }
    } catch(Exception $err) {
        AndrezzzHostAG_Error(__FUNCTION__, $params, $err);
        return array('jsonResponse' => array('result' => 'error', 'message' => $err->getMessage()));
    }
}

function AndrezzzHostAG_AdminCustomButtonArray() {
    return array(
        'Power Up' => 'PowerUp',
        'Power Down' => 'PowerDown',
        'Reboot'=> 'Reboot',
	);
}

function AndrezzzHostAG_ClientAreaCustomButtonArray() {
    return array(
        'Power Up' => 'PowerUp',
        'Power Down' => 'PowerDown',
        'Reboot'=> 'Reboot',
	);
}

function AndrezzzHostAG_ClientAreaAllowedFunctions() {
    return array('ClientAreaAPI');
}

function AndrezzzHostAG_ClientArea(array $params) {
    if ($params['moduletype'] !== 'AndrezzzHostAG') return;

    try {
        if (strpos($params['domain'], 'ORDER-') !== false) throw new Exception('The order is pending.', 1);

        $params['action'] = 'Server';
        $server = AndrezzzHostAG_API($params);

        $params['action'] = 'Operating Systems';
        $operatingSystems = AndrezzzHostAG_API($params);

        $params['action'] = 'Graphs';
        $params['format'] = 'json';

        $params['interval'] = 'current';
        $currentGraph = AndrezzzHostAG_API($params);
        
        $params['interval'] = 'last_month';
        $lastMonthGraph = AndrezzzHostAG_API($params);

        $dirOS = __DIR__ . '/template/img/os/';
        $availableOS = glob($dirOS . '*.png');
        $operatingSystemsGrouped = array();
        
        foreach ($availableOS as $key => $os) {
            $availableOS[$key] = explode('.png', explode($dirOS, $os)[1])[0];
        }

        foreach ($operatingSystems as $key => $operatingSystem) {
            $group = $operatingSystem['group'];
            
            if (!isset($operatingSystemsGrouped[$group])) {
                $operatingSystemsGrouped[$group] = array(
                    'name' => $operatingSystem['group_name'],
                    'image' => (in_array($group, $availableOS) ? $group : 'others'),
                    'versions' => array(),
                );
            }
            
            $operatingSystemsGrouped[$group]['versions'][] = $operatingSystem;
        }
        
        $server['operatingSystem'] = $server['os'];
        $server['operatingSystem'] = array_search($server['operatingSystem'], array_column($operatingSystems, 'name'));
        $server['operatingSystem'] = $operatingSystems[$server['operatingSystem']];
        $server['operatingSystem']['group_img'] = (in_array($server['operatingSystem']['group'], $availableOS) ? $server['operatingSystem']['group'] : 'others');
        
        $server['status'] = $server['power_status'] !== 0 ? 'online' : 'offline';
        $server['statusDescription'] = ucfirst($server['status']);

        $server['currentGraph'] = $currentGraph['graph'];
        $server['lastMonthGraph'] = $lastMonthGraph['graph'];

        return array(
            'templatefile' => 'template/clientarea',
            'vars' => array(
                'server' => $server,
                'operatingSystemsGrouped' => $operatingSystemsGrouped,
            ),
        );
    } catch (Exception $err) {
        AndrezzzHostAG_Error(__FUNCTION__, $params, $err);

        return array(
            'templatefile' => 'template/error',
            'templateVariables' => array(
                'error' => $err->getMessage(),
            ),
        );
    }
}

function AndrezzzHostAG_AdminLink(array $params) {
    try {
        $params['action'] = 'User Info';
        $account = AndrezzzHostAG_API($params);

        return '<i class="fa fa-coins"></i> Balance: €' . $account['balance'] . ' EUR<br><i class="fa fa-badge-percent"></i> Discount: ' . $account['discount'] . '%';
    } catch(Exception $err) {
        AndrezzzHostAG_Error(__FUNCTION__, $params, $err);
        return 'Received the error: ' . $err->getMessage() . ' Check module debug log for more detailed error.';
    }
}