Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45333CA6007
	for <kexec@archiver.kernel.org>; Thu,  8 Oct 2026 06:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QYjlbETRxQW9RMjfplUAnmTLI8vDWVyFt6dBT1ysNAc=; b=Jn5HRbRRXzGnncsNRncjBzL+yJ
	wXIROhSKjLmCaAqMvp0o/Q88xkDO2mYAIYP25AvjhP0s4LD5sGWRv3/cwNZnWQbmCzO5gT6WPT4PR
	CZ6DZ5qT60pWQ5jp2jFjv3QDyrR1Po0y+wYfsGetajWS7z/gC1Pxtb12cxKhOjjovBuf8ROhrF9Ca
	96FfUHftRoV8O2lhRD4/pTpzGU5/mh+9zOn0ITXQ4avYAKHZ9cWctOokzIckVjoF+bnOdbkJDPNXd
	DzJTCJ/jn4DxeQdoQlISG9itBJ+tfXbelbBfanqtfySe/EDP8htuWfqHSFkn6bUHNac5yKP0OESmX
	yRJHdebg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEhq3-00000003eKU-3Lj3;
	Thu, 08 Oct 2026 06:42:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEhq2-00000003eKD-44WG;
	Thu, 08 Oct 2026 06:42:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7EB1D41836;
	Thu,  8 Oct 2026 06:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9461F000FF;
	Thu,  8 Oct 2026 06:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791441765;
	bh=QYjlbETRxQW9RMjfplUAnmTLI8vDWVyFt6dBT1ysNAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LzwrJChRSmVjEsRakCz7KZMyALTXRiMMTQqt+Pq1DfhvTRhANdPa2qsjY85CoeKmU
	 +smyn7Lotjz8Z+6My1XtXdRcAWv0Bk3+so9601+yHD0hXOPoxrMliq4uNlyMYvPyEN
	 /KxKGNEGsRLbC5gh5Fpx/irufkYMSkObZy2nAEfpl7+01CgTBFC4KUpi+Rt44aL8Zf
	 NTIbo4/T2UBb6sZftaMcHpGWW78wNUfUZX3n+aegjkdkvaCrfhtnmdLmCzyRFXWi5O
	 KzhbRY6JsNtjGiT0SU3GKlmfmu9GhVSnGRLyWq6PEohhumSDv1uECF+lTxE7sLA503
	 DyPwUh9lm6nsw==
Date: Thu, 8 Oct 2026 08:42:25 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	ritesh.list@gmail.com, sshegde@linux.ibm.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org, akpm@linux-foundation.org, baoquan.he@linux.dev,
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
Message-ID: <asc7UdlRsy7502j8@kernel.org>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <f4ba3a6b-537d-4328-b0c1-c0e5aa61924f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4ba3a6b-537d-4328-b0c1-c0e5aa61924f@huawei.com>
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

On Thu, Oct 08, 2026 at 09:57:30AM +0800, Jinjie Ruan wrote:
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

Sorry for the delay, I was travelling for the past few weeks.
I'm planning to review this next week. 

And we do need acks from arch maintainers for most of the patches in this
series.

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

-- 
Sincerely yours,
Mike.

