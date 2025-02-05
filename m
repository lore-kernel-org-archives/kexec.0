Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF328C02192
	for <kexec@archiver.kernel.org>; Wed,  5 Feb 2025 12:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SpUOOK8GzB36zHOudH5smL0yDrIEKj5b/YwJYn+IlIE=; b=LW09yMQXvT/U1+LIRfKVYbuVka
	Oyg0CyX9VZcAGIHpii7Uo0Js7XwB//1KBWrgZqhkUXlQjmXZlq8FlSLuQ5LmF7LUdPt0VC8QyX3o3
	eiZi69boWzzl++LvdNBpm3bLEvrtWbWPAkBmTyDWZphmYiKyOuRn/U38V8TXgjCg0JaemDkF+XHn5
	yK6yhykAd40t5g5YKgNGR1Bbe5gGU78E6lNyF4x2FkNXRsscpfT+HUsE0ClLcvpg7fg1jZG3JC1Kn
	hV1plNoiNmg1S48YdsvI0oS17SFtYjI+NO3iGfOIZL5n4wdWDiybzfMju+XDDRmXrPOno9bnOd8kX
	VkeAe0UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfebg-00000003DpO-279R;
	Wed, 05 Feb 2025 12:34:16 +0000
Received: from lelvem-ot01.ext.ti.com ([198.47.23.234])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfeOL-00000003B0c-2PeU
	for kexec@lists.infradead.org;
	Wed, 05 Feb 2025 12:20:30 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 515CKQpX3419303
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 5 Feb 2025 06:20:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738758026;
	bh=SpUOOK8GzB36zHOudH5smL0yDrIEKj5b/YwJYn+IlIE=;
	h=Date:To:From:Subject;
	b=GFQ/R4w8ebSkU4Ls3eieSysAsoOzxPQdsvhmw74gkay8kYIMYDEq50Q0z0SNVqns1
	 S00RaW8mnzkP3F/XYg25gewWVbxCWrxv3g6jQzR19B6+Og9SWrolIKnpfoPBCXqFj/
	 hcFmsFDC2nkeuOWGfpcDR0f0l/e5eEPdKgZwXuP4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 515CKQrv010431
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <kexec@lists.infradead.org>; Wed, 5 Feb 2025 06:20:26 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Feb 2025 06:20:26 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Feb 2025 06:20:26 -0600
Received: from [10.24.72.64] (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.72.64])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 515CKOAW078443
	for <kexec@lists.infradead.org>; Wed, 5 Feb 2025 06:20:25 -0600
Message-ID: <4ccd4d81-2efd-4369-a759-552dbb9a007f@ti.com>
Date: Wed, 5 Feb 2025 17:50:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <kexec@lists.infradead.org>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
Subject: VMCORE and kdump.conf file not found LINUX 6.12 KERNEL
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250205_042029_703702_5DEAF94C 
X-CRM114-Status: UNSURE (   6.24  )
X-CRM114-Notice: Please train this message.
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Team,

It would be really great,if you could help me with a couple of questions 
regarding kexec and kdump.

I tried kdump on my SOC and it is rebooting fine . However,the VMCORE 
file and /etc/kdump.conf file is not found.

VERSION:
kexec-tools 2.0.30.
kernel 6.12v

STEPS FOLLOWED:

1)git clone git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

2)
    HOST PC:
	>cd $KEXEC_TOOLS_DIR
	>./bootstrap LDFLAGS=-static ./configure --prefix=/usr/local 
--host=aarch64-linux-gnu --target=aarch64-linux-gnu
	>make
	>cp $KEXEC_TOOLS_DIR/build/sbin/kexec /media/$USER/rootfs/usr/sbin (To 
copy the kexec binary to the rootfs filesystem of the target board)

    TARGET BOARD:
	>Booted upto linux
	>cmdline="crashkernel=128M console=ttyS2,115200n8 root=/dev/mmcblk0p2 
rw rootfste=ext4 rootwait" (/dev/mmcblk0p2 refers to EMMC)
	> /kexec -p /Image --command-line="$cmdline" 
--dtb=/k3-j721e-common-proc-board.dtb
	> echo c > /proc/sysrq-trigger


LOGS:

          Starting Reboot and dump vmcore via kexec...
[  OK  ] Listening on Docker Socket for the API.
[  OK  ] Listening on Weston socket.
[  OK  ] Started D-Bus System Message Bus.
[  OK  ] Reached target Socket Units.
[  OK  ] Reached target Basic System.
[  OK  ] Started Job spooling tools.
          Starting Avahi mDNS/DNS-SD Stack...
[  OK  ] Started Periodic Command Scheduler.
          Starting Print notice about GPLv3 packages...
          Starting IPv6 Packet Filtering Framework...
          Starting IPv4 Packet Filtering Framework...
[  OK  ] Started irqbalance daemon.
          Starting Telephony service...
          Starting Expand the rootfs partiti…to full size of the boot 
device....
[    5.992254] audit: type=1334 audit(1728487094.820:10): prog-id=14 op=LOAD

[    6.003634] audit: type=1334 audit(1728487094.832:11): prog-id=15 op=LOAD
[    6.010482] audit: type=1334 audit(1728487094.832:12): prog-id=16 op=LOAD
          Starting User Login Management...
          Starting Telnet Server...
[  OK  ] Finished IPv6 Packet Filtering Framework.
[  OK  ] Finished IPv4 Packet Filtering Framework.
[  OK  ] Finished Telnet Server.
[  OK  ] Started User Login Management.
[  OK  ] Finished Expand the rootfs partition to full size of the boot 
device..
[  OK  ] Started Telephony service.
[  OK  ] Started Avahi mDNS/DNS-SD Stack.
[  OK  ] Created slice Slice /system/systemd-fsck.
          Expecting device /dev/mmcblk0p1...
[  OK  ] Reached target Preparation for Network.
          Starting Load Kernel Module drm...
[    6.406000] audit: type=1334 audit(1728487095.236:13): prog-id=17 op=LOAD
          Starting Network Configuration...
          Starting Virtual Console Setup...
[  OK  ] Stopped target RPC Port Mapper.
[  OK  ] Stopped target Timer Units.
[  OK  ] Stopped Daily rotation of log files.
[  OK  ] Stopped Daily Cleanup of Temporary Directories.
[  OK  ] Stopped target System Time Set.
          Stopping Job spooling tools...
          Stopping Avahi mDNS/DNS-SD Stack...
          Stopping Periodic Command Scheduler...
          Stopping irqbalance daemon...
[  OK  ] Stopped target Host and Network Name Lookups.
          Stopping Telephony service...
[  OK  ] Stopped Expand the rootfs partition to full size of the boot 
device..
          Stopping strongSwan IPsec IKEv1/IKEv2 daemon using ipsec.conf...
[  OK  ] Removed slice Slice /system/getty.
[  OK  ] Removed slice Slice /system/serial-getty.
          Stopping User Login Management...
          Stopping Load/Save OS Random Seed...
          Starting Record Runlevel Change in UTMP...
          Stopping Telnet Server...
[  OK  ] Stopped target Remote File Systems.
[  OK  ] Stopped Reboot and dump vmcore via kexec.

