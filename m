Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3B1C3600B
	for <kexec@archiver.kernel.org>; Thu, 27 Mar 2025 13:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ltrpHuBYK3kBPf0/dcifpaTfATvh6/UqwkZCMbrzTs8=; b=cXwJuSuHvtXijxT2qnc+m/4B4I
	pXgmTasjVyfsZ3q0ktMVhcifMkALFN2IFt4yDyCjdpCCTuD+CV+3HzaZ2O3Q6m7t2mRfXVrPFy1Tt
	dRCeSf0lx9eI3iljOTfe0X+MJuCNu4++rMfzjtPU1k3TSjVTnznTuNIeoaFMQGG2R+dHRjIFF+1YL
	PZvCfsO3l/4GMPxlgCCjhjdgR+HXq56XHVDHeB7kVVAuyEJk5ypibYRtvh8MkYCEmIXzhlHOjO8GI
	UPs1WigxgdqRkvct5cC0W5vnEbGE1foVQlT7Q4wUWt1GZuf8LgSNETgxoCyHpQ2f+xGHhdosfiKHH
	UJr3mErg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txnTx-0000000B692-0nrD;
	Thu, 27 Mar 2025 13:41:17 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx9oV-00000006qj2-1H97;
	Tue, 25 Mar 2025 19:19:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DD8F1434DC;
	Tue, 25 Mar 2025 19:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95819C4CEE4;
	Tue, 25 Mar 2025 19:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742930390;
	bh=wafZEi25K9c1JaTWa6sefMLZsC4dbteHbRRbzmLF/cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPbGLGyBiB1SvRfjtdKDPGZo2ETHpmtg4qXxmT/GsGNeAR+CaOgpCSQkLho6C5cyc
	 BeFl650l1ufdKyeIojv+r6tvos6q1QYTea+agnc7gVeN//anBFAS8jHYiYDVjzt75S
	 s4ZzhkBDnUKxoUSQebcAdRQCh05nh9CfvgA1nGA7rbw2k4oclzJMZbHrxqVlBm48wb
	 Z621YrYZ+JHXHsHghbHMhKcOrjvBF8Y03gX03F9+y0ZGfKdZwqTAliB69pFxnQnTxA
	 /WTgRa7IozzmoX/kArbLGdEvNkKtPUwcd3I8f3yvhQKyd+ycRUqXs6b97otN3YzUpL
	 HwRTkHR1eqHGg==
Date: Tue, 25 Mar 2025 15:19:44 -0400
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
Message-ID: <Z-MB0Cj4tM6QgOAg@kernel.org>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-8-changyuanl@google.com>
 <CAPTztWbFXajArSN8yKu32eSoR=xsk1CHM_4V7MJ0eQxydFqPUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTztWbFXajArSN8yKu32eSoR=xsk1CHM_4V7MJ0eQxydFqPUQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250325_121951_383312_482BD02A 
X-CRM114-Status: GOOD (  33.06  )
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

On Mon, Mar 24, 2025 at 11:40:43AM -0700, Frank van der Linden wrote:
> On Wed, Mar 19, 2025 at 6:56 PM Changyuan Lyu <changyuanl@google.com> wrote:
> >
> > From: Alexander Graf <graf@amazon.com>
> >
> > Add the core infrastructure to generate Kexec HandOver metadata. Kexec
> > HandOver is a mechanism that allows Linux to preserve state - arbitrary
> > properties as well as memory locations - across kexec.
> >
> > It does so using 2 concepts:
> >
> >   1) State Tree - Every KHO kexec carries a state tree that describes the
> >      state of the system. The state tree is represented as hash-tables.
> >      Device drivers can add/remove their data into/from the state tree at
> >      system runtime. On kexec, the tree is converted to FDT (flattened
> >      device tree).
> >
> >   2) Scratch Regions - CMA regions that we allocate in the first kernel.
> >      CMA gives us the guarantee that no handover pages land in those
> >      regions, because handover pages must be at a static physical memory
> >      location. We use these regions as the place to load future kexec
> >      images so that they won't collide with any handover data.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Co-developed-by: Pratyush Yadav <ptyadav@amazon.de>
> > Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> > Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> > ---
> >  MAINTAINERS                    |   2 +-
> >  include/linux/kexec_handover.h | 109 +++++
> >  kernel/Makefile                |   1 +
> >  kernel/kexec_handover.c        | 865 +++++++++++++++++++++++++++++++++
> >  mm/mm_init.c                   |   8 +
> >  5 files changed, 984 insertions(+), 1 deletion(-)
> >  create mode 100644 include/linux/kexec_handover.h
> >  create mode 100644 kernel/kexec_handover.c
> [...]
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 04441c258b05..757659b7a26b 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/crash_dump.h>
> >  #include <linux/execmem.h>
> >  #include <linux/vmstat.h>
> > +#include <linux/kexec_handover.h>
> >  #include "internal.h"
> >  #include "slab.h"
> >  #include "shuffle.h"
> > @@ -2661,6 +2662,13 @@ void __init mm_core_init(void)
> >         report_meminit();
> >         kmsan_init_shadow();
> >         stack_depot_early_init();
> > +
> > +       /*
> > +        * KHO memory setup must happen while memblock is still active, but
> > +        * as close as possible to buddy initialization
> > +        */
> > +       kho_memory_init();
> > +
> >         mem_init();
> >         kmem_cache_init();
> >         /*
> 
> 
> Thanks for the work on this.
> 
> Obviously it needs to happen while memblock is still active - but why
> as close as possible to buddy initialization?

One reason is to have all memblock allocations done to autoscale the
scratch area. Another reason is to keep memblock structures small as long
as possible as memblock_reserve()ing the preserved memory would quite
inflate them.

And it's overall simpler if memblock only allocates from scratch rather
than doing some of early allocations from scratch and some elsewhere and
still making sure they avoid the preserved ranges.
 
> Ordering is always a sticky issue when it comes to doing things during
> boot, of course. In this case, I can see scenarios where code that
> runs a little earlier may want to use some preserved memory. The

Can you elaborate about such scenarios?

> current requirement in the patch set seems to be "after sparse/page
> init", but I'm not sure why it needs to be as close as possibly to
> buddy init.

Why would you say that sparse/page init would be a requirement here?
 
> - Frank

-- 
Sincerely yours,
Mike.

