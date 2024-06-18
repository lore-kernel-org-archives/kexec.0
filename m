Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3521C27C4F
	for <kexec@archiver.kernel.org>; Tue, 18 Jun 2024 08:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QOhYcJvE3GoMZLBgIrm0X/kZ2umUnADV/eg6gOzQVOg=; b=J91RWlXIm+QgG5
	liVc9IrCK84cmIhZx8hpW8wvSCYl5ywv3HQBq0zBRSAYlYWmlhKtXieF1m6lseTy0CC3KqNR6MOUu
	ontH7oodwg4N0bwUF7FnRvyJbEuqTPm+Bh4zTl7ZVFGg8WrKs+hLl213SPQ8tyfi8Ssilq8hEqpxA
	yQzO+nxUu0/aRIlobTmNEtvLUKysjeu2lEIfKtmoS322m4zgj+1+BhM2CuA/o/TfLIdePaGJf6Thf
	gAb+Gtub9KpEYJTZ4gPDwSC72MJuvUQK+y8gbQrVVnhl7pC0XMkP2PiIMKA7+H2MMSWX35AdkkoTr
	J4Nel1bKWRzjPP/YaOmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJUYa-0000000E7QT-1j8e;
	Tue, 18 Jun 2024 08:51:12 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJUYV-0000000E7Q6-3QoU;
	Tue, 18 Jun 2024 08:51:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=QdrI/mSqbNiLhVorxxImeaiRXnl68m01N8TtlyJQOrQ=; b=Frz1XZXFcKvs0XOBNJOM4Onv3L
	2Vk3vrOCxqHgpVeS4HcRCmisAvk/kfdKDHVEu8Se6xyodZTGXQmvl0BRESkwzJS6rDZAEBCQWu5R2
	e2BD6pdcZ//8wRtmFtjEzS8UIdwBtEx6pL2i0u7JtLG/orCrwWmFeBS5Yp6z29gVMAJWGk+5/dGug
	4AzH7NgN6Y/8nGzknyLZxzNu70VOfxQ4dmH1qwy1LdJ/aEWXpRhoGy6WxH9nX//+XvoHs/iDiglUJ
	36QEDjAHuhRTZwtwlrBwdWTbUKSERTwIhZXJjb5Gi+11zBkQjxllJc/nN4F31zfD8UINul11DOKjn
	5m0AMm7g==;
Received: from mail-ed1-f41.google.com ([209.85.208.41])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJUWw-000000070rc-0cv4;
	Tue, 18 Jun 2024 08:51:04 +0000
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57c714a1e24so5796828a12.2;
        Tue, 18 Jun 2024 01:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718700565; x=1719305365;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QdrI/mSqbNiLhVorxxImeaiRXnl68m01N8TtlyJQOrQ=;
        b=pCnfqrAfTRCXpkmTGuMAQiqob6RWdyr6VLVtCx23PJBB0E9mZ6LXWXakanxsjNYcJr
         ul0HJKpcbk6oQ06H8gmfXdWpRePxrHqF3laA5xCAqGiZgCXRWxTuVaX4iowqMbdFScJT
         y3rcxv6hCA5Nhg3vqJkfiA6PikEM//H3MHN5UnFrKKaS/CcbHKVoqEbBFX7LDguBK9f/
         5CCFx0wMo8EC0XTIxinJ6IzSnQcT+pM7SedherqxpZcn6JfGgM6wn7SkzENiHgIQuM4Z
         uw4Y76ScKE6jsD2FdRG8yvbzUw05sFYnmiTyOEKOuqXX26qKd8kTzICsvRvm0S6Hn6oU
         i9Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVoyFs0Uc8X01dGXWF2nb2V/47Al1zhgNdz/4C6jrdk4y9vvAkQAhh8t6dnAkwxRvyaRgQ/sSaI5ma4i0q2h33UUkj/jKgiLzejMNyJjN32GYaZUNY=
X-Gm-Message-State: AOJu0YwDeLVOss0jrGoKTOAYOt1TVFgN3BxsdenXFFlSXFTkymP56aCz
	fdn87+eiboCOtgV+Jw6s4L/hbWaS/MY1xiFTHGLzNTyYGCl8kXAnQJ+kZw==
X-Google-Smtp-Source: AGHT+IG++9MCPvzJ8SKQ+/eSnQr7bxDmuXB6GaW3UOrxniq+Pcjxdm17dlOvVAhEsKZOU4HYZEvSGQ==
X-Received: by 2002:a50:aad0:0:b0:57d:40d:ffdd with SMTP id 4fb4d7f45d1cf-57d040e00a7mr10756a12.12.1718700564918;
        Tue, 18 Jun 2024 01:49:24 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb741e758sm7442069a12.68.2024.06.18.01.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:49:24 -0700 (PDT)
Date: Tue, 18 Jun 2024 01:49:22 -0700
From: Breno Leitao <leitao@debian.org>
To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org
Cc: will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
	rmikey@meta.com
Subject: arm64: Kexec: Warning: virt_to_phys used for non-linear address
Message-ID: <ZnFKEtqfqJkYflwL@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240618_094938_706307_8FC9EA86 
X-CRM114-Status: UNSURE (   7.21  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hello,

I am setting the following warning when loading a kdump kernel in
ACPI-based aarch64 box, running upstream and linux-next (stack below
against 5f703ce5c981).

  virt_to_phys used for non-linear address: 00000000cf9a4e41 (0xffffffffff5e0000)
  WARNING: CPU: 35 PID: 2279 at arch/arm64/mm/physaddr.c:15 __virt_to_phys (arch/arm64/mm/physaddr.c:17)
  Modules linked in: sunrpc(E) ipmi_ssif(E) nvidia_cspmu(E) arm_cspmu_module(E) arm_smmuv3_pmu(E) coresight_trbe(E) mlx5_ib(E) ib_uverbs(E) ipmi_devintf(E) ipmi_msghandler(E) coresight_stm(E) coresight_tmc(E) coresight_funnel(E) stm_core(E) coresight_etm4x(E) coresight(E) cppc_cpufreq(E) sch_fq_codel(E) drm(E) backlight(E) drm_panel_orientation_quirks(E) crct10dif_ce(E) sm3_ce(E) sm3(E) sha3_ce(E) sha512_ce(E) sha512_arm64(E) xhci_pci(E) xhci_hcd(E) spi_tegra210_quad(E) nbd(E) acpi_power_meter(E) loop(E) efivarfs(E) autofs4(E)
  Hardware name: Quanta Java Island EVT 29F0EMAZ046/Java Island, BIOS F0EJ3A01 06/03/2024
  pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
  pc : __virt_to_phys (arch/arm64/mm/physaddr.c:17)
  lr : __virt_to_phys (arch/arm64/mm/physaddr.c:17)
  sp : ffff8000be1cf9f0
  x29: ffff8000be1cf9f0 x28: dfff800000000000 x27: ffff800083ca9630
  x26: ffff800083ca9000 x25: 1ffff000107952c6 x24: ffff0000ff1b6800
  x23: 0000000000000000 x22: 0000000000001687 x21: ffff0001ecd46800
  x20: ffff000103524000 x19: ffffffffff5e0000 x18: ffffffffffffffff
  x17: ffff8000802d07d4 x16: 2930303030653566 x15: 0000000000000001
  x14: 1ffff00017c39ed8 x13: 0000000000000000 x12: 0000000000000000
  x11: ffff700017c39ed9 x10: 0000000000000002 x9 : e7a4565c7b34a200
  x8 : ffff800083c50000 x7 : 0000000000000001 x6 : 0000000000000001
  x5 : ffff8000be1cf6a0 x4 : ffff800084a5ff40 x3 : ffff800081580960
  x2 : 0000000000000001 x1 : ffff800083253340 x0 : 000000000000004f
  Call trace:
  __virt_to_phys (arch/arm64/mm/physaddr.c:17)
  of_kexec_alloc_and_setup_fdt (drivers/of/kexec.c:305)
  load_other_segments (arch/arm64/kernel/machine_kexec_file.c:162)
  image_load (arch/arm64/kernel/kexec_image.c:103)
  __arm64_sys_kexec_file_load (kernel/kexec_file.c:73 kernel/kexec_file.c:257 kernel/kexec_file.c:296 kernel/kexec_file.c:374 kernel/kexec_file.c:332 kernel/kexec_file.c:332)
  invoke_syscall (arch/arm64/kernel/syscall.c:? arch/arm64/kernel/syscall.c:48)
  el0_svc_common (./include/linux/thread_info.h:127 arch/arm64/kernel/syscall.c:141)
  do_el0_svc (arch/arm64/kernel/syscall.c:153)
  el0_svc (arch/arm64/kernel/entry-common.c:165 arch/arm64/kernel/entry-common.c:178 arch/arm64/kernel/entry-common.c:713)
  el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:781)
  el0t_64_sync (arch/arm64/kernel/entry.S:598)
  irq event stamp: 49964
  hardirqs last enabled at (49963): console_unlock (kernel/printk/printk.c:? kernel/printk/printk.c:2746 kernel/printk/printk.c:3065)
  hardirqs last disabled at (49964): el1_dbg (arch/arm64/kernel/entry-common.c:371 arch/arm64/kernel/entry-common.c:471)
  softirqs last enabled at (49942): handle_softirqs (./arch/arm64/include/asm/preempt.h:13 kernel/softirq.c:401 kernel/softirq.c:582)
  softirqs last disabled at (49937): __do_softirq (kernel/softirq.c:589)
  ---[ end trace 0000000000000000 ]---


This is happening on the following code:

        /* Remove memory reservation for the current device tree. */
        ret = fdt_find_and_del_mem_rsv(fdt, __pa(initial_boot_params),
                                       fdt_totalsize(initial_boot_params));


Where `initial_boot_params` contains a copy of the fdt allocated at init
time, and as I've analyzed, it is a virtual address and can be
translated by the MMU.

Since __pa() is a macro to __virt_to_phys():

	#define __pa(x)                 __virt_to_phys((unsigned long)(x))

I am curious why this address is special that makes __virt_to_phys()
unhappy.

Have you seen this before? Any tip on how to debug this further?

Thanks

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
