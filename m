Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4BCD0D140
	for <kexec@archiver.kernel.org>; Wed,  7 Jan 2026 16:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:From:To:Date:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gSRhznMVNQ3g5FfOt0zXcZ9Os1ttCGfKgXLf9TOR39U=; b=wAOnj5dPeU1mtkFZS4829ov01s
	AcI7jd6YjUOUxaMkAJAoq3xNeAhcKJqxbffbBKOK9PH+iiCSO9JTd9o4jjQrssji19MD0WNv7Q+m1
	8UmePpc6dGNoliWbFGcHRcNRm2LqWBVfZ00pzKw/srUfc504di8EVXFpzn9hRukhRJXvkN0ElCXAQ
	gYQq12U6EIYdCpOT9RFYTScYIla2AJBdBFx/yfnOFc0vnEW5OhecrYfIw99meQOY5UAPa2HpGGb0C
	aaSKYePaP+V26pEetpSrKL+8ny+P1/yA81jN5bZcmWtVEPzY8RAdHf2b8ZrqXgTHXmE15PTaNqbm4
	TGXrnojA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdWd7-0000000FJtV-33DL;
	Wed, 07 Jan 2026 16:43:29 +0000
Received: from mail-43166.protonmail.ch ([185.70.43.166])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdWd4-0000000FJtD-2VZn
	for kexec@lists.infradead.org;
	Wed, 07 Jan 2026 16:43:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1767804199; x=1768063399;
	bh=gSRhznMVNQ3g5FfOt0zXcZ9Os1ttCGfKgXLf9TOR39U=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DFH8t2vfnIl8XtQAQBDUJBBhToU9Apc8rdDTifenuO015T3PNMY0slptGnHLcFiXV
	 AGDOKagp59BfjXkP0o+dcJxa6LVN/sO78u3SpnBRpvQVuAlVPfekY7IroDaTw9NNw7
	 zX32ESyXi3sPEIfdbBKmLC3YRfj+ASqBv7wd/YSrH5ChRy7ZsAcZEH8rprIjn46O3b
	 cDSIzK8bxAry9nh2Fx2BH8emJLs0SRlT75eYi2TJ/eQ5fCg72R6X79v5eG/sKwj+lb
	 oMw5Cn7mv3uhQz8PDhN+pVqgTMP1jEkSyaOX8hswfb6ToZwQN07QIFXXjvUAD3FzKO
	 YoOraipRPiqPA==
Date: Wed, 07 Jan 2026 16:43:14 +0000
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
From: Tj <tj.iam.tj@proton.me>
Subject: crash hp: kexec_trylock() failed, kdump image may be inaccurate
Message-ID: <M9wEb069tvcmJqpngM2EyYjyodw_HEmYt3KaW-XxRkVleH2qYeFvz16DLriKiOSRpLbPCVflvlCqhEFMZniF_Wb6YWL_gwhWAaPsHUYG2Bg=@proton.me>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: 1c27d120faf7a435cc74428251e1fc0571ff931d
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_084327_258285_ADC002C0 
X-CRM114-Status: UNSURE (   4.55  )
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

Currently debugging a KEXEC_JUMP preserve_context panic with amd iommu on k=
exec restart.

However, during shutdown, all but the bootstrap core (BSC) generate this me=
ssage. Is it something that {c,sh}ould be silenced if the BSC CPU holds the=
 lock (as I presume), or is it indicating a real problem because the elfhea=
der cannot be updated? My limited understanding would suggest this should b=
e ignored silently. From scanning the code it seems to suggest this is inte=
nded for sysfs directed CPU hotplug events.

[  141.722644] shutdown[1]: Rebooting with kexec.
[  141.781931] Freezing user space processes
[  141.787032] Freezing user space processes completed (elapsed 0.001 secon=
ds)
[  141.794028] OOM killer disabled.
[  141.802428] pn533_usb 5-4.4:1.0: NFC: NXP PN533 NFC device disconnected
[  142.726967] amdgpu 0000:0a:00.0: amdgpu: VCE busy: VCE_STATUS=3D0x100, S=
RBM_STATUS2=3D0x0
[  142.966113] amdgpu 0000:0a:00.0: amdgpu: PCI CONFIG reset
[  142.975667] Disabling non-boot CPUs ...
[  143.004683] smpboot: CPU 15 is now offline
[  143.008793] crash hp: kexec_trylock() failed, kdump image may be inaccur=
ate
[  143.052741] smpboot: CPU 14 is now offline
[  143.056894] crash hp: kexec_trylock() failed, kdump image may be inaccur=
ate
[  143.088716] smpboot: CPU 13 is now offline
[  143.092840] crash hp: kexec_trylock() failed, kdump image may be inaccur=
ate
[  143.132714] smpboot: CPU 12 is now offline
[  143.136857] crash hp: kexec_trylock() failed, kdump image may be inaccur=
ate
[  143.160668] smpboot: CPU 11 is now offline
[  143.164827] crash hp: kexec_trylock() failed, kdump image may be inaccur=
ate
[  143.184791] smpboot: CPU 10 is now offline
[  143.188924] crash hp: kexec_trylock() failed, kdump image may be inaccur=
ate
[  143.208671] smpboot: CPU 9 is now offline
[  143.212736] crash hp: kexec_trylock() failed, kdump image may be inaccur=
ate
[  143.236943] smpboot: CPU 8 is now offline
[  143.241005] crash hp: kexec_trylock() failed, kdump image may be inaccur=
ate
[  143.248682] Spectre V2 : Update user space SMT mitigation: STIBP off
[  143.280790] smpboot: CPU 7 is now offline
[  143.284839] crash hp: kexec_trylock() failed, kdump image may be inaccur=
ate
[  143.316796] smpboot: CPU 6 is now offline
[  143.320844] crash hp: kexec_trylock() failed, kdump image may be inaccur=
ate
[  143.352805] smpboot: CPU 5 is now offline
[  143.356853] crash hp: kexec_trylock() failed, kdump image may be inaccur=
ate
[  143.432608] smpboot: CPU 4 is now offline
[  143.436642] crash hp: kexec_trylock() failed, kdump image may be inaccur=
ate
[  143.468682] smpboot: CPU 3 is now offline
[  143.472720] crash hp: kexec_trylock() failed, kdump image may be inaccur=
ate
[  143.512698] smpboot: CPU 2 is now offline
[  143.516743] crash hp: kexec_trylock() failed, kdump image may be inaccur=
ate
[  143.536710] smpboot: CPU 1 is now offline
[  143.540794] crash hp: kexec_trylock() failed, kdump image may be inaccur=
ate
[  143.548516] Calling amd_iommu_syscore_data_set+0x0/0x40
[  143.553761] Checking wakeup interrupts
[  143.557519] Calling kvm_suspend+0x0/0x30 [kvm]
[  143.562023] Calling mce_syscore_suspend+0x0/0x30
[  143.566655] Calling ledtrig_cpu_syscore_suspend+0x0/0x20
[  143.571981] Calling timekeeping_syscore_suspend+0x0/0x10
[  143.577331] Calling irq_gc_suspend+0x0/0x80
[  143.581526] Calling ioapic_suspend+0x0/0x10
[  143.585853] Calling i8259A_suspend+0x0/0x30
[  143.590049] Calling perf_ibs_suspend+0x0/0x40
[  143.594423] Calling amd_iommu_suspend+0x0/0x20
[  143.598895] Calling fw_suspend+0x0/0x20
[  143.602743] Calling acpi_save_bm_rld+0x0/0x30
[  143.607118] Calling lapic_suspend+0x0/0x160
[    0.000000] Linux version 6.19.0-rc3+debian+tj (linux@iam.tj) (gcc (Debi=
an 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #364 SMP PREEM=
PT_DYNAMIC Wed Jan  7 12:46:49 UTC 2026
[    0.000000] Command line: root=3D/dev/mapper/SUNNY-rootfs ro debug syste=
md.log_level=3Dinfo drm.edid_firmware=3DDP-2:edid/UE50NU7400.edid fbcon=3Dr=
otate:3 modprobe.blacklist=3Dradeon amdgpu.si_support=3D1 console=3DttyS0,1=
15200 console=3Dtty0 no_console_suspend nosplash vt.handoff=3D7 pm_debug_me=
ssages=3D1 "dyndbg=3Dfile syscore.c +p" elfcorehdr=3D1032176K kexec_jump_ba=
ck_entry=3D0x00000001ff34012b

$ grep KEXEC /boot/config-$(uname -r)
CONFIG_KEXEC_CORE=3Dy
CONFIG_HAVE_IMA_KEXEC=3Dy
CONFIG_KEXEC=3Dy
CONFIG_KEXEC_FILE=3Dy
CONFIG_KEXEC_SIG=3Dy
# CONFIG_KEXEC_SIG_FORCE is not set
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=3Dy
CONFIG_KEXEC_JUMP=3Dy
CONFIG_KEXEC_HANDOVER=3Dy
# CONFIG_KEXEC_HANDOVER_DEBUG is not set
CONFIG_KEXEC_HANDOVER_DEBUGFS=3Dy
# CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_KEXEC=3Dy
CONFIG_ARCH_SUPPORTS_KEXEC_FILE=3Dy
CONFIG_ARCH_SELECTS_KEXEC_FILE=3Dy
CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY=3Dy
CONFIG_ARCH_SUPPORTS_KEXEC_SIG=3Dy
CONFIG_ARCH_SUPPORTS_KEXEC_SIG_FORCE=3Dy
CONFIG_ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG=3Dy
CONFIG_ARCH_SUPPORTS_KEXEC_JUMP=3Dy
CONFIG_ARCH_SUPPORTS_KEXEC_HANDOVER=3Dy
# CONFIG_IMA_KEXEC is not set
# CONFIG_TEST_KEXEC_HANDOVER is not set

Thanks for looking at this.

Tj.

