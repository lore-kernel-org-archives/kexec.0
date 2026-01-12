Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A66CD25030
	for <kexec@archiver.kernel.org>; Mon, 12 Jan 2026 05:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AYGWeOErk4lb/6CF+ZsyYFNx81ZOt42GW1Bo+s/85tE=; b=dW1XHuvOmI2HHXoXbSUegSOTsz
	jDJjYRLtJEV1G5RJWH/Vwrbml2o4BCx7K2NOuiQjfc2ViBsqC0yqX3371OyfYem4MGNHqvwBi/p6s
	lEqyyGrprW0tFc+o/F8xFmXs3rCRChC8nySS+NO9uPuUyWwjCfFIOTvjlgpvWD2nEVxYceXsYWu44
	KAKQzKVQSVixB1AJFEOAipf6SRZArrqZKZ1KaR5OC4PgMcACIyK6b3GUFFoL8dH2qQjRzZatyTGBC
	bMApFWyJVay1BRHcDONSxtV9NsfuoE3kSiBi9W2mLao3mWItRwyomaCxILa6vK39VtjuUmMn7Pb5M
	MwA3M+iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfAtD-00000004ngI-34AR;
	Mon, 12 Jan 2026 05:54:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfAt7-00000004nfl-1Xac
	for kexec@lists.infradead.org;
	Mon, 12 Jan 2026 05:54:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768197286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AYGWeOErk4lb/6CF+ZsyYFNx81ZOt42GW1Bo+s/85tE=;
	b=EZO2Kc7FdgtX+xgXDZSwmKXY+NSf6+mcgfAtYdRvDc+bzAxNFIYT9HOyCq5mGQlkU2u5AG
	M5tGbLczLEVogA8eCnWkEm+37uPA5wO5pRU59/1iZIryGBPR6zEsdCH6jfsKqmSy9xyHZc
	3F/U+Pu/8g+rClJ7z2Yyg0F1FtgcVkc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-sYZn12oUPriccI1cGEom4w-1; Mon,
 12 Jan 2026 00:54:44 -0500
X-MC-Unique: sYZn12oUPriccI1cGEom4w-1
X-Mimecast-MFC-AGG-ID: sYZn12oUPriccI1cGEom4w_1768197283
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC1AF18005AE;
	Mon, 12 Jan 2026 05:54:42 +0000 (UTC)
Received: from localhost (unknown [10.72.112.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94F9730001A2;
	Mon, 12 Jan 2026 05:54:39 +0000 (UTC)
Date: Mon, 12 Jan 2026 13:54:35 +0800
From: Baoquan He <bhe@redhat.com>
To: Tj <tj.iam.tj@proton.me>, dwmw2@infradead.org
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: crash hp: kexec_trylock() failed, kdump image may be inaccurate
Message-ID: <aWSMm/E1BNTMZ//a@fedora>
References: <M9wEb069tvcmJqpngM2EyYjyodw_HEmYt3KaW-XxRkVleH2qYeFvz16DLriKiOSRpLbPCVflvlCqhEFMZniF_Wb6YWL_gwhWAaPsHUYG2Bg=@proton.me>
MIME-Version: 1.0
In-Reply-To: <M9wEb069tvcmJqpngM2EyYjyodw_HEmYt3KaW-XxRkVleH2qYeFvz16DLriKiOSRpLbPCVflvlCqhEFMZniF_Wb6YWL_gwhWAaPsHUYG2Bg=@proton.me>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QMdA4g9dpO5kTdoXZLEWRA50uhLTGgA7uXwbAYXevlQ_1768197283
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260111_215449_485834_79568A69 
X-CRM114-Status: GOOD (  14.01  )
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

On 01/07/26 at 04:43pm, Tj wrote:
> Currently debugging a KEXEC_JUMP preserve_context panic with amd iommu on kexec restart.

CC David to see if he knows this.

> 
> However, during shutdown, all but the bootstrap core (BSC) generate this message. Is it something that {c,sh}ould be silenced if the BSC CPU holds the lock (as I presume), or is it indicating a real problem because the elfheader cannot be updated? My limited understanding would suggest this should be ignored silently. From scanning the code it seems to suggest this is intended for sysfs directed CPU hotplug events.
> 
> [  141.722644] shutdown[1]: Rebooting with kexec.
> [  141.781931] Freezing user space processes
> [  141.787032] Freezing user space processes completed (elapsed 0.001 seconds)
> [  141.794028] OOM killer disabled.
> [  141.802428] pn533_usb 5-4.4:1.0: NFC: NXP PN533 NFC device disconnected
> [  142.726967] amdgpu 0000:0a:00.0: amdgpu: VCE busy: VCE_STATUS=0x100, SRBM_STATUS2=0x0
> [  142.966113] amdgpu 0000:0a:00.0: amdgpu: PCI CONFIG reset
> [  142.975667] Disabling non-boot CPUs ...
> [  143.004683] smpboot: CPU 15 is now offline
> [  143.008793] crash hp: kexec_trylock() failed, kdump image may be inaccurate
> [  143.052741] smpboot: CPU 14 is now offline
> [  143.056894] crash hp: kexec_trylock() failed, kdump image may be inaccurate
> [  143.088716] smpboot: CPU 13 is now offline
> [  143.092840] crash hp: kexec_trylock() failed, kdump image may be inaccurate
> [  143.132714] smpboot: CPU 12 is now offline
> [  143.136857] crash hp: kexec_trylock() failed, kdump image may be inaccurate
> [  143.160668] smpboot: CPU 11 is now offline
> [  143.164827] crash hp: kexec_trylock() failed, kdump image may be inaccurate
> [  143.184791] smpboot: CPU 10 is now offline
> [  143.188924] crash hp: kexec_trylock() failed, kdump image may be inaccurate
> [  143.208671] smpboot: CPU 9 is now offline
> [  143.212736] crash hp: kexec_trylock() failed, kdump image may be inaccurate
> [  143.236943] smpboot: CPU 8 is now offline
> [  143.241005] crash hp: kexec_trylock() failed, kdump image may be inaccurate
> [  143.248682] Spectre V2 : Update user space SMT mitigation: STIBP off
> [  143.280790] smpboot: CPU 7 is now offline
> [  143.284839] crash hp: kexec_trylock() failed, kdump image may be inaccurate
> [  143.316796] smpboot: CPU 6 is now offline
> [  143.320844] crash hp: kexec_trylock() failed, kdump image may be inaccurate
> [  143.352805] smpboot: CPU 5 is now offline
> [  143.356853] crash hp: kexec_trylock() failed, kdump image may be inaccurate
> [  143.432608] smpboot: CPU 4 is now offline
> [  143.436642] crash hp: kexec_trylock() failed, kdump image may be inaccurate
> [  143.468682] smpboot: CPU 3 is now offline
> [  143.472720] crash hp: kexec_trylock() failed, kdump image may be inaccurate
> [  143.512698] smpboot: CPU 2 is now offline
> [  143.516743] crash hp: kexec_trylock() failed, kdump image may be inaccurate
> [  143.536710] smpboot: CPU 1 is now offline
> [  143.540794] crash hp: kexec_trylock() failed, kdump image may be inaccurate
> [  143.548516] Calling amd_iommu_syscore_data_set+0x0/0x40
> [  143.553761] Checking wakeup interrupts
> [  143.557519] Calling kvm_suspend+0x0/0x30 [kvm]
> [  143.562023] Calling mce_syscore_suspend+0x0/0x30
> [  143.566655] Calling ledtrig_cpu_syscore_suspend+0x0/0x20
> [  143.571981] Calling timekeeping_syscore_suspend+0x0/0x10
> [  143.577331] Calling irq_gc_suspend+0x0/0x80
> [  143.581526] Calling ioapic_suspend+0x0/0x10
> [  143.585853] Calling i8259A_suspend+0x0/0x30
> [  143.590049] Calling perf_ibs_suspend+0x0/0x40
> [  143.594423] Calling amd_iommu_suspend+0x0/0x20
> [  143.598895] Calling fw_suspend+0x0/0x20
> [  143.602743] Calling acpi_save_bm_rld+0x0/0x30
> [  143.607118] Calling lapic_suspend+0x0/0x160
> [    0.000000] Linux version 6.19.0-rc3+debian+tj (linux@iam.tj) (gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #364 SMP PREEMPT_DYNAMIC Wed Jan  7 12:46:49 UTC 2026
> [    0.000000] Command line: root=/dev/mapper/SUNNY-rootfs ro debug systemd.log_level=info drm.edid_firmware=DP-2:edid/UE50NU7400.edid fbcon=rotate:3 modprobe.blacklist=radeon amdgpu.si_support=1 console=ttyS0,115200 console=tty0 no_console_suspend nosplash vt.handoff=7 pm_debug_messages=1 "dyndbg=file syscore.c +p" elfcorehdr=1032176K kexec_jump_back_entry=0x00000001ff34012b
> 
> $ grep KEXEC /boot/config-$(uname -r)
> CONFIG_KEXEC_CORE=y
> CONFIG_HAVE_IMA_KEXEC=y
> CONFIG_KEXEC=y
> CONFIG_KEXEC_FILE=y
> CONFIG_KEXEC_SIG=y
> # CONFIG_KEXEC_SIG_FORCE is not set
> CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
> CONFIG_KEXEC_JUMP=y
> CONFIG_KEXEC_HANDOVER=y
> # CONFIG_KEXEC_HANDOVER_DEBUG is not set
> CONFIG_KEXEC_HANDOVER_DEBUGFS=y
> # CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT is not set
> CONFIG_ARCH_SUPPORTS_KEXEC=y
> CONFIG_ARCH_SUPPORTS_KEXEC_FILE=y
> CONFIG_ARCH_SELECTS_KEXEC_FILE=y
> CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY=y
> CONFIG_ARCH_SUPPORTS_KEXEC_SIG=y
> CONFIG_ARCH_SUPPORTS_KEXEC_SIG_FORCE=y
> CONFIG_ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG=y
> CONFIG_ARCH_SUPPORTS_KEXEC_JUMP=y
> CONFIG_ARCH_SUPPORTS_KEXEC_HANDOVER=y
> # CONFIG_IMA_KEXEC is not set
> # CONFIG_TEST_KEXEC_HANDOVER is not set
> 
> Thanks for looking at this.
> 
> Tj.
> 


