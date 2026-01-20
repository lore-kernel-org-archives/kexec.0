Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E97CA5FA0
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 16:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LaNZKx3aitCjIZUu8i1aQUcjkyqufyS/EzpiGQL6i8g=; b=Uvd4gsiBDWm28aXdVmdGaR8H3R
	py8pvhc82Vhn4U0Pd4eFX10jf3w8eQjmRt14MfeJW9Tli/pMrWPDqnsGBaSGD6jCIleMmEP7DhX/0
	8wdoYJrsUkcb5L1T4nBpJsfy5ehHepQhVVwZa9xzHjr/wpgXV3dJdRH24h6hJ3NZLHEzuAxgk3PSw
	s0CZZ6hRdZNyAlbhu5oN51a9SF/1raisw1w5jTDRcnuPq8Ajd6rJTKXw7SfUILqIy+bWY/ASfp8tc
	KDCzAdtOrV4GA+EEJaJ/GlSdngLT6e6UWijH1bN41kSRKkDOm+hIJ+fS8HgHQIJP6NFlCaGze6S1v
	LytbSUPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viEHt-000000048DZ-1f9j;
	Tue, 20 Jan 2026 16:09:01 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viEHs-000000048DT-2N7p
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 16:09:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A28EF600CB;
	Tue, 20 Jan 2026 16:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BFBC16AAE;
	Tue, 20 Jan 2026 16:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768925339;
	bh=os1EwFT5nvnw99r6n/Mg19gaCUrjgTrNjKTqCnEbqzs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=g9Tg7woKpvI/KsMGSfnoNo0YwIS4G+sKz+BWpN2P7V68wE1XLyYkmeEbL6WPngR5d
	 WkiLXBu2+bGWI55uOYf7LogQY9MXJl2Q91vZ9qcSfQkn0PVRmsQ7BfQzTlmLho6Ng1
	 GDrlV4HyJL2I2MFnEE9rlwIV6tQkKxrSWljL3OWyynWhc6XZa6EjvKauM+iD1qzfjW
	 eJb+IPurbeVcPvU0DGnYpcmYkd8JJHXXLCq1igkdDqD7zeW+OLcwAt9gAXf6li+nWi
	 9HqJe2cEhrvP/9TKUOs1F5w8QzNZ0rAnyWvZk5H74XHpR1m63VP9FGvXP+9GqjxMih
	 1L8/mL8J3iHcQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Jason Miu <jasonmiu@google.com>,  Jonathan Corbet
 <corbet@lwn.net>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH 3/6] kho: docs: combine concepts and FDT documentation
In-Reply-To: <20260105165839.285270-4-rppt@kernel.org> (Mike Rapoport's
	message of "Mon, 5 Jan 2026 18:58:36 +0200")
References: <20260105165839.285270-1-rppt@kernel.org>
	<20260105165839.285270-4-rppt@kernel.org>
Date: Tue, 20 Jan 2026 16:08:56 +0000
Message-ID: <2vxz7btce06f.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Jan 05 2026, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Currently index.rst in KHO documentation looks empty and sad as it only
> contains links to "Kexec Handover Concepts" and "KHO FDT" chapters.
>
> Inline contents of these chapters into index.rst to provide a single
> coherent chapter describing KHO.
>
> While on it, drop parts of the KHO FDT description that will be superseded
> by addition of KHO ABI documentation.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
[...]
> diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
> index 0c63b0c5c143..03cd9afbdb2e 100644
> --- a/Documentation/core-api/kho/index.rst
> +++ b/Documentation/core-api/kho/index.rst
> @@ -4,10 +4,73 @@
>  Kexec Handover Subsystem
>  ========================
>  
> -.. toctree::
> -   :maxdepth: 1
> +Overview
> +========

I ran a test build and Sphinx complains about:

    Documentation/admin-guide/mm/kho.rst:10: WARNING: undefined label: 'kho-concepts' [ref.ref]
    Documentation/admin-guide/mm/kho.rst:31: WARNING: undefined label: 'kho-finalization-phase' [ref.ref]

I suppose you should add these labels here.

Otherwise LGTM.

>  
> -   concepts
> -   fdt
> +Kexec HandOver (KHO) is a mechanism that allows Linux to preserve memory
> +regions, which could contain serialized system states, across kexec.
>  
> -.. only::  subproject and html
> +KHO uses :ref:`flattened device tree (FDT) <kho_fdt>` to pass information about
> +the preserved state from pre-exec kernel to post-kexec kernel and :ref:`scratch
> +memory regions <kho_scratch>` to ensure integrity of the preserved memory.
> +
> +.. _kho_fdt:
> +
> +KHO FDT
> +=======
> +Every KHO kexec carries a KHO specific flattened device tree (FDT) blob that
> +describes the preserved state. The FDT includes properties describing preserved
> +memory regions and nodes that hold subsystem specific state.
> +
> +The preserved memory regions contain either serialized subsystem states, or
> +in-memory data that shall not be touched across kexec. After KHO, subsystems
> +can retrieve and restore the preserved state from KHO FDT.
> +
> +Subsystems participating in KHO can define their own format for state
> +serialization and preservation.
> +
> +.. _kho_scratch:
> +
> +Scratch Regions
> +===============
> +
> +To boot into kexec, we need to have a physically contiguous memory range that
> +contains no handed over memory. Kexec then places the target kernel and initrd
> +into that region. The new kernel exclusively uses this region for memory
> +allocations before during boot up to the initialization of the page allocator.
> +
> +We guarantee that we always have such regions through the scratch regions: On
> +first boot KHO allocates several physically contiguous memory regions. Since
> +after kexec these regions will be used by early memory allocations, there is a
> +scratch region per NUMA node plus a scratch region to satisfy allocations
> +requests that do not require particular NUMA node assignment.
> +By default, size of the scratch region is calculated based on amount of memory
> +allocated during boot. The ``kho_scratch`` kernel command line option may be
> +used to explicitly define size of the scratch regions.
> +The scratch regions are declared as CMA when page allocator is initialized so
> +that their memory can be used during system lifetime. CMA gives us the
> +guarantee that no handover pages land in that region, because handover pages
> +must be at a static physical memory location and CMA enforces that only
> +movable pages can be located inside.
> +
> +After KHO kexec, we ignore the ``kho_scratch`` kernel command line option and
> +instead reuse the exact same region that was originally allocated. This allows
> +us to recursively execute any amount of KHO kexecs. Because we used this region
> +for boot memory allocations and as target memory for kexec blobs, some parts
> +of that memory region may be reserved. These reservations are irrelevant for
> +the next KHO, because kexec can overwrite even the original kernel.
> +
> +KHO finalization phase
> +======================
> +
> +To enable user space based kexec file loader, the kernel needs to be able to
> +provide the FDT that describes the current kernel's state before
> +performing the actual kexec. The process of generating that FDT is
> +called serialization. When the FDT is generated, some properties
> +of the system may become immutable because they are already written down
> +in the FDT. That state is called the KHO finalization phase.
> +
> +See Also
> +========
> +
> +- :doc:`/admin-guide/mm/kho`
> diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
> index 7960eb15a81f..e2aba13494cf 100644
> --- a/Documentation/core-api/liveupdate.rst
> +++ b/Documentation/core-api/liveupdate.rst
> @@ -58,4 +58,4 @@ See Also
>  ========
>  
>  - :doc:`Live Update uAPI </userspace-api/liveupdate>`
> -- :doc:`/core-api/kho/concepts`
>
> +- :doc:`/core-api/kho/index`
>
> diff --git a/Documentation/mm/memfd_preservation.rst b/Documentation/mm/memfd_preservation.rst
> index 66e0fb6d5ef0..a8a5b476afd3 100644
> --- a/Documentation/mm/memfd_preservation.rst
> +++ b/Documentation/mm/memfd_preservation.rst
> @@ -20,4 +20,4 @@ See Also
>  ========
>  
>  - :doc:`/core-api/liveupdate`
> -- :doc:`/core-api/kho/concepts`
>
> +- :doc:`/core-api/kho/index`

-- 
Regards,
Pratyush Yadav

