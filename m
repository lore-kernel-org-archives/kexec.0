Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFDDC3601A
	for <kexec@archiver.kernel.org>; Fri,  4 Apr 2025 13:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=liPR8OoKzkJaJMnL8kCCcZWI/W4b5B1Ki+ntUn+zDcE=; b=Mv7Wrm6NyRcgFEmJECtiu62SkD
	+ln+Ija4TgnVTbvzN5jOOkW04EfdECGDIfqDePR30WOMbGHoZ9TR38tTtF4WkycDg60mDfMWeM1M5
	deZbK3J4nSep8q2sKgeKwleOpvAzHTaemRJO+827QAnoBc0ZPDOVHae6i75E7g1J7SNoVn0bvvBuq
	rZqPD1peAqUJETv5WBVtYC/6vwvTA2BRxNKotcwoI+5amTX2MZHkSaJOu7ps3oegp9mbh1hxBSZW0
	Rojx09t9gkmOK46IypS1V0xx3XrAbO43oC4dRwpWVMTFUd8Cxe28sWjczH69UtIwF2jWoVyGlnNdj
	0KWJ7IGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0gl6-0000000BlFu-3V9v;
	Fri, 04 Apr 2025 13:06:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0L5g-00000008z0u-1bRs;
	Thu, 03 Apr 2025 13:58:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8AFB24395F;
	Thu,  3 Apr 2025 13:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F347C4CEE5;
	Thu,  3 Apr 2025 13:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743688723;
	bh=BrgR3NVGaMIq0cDdSFPpPKZhtRzYxdIHTZqfFmuVPko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=umP7ldLW1m+GF85JZqxyEuuOLUb1h9mCQmDzKwZnrLKraN0WoXYL/1EVjHchIjzNi
	 0EYgu0oTZkxDRRI0C/+454BgBCgu6Wp1xaBiO1psabHDO+DVSl06T+0+KmSX8LKwrR
	 jrvg7uZujTiRZGfAtk5Vp16S0TECDoHWQJdL+vdqSuKODi1li1JujZTSCkme3ilZ03
	 DJQwIa7PPVlTdeESBd9x+fbDtbMZE3vlRUKmeWFWG7cqIjFvPxdpQysNR3RcA1D55z
	 KBVyUhIHai5T1wt9w9qkpNFzkXFgek1AKaTqZ5Z16Z6W0LmZmj0YT1OK6FXYhjcHrd
	 tMFW218IYwAWQ==
Date: Thu, 3 Apr 2025 16:58:27 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <ptyadav@amazon.de>,
	Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, robh+dt@kernel.org, robh@kernel.org,
	saravanak@google.com, skinsburskii@linux.microsoft.com,
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <Z-6UA3C1TPeH_kGL@kernel.org>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-10-changyuanl@google.com>
 <mafs05xjmqsqc.fsf@amazon.de>
 <20250403114209.GE342109@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403114209.GE342109@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_065844_455964_67987B8E 
X-CRM114-Status: GOOD (  13.80  )
X-Mailman-Approved-At: Fri, 04 Apr 2025 06:06:49 -0700
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

On Thu, Apr 03, 2025 at 08:42:09AM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 02, 2025 at 07:16:27PM +0000, Pratyush Yadav wrote:
> > > +int kho_preserve_phys(phys_addr_t phys, size_t size)
> > > +{
> > > +	unsigned long pfn = PHYS_PFN(phys), end_pfn = PHYS_PFN(phys + size);
> > > +	unsigned int order = ilog2(end_pfn - pfn);
> > 
> > This caught my eye when playing around with the code. It does not put
> > any limit on the order, so it can exceed NR_PAGE_ORDERS. Also, when
> > initializing the page after KHO, we pass the order directly to
> > prep_compound_page() without sanity checking it. The next kernel might
> > not support all the orders the current one supports. Perhaps something
> > to fix?
> 
> IMHO we should delete the phys functions until we get a user of them

The only user of memory tracker in this series uses kho_preserve_phys()
 
> Jason

-- 
Sincerely yours,
Mike.

