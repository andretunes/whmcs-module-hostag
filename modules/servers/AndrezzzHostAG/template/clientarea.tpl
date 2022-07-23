<script src="https://cdn.jsdelivr.net/npm/frappe-charts@1.2.4/dist/frappe-charts.min.iife.js"></script>

<style>
    .AndrezzzHostAG {
        font-family: sans-serif;
        font-size: 14px;
    }

    .AndrezzzHostAG .fade:not(.show) {
        display: none;
    }

    .AndrezzzHostAG #loading {
        position:fixed;
        color: #65686a;
        display:none;
        z-index:1000000;
    }

    .AndrezzzHostAG #loading-spinner {
        position:fixed;
        overflow: visible;
        margin: auto;
        top: 0;
        left: 0;
        bottom: 0;
        right: 0;
    }

    .AndrezzzHostAG #loading:before {
        content: '';
        display: block;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.3);
    }

    .AndrezzzHostAG a {
        cursor: pointer;
    }
    .AndrezzzHostAG img {
        border-style: none;
        margin-bottom: 10px;
        vertical-align: middle;
    }

    .AndrezzzHostAG .information {
        left: 0;
        right: 0;
        bottom: 0;
        color: #343a40;
        position: absolute;
    }

    .AndrezzzHostAG .form-label {
        color: #868888;
        margin-bottom: 0px;
        word-break: break-all;
    }

    .AndrezzzHostAG .border {
        display: flex;
        min-height: 125px;
        position: relative;
        align-items: center;
        justify-content: center;
    }

    .AndrezzzHostAG .mb-3, .AndrezzzHostAG .my-3 {
        margin-bottom: 1rem!important;
    }

    .AndrezzzHostAG .without-mb {
        margin-bottom: 0rem!important;
    }

    .AndrezzzHostAG .p-2 {
        padding: .5rem!important;
    }

    .AndrezzzHostAG i.fa.fa-play.start {
        color: #06d79c;
        font-size: 30px;
    }

    .AndrezzzHostAG i.fa.fa-stop.stop {
        color: #656373;
        font-size: 30px;
    }

    .AndrezzzHostAG i.fa.fa-sync.reboot {
        color: #398bf7;
        font-size: 30px;
    }

    .AndrezzzHostAG i.fa.fa-terminal.kvm {
        color: #868888;
        font-size: 30px;
    }

    .AndrezzzHostAG .dashboard-title {
        color: #3d3d3d;
        font-size: 22px;
    }

    .AndrezzzHostAG .dashboard-value {
        color: #586271 !important;
    }

    .AndrezzzHostAG .usage-details {
        border: 1px solid #e7e4e4;
        transition: all ease-in .2s;
    }

    .AndrezzzHostAG .usage-details:hover {
        border:1px solid transparent;
        box-shadow: 1px 1px 8px 6px #e5e3e3bf;
    }

    .AndrezzzHostAG .overview-label {
        color: #99abb4;
    }

    .AndrezzzHostAG .progress.disk-bar {
        height: 14px;
        margin-top: 25px;
        margin-bottom: 20px;
        border-radius: 6px;
        -webkit-box-shadow: none;
        box-shadow: none;
    }

    .AndrezzzHostAG .used_disk_percent, .used-cpu {
        color: #1e88e5;
        font-size: 20px;
    }

    .AndrezzzHostAG .dashboard-tab .nav-tabs {
        border-bottom: 1px solid #dfd8d8;
        margin: 0;
    }

    .AndrezzzHostAG .dashboard-tab .nav-tabs .nav-item {
        border-bottom: 1px solid #dfd8d8;
    }

    .AndrezzzHostAG .dashboard-tab .nav-tabs li a {
        position: relative;
        padding: 5px;
        margin-right: 10px;
        color: #374045 !important;
        border: none;
        border-radius: 0;
        background: transparent;
        transition: all 0.3s ease 0s;
        z-index: 2;
    }

    .AndrezzzHostAG .dashboard-tab .nav-tabs li a:before {
        content: "";
        width: 100%;
        height: 4px;
        border-radius: 2px;
        position: absolute;
        bottom: 0;
        left: 0;
    }

    .AndrezzzHostAG .dashboard-tab .nav-tabs li a:after {
        content: "";
        width: 0;
        height: 4px;
        background: linear-gradient(to right, #396afc, #2948ff);
        border-bottom: 1px solid #727cb6;
        border-radius: 2px;
        position: absolute;
        bottom: -2px;
        left: 0;
        transition: all .4s ease 0s;
        z-index: 1;
    }

    .AndrezzzHostAG .dashboard-tab .nav-tabs li a.active:after {
        width: 100%;
        opacity: 1;
    }

    .AndrezzzHostAG .vertical-tabs .nav-link {
        color: #515a68;
        padding: 7px 5px;
        margin-bottom: 10px;
        transition: all ease-in 0.2s;
        text-align: left!important;
    }

    .AndrezzzHostAG .vertical-tabs .nav-link.active {
        border-radius: 0px;
        color: #2948ff;
    }

    .AndrezzzHostAG .v-tabs-container {
        border-right: 1px solid #dfd8d8;
    }

    .AndrezzzHostAG .nav-pills .nav-link.active {
        background-color: unset;
    }

    .AndrezzzHostAG .custom-control-input:checked~.custom-control-label::before {
        color: #fff;
        border-color: #007bff;
        background-color: #007bff;
    }

    .AndrezzzHostAG .info-text {
        color: #398bf7;
        cursor: pointer;
    }
    
    .AndrezzzHostAG .bandwidth-graphs {
        width: 100%;
    }

    .AndrezzzHostAG .submit-btn {
        background-color: #398bf7;
        border:none;
        border-radius: 4px;
        color: #ffffff;
        font-weight: 500;
        padding: 7px 12px;
        transition: 0.2s ease-in;
    }

    .AndrezzzHostAG .cancel-btn {
        background-color: #5a6268;
        border:none;
        border-radius: 4px;
        color: #ffffff;
        font-weight: 500;
        padding: 7px 12px;
        transition: 0.2s ease-in;
    }

    .AndrezzzHostAG .submit-btn:hover {
        color: #ffffff !important;
        box-shadow:0 14px 26px -12px #1769ff6b, 0 4px 23px 0 #0000001f, 0 8px 10px -5px #1769ff33;
    }

    .AndrezzzHostAG .cancel-btn:hover {
        color: #ffffff !important;
        box-shadow:0 14px 26px -12px #000000, 0 4px 23px 0 #0000001f, 0 8px 10px -5px #07183533;
    }

    .AndrezzzHostAG .modal-title {
        font-weight: 400;
        color: #455a64;
    }

    .AndrezzzHostAG .modal-title i.success {
        font-size: 40px;
        color: #06d79c;
        vertical-align: middle;
    }

    .AndrezzzHostAG .modal-title i.warning {
        font-size: 40px;
        color: orange;
        vertical-align: middle;
    }

    .AndrezzzHostAG .modal-title i.error {
        font-size: 40px;
        color: #ef5350;
        vertical-align: middle;
    }

    .AndrezzzHostAG .modal-body {
        color: #868888;
        font-weight: 500;
        line-height: 30px;
        margin-bottom: 0px;
    }

    .AndrezzzHostAG .modal-body p {
        margin-bottom: 0px;
    }

    .AndrezzzHostAG .link-btn {
        background-color: #398bf7;
        border:none;
        border-radius: 4px;
        text-decoration: none !important;
        color: #ffffff !important;
        font-size: 14px;
        padding: 7px 12px;
        transition: 0.2s ease-in;
    }

    .AndrezzzHostAG .link-btn:hover {
        text-decoration: none;
        color: #ffffff;
        box-shadow: 0 14px 26px -12px rgba(23, 105, 255, 0.42), 0 4px 23px 0 rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(23, 105, 255, 0.2);
    }

    .AndrezzzHostAG .v-tab-heading {
        color: #515557;
        font-size: 18px;
    }

    .AndrezzzHostAG .distro_img {
        width: 64px;
        height: 64px;
    }

    .AndrezzzHostAG .distro_name.media-heading {
        color: #3d3d3d;
        font-size: 22px;
    }

    .AndrezzzHostAG .version {
        color: #586271;
        font-size: 16px;
    }

    .AndrezzzHostAG .info-icon {
        background-color: #007bff;
        color: #fff;
        padding: 4px 12px;
        border: none;
        border-radius: 4px;
    }

    .AndrezzzHostAG .info-icon:hover,
    .AndrezzzHostAG .info-icon:focus {
        border:none;
        box-shadow: 0 14px 26px -12px rgba(23, 105, 255, 0.42), 0 4px 23px 0 rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(23, 105, 255, 0.2);
    }

    .AndrezzzHostAG .info-icon i {
        font-size: 12px;
    }

    .AndrezzzHostAG .os_badge {
        border: 1px solid #ccc;
        cursor: pointer;
        transition: height 0.5s;
        border-radius: 3px;
        position: relative;
    }

    .AndrezzzHostAG #os_list .dropdown-menu {
        max-height: 200px;
        overflow-y: auto;
    }

    .AndrezzzHostAG .os_badge_list a {
        color: #576170;
        text-decoration: none;
        outline: none;
        display:block;
        padding:8px;
        background-color: #fff;
    }

    .AndrezzzHostAG .os_badge_list a:hover {
        color: #2f3235;
        background-color: #f9f6f6;
    }

    .AndrezzzHostAG .os_badge_list .SelectedOS { 
        color: #ffffff;
        background-color: #2196F3;
    }

    .AndrezzzHostAG .os_badge.selected .version,
    .AndrezzzHostAG .os_badge.selected .distro_name.media-heading, .os_badge.selected i {
        color: #ffffff;
    }
        
    .AndrezzzHostAG .os_badge.selected {
        color: #fff;
        background-color: #06d79c;
    }

    .AndrezzzHostAG .os_badge i {
        position: absolute;
        top: 26px;
        right: 16px;
        color: #aaa;
    }

    .AndrezzzHostAG .os_badge .media-left {
        padding: 8px;
    }

    .AndrezzzHostAG .os_badge .media-body {
        vertical-align: middle;
        padding: 8px;
    }

    .AndrezzzHostAG .os_badge .version {
        color: #888;
    }

    .AndrezzzHostAG .os_badge.expanded {
        position: relative;
        z-index: 999;
    }

    .AndrezzzHostAG .os_badge .dropdown-toggle::after {
        content: none;
    }

    .AndrezzzHostAG .tab-content>.tab-pane {
        display: none;
    }
 
    .AndrezzzHostAG .tab-content>.active {
        display: block;
    }

    .AndrezzzHostAG .head {
        margin-bottom: 10px;
    }

    .AndrezzzHostAG .head>img {
        width: 32px;
    }

    .AndrezzzHostAG .fa-1x {
        font-size: 20px !important;
    }

    .AndrezzzHostAG .grey-txt {
        color: #666;
    }
</style>

<script>
    function $_(id) {
        return document.getElementById(id);
    }

    function AndrezzzHostAG_API(action, alert = true, json = {}) {
        AndrezzzHostAG_Loading(true);
        
        WHMCS.http.jqClient.post('clientarea.php?action=productdetails&id={$serviceid}&modop=custom&a=ClientAreaAPI&api=' + action, json,
            function(data) {
                if (data.status === 1) {
                    switch (action) {
						case 'Reinstall':
                            window.location.reload();
							break;

						case 'IPs':
                            $('#rdnsIP').empty();
                            const select = $_('rdnsIP');

                            for (var i = 0; i < data.result.length; i++) {
                                const ip = data.result[i];
                                const option = document.createElement('option');

                                option.value = option.text = ip.ip;
                                option.setAttribute('data-reverse', ip.reverse);
                                select.add(option);

                                if (i === 0) $_('rdnsReverse').value = ip.reverse;
                            }
                            
							break;
                    }

                    AndrezzzHostAG_Loading(false);
                    
                    if (alert) {
                        if (typeof data.result === 'string') {
                            $('#AndrezzzHostAG-AlertSuccessMsg').html(data.result);
                        } else {
                            $('#AndrezzzHostAG-AlertSuccessMsg').html('{$LANG.moduleactionsuccess}');
                        }

                        $('#AndrezzzHostAG-AlertSuccess').hide().removeClass('hidden').slideDown();

                    	setTimeout(function() {
							$('#AndrezzzHostAG-AlertSuccess').slideUp();
						}, 5000);
                    }
                } else {
                    AndrezzzHostAG_Loading(false);
                    
                    $('#AndrezzzHostAG-AlertFailedMsg').html(data.result);
                    $('#AndrezzzHostAG-AlertFailed').hide().removeClass('hidden').slideDown();

                    setTimeout(function() {
                        $('#AndrezzzHostAG-AlertFailed').slideUp();
                    }, 5000);
                }
            }
        );
    }

    function AndrezzzHostAG_ShowTooltip(x, y, contents) {
        $('<div id="tooltip">' + contents + '</div>').css({
            position: 'absolute',
            display: 'none',
            top: y + 20,
            left: x - 20,
            border: '1px solid #CCCCCC',
            padding: '2px',
            'background-color': '#EFEFEF',
            'z-index': 10000,
            opacity: 0.80
        }).appendTo('body').fadeIn(200);
    }

    function AndrezzzHostAG_MakeData(data) {
        var now = new Date().getTime();
        var updateInterval = 1000;

        i = 0;
        var fdata = [];

        for (x in data) {
            fdata.push([now += updateInterval, data[x]]);
            i++;
        }

        return fdata;
    }

    function AndrezzzHostAG_Loading(status) {
        $_('loading').style.left = ((document.body.clientWidth - $('#loading').width()) / 2).toString() + 'px';

        if (status) {
            $('#loading').show();
        } else {
            $('#loading').hide();
        }
    }

    $(document).ready(function () {
        const bandwidth = '{$server.bandwidth}';
        const bandwidthUsage = '{$server.bandwidth_usage}';
        const bandwidthPackageText = '{$server.bandwidth_package_text}';
        const bandwidthPercentage = ((bandwidthUsage * 100) / (bandwidth * 1000)).toFixed();

        $('#bandwidthPercentBar').css('background', (bandwidthPercentage <= 40 ? '#9c06d7' : bandwidthPercentage < 80 ? 'orange' :  bandwidthPercentage >= 80 ? 'red' : '#ff0000'));
        $('#bandwidthPercentBar').css('width', bandwidthPercentage + '%');
        $('#bandwidthPercentBar').html(bandwidthPercentage + ' %');
        $('#bandwidthPercentBar').attr('tooltip', bandwidthPercentage + ' %');
        $('#bandwidthPercentVal').html(bandwidthUsage + ' / ' + (bandwidth != 0 ? bandwidth * 1000 : '∞') + ' GB');

        const currentData = {
            labels: [],

            datasets: [
                {
                    name: "In",
                    chartType: "line",
                    values: []
                },
                {
                    name: "Out",
                    chartType: "line",
                    values: []
                }
            ],
        };

        const lastMonthData = {
            ...currentData,
        };

        const currentGraph = JSON.parse('{$server["currentGraph"]|@json_encode}');

        for (var i = 0; i < currentGraph.length; i++) {
            const item = currentGraph[i];
            const label = new Date(item.created_at).toLocaleDateString();

            currentData.labels.push(label);
            currentData.datasets[0].values.push(Math.round(item.in * 1e-6));
            currentData.datasets[1].values.push(Math.round(item.out * 1e-6));
        }

        new frappe.Chart('#bandwidth-currentGraph', {
            title: 'Current month Bandwidth',
            data: currentData,
            type: 'line',
            height: 300,
            colors: ["#f5714f", "#008080"],
            axisOptions: {
                xAxisMode: "tick",
                xIsSeries: true
            },
            barOptions: {
                stacked: true,
                spaceRatio: 0.5
            },
            tooltipOptions: {
                formatTooltipX: (d) => (d + "").toUpperCase(),
                formatTooltipY: (d) => d + " mbps"
            }
        });

        const lastMonthGraph = JSON.parse('{$server["lastMonthGraph"]|@json_encode}');
    
        for (var i = 0; i < lastMonthGraph.length; i++) {
            const item = lastMonthGraph[i];
            const label = new Date(item.created_at).toLocaleDateString();

            lastMonthData.labels.push(label);
            lastMonthData.datasets[0].values.push(Math.round(item.in * 1e-6));
            lastMonthData.datasets[1].values.push(Math.round(item.out * 1e-6));
        }

        new frappe.Chart('#bandwidth-lastMonthGraph', {
            title: 'Last month Bandwidth',
            data: lastMonthData,
            type: 'line',
            height: 300,
            colors: ["#f5714f", "#008080"],
            axisOptions: {
                xAxisMode: "tick",
                xIsSeries: true
            },
            barOptions: {
                stacked: true,
                spaceRatio: 0.5
            },
            tooltipOptions: {
                formatTooltipX: (d) => (d + "").toUpperCase(),
                formatTooltipY: (d) => d + " mbps"
            }
        });
    });

	function AndrezzzHostAG_ChooseOS(button) {
		var newOS = $_('newOS').value;

		if (newOS !== '0') {
			newOS = $('[data-os="' + newOS + '"]')[0];

			newOS.classList.remove('SelectedOS');
			$_(newOS.dataset.group + '-os').classList.remove('selected');
			$_(newOS.dataset.group + '-version').innerText = 'SELECT VERSION';
		}

		$_('newOS').value = button.dataset.os;

		button.classList.add('SelectedOS');
		$_(button.dataset.group + '-os').classList.add('selected');
		$_(button.dataset.group + '-version').innerText = button.innerText;
	}

    function AndrezzzHostAG_ChooseRDNSIP(select) {
        $_('rdnsReverse').value = select.options[select.selectedIndex].dataset.reverse;
    }
</script>

<div class="AndrezzzHostAG" style="display: block">
    <div id="loading" class="font-weight-bold" style="display: none;">
        <span class="spinner-border spinner-border-sm" style="width: 3rem; height: 3rem;" id="loading-spinner" role="status" aria-hidden="true"></span>
    </div>

    {include file="$template/includes/alert.tpl" type="success" msg='<span id="AndrezzzHostAG-AlertSuccessMsg"></span>' textcenter=true hide=true idname="AndrezzzHostAG-AlertSuccess"}
    {include file="$template/includes/alert.tpl" type="danger" msg=$LANG.moduleactionfailed|cat:': <span id="AndrezzzHostAG-AlertFailedMsg"></span>' textcenter=true hide=true idname="AndrezzzHostAG-AlertFailed"}

    <div class="title-block text-center dashboard-title mb-3">Server Information</div>

    <div class="row mb-3">
        <div class="col-md-6 mb-3 text-center">
            <div class="border p-2">
                <div class="mb-2">
                    <span><img src="{$WEB_ROOT}/modules/servers/AndrezzzHostAG/template/img/os/{$server['operatingSystem']['group_img']}.png" width="64px" height="64px" alt="{$server['operatingSystem']['name']}"/></span>
                </div>
                <div class="information">
                    <span class="form-label dashboard-value d-inline-block mb-2">{$server['operatingSystem']['name']}</span>
                </div>
            </div>
        </div>
        <div class="col-md-6 mb-3 text-center">
            <div class="border p-2">
                <div class="mb-2">
                    <span><img src="{$WEB_ROOT}/modules/servers/AndrezzzHostAG/template/img/{$server['status']}.png" height="64px"/></span>
                </div>
                <div class="information">
                    <span class="form-label dashboard-value d-inline-block mb-2">{$server['statusDescription']}</span>
                </div>
            </div>
        </div>
        <div class="col-md-12 mb-6">
            <div class="border p-2">
                <div class="row w-100">
                    <div class="col-3 without-mb text-center" tooltip="Start the Server" data-original-title="" title="">
                        <a onclick="AndrezzzHostAG_API('PowerUp');"><i class="fa fa-play start mr-2" aria-hidden="true"></i></a>
                    </div>
                    <div class="col-3 without-mb text-center" tooltip="Stop the Server" data-original-title="" title="">
                        <a onclick="AndrezzzHostAG_API('PowerDown');"><i class="fa fa-stop stop mr-2" aria-hidden="true"></i></a>
                    </div>
                    <div class="col-3 without-mb text-center" tooltip="Reboot the Server" data-original-title="" title="">
                        <a onclick="AndrezzzHostAG_API('Reboot');"><i class="fa fa-sync reboot mr-2" aria-hidden="true"></i></a>
                    </div>
                    <div class="col-3 without-mb text-center" tooltip="Connect to the Server via KVM" data-original-title="" title="">
                        <a onclick="AndrezzzHostAG_API('KVM');"><i class="fa fa-terminal kvm mr-2" aria-hidden="true"></i></a>
                    </div>
                    <div class="col-md-12">
                        <br />
                        <label class="form-label d-inline-block">IPv4:</label>
                        <span class="form-label dashboard-value d-inline-block mr-2">{$server['ips'][0]}</span>
                        {* <br />
                        <label class="form-label d-inline-block">IPv6:</label>
                        <span class="form-label dashboard-value d-inline-block mr-2">{if $server['ipv6'] !== ''}{$server['ipv6']}{else}<a onclick="AndrezzzHostAG_API('IPv6');">Create</a>{/if}</span> *}
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="dashboard-tab" id="dashboard">
        <ul class="nav nav-tabs mb-4 dash-tabs" id="pills-tab" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="overview-tab" data-toggle="pill" href="#overview" role="tab" aria-controls="overview" aria-selected="false">Overview</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="settings-tab" data-toggle="pill" href="#settings" role="tab" aria-controls="settings" aria-selected="false">Settings</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="rdns-tab" data-toggle="pill" href="#rdns" onclick="AndrezzzHostAG_API('IPs', false);" role="tab" aria-controls="rdns" aria-selected="false">Reverse DNS</a>
            </li>
        </ul>
        <div class="tab-content" id="pills-tabContent">
            <div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview-tab">
                <div class="head">
                    <img src="{$WEB_ROOT}/modules/servers/AndrezzzHostAG/template/img/eye.png">
                    <span class="h3">Overview</span>
                </div>

                <div class="row mb-2">
                    <div class="col-md-12 mb-6">
                        <div class="usage-details px-3 py-4">
                            <p class="overview-label">Bandwidth Usage</p>
                            <div class="progress disk-bar">
                                <div id="bandwidthPercentBar" aria-valuemin="0" aria-valuemax="100" role="progressbar" class="progress-bar prog-organge" data-placement="right" tooltip="0% Used" style="background: #9c06d7; width: 0%">0%</div>
                            </div>
                            <span id="bandwidthPercentVal" class="used_disk_percent mr-1">0 / 0 TB</span>
                            <span class="overview-label">Used</span>
                        </div>
                    </div>
                    <br />
                    <div class="col-md-12 mb-6">
                        <div id="bandwidth-currentGraph" class="bandwidth-graphs usage-details px-3 py-4"></div>
                    </div>
                    <br />
                    <div class="col-md-12 mb-6">
                        <div id="bandwidth-lastMonthGraph" class="bandwidth-graphs usage-details px-3 py-4"></div>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="settings" role="tabpanel" aria-labelledby="settings-tab">
                <div class="row vertical-tabs">
                    <div class="col-md-3 v-tabs-container" style="max-width: 15%!important;">
                        <div class="nav flex-md-column mx-auto left-side-tabs mb-4 mb-md-0" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                            <a class="nav-link mr-2 mr-md-0 active" id="password-tab" data-toggle="pill" href="#password" role="tab" aria-controls="password" aria-selected="false" style="display: block">Password</a>
                            <a class="nav-link mr-2 mr-md-0" id="reinstall-tab" data-toggle="pill" href="#reinstall" role="tab" aria-controls="reinstall" aria-selected="false" style="display: block">Reinstall</a>
                        </div>
                    </div>
					<div class="col-md-10">
                        <div class="tab-content vertical-tab-content">
                            <div class="tab-pane fade active show" id="password" role="tabpanel" aria-labelledby="password-tab">
                                <div class="head">
                                    <img src="{$WEB_ROOT}/modules/servers/AndrezzzHostAG/template/img/lock.png">
                                    <span class="h3">Password</span>
                                </div>

                                {* <div class="badge badge-warning mb-3">It's mandatory for you to change the password on your first login!</div> *}
                                <div class="badge badge-warning mb-3">The installation password is removed from our systems after 72 hours.<br />It is mandatory for you to change the password on your first login!</div>
                                <br />
                                <label class="form-label d-inline-block">Password:</label>
                                <span class="form-label dashboard-value d-inline-block mr-2">{if $server['root_password'] != ''}{$server['root_password']}{else}Expired{/if}</span>
                            </div>
                            <div class="tab-pane fade" id="reinstall" role="tabpanel" aria-labelledby="reinstall-tab">
                                <div class="head">
                                    <img src="{$WEB_ROOT}/modules/servers/AndrezzzHostAG/template/img/installing.png">
                                    <span class="h3">Reinstall</span>
                                </div>

                                <div class="badge badge-danger mb-3">Please understand that by reinstalling, all the data will be wiped from the server.</div>

                                <div id="reinstallIntructions" class="col-lg-10 col-12 mx-auto">
                                    <label class="form-label">Select OS:</label>
                                    
                                    <div id="os_list" class="row mb-4">
                                        {foreach from=$operatingSystemsGrouped key=$group item=$operatingSystemsGroup}
                                        <div id="{$group}-os" class="col os_badge media dropdown show">
                                            <button class="btn dropdown-toggle border-0 w-100 p-0" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                <div class="media-left p-1 float-left">
                                                    <img class="distro_img media-object" src="{$WEB_ROOT}/modules/servers/AndrezzzHostAG/template/img/os/{$operatingSystemsGroup['image']}.png">
                                                </div>
                                                <div class="media-body float-left text-left p-2">
                                                    <h4 class="distro_name media-heading">{$operatingSystemsGroup['name']}</h4>
                                                    <span id="{$group}-version" class="version">SELECT VERSION</span>
                                                </div>
                                            </button>
                                            <div class="os_badge_list dropdown-menu w-100" x-placement="bottom-start" style="position: absolute; transform: translate3d(0px, 68px, 0px); top: 0px; left: 0px; will-change: transform;">
                                                {foreach from=$operatingSystemsGrouped[$group]['versions'] item=$operatingSystem}
                                                <a href="#" data-os="{$operatingSystem['id']}" data-group="{$group}" onclick="AndrezzzHostAG_ChooseOS(this);return false;">{$operatingSystem['name']}</a>
                                                {/foreach}
                                            </div>
                                        </div>
                                        {/foreach}
                                    </div>

                                    <input type="hidden" id="newOS" value="0"/>				
                                    <button onclick="AndrezzzHostAG_API('Reinstall', true, { os: $_('newOS').value });" class="submit-btn">Reinstall</button>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="rdns" role="tabpanel" aria-labelledby="rdns-tab">
                <div class="head">
                    <img src="{$WEB_ROOT}/modules/servers/AndrezzzHostAG/template/img/search.png">
                    <span class="h3">rDNS Records</span>
                </div>

                <div class="rdns">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="rdnsIP" class="form-label mr-1 d-inline-block">IP Address</label>
                                <select class="form-control" name="rdnsIP" id="rdnsIP" onchange="AndrezzzHostAG_ChooseRDNSIP(this);return false;"></select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="rdnsReverse" class="form-label mr-1 d-inline-block">Reverse DNS</label>
                                <input class="form-control" type="text" name="rdnsReverse" size="30" id="rdnsReverse"/>
                            </div>
                        </div>
                    </div>

                    <button onclick="AndrezzzHostAG_API('ReverseDNS', true, { ip: $_('rdnsIP').value, reversedns: $_('rdnsReverse').value });" class="submit-btn">Add Reverse DNS</button>
                </div>
            </div>
        </div>
    </div>
</div>