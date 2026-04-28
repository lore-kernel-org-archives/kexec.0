Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80738CD13D3
	for <kexec@archiver.kernel.org>; Thu, 30 Apr 2026 20:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=53v80o50pdZvZamiU87690P2YfIvRYFux+/+SYSB+8A=; b=aPh6X79D8ZZAoSISIENzg8jC5y
	pv4MDd0u4krnGO28fZww6h2nhXp0rHIb1QA/h1UcMXOvkuRR42nVgUvAEiyxcVtsyPO1MbzRS9SaQ
	bdUptuU3LqnEpjOxAAdkDGXPATio8p2dv4cXre6UPtpitItUIxvX0mXZ6crNOaa1Of1hofBNuyAgt
	cZikapBx6oGUuhpO8DgUZ1VUuR+7xbF5t/guSZq7mf84k4g5lbMMt+xS+lKE91+LqFUqYUvp3tCGU
	K2FPU1AeE2KflEww7BbuVlVwfE7rRaP04IGaJ8C1mjCXtHmF6bgLyYt46EuPu8VLea2VQFnZEkOqN
	GlOjqvYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIY68-00000005vJ4-0Yvy;
	Thu, 30 Apr 2026 20:35:00 +0000
Received: from canpmsgout08.his.huawei.com ([113.46.200.223])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHZ9c-00000000V89-43pF;
	Tue, 28 Apr 2026 03:30:35 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=53v80o50pdZvZamiU87690P2YfIvRYFux+/+SYSB+8A=;
	b=Ax7zlBnDvsHBrG11SUZ1Pks+cdQ09GMnJHUeJDFPnJ+emSKulfDm5/phFAybcSONUZOz7Zmdk
	JuXPr9JubkLETkbEhoVW7TASFkDw2eI7slX9Rgg90k2o6zU9Md1T0fRV5pJf4I+L2IYefJy2p2S
	PTql3k7K5Kbuffhny79gszs=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4g4Qks3tnTzmV7c;
	Tue, 28 Apr 2026 11:23:49 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 25E5F40562;
	Tue, 28 Apr 2026 11:30:17 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Apr 2026 11:30:14 +0800
Message-ID: <dfa24c4b-a423-4c80-9a8f-28c577c9ec11@huawei.com>
Date: Tue, 28 Apr 2026 11:30:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/15] arm64/riscv: Add support for crashkernel CMA
 reservation
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <rdunlap@infradead.org>, <peterz@infradead.org>,
	<pawan.kumar.gupta@linux.intel.com>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <rppt@kernel.org>,
	<leitao@debian.org>, <ardb@kernel.org>, <jbohac@suse.cz>,
	<cfsworks@gmail.com>, <tangyouling@kylinos.cn>, <sourabhjain@linux.ibm.com>,
	<ritesh.list@gmail.com>, <hbathini@linux.ibm.com>, <eajames@linux.ibm.com>,
	<guoren@kernel.org>, <songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <coxu@redhat.com>,
	<fuqiang.wang@easystack.cn>, <liaoyuanhong@vivo.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <lizhengyu3@huawei.com>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
References: <20260402072701.628293-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260402072701.628293-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_203033_670531_081680D7 
X-CRM114-Status: GOOD (  19.91  )
X-Mailman-Approved-At: Thu, 30 Apr 2026 13:34:59 -0700
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



On 4/2/2026 3:26 PM, Jinjie Ruan wrote:
> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> This patch set handle them in crash core in a general way, which eliminate
> a lot of duplication code.
> 
> And add support for crashkernel CMA reservation for arm64 and riscv.
> 
> Rebased on v7.0-rc1.
> 
> Basic second kernel boot test were performed on QEMU platforms for x86,
> ARM64, and RISC-V architectures with the following parameters:
> 
> 	"cma=256M crashkernel=256M crashkernel=64M,cma"
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
> Jinjie Ruan (14):
>   riscv: kexec_file: Fix crashk_low_res not exclude bug
>   powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
>   x86/kexec: Fix potential buffer overflow in prepare_elf_headers()
>   arm64: kexec_file: Fix potential buffer overflow in
>     prepare_elf_headers()
>   riscv: kexec_file: Fix potential buffer overflow in
>     prepare_elf_headers()
>   LoongArch: kexec: Fix potential buffer overflow in
>     prepare_elf_headers()
>   crash: Add crash_prepare_headers() to exclude crash kernel memory
>   arm64: kexec_file: Use crash_prepare_headers() helper to simplify code
>   x86/kexec: Use crash_prepare_headers() helper to simplify code
>   riscv: kexec_file: Use crash_prepare_headers() helper to simplify code
>   LoongArch: kexec: Use crash_prepare_headers() helper to simplify code
>   crash: Use crash_exclude_core_ranges() on powerpc
>   arm64: kexec: Add support for crashkernel CMA reservation
>   riscv: kexec: Add support for crashkernel CMA reservation

Hi, every one,

It seems the patches for crash core rework, powerpc, riscv, and arm64
are mostly ready to be merged. Could any maintainer help pick these up,
or should I rebase the entire series against v7.1-rc1?

> 
> Sourabh Jain (1):
>   powerpc/crash: sort crash memory ranges before preparing elfcorehdr
> 
>  .../admin-guide/kernel-parameters.txt         |  16 +--
>  arch/arm64/kernel/machine_kexec_file.c        |  43 +++-----
>  arch/arm64/mm/init.c                          |   5 +-
>  arch/loongarch/kernel/machine_kexec_file.c    |  43 +++-----
>  arch/powerpc/include/asm/kexec_ranges.h       |   1 -
>  arch/powerpc/kexec/crash.c                    |   7 +-
>  arch/powerpc/kexec/ranges.c                   | 101 +-----------------
>  arch/riscv/kernel/machine_kexec_file.c        |  42 +++-----
>  arch/riscv/mm/init.c                          |   5 +-
>  arch/x86/kernel/crash.c                       |  92 +++-------------
>  drivers/of/fdt.c                              |   9 +-
>  drivers/of/kexec.c                            |   9 ++
>  include/linux/crash_core.h                    |   9 ++
>  include/linux/crash_reserve.h                 |   4 +-
>  kernel/crash_core.c                           |  89 ++++++++++++++-
>  15 files changed, 193 insertions(+), 282 deletions(-)
> 


