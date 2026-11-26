Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D09606A31C
	for <kexec@archiver.kernel.org>; Thu, 26 Nov 2026 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oLmG/1Fi;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhIgcTNy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=g76ZCxcIcpyNOspZC9j/ne3dtmiKHKAQji21AEWRzhs=; b=oLmG/1FirD8RHFrR9Y2C5XUeqw
	w/4HuBJx7IN8VHRIwFhyGkjQ7Rd/624xqlRSbyq0vX0hQt28YdUCc4bWTH5Dm5fpE/sN95k4XEBKR
	wllxcueF/fJh3y8Xw3oHiKvXsYDMNkWWFbs/vTsgKtDRmO0NWlZmMKjc/rlW0zW8Bs2WORHjdNGAf
	SchEYWYB2lyKnb3Bnh6HC9tnyp8m3ZEzLQEXuX2WTjrlojRGTZF2VAhyt7ekZ2E4EXX6IZjmfpIVX
	1Fm8c7GthixTP0W5gvaXAs00Qv5NAstp2JXaVUUugwlRpResws/pch59IPqJ2V2jhifRugaUkcL8U
	xfcs2B+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWYdb-0000000D9rY-2TIB;
	Thu, 26 Nov 2026 12:31:43 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWYdY-0000000D9rD-3Di6;
	Thu, 26 Nov 2026 12:31:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1C6B445ADF;
	Thu, 26 Nov 2026 12:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8E31F000EC;
	Thu, 26 Nov 2026 12:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795696300;
	bh=g76ZCxcIcpyNOspZC9j/ne3dtmiKHKAQji21AEWRzhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FhIgcTNyf14ldQHtiXv4zYG7ZY7VCqUA0BM8xEiAd9PiTm163jt+tIucHvtp12C8Z
	 hTWcxCBuQSmBdPjWBXBZNhoWsIRaeZwk4tBrpXsXp0LFE7rslODJBmDyl3YQpg6Ny/
	 ZQqOVxVhkX4GcW5TAfSjWCdZhxgEs/tJx7zxfh/n5fb8xCMqBvorTueaamFp/RlS4/
	 dMV1Xmmt3A6+Gg03qpav/T8uWqHtizB8mmoUOgZZwBmCLaSrlFT2sBQ8IPhG1sybXm
	 JThOqAaaV55drREdq3cv4z5h+Vfq577y0fulQy6Oo6YnLP7UaB0gh1hEnnj5kEf7X0
	 5lql7h2/dp6dw==
Date: Thu, 26 Nov 2026 14:31:18 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	akpm@linux-foundation.org, baoquan.he@linux.dev,
	pasha.tatashin@soleen.com, pratyush@kernel.org, leitao@debian.org,
	yeoreum.yun@arm.com, mpilaniy@redhat.com, robh@kernel.org,
	coiby.xu@gmail.com, Yeking@red54.com, prudo@redhat.com,
	brads@mainlining.org, sourabhjain@linux.ibm.com,
	mkchauras@gmail.com, blum@kernel.org, adityag@linux.ibm.com,
	qirui.001@bytedance.com, hui.wang@canonical.com,
	sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn,
	ionut.nechita@windriver.com, vishal.l.verma@intel.com,
	seanjc@google.com, ardb@kernel.org, richard.lyu@suse.com,
	arnd@arndb.de, tzimmermann@suse.de, rick.p.edgecombe@intel.com,
	kai.huang@intel.com, kas@kernel.org, piliu@redhat.com,
	thuth@redhat.com, shradhagupta@linux.microsoft.com,
	ebiggers@kernel.org, jbouron@amazon.com, me@linux.beauty,
	mclapinski@google.com, graf@amazon.com, tangyouling@kylinos.cn,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v8 00/11] kexec: Rework segment loading and fix CMA
 retries
Message-ID: <awgmlnibFRpjgG2a@kernel.org>
References: <20261112133418.4044428-1-ruanjinjie@huawei.com>
 <584a0e7a-230e-4a95-9e09-a1d6499a6ea9@huawei.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <584a0e7a-230e-4a95-9e09-a1d6499a6ea9@huawei.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jinjie,

On Mon, Nov 23, 2026 at 03:10:53PM +0800, Jinjie Ruan wrote:
> 
> 在 2026/11/12 21:34, Jinjie Ruan 写道:
> > ARM64, LoongArch, RISC-V, x86 and powerpc build the elf core header
> > and place it together with the initrd and the DTB with almost identical
> > code.
> > 
> > This series reworks that path into common helpers that the architectures
> > reuse, and fixes the CMA page and elf core header leaks in the arm64
> > and LoongArch placement retry loops.
> > 
> > The patch organization is as follows:
> > 
> > - Patch 1 moves the release of the elf core header into the generic
> >   post-load cleanup, so that the architectures no longer free it
> >   themselves.
> > 
> > - Patch 2 adds the common helpers
> > 
> > - Patches 3-7 convert arm64, LoongArch, RISC-V, X86 and Powerpc to
> >   reuse the common helpers
> > 
> > - Patches 8-11 fix the CMA pages leaked by the retry loops and
> >   the loop that makes no progress
> > 
> > Tested with kexec_file_load() on arm64, LoongArch, RISC-V, X86 and
> > Powerpc under QEMU, including the CMA retry paths, loading a crash
> > kernel and booting the second kernel, with the agent help.
> > 
> > This series is also available at:
> > 	https://github.com/ruanjinjie-eng/linux/tree/kexec_rework_cma_bugfx_v9
> > 
> > Changes in v8:
> > - Rework the common code as Mike suggested: the core provides building
> >   blocks and the architectures uses them (Mike)
> > - Build the elf core header once and only place it on the retries (Mike)
> > - Keep the segment order and the arch placement policy unchanged (Mike)
> > - Convert x86 and powerpc as well
> > - Move the CMA fixes to the end of the series (Mike)
> 
> Hi Mike,
> 
> Does this refactoring now meet your expectations?

I only had time for a quick skim, and overall it looks good to me.

The only thing that stood out was kexec_add_fdt() in kexec/kexec_file.c.
I believe drivers/of/kexec.c is a better place for it.
 
> In my view, there is still an issue worth discussing: should we reserve
> for the crash hotplug elf core header in the framework code
> kexec_add_elf_core_header(), or only implement it in the x86
> architecture code, and consider generalizing it after the ARM64
> implementation is available?

I think it's better to keep it in x86 for now and generalize later.
 
> Best regards,
> Jinjie
> 
> 
> > - Link to v7: https://lore.kernel.org/all/20261026075201.699550-1-ruanjinjie@huawei.com/
> > 
> > Previous Versions are as below:
> > - v6: https://lore.kernel.org/all/20260921090450.807575-1-ruanjinjie@huawei.com/
> > - v5: https://lore.kernel.org/all/20260918100442.3841135-1-ruanjinjie@huawei.com/
> > - v4: https://lore.kernel.org/all/20260907125404.922123-1-ruanjinjie@huawei.com/
> > - v3: https://lore.kernel.org/all/20260826092541.3905933-1-ruanjinjie@huawei.com/
> > - v2: https://lore.kernel.org/all/20260729031235.2840255-1-ruanjinjie@huawei.com/
> > - v1: https://lore.kernel.org/all/20260723131242.1537633-1-ruanjinjie@huawei.com/#t
> > 
> > Jinjie Ruan (11):
> >   kexec: Free the elf core header in kimage_file_post_load_cleanup()
> >   kexec: Add helpers to load the elf core header, initrd and FDT
> >   arm64: kexec_file: Load the other segments with common helpers
> >   LoongArch: kexec_file: Load the other segments with common helpers
> >   riscv: kexec_file: Load the extra segments with common helpers
> >   x86: kexec_file: Use the common segment helpers
> >   powerpc: kexec_file: Use the common segment helpers
> >   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
> >   kexec: Add kexec_rollback_segments() helper
> >   arm64: kexec_file: Fix CMA segment placement retries
> >   LoongArch: kexec_file: Fix CMA segment placement retries
> > 
> >  arch/arm64/include/asm/kexec.h             |   4 +-
> >  arch/arm64/kernel/kexec_image.c            |  15 ++-
> >  arch/arm64/kernel/machine_kexec_file.c     |  87 ++++----------
> >  arch/loongarch/include/asm/kexec.h         |   3 +-
> >  arch/loongarch/kernel/kexec_efi.c          |  15 ++-
> >  arch/loongarch/kernel/kexec_elf.c          |   3 +-
> >  arch/loongarch/kernel/machine_kexec_file.c |  80 +++++--------
> >  arch/powerpc/kexec/elf_64.c                |   9 +-
> >  arch/powerpc/kexec/file_load_64.c          |  18 +--
> >  arch/riscv/include/asm/kexec.h             |   4 +-
> >  arch/riscv/kernel/kexec_elf.c              |   3 +-
> >  arch/riscv/kernel/kexec_image.c            |   3 +-
> >  arch/riscv/kernel/machine_kexec_file.c     |  83 ++++----------
> >  arch/x86/kernel/crash.c                    |  25 +----
> >  arch/x86/kernel/kexec-bzimage64.c          |   8 +-
> >  arch/x86/kernel/machine_kexec_64.c         |   4 -
> >  include/linux/kexec.h                      |  14 +++
> >  kernel/kexec_core.c                        |  25 +++--
> >  kernel/kexec_file.c                        | 125 +++++++++++++++++++++
> >  19 files changed, 254 insertions(+), 274 deletions(-)
> > 
> 

-- 
Sincerely yours,
Mike.

