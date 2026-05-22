Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883F8CD5BAF
	for <kexec@archiver.kernel.org>; Fri, 22 May 2026 00:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AUuo4Wsm5kupCrQA3m4DdC09avG22p4BEbUBdKbxJRo=; b=YweB60+XC2ZiTA8sbiLs+kuPQ7
	h/a1e5+o0/cSG1HrzA1v6JCL2POV62EeSH+TkN+Hnsr9dVGsg7v3+dPU/kQaGSI89Lqd3E3f4u/a5
	4EggihfdFcApxvF9XU7AVmAHrPPtTAgxukFWJ75afqSCw5LkCWTDKWuXL7uWfxIWZrriYgSd4i5vl
	1QDP7Wxc+59IYrhCIfcQU96sHO80Xyygcpcy1/AeJTJ8PZZdmTDsu0uwrHTcelyQeVveidRPKxq4v
	4yGv+77+SEX+IEGKAJB+WQy485Fxma2o7FpLUtvW4P0q49NZ6IH9AO6GLhVfVlDS6tfHJwS3I0zp7
	XIO3+kTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQE48-00000009Qw4-3Xhi;
	Fri, 22 May 2026 00:48:40 +0000
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQE46-00000009QvI-0tNS
	for kexec@lists.infradead.org;
	Fri, 22 May 2026 00:48:39 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so92080756d6.1
        for <kexec@lists.infradead.org>; Thu, 21 May 2026 17:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779410917; x=1780015717; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AUuo4Wsm5kupCrQA3m4DdC09avG22p4BEbUBdKbxJRo=;
        b=huPKnsjync6vNIlG77mIYrqA/e37t1PJSaatpj/Rn5MZ8RY1oNY/clvIZDvJ/QwURj
         q3YIDebtlYRoubZZFiQI5w+taAlM2mFx6TyIOJWbja0sxNjU0qVOJpAcNgJdYJHI+qUw
         2MzYCuWL+4hcMhrr8u1MBHshTy4ETVhbnO6aMFs2genQgedcjqg7BdLNCitb2ilEh5ny
         prFP7YW6WDvq7ssQPM7pOv2FlExUuzNUTTJyXoIYfTBujsoUXR6Ffm0PC5UCvsjm9ODm
         2lpgODsfiPwI36M+bnRlY56egNb6OLpkCKn1OoyxOJd0KLRwN8AN4/mZTlbVFtRW+gBz
         D1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779410917; x=1780015717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUuo4Wsm5kupCrQA3m4DdC09avG22p4BEbUBdKbxJRo=;
        b=YJ10hwXdjy8j9T+aa1QwOcOkbKaB600mildc6ntcaBlI/Us45OlNE3zijUuUl76fgf
         pWeaegHeXBfy2sSLKaahCFRukSr0I5j/LEXs0/ZdIA9aExeh/UGS7l9VMBCMy6GFvJpQ
         Jf6PGNpCdIWKXF3dIJGlkqLzhf2u1hOV6nDRgxfWjYAooYkvzOt7sKVMXU4acr+A7/tB
         1AErWXc+C+bkhMnZQDxIS1oWax/8nSulTGhomyyu74tjT8VTSUA0RHLg3mfVEOhe9Mt6
         l7PgijolcT4aEmuDug20jmrJt51mVFQhHM1dh/w+JWEHiBV1qOM/+PjDkj0l2fhDZrxw
         jozg==
X-Forwarded-Encrypted: i=1; AFNElJ+Z2BMNTwnNNev0K0vS2xdmFv3rOux2kJ+RF/ghxE+K6tYB7oLHIYN2RR9k6MsnHEU5ZXXq3A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz1Qhkhc0X/idrxOocVZtrmuVjSDuhgYkW3QSrvFGGrWUoKXqJC
	kccYAijy9vAGKP1tNSi3Zqhc08LxLvFCH4jnFM8iPh3J+gEuHzFyuHUc7jBDxt85P+c=
X-Gm-Gg: Acq92OE6/qUDty+Xw05j50Hvu/3/4fLq5kJOgoCHhzQTiuaxX8buiOee0Ace6iylPQx
	ObbOf3mmp8PelEoTUTWt0eAGMhY5ePV8a+pm3vZBgg5oHh8lS69DLdJiKJGfxLDTKnSPL9TLY21
	DNXZQXiG+wbrcH9v/RoRPDyT8JRoF3SHHI0DwdLmHQ4saFg/vnuxwoee0ekwQ8gL8DHnbMXaHSN
	CmjGuxMq1Sz+2oNKf5sk/HHGSx98TXHC4g+OPpurpYm6u5tH36SJtHxBzneFJaEBqLKgeGX844J
	Z0YF2qJvA/IlfluQFNgKYmMax0JtRTxUc0ttGAOdN87xCgCnUCxeintm4CaE0q2mGQkuXffj57C
	UU5eEt5IGkZ9T9aIi3qGDYfpA0uEryU2n/0CHZ3BvXMv35J/2jNcd8/uYkHZv/H6wS/eDAL8ECV
	E4sk+IN/qeV1JpeNozzT/3/WI9HHcWPWcGYleny9nY0RCJN2yT1rg=
X-Received: by 2002:a05:6214:3204:b0:8cc:3546:2612 with SMTP id 6a1803df08f44-8cc7b55066fmr31946416d6.14.1779410916844;
        Thu, 21 May 2026 17:48:36 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc81316e4esm3013256d6.41.2026.05.21.17.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 17:48:36 -0700 (PDT)
Date: Fri, 22 May 2026 00:48:35 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] memblock: introduce MEMBLOCK_KHO_SCRATCH_EXT
Message-ID: <ag-a4ru9bMkDMthO@plex>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-10-pratyush@kernel.org>
 <agHGOxSnP_VraH1M@kernel.org>
 <2vxzecjhc2s8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzecjhc2s8.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_174838_274906_EC0ECCCA 
X-CRM114-Status: GOOD (  32.52  )
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

On 05-11 18:46, Pratyush Yadav wrote:
> On Mon, May 11 2026, Mike Rapoport wrote:
> 
> > On Wed, Apr 29, 2026 at 03:39:11PM +0200, Pratyush Yadav wrote:
> >> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> >> 
> >> In the upcoming commits, the KHO will learn how to discover free blocks
> >> of memory by walking the KHO radix tree. It will then mark those regions
> >> as scratch to allow memory allocation in case scratch runs low.
> >> 
> >> To differentiate the extended scratch areas from the main scratch areas,
> >> introduce MEMBLOCK_KHO_SCRATCH_EXT. Use it when choosing memblock flags
> >> for allocations during scratch-only. Teach should_skip_region() to check
> >> for both flags before deciding if the region should be skipped.
> >
> > Why there's a need to differentiate SCRATCH and SCRATCH_EXT?
> > SCRATCH (I still hate the name) means "memory memblock can safely use for

 +1000

I also strongly dislike this name and mentioned it in another thread
earlier today.

If we ever decide to s/scratch/something-else/ globally, that should be a
separate cleanup effort. However, since we are introducing a brand new flag
here, we can discuss a better name for the _ext portion to avoid overloading
the "scratch" concept.

> > the allocations". Initially this memory comes from the reservations in the
> > first kernel, but if the second kernel can find more memory to extend it,
> > why that additional memory should be treated differently? 
> 
> Two reasons:
> 
> 1. We mark SCRATCH as MIGRATE_CMA. We don't want to do that for
>    SCRATCH_EXT since this memory can be used for non-movable
>    allocations.
> 
> 2. Gigantic (1G) huge pages can not be allocated from scratch. They can
>    be preserved memory and thus should not be allocated from SCRATCH.
>    See patch 12 that does allocations for gigantic huge pages only from
>    SCRATCH_EXT.
> 
> I will add this in the commit message for the next version.
> 
> Naming is hard, so if you have any better names I'm all ears :-)

IMO, this scratch_ext is not "scratch" in the traditional KHO sense at all.
The traditional KHO scratch is what is passed from kernel to kernel and is
guaranteed to contain zero preserved memory. This new memory is not passed
from kernel to kernel and can contain preserved memory at runtime. It's
essentially just memory that we identify as currently unpreserved and release
early to the system.

If we want to keep the naming aligned with the existing codebase for now:
MEMBLOCK_KHO_SCRATCH      -> original scratch
MEMBLOCK_KHO_UNPRESERVED  -> for the new memory (instead of SCRATCH_EXT)

Alternatively, if we do want to tackle the global rename of "scratch" later:
MEMBLOCK_KHO_BOOTSTRAP    -> for the original scratch
MEMBLOCK_KHO_UNPRESERVED  -> for this new dynamic memory

What do you think?

Pasha

> 
> >
> >> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> >> ---
> >> 
> >> Notes:
> >>     Checkpatch complains about no space after MEMBLOCK_KHO_SCRATCH_EXT in
> >>     the declaration, but doing so makes it nicely align with all the other
> >>     numbers. Mike, if you'd like I can add some whitespace.
> >> 
> >>  include/linux/memblock.h | 10 ++++++++++
> >>  mm/memblock.c            | 41 ++++++++++++++++++++++++++++++++++------
> >>  2 files changed, 45 insertions(+), 6 deletions(-)
> 
> -- 
> Regards,
> Pratyush Yadav

