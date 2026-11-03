Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A3606A33A
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jpxAc59y;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ZZLh0PUQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Tn8JJ6e2rb+ujxI+sTGHT+OqEATEBHO8rrC9BgLrjPE=; b=jpxAc59yZRBC+j
	M9DojQyRUPxaRzzX8QmNi70P5qubbU/2xKuo9ldvyOtK50ka9FtFVHpSEvcPqpp78R0yKv/9Pl4bx
	jTOGsbfaaNNI0+uTkBOLgUdtVhaOTHxcaqMZYWde27PfBTjtUhS/+63hGaarkdekw566KUCxB1fwc
	rqkoeVrh00CRJTB9yqF5yI/72neuga3dvlHT5E6IVjVI9gCnE/1ICuOR1nE/zqPqN753/xpAPEnm2
	gaTQUMY1ga6+KFCoHLo35+UWEpS5zyZlNCcU9NLprkNnS4b5SLuDkHb6a4aAN18nzuLF6xFNNKMDR
	jlqcAwOa7uzPiU5rW/sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOAbR-00000001iKn-19wF;
	Tue, 03 Nov 2026 09:14:49 +0000
Received: from canpmsgout01.his.huawei.com ([113.46.200.216])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOAbM-00000001iIE-10Q3;
	Tue, 03 Nov 2026 09:14:47 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Tn8JJ6e2rb+ujxI+sTGHT+OqEATEBHO8rrC9BgLrjPE=;
	b=ZZLh0PUQ1ZZiNnfLu8uV6kw465/92VoTefC9sc818KZ47gSrCoOLE4H+gQBVYp/oXtMCHQGBE
	/xxU76TnM8sqb8j6X269lFFu/zBlJdYIDfc09Pt9kMeIGaLVXeVOU+Fj5wlRPONrYU2LJAaTcTe
	QH3ZbbAuATkrqCZCdRFZpKs=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jJjZ432W9z1T4LL;
	Tue,  3 Nov 2026 17:14:20 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id A470540537;
	Tue,  3 Nov 2026 17:14:38 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 3 Nov
 2026 17:14:36 +0800
Message-ID: <6ed88169-f663-4b72-a8f7-f75f2c7dc080@huawei.com>
Date: Tue, 3 Nov 2026 17:14:35 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/15] kexec: Fix CMA and elf header leaks and rework
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <thuth@redhat.com>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <robh@kernel.org>, <sourabhjain@linux.ibm.com>,
	<kees@kernel.org>, <coiby.xu@gmail.com>, <Yeking@Red54.com>,
	<tangyouling@kylinos.cn>, <maqianga@uniontech.com>,
	<zhangtianyang@loongson.cn>, <guodongtai@kylinos.cn>, <blum@kernel.org>,
	<adityag@linux.ibm.com>, <hui.wang@canonical.com>, <sohammetha01@gmail.com>,
	<guoren@kernel.org>, <gaohan@iscas.ac.cn>, <kai.huang@intel.com>,
	<kas@kernel.org>, <vishal.l.verma@intel.com>, <piliu@redhat.com>,
	<jbouron@amazon.com>, <mclapinski@google.com>, <me@linux.beauty>,
	<graf@amazon.com>, <bgwin@google.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20261026075201.699550-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_011445_452150_F394BAC9 
X-CRM114-Status: GOOD (  14.89  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/10/26 15:51, Jinjie Ruan 写道:
> ARM64, LoongArch and RISC-V load the elf core header, initrd, DTB
> and cmdline parameters with almost identical code. This series fixes
> the bugs in that path. And as Mike suggested, rework the common part
> into a helper.
> 
> Patch 1 stops using the Image text_offset for arm64, which breaks CMA
> segments in both the load and release paths, and rejects images with
> a non-zero value.
> 
> Patches 2-7 fix the CMA page and elf core header leaks in the retry
> loops in arm64 and LoongArch, also fix a modified_cmdline leak
> in LoongArch.
> 
> Patches 8-10 pass the kbuf fields to crash_prepare_headers() to
> simplfy code.
> 
> Patch 11 frees the elf core header from the generic post-load cleanup.
> 
> Patches 12-15 add kexec_load_other_segments() and convert the three
> architectures, and arch_kexec_setup_other_segments() builds
> the architecture specific boot parameters (a DTB or a command line).


Hi, everyone,

Any thoughts or suggestions?

> 
> Tested with kexec_file_load() and kdump on arm64, RISC-V and LoongArch
> under QEMU, including the non-zero text_offset rejection.
> 
> This series is also available at:
>         https://github.com/ruanjinjie-eng/linux/tree/kexec_cleanup_v7
> 
> Changes in v7:
> - Rework the kexec_file load code to avoid code duplication
>   as Mike suggested.
> - Add Acked-by.
> - Drop the two non-zero text_offset fix patches
>   and deprecate .text_offset in arm64 as Mike suggested.
> - Drop the x86-32 fix patch.
> - Drop the TOCTOU race fix patches.
> - Link to v6: https://lore.kernel.org/all/20260921090450.807575-1-ruanjinjie@huawei.com/
> 
> Previous Versions are as below:
> - v5: https://lore.kernel.org/all/20260918100442.3841135-1-ruanjinjie@huawei.com/
> - v4: https://lore.kernel.org/all/20260907125404.922123-1-ruanjinjie@huawei.com/
> - v3: https://lore.kernel.org/all/20260826092541.3905933-1-ruanjinjie@huawei.com/
> - v2: https://lore.kernel.org/all/20260729031235.2840255-1-ruanjinjie@huawei.com/
> - v1: https://lore.kernel.org/all/20260723131242.1537633-1-ruanjinjie@huawei.com/#t
> 
> Jinjie Ruan (15):
>   arm64: kexec_file: Stop using the Image text_offset
>   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
>   arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
>   arm64: kexec_file: Fix elf_headers memory leak in retry loop
>   LoongArch: kexec_file: Fix CMA page leaks in segment placement retry
>     loops
>   LoongArch: kexec_file: Fix elf_headers memory leak in retry loop
>   LoongArch: kexec_file: Fix a modified_cmdline leak
>   arm64: kexec_file: Simplify load_other_segments()
>   LoongArch: kexec_file: Simplify load_other_segments()
>   riscv: kexec_file: Simplify load_extra_segments()
>   kexec: Free the elf core header in kimage_file_post_load_cleanup()
>   kexec: Add kexec_load_other_segments() helper
>   arm64: kexec_file: Use kexec_load_other_segments() to simplify code
>   LoongArch: kexec_file: Use kexec_load_other_segments() to simplify
>     code
>   riscv: kexec_file: Use kexec_load_other_segments() to simplify code
> 
>  arch/arm64/include/asm/kexec.h             |   5 -
>  arch/arm64/kernel/kexec_image.c            |  33 +++++--
>  arch/arm64/kernel/machine_kexec_file.c     | 103 ++++-----------------
>  arch/loongarch/include/asm/kexec.h         |   4 -
>  arch/loongarch/kernel/kexec_efi.c          |  20 +++-
>  arch/loongarch/kernel/kexec_elf.c          |  11 ++-
>  arch/loongarch/kernel/machine_kexec.c      |   2 +
>  arch/loongarch/kernel/machine_kexec_file.c |  96 +++----------------
>  arch/powerpc/kexec/file_load_64.c          |   4 -
>  arch/riscv/include/asm/kexec.h             |   4 -
>  arch/riscv/kernel/kexec_elf.c              |  11 ++-
>  arch/riscv/kernel/kexec_image.c            |  11 ++-
>  arch/riscv/kernel/machine_kexec_file.c     |  79 ++++------------
>  arch/x86/kernel/machine_kexec_64.c         |   4 -
>  include/linux/kexec.h                      |  17 ++++
>  kernel/kexec_core.c                        |  25 ++---
>  kernel/kexec_file.c                        |  99 ++++++++++++++++++++
>  17 files changed, 248 insertions(+), 280 deletions(-)
> 

-- 
Best regards,
Jinjie


