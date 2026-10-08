Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA20DCA6007
	for <kexec@archiver.kernel.org>; Thu,  8 Oct 2026 01:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bXamncWaqlfk8qQgL1B8Mu0pQVkhOxTSHqjddGG4KBw=; b=MX4IaagQCxKtHEQw54xuXl50cf
	DTHNd0hhrEqdx/m6QYzSmR3C1xraFCdBmP+paSfpOLisQ1po0J/Tft5HbthMEN70M3Anmh0keXQYe
	IdEMI2RUY2smU61BvcUqTiJuR4gSYFxBoLNRDI2WRPf8AFSZL9QHPm5xNkyk2491zdyVUNW1/ZN4S
	LgGKEO7a6mNjkcY3ElwibnOkNdmCDfn2lWdDrf0cOI7+WBm/WRXG1yDlzWNffSz4Wmu5qi+YUqwnD
	hSA1l57omhSMUG0eLzYAuLrJ2vnlu7LEWsvAIH5TwrmB/J/c6BnTl+RYA5SE6BQus88cjArS50oDl
	/ULENLKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEdOh-00000003NaY-2DTz;
	Thu, 08 Oct 2026 01:58:15 +0000
Received: from [113.46.200.225] (helo=canpmsgout10.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEdOa-00000003NZP-1Pcm;
	Thu, 08 Oct 2026 01:58:10 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bXamncWaqlfk8qQgL1B8Mu0pQVkhOxTSHqjddGG4KBw=;
	b=g78aXu5F+eX1vFGrdr7ODw3mfWRzJ2xHcdspBUNlAxc5IhvP2m+84BEowtEnJ7toedzRiDPqJ
	c5RrHPIU8ToMw1OQpK0Wh1ee8RrekPA+Bcg43S7Q5Mtdi8Sp9wD1KAgm7iJsyXAjU3PESGUAKbY
	aQDiKZOBs1rzK16wrPIzn0k=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4j0Xr464hkz1K97G;
	Thu,  8 Oct 2026 09:45:24 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AC8D4055B;
	Thu,  8 Oct 2026 09:57:39 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 8 Oct
 2026 09:57:32 +0800
Message-ID: <f4ba3a6b-537d-4328-b0c1-c0e5aa61924f@huawei.com>
Date: Thu, 8 Oct 2026 09:57:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] crash: Fix several bugs
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<kees@kernel.org>, <tangyouling@kylinos.cn>, <liukexin@kylinos.cn>,
	<zhangtianyang@loongson.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <chao.gao@intel.com>, <kai.huang@intel.com>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<thuth@redhat.com>, <jbouron@amazon.com>, <me@linux.beauty>,
	<mclapinski@google.com>, <graf@amazon.com>, <bgwin@google.com>,
	<hbathini@linux.ibm.com>, <eric.devolder@oracle.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <palmer@rivosinc.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <driver-core@lists.linux.dev>,
	<kexec@lists.infradead.org>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260921090450.807575-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.68]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261007_185808_689488_BB69DE1D 
X-CRM114-Status: GOOD (  22.54  )
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



在 2026/9/21 17:04, Jinjie Ruan 写道:
> As Baoquan and Catalin suggested, this patch set fixes
> several pre-existing code issues found by Sashiko AI [1][2][3].
> 
> The major improvements and fixes included in this series are:
> - Fix several memory leaks for arm64, and similar issues on LoongArch.
> - Fix out-of-bounds write on 32-bit Highmem for x86.
> - Fix TOCTOU race in crash memory range collection.

Hi all,

Gentle ping.

Could anyone take a look or let me know if there's anything
else needed? I can rebase/resend if required.

> 
> This patch set is rebased on v7.3-rc3. Compared to the previous version,
> split out arm64 crash hotplug patches as Breno suggested, which are based
> on these bugfix patches and will be resubmitted after this patch series
> is merged.
> 
> Slightly tested on x86_64 and arm64 qemu with:
> - kexec_load (--kexec-syscall --hotplug)
> - kexec_load (--kexec-file-syscall)
> 
> All boot successfully into the second kernel.
> 
> [1]: https://lore.kernel.org/all/20260601094805.2928614-1-ruanjinjie@huawei.com/
> [2]: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%40huawei.com
> [3]: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%40huawei.com
> 
> Changes in v6:
> - Split out arm64 crash hotplug patches as Breno suggested.
> - Remove unused elfcorehdr_updated [4].
> - Make the patch split more clear.
> - Link to v5: https://lore.kernel.org/all/20260918100442.3841135-1-ruanjinjie@huawei.com/
> 
> [4]: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%40huawei.com
> 
> Changs in v5:
> - Rebased on v7.3-rc3.
> - Fix several pre-existing code issues reported by Sashiko AI review. [3]
> - Add an extra slot for memory hot-unplug.
> - Add device_hotplug_lock_assert_held() helper.
> - Rework to let the hotplug paths to skip CPU events entirely, which avoid
>   the TOCTOU race of memory hotplug events and internal CPU offline path
>   without holding device_hotplug_lock.
> - Link to v4: https://lore.kernel.org/all/20260907125404.922123-1-ruanjinjie@huawei.com/
> 
> Changes in v4:
> - Rebased on v7.3-rc1.
> - Update the kexec_core code as Mike suggested.
> - Update the LoongArch subject as Huacai suggested.
> - Drop crash_dump_dm_crypt patch which will be fixed by Coiby in [4] as
>   Sourabh suggested.
> - Drop x86 related patches because of branch conflict, which will
>   be done later.
> - Drop the incorrect CRASH_MAX_MEMORY_RANGES patch.
> - Handle elfcorehdr_index in arm64 arch code.
> - Link to v3: https://lore.kernel.org/all/20260826092541.3905933-1-ruanjinjie@huawei.com/
> 
> [4] https://lore.kernel.org/all/20260828084900.1496839-2-coiby.xu@gmail.com/
> 
> Changes in v3:
> - Handle "KEXEC_CRASH_HP_REMOVE_MEMORY" action.
> - Fix several pre-existing code issues reported by Sashiko AI review [3].
> - Introduce crash_extra_elfcorehdr_size() and elf64_phdr_size() helper.
> - Rework related crash and arch code.
> - Add test method.
> - v2: https://lore.kernel.org/all/20260729031235.2840255-1-ruanjinjie@huawei.com/
> 
> Changes in v2:
> - Split out Powerpc bugfix patch as Mike suggested.
> - Use phys_to_virt() instead of __va() in update_crash_elfcorehdr().
> - Convert pnum_hdr_sz() to a function.
> - Only assign elfcorehdr_index after kexec_add_buffer succeeds, considering
>   crash_handle_hotplug_event() already performs validity check on
>   elfcorehdr_index:
>   - We can safely remove the check for CPU hotplug
>     in arch_crash_handle_hotplug_event().
>   - The elfcorehdr_index's segment mem will be valid in
>     update_crash_elfcorehdr(), so we can safely remove the NULL check.
> - Simplify the commit message.
> - v1: https://lore.kernel.org/all/20260723131242.1537633-1-ruanjinjie@huawei.com/#t
> 
> Jinjie Ruan (14):
>   kexec: Fix CMA segment address translation with non-zero text_offset
>   kexec: Record allocated CMA pages to fix release size mismatch
>   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
>   arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
>   arm64: kexec_file: Fix elf_headers memory leak in retry loop
>   LoongArch: kexec_file: Fix CMA page leaks in segment placement retry
>     loops
>   LoongArch: kexec_file: Fix elf_headers memory leak in retry loop
>   LoongArch: kexec_file: Fix a modified_cmdline leak
>   x86/crash: Fix massive out-of-bounds write on 32-bit Highmem
>   crash: Extract crash_get_memory_ranges() helper
>   crash: Factor out crash_find_elfcorehdr() helper
>   crash: Normalize the kexec_load elfcorehdr at load time
>   driver core: Add device_hotplug_lock_assert_held() helper
>   crash: Fix TOCTOU race in crash memory range collection
> 
>  arch/arm64/kernel/kexec_image.c            |   1 +
>  arch/arm64/kernel/machine_kexec_file.c     |   9 +-
>  arch/loongarch/kernel/kexec_efi.c          |   1 +
>  arch/loongarch/kernel/machine_kexec.c      |   2 +
>  arch/loongarch/kernel/machine_kexec_file.c |  10 +-
>  arch/powerpc/kexec/crash.c                 |   1 +
>  arch/x86/kernel/crash.c                    |  40 +++++---
>  drivers/base/core.c                        |   5 +
>  include/linux/crash_core.h                 |   2 +
>  include/linux/device.h                     |   1 +
>  include/linux/kexec.h                      |   4 +-
>  kernel/crash_core.c                        | 114 +++++++++++++++++----
>  kernel/kexec.c                             |   4 +
>  kernel/kexec_core.c                        |  43 +++++---
>  kernel/kexec_file.c                        |  13 ++-
>  15 files changed, 192 insertions(+), 58 deletions(-)
> 

-- 
Best regards,
Jinjie


