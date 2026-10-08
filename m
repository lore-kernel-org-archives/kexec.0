Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE826CA6007
	for <kexec@archiver.kernel.org>; Thu,  8 Oct 2026 03:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=utCPSZvpjilWfg61MLNxidAF6z77XObpS8R/pvNjMCg=; b=i0Pc6JdWOaZNZYJ7jmUZwrTRPZ
	80k3FSh33ktca+PRguAHbWsR8dFRDXfcOQCpUrn+djezSyPuC2XVMzL6BFmx1/bv0FsWi5qJrQIbp
	/DIJWM8fgs3KyBbkofmSGKGfr125/ZgHporo6k8/2S9siQyKCgHAUbGB4u87JJIOynRu34K7aJNU4
	s3U0nURTt1zD9xFKKqXuUqxZCOUrSeDbqUUt+nz2BAgUji4gLBPzAjDDpxIt2VdYOJPFUuIKoDjuj
	IlTp3W43wqB0tMQBwlqi7AOqbomNf78ap9kpIzwb27kiKpIksgA0CRYx4reAsqdQw5DIybbblNK05
	Ya1mjSSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEemg-00000003RdD-3LvY;
	Thu, 08 Oct 2026 03:27:06 +0000
Received: from out-174.mta0.migadu.com ([2001:41d0:1004:224b::ae] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEema-00000003RcQ-2U1o
	for kexec@lists.infradead.org;
	Thu, 08 Oct 2026 03:27:04 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=gmfp3ivCG1+n0TaJLGaQX1ngoAFvegNr6FLCt8R7HoA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791430015; v=1; x=1792034815;
 b=sfRg+Kjg/eBrMvxARWsZKSW0GqYsZHeSrusj2Kk0BrTlDsimt1UC7y3YMMtdaI3474NOvFRO
 zox+uJaSfyW1h13gOJ/+ndSgpu4aevbBKF5gbiLKAY/zvUNbeWPCK+GGgOw9uX9k3hoe7SlTPSD
 v8Op7U01mzcGdG27M+cii8kI=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta12.migadu.com with ESMTPS id 94fa78c7ea5d33cd;
	Thu, 08 Oct 2026 03:26:54 +0000
X-Mizu-Trace-ID: 94fa78c7ea5d33cd
X-Migadu-Flow: FLOW_OUT
Date: Thu, 8 Oct 2026 11:26:46 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	ritesh.list@gmail.com, sshegde@linux.ibm.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, leitao@debian.org, yeoreum.yun@arm.com,
	sourabhjain@linux.ibm.com, robh@kernel.org, coxu@redhat.com,
	kees@kernel.org, tangyouling@kylinos.cn, liukexin@kylinos.cn,
	zhangtianyang@loongson.cn, guodongtai@kylinos.cn,
	maqianga@uniontech.com, chao.gao@intel.com, kai.huang@intel.com,
	vishal.l.verma@intel.com, seanjc@google.com, piliu@redhat.com,
	thuth@redhat.com, jbouron@amazon.com, me@linux.beauty,
	mclapinski@google.com, graf@amazon.com, bgwin@google.com,
	hbathini@linux.ibm.com, eric.devolder@oracle.com,
	takahiro.akashi@linaro.org, james.morse@arm.com,
	palmer@rivosinc.com, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	driver-core@lists.linux.dev, kexec@lists.infradead.org
Subject: Re: [PATCH v6 00/14] crash: Fix several bugs
Message-ID: <ascNduTeakZBflVS@fedora>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <f4ba3a6b-537d-4328-b0c1-c0e5aa61924f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4ba3a6b-537d-4328-b0c1-c0e5aa61924f@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261007_202702_372579_28D5DF1B 
X-CRM114-Status: GOOD (  30.62  )
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

On 10/08/26 at 09:57am, Jinjie Ruan wrote:
> 
> 
> 在 2026/9/21 17:04, Jinjie Ruan 写道:
> > As Baoquan and Catalin suggested, this patch set fixes
> > several pre-existing code issues found by Sashiko AI [1][2][3].
> > 
> > The major improvements and fixes included in this series are:
> > - Fix several memory leaks for arm64, and similar issues on LoongArch.
> > - Fix out-of-bounds write on 32-bit Highmem for x86.
> > - Fix TOCTOU race in crash memory range collection.
> 
> Hi all,
> 
> Gentle ping.
> 
> Could anyone take a look or let me know if there's anything
> else needed? I can rebase/resend if required.

They may need reviewing and ack from different arch. E.g patch 1,
even though it's changed in kernel/kexec_core.c, the arm64 specific
handling need be checked and confirmed by arm64 expert.

I can review changes in generic code and arch I am familiar with, while
those part I am unfamiliar with need be reviewed by experts of specific
area.

> 
> > 
> > This patch set is rebased on v7.3-rc3. Compared to the previous version,
> > split out arm64 crash hotplug patches as Breno suggested, which are based
> > on these bugfix patches and will be resubmitted after this patch series
> > is merged.
> > 
> > Slightly tested on x86_64 and arm64 qemu with:
> > - kexec_load (--kexec-syscall --hotplug)
> > - kexec_load (--kexec-file-syscall)
> > 
> > All boot successfully into the second kernel.
> > 
> > [1]: https://lore.kernel.org/all/20260601094805.2928614-1-ruanjinjie@huawei.com/
> > [2]: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%40huawei.com
> > [3]: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%40huawei.com
> > 
> > Changes in v6:
> > - Split out arm64 crash hotplug patches as Breno suggested.
> > - Remove unused elfcorehdr_updated [4].
> > - Make the patch split more clear.
> > - Link to v5: https://lore.kernel.org/all/20260918100442.3841135-1-ruanjinjie@huawei.com/
> > 
> > [4]: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%40huawei.com
> > 
> > Changs in v5:
> > - Rebased on v7.3-rc3.
> > - Fix several pre-existing code issues reported by Sashiko AI review. [3]
> > - Add an extra slot for memory hot-unplug.
> > - Add device_hotplug_lock_assert_held() helper.
> > - Rework to let the hotplug paths to skip CPU events entirely, which avoid
> >   the TOCTOU race of memory hotplug events and internal CPU offline path
> >   without holding device_hotplug_lock.
> > - Link to v4: https://lore.kernel.org/all/20260907125404.922123-1-ruanjinjie@huawei.com/
> > 
> > Changes in v4:
> > - Rebased on v7.3-rc1.
> > - Update the kexec_core code as Mike suggested.
> > - Update the LoongArch subject as Huacai suggested.
> > - Drop crash_dump_dm_crypt patch which will be fixed by Coiby in [4] as
> >   Sourabh suggested.
> > - Drop x86 related patches because of branch conflict, which will
> >   be done later.
> > - Drop the incorrect CRASH_MAX_MEMORY_RANGES patch.
> > - Handle elfcorehdr_index in arm64 arch code.
> > - Link to v3: https://lore.kernel.org/all/20260826092541.3905933-1-ruanjinjie@huawei.com/
> > 
> > [4] https://lore.kernel.org/all/20260828084900.1496839-2-coiby.xu@gmail.com/
> > 
> > Changes in v3:
> > - Handle "KEXEC_CRASH_HP_REMOVE_MEMORY" action.
> > - Fix several pre-existing code issues reported by Sashiko AI review [3].
> > - Introduce crash_extra_elfcorehdr_size() and elf64_phdr_size() helper.
> > - Rework related crash and arch code.
> > - Add test method.
> > - v2: https://lore.kernel.org/all/20260729031235.2840255-1-ruanjinjie@huawei.com/
> > 
> > Changes in v2:
> > - Split out Powerpc bugfix patch as Mike suggested.
> > - Use phys_to_virt() instead of __va() in update_crash_elfcorehdr().
> > - Convert pnum_hdr_sz() to a function.
> > - Only assign elfcorehdr_index after kexec_add_buffer succeeds, considering
> >   crash_handle_hotplug_event() already performs validity check on
> >   elfcorehdr_index:
> >   - We can safely remove the check for CPU hotplug
> >     in arch_crash_handle_hotplug_event().
> >   - The elfcorehdr_index's segment mem will be valid in
> >     update_crash_elfcorehdr(), so we can safely remove the NULL check.
> > - Simplify the commit message.
> > - v1: https://lore.kernel.org/all/20260723131242.1537633-1-ruanjinjie@huawei.com/#t
> > 
> > Jinjie Ruan (14):
> >   kexec: Fix CMA segment address translation with non-zero text_offset
> >   kexec: Record allocated CMA pages to fix release size mismatch
> >   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
> >   arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
> >   arm64: kexec_file: Fix elf_headers memory leak in retry loop
> >   LoongArch: kexec_file: Fix CMA page leaks in segment placement retry
> >     loops
> >   LoongArch: kexec_file: Fix elf_headers memory leak in retry loop
> >   LoongArch: kexec_file: Fix a modified_cmdline leak
> >   x86/crash: Fix massive out-of-bounds write on 32-bit Highmem
> >   crash: Extract crash_get_memory_ranges() helper
> >   crash: Factor out crash_find_elfcorehdr() helper
> >   crash: Normalize the kexec_load elfcorehdr at load time
> >   driver core: Add device_hotplug_lock_assert_held() helper
> >   crash: Fix TOCTOU race in crash memory range collection
> > 
> >  arch/arm64/kernel/kexec_image.c            |   1 +
> >  arch/arm64/kernel/machine_kexec_file.c     |   9 +-
> >  arch/loongarch/kernel/kexec_efi.c          |   1 +
> >  arch/loongarch/kernel/machine_kexec.c      |   2 +
> >  arch/loongarch/kernel/machine_kexec_file.c |  10 +-
> >  arch/powerpc/kexec/crash.c                 |   1 +
> >  arch/x86/kernel/crash.c                    |  40 +++++---
> >  drivers/base/core.c                        |   5 +
> >  include/linux/crash_core.h                 |   2 +
> >  include/linux/device.h                     |   1 +
> >  include/linux/kexec.h                      |   4 +-
> >  kernel/crash_core.c                        | 114 +++++++++++++++++----
> >  kernel/kexec.c                             |   4 +
> >  kernel/kexec_core.c                        |  43 +++++---
> >  kernel/kexec_file.c                        |  13 ++-
> >  15 files changed, 192 insertions(+), 58 deletions(-)
> > 
> 
> -- 
> Best regards,
> Jinjie
> 

