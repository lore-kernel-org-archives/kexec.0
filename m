Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AC9C87FDA
	for <kexec@archiver.kernel.org>; Fri,  8 Aug 2025 12:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SAHcgC2dCT7lVWSIBQiGXToCZB1mcTit8Lv2oRnEaqE=; b=sN+bY65mjpbMvb1t+W+ol1ZzTl
	s1UpUbwH+Qt+LKdPFbt5m+MjRySLYOG9ukoy0x048j3PDfbCwcxqhv79hD4UDacXCgzrE1YE0wCnp
	AQAfXVD5p6PaTgoyRCsXQ/KQq73ubBWwjQD3uG2oAW65TBpMQWuJxRwlTSAnQvHcf4pxuJF1B+OlL
	jmMyE+zoHWJN1JeoO+sa3XZIhmXWdeOgriNyoLgnhT7FeQm5wPuMou58AAIXNcwnIQvhkUo53ZHka
	3A//BYBhZv45tJTJz8c5qg/IzL3ldYKc5qBvNv/i+ggo/AFv+F0HqdacAoPBZmrmpcnWWR/5Vvbet
	zHV5YyRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukLwz-00000002lT6-3yTX;
	Fri, 08 Aug 2025 12:11:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukLH2-00000002fwJ-25jE
	for kexec@lists.infradead.org;
	Fri, 08 Aug 2025 11:28:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 986955C655A;
	Fri,  8 Aug 2025 11:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D52C4CEED;
	Fri,  8 Aug 2025 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754652514;
	bh=7bjZzLfO9fl1ghbHcTqWmndQHxP4RCvD8GzQZJjMcHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EM9N/akdd5EknCUIRfNSycnmf+GuuLwx9r1iowOgI1VM/jPQJJWuTe2M0lx0BCn62
	 7ZJZSQ8QPw4PqxA3E7U0+yIrHQZQeATd5AYlunMxnVVvZWTDPCfTicAT0WobVXjfdP
	 qAaqRL8W/f20T5FDrzmj4TI/NVMtel/Vur+PgekEOSgDoqkTqBWpz3mfJiTtWKT3kK
	 pRUnPPM6tBDkZBCEfnDCMrAeK5NqhPOWuxZQ+FkxBCvlkPB5K7ZFj5NdL//rfUHp3r
	 JQSeLsGt2mezuOoIzXIH5b/tSYvkvtRRvvukOVKBp96rhpHiU+4ZKlUa79r0A3m4lW
	 p+zYV/qcchcFQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Mike Rapoport <rppt@kernel.org>,  <oe-lkp@lists.linux.dev>,
  <lkp@intel.com>,  <linux-kernel@vger.kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Graf <graf@amazon.com>,  Changyuan
 Lyu <changyuanl@google.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Shuah Khan <shuah@kernel.org>,
  <kexec@lists.infradead.org>,  <linux-mm@kvack.org>
Subject: Re: [linus:master] [kho]  b753522bed:
 INFO:trying_to_register_non-static_key
In-Reply-To: <202508081032.1450e413-lkp@intel.com>
References: <202508081032.1450e413-lkp@intel.com>
Date: Fri, 08 Aug 2025 13:28:31 +0200
Message-ID: <mafs0sei2aw80.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_042836_619845_18E6B32A 
X-CRM114-Status: UNSURE (   7.88  )
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

On Fri, Aug 08 2025, kernel test robot wrote:

> Hello,
>
[...]
>
>
> [   59.011407][    T1] INFO: trying to register non-static key.
> [   59.011783][    T1] The code is fine but needs lockdep annotation, or maybe
> [   59.011783][    T1] you didn't initialize this object before use?
> [   59.011783][    T1] turning off the locking correctness validator.
> [   59.011783][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T   6.16.0-rc5-00079-gb753522bed0b #1 PREEMPT(voluntary)
> [   59.011783][    T1] Tainted: [T]=RANDSTRUCT
> [   59.011783][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   59.011783][    T1] Call Trace:

Pasha, I think your patch [0] fixes this. Perhaps it is a good idea for
it to land independent of the LUO patches, since those are likely to
take some more time?

[0] https://lore.kernel.org/lkml/20250807014442.3829950-2-pasha.tatashin@soleen.com/

> [   59.011783][    T1]  <TASK>
> [ 59.011783][ T1] dump_stack_lvl (lib/dump_stack.c:123) 
> [ 59.011783][ T1] assign_lock_key (kernel/locking/lockdep.c:988) 
> [ 59.011783][ T1] register_lock_class (kernel/locking/lockdep.c:?) 
> [ 59.011783][ T1] __lock_acquire (kernel/locking/lockdep.c:?) 
> [ 59.011783][ T1] lock_acquire (kernel/locking/lockdep.c:5871) 
> [ 59.011783][ T1] ? xa_load_or_alloc (include/linux/xarray.h:699 kernel/kexec_handover.c:106) 
> [ 59.011783][ T1] ? tracer_preempt_off (kernel/trace/trace_irqsoff.c:412) 
> [ 59.011783][ T1] _raw_spin_lock (include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:154) 
> [ 59.011783][ T1] ? xa_load_or_alloc (include/linux/xarray.h:699 kernel/kexec_handover.c:106) 
> [ 59.011783][ T1] xa_load_or_alloc (include/linux/xarray.h:699 kernel/kexec_handover.c:106) 
> [ 59.011783][ T1] __kho_preserve_order (kernel/kexec_handover.c:156) 
> [ 59.011783][ T1] kho_test_init (lib/test_kho.c:84) 
> [ 59.011783][ T1] ? __cfi_kho_test_init (lib/test_kho.c:271) 
> [ 59.011783][ T1] do_one_initcall (init/main.c:1274) 
> [ 59.011783][ T1] ? __cfi_kho_test_init (lib/test_kho.c:271) 
> [ 59.011783][ T1] ? kasan_save_track (arch/x86/include/asm/current.h:25 mm/kasan/common.c:60 mm/kasan/common.c:69) 
> [ 59.011783][ T1] ? kasan_save_track (mm/kasan/common.c:48 mm/kasan/common.c:68) 
> [ 59.011783][ T1] ? __kasan_kmalloc (mm/kasan/common.c:398) 
> [ 59.011783][ T1] ? tracer_hardirqs_off (kernel/trace/trace_irqsoff.c:412) 
> [ 59.011783][ T1] ? do_initcalls (include/linux/slab.h:909 include/linux/slab.h:1039 init/main.c:1345) 
> [ 59.011783][ T1] ? kernel_init_freeable (init/main.c:1588) 
> [ 59.011783][ T1] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:452) 
> [ 59.011783][ T1] ? tracer_hardirqs_off (kernel/trace/trace_irqsoff.c:412) 
> [ 59.011783][ T1] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:452) 
> [ 59.011783][ T1] ? irqentry_exit (kernel/entry/common.c:311) 
> [ 59.011783][ T1] ? next_arg (lib/cmdline.c:273) 
> [ 59.011783][ T1] ? parameq (kernel/params.c:91) 
> [ 59.011783][ T1] ? parse_args (kernel/params.c:?) 
> [ 59.011783][ T1] do_initcall_level (init/main.c:1335) 
> [ 59.011783][ T1] do_initcalls (init/main.c:1349) 
> [ 59.011783][ T1] kernel_init_freeable (init/main.c:1588) 
> [ 59.011783][ T1] ? __cfi_kernel_init (init/main.c:1466) 
> [ 59.011783][ T1] kernel_init (init/main.c:1476) 
> [ 59.011783][ T1] ? __cfi_kernel_init (init/main.c:1466) 
> [ 59.011783][ T1] ret_from_fork (arch/x86/kernel/process.c:154) 
> [ 59.011783][ T1] ? __cfi_kernel_init (init/main.c:1466) 
> [ 59.011783][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:255) 
> [   59.011783][    T1]  </TASK>

-- 
Regards,
Pratyush Yadav

