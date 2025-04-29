Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15106C369CB
	for <kexec@archiver.kernel.org>; Tue, 29 Apr 2025 08:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=97/XTbBVa/VhLqAzcVmPdfXdxwWdIcyYHBaxl2j9mtY=; b=Ge0iwEx7uGGu0uibrlJCl319GA
	Xv1U08eax+uDdgjHG6nZmLT3nbL7qYa45v2bdnwBu8rRC7eZkQADI56gInM0+V8BxI67w/Wx/s/xd
	qG6XyJ0yK5k42eM562axV4MB/orjRKyD3n02rpWauEw3YgH6I1BMbRYMm+EKBCdHQfXybofMIBjUp
	iY0fkiYuXdjY/GkdSkvzXNe683OPpmMvW0jRvL32z6EXPomeyaeguFsUsSiuRIo4douFm3nYkMgub
	XNL+xoViNjtvkl13C87Ncgae3Ad1TO5NmUdcWDV0jXu60gKANDeeJXmOxc8cS5pt6HtRWexumfK/S
	OC/RwDsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9g1o-00000008rty-2jPp;
	Tue, 29 Apr 2025 08:09:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9fzI-00000008rPN-4C25;
	Tue, 29 Apr 2025 08:06:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C797F5C4D8E;
	Tue, 29 Apr 2025 08:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D988C4CEE3;
	Tue, 29 Apr 2025 08:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745914003;
	bh=T+OFZKl+3KvYwlqOnSAJknFTlFAGkXBm4R7faZdxC7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g4MP1qWhXsNl/uB3rPYca9oL1jVE0ekWEV6gfciWYbB1+dqLQ9mMLhKCeQ4kEML3r
	 bJyb0LeyWTmqcsUmRVfFDi6VMDW5WBeVc88je0PluGWeRS97AYRHNXEXRaWe2ZBNUR
	 h2P24d0Nb3ya3adWViA9y0dL9GADK0WkUOludE9eaO59e5mCjZo+20Kkb33rkTCZ3T
	 joUB021ZBtmCwCwJ8IZUTlrvA217Wsdkv6riqQodhqkESfxv93/qyLqVSaXCE995Qd
	 adxuArH/4q+RMu7lWE/6XP1SpcSbdgr9HJnDqYvJZCKjQED2Lf6yl72MdWWvLKHiTL
	 2/8qg6TYlg6Ig==
Date: Tue, 29 Apr 2025 11:06:29 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de,
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de,
	catalin.marinas@arm.com, corbet@lwn.net,
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org,
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com,
	hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org,
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com,
	pbonzini@redhat.com, peterz@infradead.org, ptyadav@amazon.de,
	robh@kernel.org, rostedt@goodmis.org, saravanak@google.com,
	skinsburskii@linux.microsoft.com, tglx@linutronix.de,
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Subject: Re: [PATCH v6 11/14] x86: add KHO support
Message-ID: <aBCIhQjKKyaAuvC9@kernel.org>
References: <20250411053745.1817356-1-changyuanl@google.com>
 <20250411053745.1817356-12-changyuanl@google.com>
 <35c58191-f774-40cf-8d66-d1e2aaf11a62@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35c58191-f774-40cf-8d66-d1e2aaf11a62@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_010645_136956_794CBF6A 
X-CRM114-Status: GOOD (  24.01  )
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

On Mon, Apr 28, 2025 at 03:05:55PM -0700, Dave Hansen wrote:
> On 4/10/25 22:37, Changyuan Lyu wrote:
> > From: Alexander Graf <graf@amazon.com>
> > 
> > +/*
> > + * If KHO is active, only process its scratch areas to ensure we are not
> > + * stepping onto preserved memory.
> > + */
> 
> Same thing on the imperative voice here.
> 
> I'm also not fully understanding the comment. Do these "scratch" regions
> basically represent all the memory that's not being handed over? It's
> not obvious.

Scratch memory represents areas created at the boot of the first kernel and
it's known that scratch areas won't contain any memory that's being handed
over.
 
> > diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> > index 57120f0749cc3..c314212a5ecd5 100644
> > --- a/arch/x86/kernel/e820.c
> > +++ b/arch/x86/kernel/e820.c
> > @@ -1300,6 +1300,24 @@ void __init e820__memblock_setup(void)
> >  		memblock_add(entry->addr, entry->size);
> >  	}
> >  
> > +	/*
> > +	 * At this point with KHO we only allocate from scratch memory.
> > +	 * At the same time, we configure memblock to only allow
> > +	 * allocations from memory below ISA_END_ADDRESS which is not
> > +	 * a natural scratch region, because Linux ignores memory below
> > +	 * ISA_END_ADDRESS at runtime. Beside very few (if any) early
> > +	 * allocations, we must allocate real-mode trapoline below
> 
> 						trampoline ^
> 
> > +	 * ISA_END_ADDRESS.
> > +	 *
> > +	 * To make sure that we can actually perform allocations during
> > +	 * this phase, let's mark memory below ISA_END_ADDRESS as scratch
> > +	 * so we can allocate from there in a scratch-only world.
> > +	 *
> > +	 * After real mode trampoline is allocated, we clear scratch
> > +	 * marking from the memory below ISA_END_ADDRESS
> > +	 */
> > +	memblock_mark_kho_scratch(0, ISA_END_ADDRESS);
> 
> This isn't making a whole ton of sense to me.
> 
> Is this *only* to facilitate possible users that need <ISA_END_ADDRESS
> allocations? If so, please say that.
> 
> I _think_ this is trying to say that KHO kernels are special and are
> trying to only allocate from scratch areas. But <ISA_END_ADDRESS
> allocations are both necessary and not marked by KHO _as_ a scratch area
> which causes a problem.

Yes :)

-- 
Sincerely yours,
Mike.

