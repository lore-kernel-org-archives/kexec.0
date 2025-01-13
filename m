Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF04BC02180
	for <kexec@archiver.kernel.org>; Mon, 13 Jan 2025 21:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=80qZXOdgGrL8Jm5xXofGCRM3MB/t7+shD9tCNhzcYhk=; b=V/PVtTG7E6mD0aM20YCAt2SLig
	zHesCGt3YJ+ocl8HxmZIF69VFpH0iGN0l3i7vzP4rO1yFWX5lwxSQlTZn7PvmO0kQDfuiZkr1e/qW
	EMWrbDFjk2POoEvnKXkLaoydme6FJYE5R7d2PsB500PIzQ7Buy3GlysYE8kgxfm1X3iP/OC8EHdhh
	HTtzHquiOVrGoyU5Q4OFB/OQwEmTIW39iTs4TR+nUjlkLuajUSWsRU+/ryAV6DeMSIUXJwGjQKkEC
	j8gi99kNZmj/k7wD2rAh84TjgZGtosrGQZGTYHPsTozphIlMbHV3qxLIMQCNxB1JaXVrhIBt0JJtC
	2phz250Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXRzY-00000006gG8-0oQr;
	Mon, 13 Jan 2025 21:29:00 +0000
Received: from out-170.mta0.migadu.com ([91.218.175.170])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXRzU-00000006gDy-0tYR
	for kexec@lists.infradead.org;
	Mon, 13 Jan 2025 21:28:58 +0000
Date: Mon, 13 Jan 2025 22:28:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1736803728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=80qZXOdgGrL8Jm5xXofGCRM3MB/t7+shD9tCNhzcYhk=;
	b=seJLprL/jZaTwc1fvvIfVLh5hlr2Z5fesRsTuyObvOW7PFW3nVGsZ553+e8+xs2P2UuRhb
	qTyaBjFu5FQNYk6tEIIaEe8Wd5a73Ud01Z6PLU41tL33BflLbT7B6V6s2qXO9tVEc6tatF
	e79FZocYBybwXbOgzG2+ulemv+2dKotSbb2uQqyT8CqYpH5iqun0EORhOJb5YXX9Vjxq5A
	k8qwOPtm+PAmdWnGAv9oeYMvpm02AQZ+mxO68LbPbHLXDeiadUb87TYSSjHaBdwcZsbSXX
	N2CcCGxdcc5+m+FRJVzRqzsvqDlc/ghIqCXhrG/A5qz72k7GvMyweqcaLXgROw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com
Cc: kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	akpm@linux-foundation.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [REGRESSION] Kernel booted via kexec fails to resume from hibernation
Message-ID: <Z4WFjBVHpndct7br@desktop0a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_132856_967626_7E977BA5 
X-CRM114-Status: UNSURE (   6.41  )
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

After rebooting the system via kexec, hibernating and rebooting the machine, this oops occurs:

```
[   88.485216] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000940: 0000 [#1] PREEMPT SMP KASAN PTI
[   88.485233] KASAN: probably user-memory-access in range [0x0000000000004a00-0x0000000000004a07]
[   88.485240] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Kdump: loaded Not tainted 6.13.0-rc7_ricci #1
[   88.485245] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   88.485252] RIP: 0010:next_zone (mm/mmzone.c:20 mm/mmzone.c:37)
[ 88.485270] Code: 73 10 48 05 c0 06 00 00 48 83 c4 08 5b c3 cc cc cc cc 48 8d bb 00 4a 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 9d 00 00 00 8b 8b 00 4a 00 00
All code
========
   0:	73 10                	jae    0x12
   2:	48 05 c0 06 00 00    	add    $0x6c0,%rax
   8:	48 83 c4 08          	add    $0x8,%rsp
   c:	5b                   	pop    %rbx
   d:	c3                   	ret
   e:	cc                   	int3
   f:	cc                   	int3
  10:	cc                   	int3
  11:	cc                   	int3
  12:	48 8d bb 00 4a 00 00 	lea    0x4a00(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df 
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax		<-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 08                	je     0x3a
  32:	3c 03                	cmp    $0x3,%al
  34:	0f 8e 9d 00 00 00    	jle    0xd7
  3a:	8b 8b 00 4a 00 00    	mov    0x4a00(%rbx),%ecx

Code starting with the faulting instruction
===========================================
   0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4:	84 c0                	test   %al,%al
   6:	74 08                	je     0x10
   8:	3c 03                	cmp    $0x3,%al
   a:	0f 8e 9d 00 00 00    	jle    0xad
  10:	8b 8b 00 4a 00 00    	mov    0x4a00(%rbx),%ecx
[   88.485275] RSP: 0018:ffffffffa4807ce8 EFLAGS: 00010002
[   88.485279] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff11027fff565
[   88.485281] RDX: 0000000000000940 RSI: ffffffffa3a89b80 RDI: 0000000000004a00
[   88.485283] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffed10234c82c8
[   88.485285] R10: ffff88811a641647 R11: ffff88811a635e30 R12: 0000000000000000
[   88.485287] R13: 1ffffffff4839048 R14: 0000000000000000 R15: 000000000000003d
[   88.485290] FS:  0000000000000000(0000) GS:ffff88811a600000(0000) knlGS:0000000000000000
[   88.485292] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   88.485294] CR2: 000055e8c586c300 CR3: 0000000106eb0000 CR4: 00000000000006f0
[   88.485299] Call Trace:
[   88.485301]  <TASK>
[   88.485306] ? die_addr (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:460)
[   88.485313] ? exc_general_protection (arch/x86/kernel/traps.c:751 arch/x86/kernel/traps.c:693)
[   88.485319] ? asm_exc_general_protection (./arch/x86/include/asm/idtentry.h:617)
[   88.485324] ? next_zone (mm/mmzone.c:20 mm/mmzone.c:37)
[   88.485336] ? calc_load_nohz_start (kernel/sched/loadavg.c:251 (discriminator 2))
[   88.485341] need_update (mm/vmstat.c:2032 (discriminator 2))
[   88.485366] quiet_vmstat (mm/vmstat.c:2065 (discriminator 2))
[   88.485369] tick_nohz_stop_tick (./include/linux/hrtimer.h:135 kernel/time/tick-sched.c:1044)
[   88.485373] ? __pfx_tick_nohz_stop_tick (kernel/time/tick-sched.c:970)
[   88.485376] ? tick_nohz_next_event (kernel/time/tick-sched.c:952 (discriminator 2))
[   88.485379] ? __pfx_tsc_verify_tsc_adjust (arch/x86/kernel/tsc_sync.c:51)
[   88.485396] tick_nohz_idle_stop_tick (kernel/time/tick-sched.c:1229)
[   88.485399] do_idle (kernel/sched/idle.c:185 kernel/sched/idle.c:325)
[   88.485403] ? __pfx_do_idle (kernel/sched/idle.c:253)
[   88.485406] cpu_startup_entry (kernel/sched/idle.c:422)
[   88.485409] rest_init (init/main.c:720)
[   88.485413] ? acpi_subsystem_init (drivers/acpi/bus.c:1314)
[   88.485417] start_kernel (init/main.c:1000)
[   88.485422] x86_64_start_reservations (arch/x86/kernel/head64.c:495)
[   88.485426] x86_64_start_kernel (??:?)
[   88.485432] common_startup_64 (arch/x86/kernel/head_64.S:415)
[   88.485437]  </TASK>
[   88.485439] Modules linked in: cfg80211 8021q garp stp mrp llc ppdev evdev input_leds intel_agp e1000 mac_hid intel_gtt pcspkr i2c_piix4 agpgart i2c_smbus parport_pc parport tiny_power_button button rfkill vhost_vsock vmw_vsock_virtio_transport_common vsock vhost_net vhost vhost_iotlb tap vfio_iommu_type1 vfio iommufd uhid hid dm_mod uinput userio ppp_generic slhc tun loop cuse fuse ext4 crc32c_generic crc16 mbcache jbd2 bochs drm_client_lib drm_shmem_helper sd_mod drm_kms_helper ata_generic pata_acpi ata_piix libata drm scsi_mod serio_raw scsi_common qemu_fw_cfg
```

I can reproduce this with kernel 6.13-rc7 in a qemu x86_64 virtual machine
running Void Linux, with the following commands:

```
# kexec -l /boot/vmlinuz-6.13.0-rc7 --initrd=/boot/initramfs-6.13.0-rc7 --reuse-cmdline
# reboot
# printf reboot >/sys/power/disk
# printf disk >/sys/power/state
```

If kexec is not used, hibernation works fine.

This started happening since the 6.8 series; 6.7 works fine.
I performed a bisection and it pointed to
18d565ea95fe ("kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()").

#regzbot introduced: 18d565ea95fe553f442c5bbc5050415bab3c3fa4

I will send the kernel config and dmesg in replies to this email.

