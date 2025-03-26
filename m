Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D985C36012
	for <kexec@archiver.kernel.org>; Thu, 27 Mar 2025 13:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oa6CEdQgzAg5lBq2N6XQeKHkfOX+obSEnZeTTxS3+iE=; b=T8tY9b26l1sBWcDemIx6Rv+1yu
	bnOMKtPE0+FXhRm3uEEmcCI4w/BnfY6kIJE5Rj/nYKeeTnDyV2Oh6Ns7B0zjFM7U8wME0JscRYkPR
	HWzmm/l07XorKmTf5Vpdu3y1XvsklZDUGzBYuCG2uhGMeywAdMGaOXWwDV28AByFxmx0D23+K9byh
	zmK+fxMEshuhrnaWGy4MtsK4ZncKyx3xSeJc3+QdGpfZbpjRiRUvFkGlqktd9kMLLJVyV92uXzvwq
	ndxjKip3uKEMbQFbw7iWCBq/jLPdvXBcAbtv9qAIb7AZX9Jm7vk6Fe7VyF4xnq8QPatnyLejrUYtk
	UkLqOg2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txnTz-0000000B6E1-3vgp;
	Thu, 27 Mar 2025 13:41:19 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txPQB-00000008Pco-0izc;
	Wed, 26 Mar 2025 11:59:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3BEDE6112F;
	Wed, 26 Mar 2025 11:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8AEC4CEE2;
	Wed, 26 Mar 2025 11:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742990385;
	bh=cjxrsIzX/WPyXr7qdJpErRGIpF/kZxl22HylGb7mEwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LhPUdmq1h7gvCSyDJ4n5B+4eRaGO5moH9CfG7jg7AQW5aPyeCDq2hBlFxoYjjVSlZ
	 VC/V+Bixj8HZzyowNqA066Z5Np/7rN3pTPMilK3q5mgy0LnHOq+14v86HCYR2l+yn6
	 e6g8oVWNq4Oy9Ij3p/6BCYiNZnS5659ckKwyTePqMI8tZZz0VPq9KTqvsWWEwQ9zsJ
	 f/61VbQQ9B4OxQWSMiWDMS+ss5uyO8eyB1ZikVuHGAoUaYZ7BLWyzPftmXh+1uIeY+
	 ru6EG6DyITSaRWZbJTdd9xC6DquohsYrSIlfLjsLjC60xDWGZmxOIvftTBoNzZfTMB
	 7ZVrb394mhsAg==
Date: Wed, 26 Mar 2025 07:59:40 -0400
From: Mike Rapoport <rppt@kernel.org>
To: Frank van der Linden <fvdl@google.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org,
	robh@kernel.org, saravanak@google.com,
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org,
	tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 07/16] kexec: add Kexec HandOver (KHO) generation
 helpers
Message-ID: <Z-PsLDv-DkxitRv1@kernel.org>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-8-changyuanl@google.com>
 <CAPTztWbFXajArSN8yKu32eSoR=xsk1CHM_4V7MJ0eQxydFqPUQ@mail.gmail.com>
 <Z-MB0Cj4tM6QgOAg@kernel.org>
 <CAPTztWbDtDhKZS89-aEBaZoPW2jZM2CAWW1Y_m3OnNE26=d9UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTztWbDtDhKZS89-aEBaZoPW2jZM2CAWW1Y_m3OnNE26=d9UQ@mail.gmail.com>
X-Mailman-Approved-At: Thu, 27 Mar 2025 06:41:08 -0700
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

On Tue, Mar 25, 2025 at 02:56:52PM -0700, Frank van der Linden wrote:
> On Tue, Mar 25, 2025 at 12:19 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Mon, Mar 24, 2025 at 11:40:43AM -0700, Frank van der Linden wrote:
> [...]
> > > Thanks for the work on this.
> > >
> > > Obviously it needs to happen while memblock is still active - but why
> > > as close as possible to buddy initialization?
> >
> > One reason is to have all memblock allocations done to autoscale the
> > scratch area. Another reason is to keep memblock structures small as long
> > as possible as memblock_reserve()ing the preserved memory would quite
> > inflate them.
> >
> > And it's overall simpler if memblock only allocates from scratch rather
> > than doing some of early allocations from scratch and some elsewhere and
> > still making sure they avoid the preserved ranges.
> 
> Ah, thanks, I see the argument for the scratch area sizing.
> 
> >
> > > Ordering is always a sticky issue when it comes to doing things during
> > > boot, of course. In this case, I can see scenarios where code that
> > > runs a little earlier may want to use some preserved memory. The
> >
> > Can you elaborate about such scenarios?
> 
> There has, for example, been some talk about making hugetlbfs
> persistent. You could have hugetlb_cma active. The hugetlb CMA areas
> are set up quite early, quite some time before KHO restores memory. So
> that would have to be changed somehow if the location of the KHO init
> call would remain as close as possible to buddy init as possible. I
> suspect there may be other uses.

I think we can address this when/if implementing preservation for hugetlbfs
and it will be tricky. 
If hugetlb in the first kernel uses a lot of memory, we just won't have
enough scratch space for early hugetlb reservations in the second kernel
regardless of hugetlb_cma. On the other hand, we already have the preserved
hugetlbfs memory, so we'd probably need to reserve less memory in the
second kernel.

But anyway, it's completely different discussion about how to preserve
hugetlbfs.
 
> > > current requirement in the patch set seems to be "after sparse/page
> > > init", but I'm not sure why it needs to be as close as possibly to
> > > buddy init.
> >
> > Why would you say that sparse/page init would be a requirement here?
> 
> At least in its current form, the KHO code expects vmemmap to be
> initialized, as it does its restore base on page structures, as
> deserialize_bitmap expects them. I think the use of the page->private
> field was discussed in a separate thread, I think. If that is done
> differently, it wouldn't rely on vmemmap being initialized.

In the current form KHO does relies on vmemmap being allocated, but it does
not rely on it being initialized. Marking memblock ranges NOINT ensures
nothing touches the corresponding struct pages and KHO can use their fields
up to the point the memory is returned to KHO callers.
 
> A few more things I've noticed (not sure if these were discussed before):
> 
> * Should KHO depend on CONFIG_DEFERRED_STRUCT_PAGE_INIT? Essentially,
> marking memblock ranges as NOINIT doesn't work without
> DEFERRED_STRUCT_PAGE_INIT. Although, if the page->private use
> disappears, this wouldn't be an issue anymore.

It does. 
memmap_init_reserved_pages() is called always, no matter of
CONFIG_DEFERRED_STRUCT_PAGE_INIT is set or not and it skips initialization
of NOINIT regions.

> * As a future extension, it could be nice to store vmemmap init
> information in the KHO FDT. Then you can use that to init ranges in an
> optimized way (HVO hugetlb or DAX-style persisted ranges) straight
> away.
 
These days memmap contents is unstable because of the folio/memdesc
project, but in general carrying memory map data from kernel to kernel is
indeed something to consider.

> - Frank

-- 
Sincerely yours,
Mike.

