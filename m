Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382FEFD530E
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 08:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4QNE0rmrVgUNOHM54Q6+KXIw9mcgEQxg8vQIoBdEY9c=; b=C+N4wc5TBGqb+IDOOG7O1f+YfW
	uRYmdi8raLs5eGwyQXqejXsNlhWHtWwFYbRDtV7WIA+r5mJsP/KrZ2XgC3mDJiz9CpExWDvPD4GZe
	4Yej98x4kIYnh/JNbkdQ5Rlkoxv2cq8vZWbMLYaMXbdiiU3WtpFrnqSCEvyKsahhGcTGXuqzDPloh
	VZglS1vECD+DR48RdxAd0zl0zUguRM4nWQe/Qklub3EymIHNZFbPAotK46TAF5kPwYLEB+dP8GbZo
	dw/j7xPlFp32/WnzdaSHiJM+vRYfEpa8gJP/QjdlIn1dyUDTJlnA5IeVD7Jhl0AwHWHJjE4ckGgnR
	K6sX9lhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvtNF-000000080Uh-2zOS;
	Fri, 27 Feb 2026 08:39:01 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqXvF-00000002DI5-2SJC;
	Thu, 12 Feb 2026 14:44:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7DEA040A48;
	Thu, 12 Feb 2026 14:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E60C4CEF7;
	Thu, 12 Feb 2026 14:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770907440;
	bh=JgHytrfIoVHvSrB+ZHqvgP9qOCOR6LftqPuUXmXPewE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ko6YX0yEFe4E0jrbp3XxgX4zcX+pt5kKGo3qsoUNXAjP6BmajfjaWMR7EZwObD3mv
	 RaQE4z+0+Y4Gvw1ciyp3sCoy9AWoV51k6SCkkX3HI2r8w9NGPYJAIaOZZnUH2/CyAt
	 FCBngxnZE5xc2/k3bOXFQAM1G/mpwsKy3pmOJK8ljYA+CUHAY9etU2AWnTdKmHe6kI
	 HZlhRcgRSjONrL5wCWjVGmpSaYyE8ivrPjr5pZvM5QJmgaMHdUy9DFX0Ke6voUeoPk
	 feWHia6y6PLrBYPJdAa4URtO8gt/Nen7sw+LzrielacYjoBKTAX8sR6v3rAfEPlgAn
	 olPDejjZ8fPrA==
Date: Thu, 12 Feb 2026 16:43:38 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, akpm@linux-foundation.org, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org,
	kees@kernel.org, elver@google.com, paulmck@kernel.org,
	arnd@arndb.de, fvdl@google.com, thuth@redhat.com, ardb@kernel.org,
	leitao@debian.org, osandov@fb.com, cfsworks@gmail.com,
	sourabhjain@linux.ibm.com, ryan.roberts@arm.com,
	tangyouling@kylinos.cn, eajames@linux.ibm.com,
	hbathini@linux.ibm.com, ritesh.list@gmail.com,
	songshuaishuai@tinylab.org, bjorn@rivosinc.com,
	samuel.holland@sifive.com, kevin.brodsky@arm.com,
	junhui.liu@pigmoral.tech, vishal.moola@gmail.com, dwmw@amazon.co.uk,
	pbonzini@redhat.com, kai.huang@intel.com, ubizjak@gmail.com,
	coxu@redhat.com, fuqiang.wang@easystack.cn, liaoyuanhong@vivo.com,
	brgerst@gmail.com, jbohac@suse.cz, x86@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v5 1/4] powerpc/crash: sort crash memory ranges before
 preparing elfcorehdr
Message-ID: <aY3nGuredkMTCZIm@kernel.org>
References: <20260212101001.343158-1-ruanjinjie@huawei.com>
 <20260212101001.343158-2-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212101001.343158-2-ruanjinjie@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_064401_671648_E824FB38 
X-CRM114-Status: GOOD (  16.59  )
X-Mailman-Approved-At: Fri, 27 Feb 2026 00:38:19 -0800
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

On Thu, Feb 12, 2026 at 06:09:58PM +0800, Jinjie Ruan wrote:
> From: Sourabh Jain <sourabhjain@linux.ibm.com>
> 
> During a memory hot-remove event, the elfcorehdr is rebuilt to exclude
> the removed memory. While updating the crash memory ranges for this
> operation, the crash memory ranges array can become unsorted. This
> happens because remove_mem_range() may split a memory range into two
> parts and append the higher-address part as a separate range at the end
> of the array.
> 
> So far, no issues have been observed due to the unsorted crash memory
> ranges. However, this could lead to problems once crash memory range
> removal is handled by generic code, as introduced in the upcoming
> patches in this series.
> 
> Currently, powerpc uses a platform-specific function,
> remove_mem_range(), to exclude hot-removed memory from the crash memory
> ranges. This function performs the same task as the generic
> crash_exclude_mem_range() in crash_core.c. The generic helper also
> ensures that the crash memory ranges remain sorted. So remove the
> redundant powerpc-specific implementation and instead call
> crash_exclude_mem_range_guarded() (which internally calls
> crash_exclude_mem_range()) to exclude the hot-removed memory ranges.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Jinjie Ruan <ruanjinjie@huawei.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/kexec_ranges.h |  4 +-
>  arch/powerpc/kexec/crash.c              |  5 +-
>  arch/powerpc/kexec/ranges.c             | 87 +------------------------
>  3 files changed, 7 insertions(+), 89 deletions(-)

This looks like a nice improvement!
FWIW

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

