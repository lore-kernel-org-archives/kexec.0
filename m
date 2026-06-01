Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05915CD6E69
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 15:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iQyez31M9+cqRzG0mNDzNeBP+DcO+f5iCUnGf0mcB+I=; b=tQys1+HmSLBbyasHPPvYiLYcXM
	rVneiP8P9heHHj0YO/f+tllpdVKAUYLet7J1C/181+YkShOES1+KDzJWzZDBS8imO5JjJGJ2e2pEg
	aZS9LptHjML7xID2hieWyjs/xs7XX13uByo5he4bPzgYEvlAtIEDvnzsHGqBOc2497lWLPwrhPLCd
	rE7/Le7JwbmBqV/TeTcCcl5Ojh6VAe9dtVAqi3niXXrGEhtGL3r3gs9lXgm0moE6mOsKTwTgAFwlV
	aysqytIpO5TqnM3IF+OEBSnF3/I9I/OaXSaCmzS8QPqpOeoDtcu3BA90avsDDJ5vwl+tK3hrt6uzw
	IjaZHGWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQr6-0000000DI25-3qy8;
	Tue, 02 Jun 2026 15:16:36 +0000
Received: from out-188.mta1.migadu.com ([95.215.58.188])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU2sz-0000000BDjR-45sd
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 13:40:59 +0000
Date: Mon, 1 Jun 2026 21:40:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780321243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQyez31M9+cqRzG0mNDzNeBP+DcO+f5iCUnGf0mcB+I=;
	b=l024WfFK8H8TZslgd1la8pP0IMsoUoHk+D958dcQtK1139z2FcW6CgT8NHAq1ryBrn3ISC
	V49yjHdscTNNkULL8sndRFN7LTiUJk2zYEHRJL798tKylrp/xi8IhXqWxmbEYljH9QzlNC
	GwALMjU5E7e0JSkUMqYW/poOjE9natY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, robh@kernel.org, saravanak@kernel.org,
	akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, rdunlap@infradead.org,
	feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com,
	kees@kernel.org, elver@google.com, kuba@kernel.org,
	lirongqing@baidu.com, ebiggers@kernel.org, paulmck@kernel.org,
	sourabhjain@linux.ibm.com, thuth@redhat.com, ardb@kernel.org,
	masahiroy@kernel.org, gshan@redhat.com, james.morse@arm.com,
	maz@kernel.org, leitao@debian.org, yeoreum.yun@arm.com,
	coxu@redhat.com, suzuki.poulose@arm.com, cfsworks@gmail.com,
	osandov@fb.com, jbohac@suse.cz, ryan.roberts@arm.com,
	tangyouling@kylinos.cn, ritesh.list@gmail.com,
	adityag@linux.ibm.com, hbathini@linux.ibm.com, bjorn@rivosinc.com,
	songshuaishuai@tinylab.org, vishal.moola@gmail.com,
	junhui.liu@pigmoral.tech, djordje.todorovic@htecgroup.com,
	austin.kim@lge.com, namcao@linutronix.de, djbw@kernel.org,
	chao.gao@intel.com, seanjc@google.com, fuqiang.wang@easystack.cn,
	liaoyuanhong@vivo.com, makb@juniper.net, graf@amazon.com,
	piliu@redhat.com, rafael.j.wysocki@intel.com,
	mario.limonciello@amd.com, jbouron@amazon.com,
	chenjiahao16@huawei.com, guoren@kernel.org, bauerman@linux.ibm.com,
	bgwin@google.com, takahiro.akashi@linaro.org, x86@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v15 00/23] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-ID: <ah2Lx7KHI60tzd0v@MiWiFi-R3L-srv>
References: <20260601094805.2928614-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601094805.2928614-1-ruanjinjie@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_064058_158216_062646FA 
X-CRM114-Status: GOOD (  26.87  )
X-Mailman-Approved-At: Tue, 02 Jun 2026 08:16:35 -0700
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

Hi Jinjie,

On 06/01/26 at 05:47pm, Jinjie Ruan wrote:
...snip... 
> Changes in v15:
> - Unify the subject prefix formats as Huacai suggested.
> - Fix powerpc pre-existing NULL pointer dereference [Sashiko [1]]
> - Fix powerpc pre-existing __merge_memory_ranges() memory range
>   truncation [Sashiko [1]].
> - Fix pre-existing arm64 CMA page leaks [Sashiko[2]].
> - Fix pre-existing crash_load_dm_crypt_keys() Use-After-Free and
>   Double Free issue [Sashiko[3]].
> - Fix vfree(headers) and uninitialized variables issue
>   and simplify the fix [Sashiko[2]].
> - As walk_system_ram_res() and for_each_mem_range() use different
>   lock, unify and simplify the fix of TOCTOU buffer overflow via memory
>   region padding [Sashiko[4]].
> - Fix the arm64 crash dump issues in Sashiko[5].
> - Link to v14: https://lore.kernel.org/all/20260525084932.934910-1-ruanjinjie@huawei.com/

Do these Fixes have anything with the main target of this patch series
you mentioned in cover-letter:"arm64/riscv: Add support for crashkernel CMA"?
The patches become more and more in each new version, I am wondering if
it relies on these Fixes patches to implement your adding support for
crashkernel CMA on arm64/risc-v.

If not relying on them, could you split them into different patchset
on different purpose? 

Thanks
Baoquan

> 
> [1]: https://lore.kernel.org/all/20260525092207.96B9D1F000E9@smtp.kernel.org/
> [2]: https://lore.kernel.org/all/20260525091149.1A1E01F00A3D@smtp.kernel.org/
> [3]: https://lore.kernel.org/all/20260525105227.3C2421F000E9@smtp.kernel.org/
> [4]: https://lore.kernel.org/all/20260525095447.944E11F000E9@smtp.kernel.org/
> [5]: https://lore.kernel.org/all/20260525101746.9959D1F000E9@smtp.kernel.org/
> 
> Changes in v14:
> - Fix image->elf_headers memory leak during retry loop for arm64 as Sashiko
>   AI code review pointed out.
> - Solve the hotplug notifier arch_crash_handle_hotplug_event() AA
>   self-deadlock problem as Sashiko AI code review pointed out.
> - Fix the TOCTOU issue in prepare_elf_headers() by get_online_mems().
> - -ENOMEM -> -EAGAIN as Breno suggested.
> - Add support for arm64 crash hotplug.
> - Link to v13: https://lore.kernel.org/all/20260511030454.1730881-1-ruanjinjie@huawei.com/
> 
> Changes in v13:
> - Rebased on v7.1-rc1.
> - Update the commit message.
> - Add Reviewed-by.
> - Link to v12: https://lore.kernel.org/all/20260402072701.628293-1-ruanjinjie@huawei.com/
> 
> Changes in v12:
> - Remove the unused "nr_mem_ranges" for x86.
> - Add "Fix crashk_low_res not exclude bug" test log.
> - Provide a separate patch for each architecture for using
>   crash_prepare_headers(), which will make the review more convenient.
> - Add Reviewed-by and Tested-by.
> - Link to v11: https://lore.kernel.org/all/20260328074013.3589544-1-ruanjinjie@huawei.com/
> 
> Changes in v11:
> - Avoid silently drop crash memory if the crash kernel is built without
>   CONFIG_CMA.
> - Remove unnecessary "cmem->nr_ranges = 0" for arch_crash_populate_cmem()
>   as we use kvzalloc().
> - Provide a separate patch for each architecture to fix the existing
>   buffer overflow issue.
> - Add Acked-bys for arm64.
> 
> Changes in v10:
> - Fix crashk_low_res not excluded bug in the existing
>   RISC-V code.
> - Fix an existing memory leak issue in the existing PowerPC code.
> - Fix the ordering issue of adding CMA ranges to
>   "linux,usable-memory-range".
> - Fix an existing concurrency issue. A Concurrent memory hotplug may occur
>   between reading memblock and attempting to fill cmem during kexec_load()
>   for almost all existing architectures.
> - Link to v9: https://lore.kernel.org/all/20260323072745.2481719-1-ruanjinjie@huawei.com/
> 
> Changes in v9:
> - Collect Reviewed-by and Acked-by, and prepare for Sashiko AI review.
> - Link to v8: https://lore.kernel.org/all/20260302035315.3892241-1-ruanjinjie@huawei.com/
> 
> Changes in v8:
> - Fix the build issues reported by kernel test robot and Sourabh.
> - Link to v7: https://lore.kernel.org/all/20260226130437.1867658-1-ruanjinjie@huawei.com/
> 
> Changes in v7:
> - Correct the inclusion of CMA-reserved ranges for kdump kernel in of/kexec
>   for arm64 and riscv.
> - Add Acked-by.
> - Link to v6: https://lore.kernel.org/all/20260224085342.387996-1-ruanjinjie@huawei.com/
> 
> Changes in v6:
> - Update the crash core exclude code as Mike suggested.
> - Rebased on v7.0-rc1.
> - Add acked-by.
> - Link to v5: https://lore.kernel.org/all/20260212101001.343158-1-ruanjinjie@huawei.com/
> 
> Jinjie Ruan (22):
>   riscv: kexec_file: Fix crashk_low_res not exclude bug
>   powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
>   powerpc/kexec_file: Fix NULL pointer dereference in
>     kexec_extra_fdt_size_ppc64()
>   powerpc/kexec_file: Fix memory range truncation in
>     __merge_memory_ranges()
>   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
>   arm64: kexec_file: Fix CMA page leaks during segment placement retry
>     loops
>   arm64: kexec_file: Fix image->elf_headers memory leak during retry
>     loop
>   kexec: Fix UAF and Double Free in crash_load_dm_crypt_keys()
>   crash_core: Introduce CRASH_HOTPLUG_SAFETY_PADDING for memory hotplug
>     safety
>   x86: kexec_file: Fix TOCTOU buffer overflow via memory region padding
>   arm64: kexec_file: Fix TOCTOU buffer overflow via memory region
>     padding
>   riscv: kexec_file: Fix TOCTOU buffer overflow via memory region
>     padding
>   LoongArch: kexec_file: Fix TOCTOU buffer overflow via memory region
>     padding
>   crash: Add crash_prepare_headers() to exclude crash kernel memory
>   arm64: kexec_file: Use crash_prepare_headers() helper to simplify code
>   x86: kexec_file: Use crash_prepare_headers() helper to simplify code
>   riscv: kexec_file: Use crash_prepare_headers() helper to simplify code
>   LoongArch: kexec_file: Use crash_prepare_headers() helper to simplify
>     code
>   powerpc/kexec_file: Use crash_exclude_core_ranges() helper
>   arm64: kexec_file: Add support for crashkernel CMA reservation
>   riscv: kexec_file: Add support for crashkernel CMA reservation
>   arm64: crash: Add crash hotplug support
> 
> Sourabh Jain (1):
>   powerpc/crash: sort crash memory ranges before preparing elfcorehdr
> 
>  .../admin-guide/kernel-parameters.txt         |  16 +-
>  arch/arm64/Kconfig                            |   3 +
>  arch/arm64/include/asm/kexec.h                |  13 ++
>  arch/arm64/kernel/Makefile                    |   2 +-
>  arch/arm64/kernel/crash.c                     | 152 ++++++++++++++++++
>  arch/arm64/kernel/kexec_image.c               |  34 ++++
>  arch/arm64/kernel/machine_kexec_file.c        |  78 ++-------
>  arch/arm64/mm/init.c                          |   5 +-
>  arch/loongarch/kernel/machine_kexec_file.c    |  44 ++---
>  arch/powerpc/include/asm/kexec_ranges.h       |   1 -
>  arch/powerpc/kexec/crash.c                    |   7 +-
>  arch/powerpc/kexec/file_load_64.c             |   3 +
>  arch/powerpc/kexec/ranges.c                   | 113 ++-----------
>  arch/riscv/kernel/machine_kexec_file.c        |  43 ++---
>  arch/riscv/mm/init.c                          |   5 +-
>  arch/x86/kernel/crash.c                       |  92 ++---------
>  drivers/of/fdt.c                              |   9 +-
>  drivers/of/kexec.c                            |   9 ++
>  include/linux/crash_core.h                    |  15 ++
>  include/linux/crash_reserve.h                 |   4 +-
>  include/linux/kexec.h                         |   2 +
>  kernel/crash_core.c                           |  89 +++++++++-
>  kernel/crash_dump_dm_crypt.c                  |   4 +-
>  kernel/kexec_core.c                           |  25 +--
>  24 files changed, 430 insertions(+), 338 deletions(-)
>  create mode 100644 arch/arm64/kernel/crash.c
> 
> -- 
> 2.34.1
> 

