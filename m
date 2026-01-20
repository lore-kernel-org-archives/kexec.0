Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B81D26283
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 18:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OJD5vU4OQnbGEmFpWt9NVYFsiNiyrO4DhhwC2rYlt28=; b=UscGKXH8mVCbhBab7mbbpLKIB1
	vTRIK/hm88GzBquIp/ssjYLDjJNCd+XQODp+Bqlrs7ern7S/90K1BLEf+Hv02gKuMLcsMfU4yagEO
	rquEkhu9xBIboHaU2MKAp2Z+NUgbrWJOxCqzZi/WquGeI22fF0ZkGNHsBo+hRKbAIe/hxcztkgKCC
	gahNvCQZP80r5cbZ+eYZv4TKY4ET0xcUnkDFrnCVAYVmBHTQ/xTmjjAanHPxtpa3Ik+sur/dKWgW2
	UWsgJ+8tQIA0KT2Jp6jlnBltXBgIlXqjIlrC2JrNqXy/M9gS0ctfgGV3dwAfqKDvZFPeZdmwhcZnk
	pQ9XO4cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viGZk-00000004JDb-1NYl;
	Tue, 20 Jan 2026 18:35:36 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viGZg-00000004JDH-47MC
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 18:35:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2AB4A42DE4;
	Tue, 20 Jan 2026 18:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C45C19421;
	Tue, 20 Jan 2026 18:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768934132;
	bh=5UuViMOKhctbPjtTzY+cSAg4SjcGuC20Kuka59xeaLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXaAldEp6bxXie0YRh1TMKfNcAPUEx+KFCDkPBtoCwDUSKc93CWcWhlEKk1WlmRYW
	 6hw2SnPfGVkECqWVl1OcTViy+DIMqB732m365bSaSIJVALxo2duCYdBLS5C2NKP1Wd
	 FFCBY4FU8Sx7YXbcFyU+dH+xbIEQD4l+h2q5bwp9QLdUvkUM5wds+QWAgdjuPaKnve
	 XGFu+o10G1KWf6+kc/fo1PNZzNDpeQ3BOeNI4vs82YxE5utw0WJ3St3LYB53M8gUZk
	 jDqVrvWWiTV0UstjDqvHgrnleljxubi8Z3sQ/OkovclSYNLvR+sBjq3m3GZPGBnFD/
	 P0r7tp1Yfrlng==
Date: Tue, 20 Jan 2026 20:35:25 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Jason Miu <jasonmiu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/6] kho: docs: combine concepts and FDT documentation
Message-ID: <aW_K7QZj8HYzA00t@kernel.org>
References: <20260105165839.285270-1-rppt@kernel.org>
 <20260105165839.285270-4-rppt@kernel.org>
 <2vxz7btce06f.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz7btce06f.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_103533_062908_E1AEA99C 
X-CRM114-Status: GOOD (  33.11  )
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

On Tue, Jan 20, 2026 at 04:08:56PM +0000, Pratyush Yadav wrote:
> On Mon, Jan 05 2026, Mike Rapoport wrote:
> 
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > Currently index.rst in KHO documentation looks empty and sad as it only
> > contains links to "Kexec Handover Concepts" and "KHO FDT" chapters.
> >
> > Inline contents of these chapters into index.rst to provide a single
> > coherent chapter describing KHO.
> >
> > While on it, drop parts of the KHO FDT description that will be superseded
> > by addition of KHO ABI documentation.
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> [...]
> > diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
> > index 0c63b0c5c143..03cd9afbdb2e 100644
> > --- a/Documentation/core-api/kho/index.rst
> > +++ b/Documentation/core-api/kho/index.rst
> > @@ -4,10 +4,73 @@
> >  Kexec Handover Subsystem
> >  ========================
> >  
> > -.. toctree::
> > -   :maxdepth: 1
> > +Overview
> > +========
> 
> I ran a test build and Sphinx complains about:
> 
>     Documentation/admin-guide/mm/kho.rst:10: WARNING: undefined label: 'kho-concepts' [ref.ref]
>     Documentation/admin-guide/mm/kho.rst:31: WARNING: undefined label: 'kho-finalization-phase' [ref.ref]
> 
> I suppose you should add these labels here.

It's already in Andrew's tree:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-nonmm-unstable&id=bc1a060da2a76161ba65f1badc551de15056e398
 
> Otherwise LGTM.
> 
> >  
> > -   concepts
> > -   fdt
> > +Kexec HandOver (KHO) is a mechanism that allows Linux to preserve memory
> > +regions, which could contain serialized system states, across kexec.
> >  
> > -.. only::  subproject and html
> > +KHO uses :ref:`flattened device tree (FDT) <kho_fdt>` to pass information about
> > +the preserved state from pre-exec kernel to post-kexec kernel and :ref:`scratch
> > +memory regions <kho_scratch>` to ensure integrity of the preserved memory.
> > +
> > +.. _kho_fdt:
> > +
> > +KHO FDT
> > +=======
> > +Every KHO kexec carries a KHO specific flattened device tree (FDT) blob that
> > +describes the preserved state. The FDT includes properties describing preserved
> > +memory regions and nodes that hold subsystem specific state.
> > +
> > +The preserved memory regions contain either serialized subsystem states, or
> > +in-memory data that shall not be touched across kexec. After KHO, subsystems
> > +can retrieve and restore the preserved state from KHO FDT.
> > +
> > +Subsystems participating in KHO can define their own format for state
> > +serialization and preservation.
> > +
> > +.. _kho_scratch:
> > +
> > +Scratch Regions
> > +===============
> > +
> > +To boot into kexec, we need to have a physically contiguous memory range that
> > +contains no handed over memory. Kexec then places the target kernel and initrd
> > +into that region. The new kernel exclusively uses this region for memory
> > +allocations before during boot up to the initialization of the page allocator.
> > +
> > +We guarantee that we always have such regions through the scratch regions: On
> > +first boot KHO allocates several physically contiguous memory regions. Since
> > +after kexec these regions will be used by early memory allocations, there is a
> > +scratch region per NUMA node plus a scratch region to satisfy allocations
> > +requests that do not require particular NUMA node assignment.
> > +By default, size of the scratch region is calculated based on amount of memory
> > +allocated during boot. The ``kho_scratch`` kernel command line option may be
> > +used to explicitly define size of the scratch regions.
> > +The scratch regions are declared as CMA when page allocator is initialized so
> > +that their memory can be used during system lifetime. CMA gives us the
> > +guarantee that no handover pages land in that region, because handover pages
> > +must be at a static physical memory location and CMA enforces that only
> > +movable pages can be located inside.
> > +
> > +After KHO kexec, we ignore the ``kho_scratch`` kernel command line option and
> > +instead reuse the exact same region that was originally allocated. This allows
> > +us to recursively execute any amount of KHO kexecs. Because we used this region
> > +for boot memory allocations and as target memory for kexec blobs, some parts
> > +of that memory region may be reserved. These reservations are irrelevant for
> > +the next KHO, because kexec can overwrite even the original kernel.
> > +
> > +KHO finalization phase
> > +======================
> > +
> > +To enable user space based kexec file loader, the kernel needs to be able to
> > +provide the FDT that describes the current kernel's state before
> > +performing the actual kexec. The process of generating that FDT is
> > +called serialization. When the FDT is generated, some properties
> > +of the system may become immutable because they are already written down
> > +in the FDT. That state is called the KHO finalization phase.
> > +
> > +See Also
> > +========
> > +
> > +- :doc:`/admin-guide/mm/kho`
> > diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
> > index 7960eb15a81f..e2aba13494cf 100644
> > --- a/Documentation/core-api/liveupdate.rst
> > +++ b/Documentation/core-api/liveupdate.rst
> > @@ -58,4 +58,4 @@ See Also
> >  ========
> >  
> >  - :doc:`Live Update uAPI </userspace-api/liveupdate>`
> > -- :doc:`/core-api/kho/concepts`
> >
> > +- :doc:`/core-api/kho/index`
> >
> > diff --git a/Documentation/mm/memfd_preservation.rst b/Documentation/mm/memfd_preservation.rst
> > index 66e0fb6d5ef0..a8a5b476afd3 100644
> > --- a/Documentation/mm/memfd_preservation.rst
> > +++ b/Documentation/mm/memfd_preservation.rst
> > @@ -20,4 +20,4 @@ See Also
> >  ========
> >  
> >  - :doc:`/core-api/liveupdate`
> > -- :doc:`/core-api/kho/concepts`
> >
> > +- :doc:`/core-api/kho/index`
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

