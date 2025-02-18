Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862BEC02198
	for <kexec@archiver.kernel.org>; Tue, 18 Feb 2025 06:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iJvBrvfSqJVVEUrBz/DFtx1SwLDqwHZYI30PBbPuvjM=; b=cMNVPFuJRBqEVJoSU4KcJOTGa/
	YTbBg2c+nl+85rkzyDL9Cm2CTGoZPBUsPDHiBZz/l7NBUsQo3kgPr2l4g5olQapyoJ9xMt40vrD2y
	usGX3xRDtYoKSvMcTBp1+c9E1qJ+cAX8YktHy5eqMJ/zE75vYXwu1GaCdqAHH9zBPcMfVjA003KSo
	U1nHZImVji3DnhrofRzjcIxH9I7egWiNHOb5jjQ+/HAg13ymaPBNS6RuSVt4/GnxP4j8mBQCqCCD/
	PDuAL0lKH7ysyrBMLem5dSzYNhq7pCGFgVMfV6Gq0QSnN/19BSyH+IjVf5oeMdduxkXjCJRUTnlbm
	CXklNyVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGkl-00000006x2B-38Y9;
	Tue, 18 Feb 2025 06:06:43 +0000
Received: from fllvem-ot04.ext.ti.com ([198.47.19.246])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGkj-00000006x1W-1MyE
	for kexec@lists.infradead.org;
	Tue, 18 Feb 2025 06:06:42 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51I66dtR654251
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Tue, 18 Feb 2025 00:06:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739858799;
	bh=iJvBrvfSqJVVEUrBz/DFtx1SwLDqwHZYI30PBbPuvjM=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=EJfWqrNj15ty135ZoSaHTjSjEG2A6f2Fv/AnjUNAmfK+yGnU5fnz7+4eiauuZAsNY
	 BorGZE1wG02eo2V4dkCN2TS3i7RqDPn6YdYZ2/sjP4YoJA/+B8SH4SbEf+mDqkUyfG
	 5wDdnNAYQp1fq3MYwsgm7TDnnXKbPl5D0XGB9QIY=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51I66d8L021700
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <kexec@lists.infradead.org>; Tue, 18 Feb 2025 00:06:39 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Feb 2025 00:06:39 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Feb 2025 00:06:38 -0600
Received: from [10.24.68.214] (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.68.214])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51I66b0Q029056
	for <kexec@lists.infradead.org>; Tue, 18 Feb 2025 00:06:38 -0600
Message-ID: <a69a8eaf-9fc0-468b-b39a-1486e6054878@ti.com>
Date: Tue, 18 Feb 2025 11:36:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VMCORE and kdump.conf file not found LINUX 6.12 KERNEL
From: Gokul Praveen <g-praveen@ti.com>
To: <kexec@lists.infradead.org>
References: <4ccd4d81-2efd-4369-a759-552dbb9a007f@ti.com>
Content-Language: en-US
In-Reply-To: <4ccd4d81-2efd-4369-a759-552dbb9a007f@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250217_220641_461743_853EFE48 
X-CRM114-Status: GOOD (  12.48  )
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

Just a reminder.
It would be really great if you could help me with the following.

Regards
Gokul

On 05/02/25 17:50, Gokul Praveen wrote:
> Hi Team,
> 
> It would be really great,if you could help me with a couple of questions 
> regarding kexec and kdump.
> 
> I tried kdump on my SOC and it is rebooting fine . However,the VMCORE 
> file and /etc/kdump.conf file is not found.
> 
> VERSION:
> kexec-tools 2.0.30.
> kernel 6.12v
> 
> STEPS FOLLOWED:
> 
> 1)git clone git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> 
> 2)
>     HOST PC:
>      >cd $KEXEC_TOOLS_DIR
>      >./bootstrap LDFLAGS=-static ./configure --prefix=/usr/local 
> --host=aarch64-linux-gnu --target=aarch64-linux-gnu
>      >make
>      >cp $KEXEC_TOOLS_DIR/build/sbin/kexec /media/$USER/rootfs/usr/sbin 
> (To copy the kexec binary to the rootfs filesystem of the target board)
> 
>     TARGET BOARD:
>      >Booted upto linux
>      >cmdline="crashkernel=128M console=ttyS2,115200n8 
> root=/dev/mmcblk0p2 rw rootfste=ext4 rootwait" (/dev/mmcblk0p2 refers to 
> EMMC)
>      > /kexec -p /Image --command-line="$cmdline" 
> --dtb=/k3-j721e-common-proc-board.dtb
>      > echo c > /proc/sysrq-trigger
> 
> 
> LOGS:
> 
>           Starting Reboot and dump vmcore via kexec...
> [  OK  ] Listening on Docker Socket for the API.
> [  OK  ] Listening on Weston socket.
> [  OK  ] Started D-Bus System Message Bus.
> [  OK  ] Reached target Socket Units.
> [  OK  ] Reached target Basic System.
> [  OK  ] Started Job spooling tools.
>           Starting Avahi mDNS/DNS-SD Stack...
> [  OK  ] Started Periodic Command Scheduler.
>           Starting Print notice about GPLv3 packages...
>           Starting IPv6 Packet Filtering Framework...
>           Starting IPv4 Packet Filtering Framework...
> [  OK  ] Started irqbalance daemon.
>           Starting Telephony service...
>           Starting Expand the rootfs partiti…to full size of the boot 
> device....
> [    5.992254] audit: type=1334 audit(1728487094.820:10): prog-id=14 
> op=LOAD
> 
> [    6.003634] audit: type=1334 audit(1728487094.832:11): prog-id=15 
> op=LOAD
> [    6.010482] audit: type=1334 audit(1728487094.832:12): prog-id=16 
> op=LOAD
>           Starting User Login Management...
>           Starting Telnet Server...
> [  OK  ] Finished IPv6 Packet Filtering Framework.
> [  OK  ] Finished IPv4 Packet Filtering Framework.
> [  OK  ] Finished Telnet Server.
> [  OK  ] Started User Login Management.
> [  OK  ] Finished Expand the rootfs partition to full size of the boot 
> device..
> [  OK  ] Started Telephony service.
> [  OK  ] Started Avahi mDNS/DNS-SD Stack.
> [  OK  ] Created slice Slice /system/systemd-fsck.
>           Expecting device /dev/mmcblk0p1...
> [  OK  ] Reached target Preparation for Network.
>           Starting Load Kernel Module drm...
> [    6.406000] audit: type=1334 audit(1728487095.236:13): prog-id=17 
> op=LOAD
>           Starting Network Configuration...
>           Starting Virtual Console Setup...
> [  OK  ] Stopped target RPC Port Mapper.
> [  OK  ] Stopped target Timer Units.
> [  OK  ] Stopped Daily rotation of log files.
> [  OK  ] Stopped Daily Cleanup of Temporary Directories.
> [  OK  ] Stopped target System Time Set.
>           Stopping Job spooling tools...
>           Stopping Avahi mDNS/DNS-SD Stack...
>           Stopping Periodic Command Scheduler...
>           Stopping irqbalance daemon...
> [  OK  ] Stopped target Host and Network Name Lookups.
>           Stopping Telephony service...
> [  OK  ] Stopped Expand the rootfs partition to full size of the boot 
> device..
>           Stopping strongSwan IPsec IKEv1/IKEv2 daemon using ipsec.conf...
> [  OK  ] Removed slice Slice /system/getty.
> [  OK  ] Removed slice Slice /system/serial-getty.
>           Stopping User Login Management...
>           Stopping Load/Save OS Random Seed...
>           Starting Record Runlevel Change in UTMP...
>           Stopping Telnet Server...
> [  OK  ] Stopped target Remote File Systems.
> [  OK  ] Stopped Reboot and dump vmcore via kexec.

