Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CA0C5B56A
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 13:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PyT7L9VvlAwN00Tq2hdXOPPcmRRnmrYvQNotKzwnFa0=; b=2HiYRK1wkeviqNIRSwJCEqgyL6
	biTK8u4GLsANUxwptZfxkI85DUR9sEcxxzGRbs1rptw9kKoAaLDmnTBzP9279aajya16fs61pjp/O
	/PEa3oVijvSlOg8FMPtAkXYXyMYFRoyk009CYktLJmWS/LivhYkYZ2qvs+0WPax4nlqL3b5xRw1Wg
	RkxrISm8E6PpS5oWQQH9AgxNXsycGCxJ7Vh4MoTZbi8/IxmRidkxOdMjyFqTxG1b1pLa2MkOKuTW6
	TC31Wu4e+LKbeLDuaAAHafcANOphSK23pXjEDA2t7vR4zsaxhOc6ZSHxnKi2ZtiQJxklJJzWVaVrH
	zjuCF8gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtmB1-0000000E48K-497O;
	Tue, 11 Aug 2026 13:05:55 +0000
Received: from canpmsgout03.his.huawei.com ([113.46.200.218])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtmAz-0000000E47l-2WyF;
	Tue, 11 Aug 2026 13:05:55 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PyT7L9VvlAwN00Tq2hdXOPPcmRRnmrYvQNotKzwnFa0=;
	b=068x4Nd7d2fYkpSHOXDCfE8Y9ULsM6ZIFire76TbWvVgpXtlTXFvthl3A7Q9zsqjMd/qOjsCT
	A5ByliDQVUBcqDHtada/NarmfbvnaLwfhzzNMC+R2C4+GagAEQpWe4RlNhqnWIOM9PiqkAuDnTj
	d0yNAKp0SmRpNQu9pofiKf0=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hKBRK6QXkzpSvB;
	Tue, 11 Aug 2026 20:54:53 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 0687D40538;
	Tue, 11 Aug 2026 21:05:36 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Aug 2026 21:05:32 +0800
Message-ID: <8e548d5e-8d80-4ef2-961f-2bcaa7907b8a@huawei.com>
Date: Tue, 11 Aug 2026 21:05:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] arm64: crash: Add crash hotplug support
To: <catalin.marinas@arm.com>, <will@kernel.org>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <thuth@redhat.com>, <mark.rutland@arm.com>,
	<jic23@kernel.org>, <james.morse@arm.com>, <ardb@kernel.org>,
	<leitao@debian.org>, <yeoreum.yun@arm.com>, <sourabhjain@linux.ibm.com>,
	<robh@kernel.org>, <kees@kernel.org>, <coxu@redhat.com>, <makb@juniper.net>,
	<piliu@redhat.com>, <graf@amazon.com>, <ebiggers@kernel.org>,
	<jbouron@amazon.com>, <bgwin@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>
References: <20260729031235.2840255-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260729031235.2840255-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_060554_001214_2CBFA7BC 
X-CRM114-Status: GOOD (  20.14  )
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



在 2026/7/29 11:12, Jinjie Ruan 写道:
> When CPU or memory hotplug events occur, the elfcorehdr in the kdump
> image becomes stale, potentially leading to incomplete crash dumps.
> 
> Currently, userspace udev rules reload the entire kdump image upon such
> events, which is inefficient and leaves kdump inactive for a long time.
> 
> Commit 247262756121 ("crash: add generic infrastructure for crash hotplug
> support") introduced a kernel mechanism to update only the elfcorehdr.
> This patch set implements crash hotplug support for arm64.
> 
> As Baoquan suggested, it also addresses and fixes several
> pre-existing code issues and Sashiko AI review findings extracted
> from the previous patch set.
> 
> The major improvements and fixes included in this series are:
> - Fix several memory leaks for arm64.
> - Simplify arm64 load_other_segments().
> - Implement infrastructure for arm64 crash memory hotplug support.

Hi all,

I'd like to ask if anyone has any suggestions for improvement?

> 
> This patch set is rebased on liveupdate/crashkernel-cma.
> 
> Link: https://lore.kernel.org/all/20260601094805.2928614-1-ruanjinjie@huawei.com/
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
> Jinjie Ruan (5):
>   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
>   arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
>   arm64: kexec_file: Fix image->elf_headers memory leak in retry loop
>   arm64: kexec_file: Simplify load_other_segments()
>   arm64: crash: Add crash hotplug support
> 
>  arch/arm64/Kconfig                     |   3 +
>  arch/arm64/include/asm/kexec.h         |  16 +++
>  arch/arm64/kernel/Makefile             |   2 +-
>  arch/arm64/kernel/crash.c              | 143 +++++++++++++++++++++++++
>  arch/arm64/kernel/kexec_image.c        |   1 +
>  arch/arm64/kernel/machine_kexec_file.c |  78 +++++++-------
>  include/linux/kexec.h                  |   2 +
>  kernel/kexec_core.c                    |  25 +++--
>  8 files changed, 216 insertions(+), 54 deletions(-)
>  create mode 100644 arch/arm64/kernel/crash.c
> 


