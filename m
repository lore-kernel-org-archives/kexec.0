Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBBE606A323
	for <kexec@archiver.kernel.org>; Sun, 15 Nov 2026 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HophomGc;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Fbf7lMUe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Nwu6vL4nnJhyf28I3Hp9RT6yqlvZkPwzRk4lPxIAvmQ=; b=HophomGcCpxpMVXU3tgppNqR7e
	COow59W2J6KqZS/BbDRWRuHH3dYwEKacYsgc+VKZXRZPtF3axljH7KXlHPZ3HUZ7deqOTCRVivcsI
	N9tnWBO3ugeeHYe2TzC+k62fbLfQGlfM3hubp09HGInU6AF4RoVJW4+Pi9bmrIbduwCgpIKS+3z9F
	lY4M9/VjE4Ekb+DXyVi386iSAA7quXfSsMgp0IzGcCmT3YNK0yFAceiQRmw4O5lAjmljIrB3aEk9+
	7tOXvDC6+wOc8T72dQq0TjaO8koRcf4eKTrmRnu1D6iQjcx8bNtxCwFNhAFDONO4PddPwHnspOs1+
	JqL0vkxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xShkb-00000000VG7-1tpC;
	Sun, 15 Nov 2026 21:27:01 +0000
Received: from mail-ej1-x647.google.com ([2a00:1450:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xShkY-00000000VEv-1q84
	for kexec@lists.infradead.org;
	Sun, 15 Nov 2026 21:27:00 +0000
Received: by mail-ej1-x647.google.com with SMTP id a640c23a62f3a-c50547b4992so210162066b.3
        for <kexec@lists.infradead.org>; Sun, 15 Nov 2026 13:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794778016; x=1795382816; darn=lists.infradead.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nwu6vL4nnJhyf28I3Hp9RT6yqlvZkPwzRk4lPxIAvmQ=;
        b=Fbf7lMUeup0LrYrbpxcFeO4HdO8kM3wptZay0ZTv8OgcxbEQu4B3cpj2afJDrb9cJJ
         W5nwwujDcJ1I15RNrPWU9Lh2SzrGWbF2GVZw+f2/PSj4YqI2tTV8cpOGjo1JEbwtcTFN
         HfuTHv7LwazJVuARPmY5jVEFI2c8jnGSpKDYj5dYieTwYQMD40ZYLaiDpelj3IF/vyO7
         yOtc5otdLz82LlfG1aiHyD+V5l1PFHBYHB4DM8WkrCaW5r+38On2EUcuCY6DpYQOjmB6
         2Dmv/8m/CV/dqjnvNARCWZyIyl9x5YYlQuoo5d5olUff+XBctRIABR8vsR8SnDPngQDN
         aD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794778016; x=1795382816;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nwu6vL4nnJhyf28I3Hp9RT6yqlvZkPwzRk4lPxIAvmQ=;
        b=dU+UVN8CKsE/asvcHKdM5Ss6DYbzOWAfOZcBEM95RKcIx8CrztHD0+VHkKHJbRHBR3
         LyeuHWmG18FKXVnI2eQisAZ342qNtF8d4qJa4Skd00pANO57MHc9sFyWvDo2zeCsFcGY
         ze3/EF+UwRZaWuS06yQpIcOBNDdYK0zY6U6a0xset3mwfV043woHMZco9eyKdFRelM6t
         8ZExs/PKe/QCb3JdBOI2eTe5BrwPLDcVoL1vsDGvajCuv9qFPMEONVaQjcnZd8t5h9U3
         qWYcjnbLlRPPLniGfz29K79F9BPu9tZ4eD1h/QnBmkVeL2FVaPzoMJ+TkIb5ahdUJIol
         +ldQ==
X-Forwarded-Encrypted: i=1; AL+hErFNg6aV0SZk5/Zuo61PXgpWHhkgI6zcBVpLaoyjH1fKI3+qOD9qsEIYAFBcMk36MTOoWg6nUw==@lists.infradead.org
X-Gm-Message-State: APuU4Z8225g2zJnYxwcFcQ59Gxso3VM7x+o4aX69ZULhUyEURlFLq42q
	sYCqdYftWw5W6SE/e5iLBuFEKZ1cSZMg1c4tF5M6zHh6mASzwp5oNjsIuA4HICyxCoAOJ/8o8lx
	qAr4VNiCW4Ortyo9zEA==
X-Received: from ejgh12.prod.google.com ([2002:a17:906:3c0c:b0:c33:b3b5:5260])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1b2a:b0:c41:285a:46a9 with SMTP id a640c23a62f3a-c5096847651mr661397666b.46.1794778015420;
 Sun, 15 Nov 2026 13:26:55 -0800 (PST)
Date: Sun, 15 Nov 2026 21:26:54 +0000
In-Reply-To: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
Message-ID: <9huzzev9n5up.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v2 0/9] kho: add read-only Kexec Handover mode
From: tarunsahu@google.com
To: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kselftest@vger.kernel.org, 
	rppt@kernel.org, kuba@kernel.org, enelsonmoore@gmail.com, bp@alien8.de, 
	shuah@kernel.org, david@kernel.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, ljs@kernel.org, mhocko@suse.com, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, vbabka@kernel.org, 
	dapeng1.mi@linux.intel.com, linux-kernel@vger.kernel.org, corbet@lwn.net, 
	surenb@google.com, kexec@lists.infradead.org, pratyush@kernel.org, 
	rdunlap@infradead.org, elver@google.com, graf@amazon.com, 
	lirongqing@baidu.com, liam@infradead.org, jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_132658_571751_0FB30047 
X-CRM114-Status: GOOD (  34.00  )
X-Spam-Score: -9.5 (---------)
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
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


IIUC, this series will be pciked after the kho feature flags [1]
Should it be rebased on top of [1]?

[1]: https://lore.kernel.org/all/20261110050202.529473-1-tarunsahu@google.com/

~Tarun

Pasha Tatashin <pasha.tatashin@soleen.com> writes:

> This series introduces a read-only Kexec Handover mode, enabled at boot
> via 'kho_ro=<pa>' pointing to the physical address of the KHO FDT.
>
> In standard KHO, the outgoing kernel shuts down or serializes all
> devices into LUO state, releases machine control, and passes the KHO
> FDT physical address through the kexec_file_load() reboot path to the
> next kernel, which becomes the sole "Machine Owner" (MO), initializes
> struct pages for preserved folios during early boot, and reclaims KHO
> metadata and preserved pages back into the page allocator as they are
> restored.
>
> In the "Linux Caretaker" (LC) model (as well as inspection kernels or
> firmware), a minimal LC kernel runs concurrently on dedicated CPUs
> offlined from the MO scheduler while MO is still active or undergoing a
> standard KHO-preserved kexec reboot (Live Update). LC is given
> read-only access to KHO so a minimal VMM inside LC can keep VMs
> responsive (<30ms VM blackout time) by servicing software-only, fully
> virtualized devices (such as virtio-console, pvpanic, virtio-rng, etc.)
> that do not require host hardware interrupts or global machine state,
> while leaving the preserved KHO tree intact for the incoming MO kernel
> to retrieve normally once it boots.
>
> LC is never MO: it has no PCI support, does not handle device
> interrupts, and is booted inside a small LUO-preserved memfd region
> (e.g., ~128MB of RAM on a host with terabytes of memory). Because LC's
> direct map only covers its own small memory footprint (both for
> isolation and to avoid struct page overhead for host memory), the KHO
> FDT, radix tree, and preserved memory all reside outside of LC's direct
> map. Furthermore, because LC is configured and launched from userspace
> while MO is still running rather than through a kexec reboot handoff
> from a shutting-down kernel, userspace reads the KHO FDT physical
> address from /sys/kernel/debug/kho/out/fdt_phys and explicitly passes
> 'kho_ro=<pa>' on LC's kernel command line.
>
> Both CONFIG_KEXEC_HANDOVER and CONFIG_KEXEC_HANDOVER_READONLY can be
> compiled into the same kernel image, with the active mode selected at
> boot via the kernel command line ('kho=on' vs 'kho_ro=<pa>'; passing
> 'kho_ro=<pa>' disables regular KHO).
>
> Overview of the series:
> - Patch 1 exposes the physical address of the outgoing KHO FDT via
>   /sys/kernel/debug/kho/out/fdt_phys so userspace tooling can pass it
>   to a 'kho_ro=<pa>' kernel.
> - Patch 2 moves the shared radix-tree key encoding, indexing, leaf
>   lookup (kho_radix_find_leaf()), FDT validation, and
>   kho_retrieve_subtree() helpers into a shared
>   kernel/liveupdate/kexec_handover_common.c compilation unit with
>   declarations in kernel/liveupdate/kexec_handover_internal.h, while
>   also checking that fdt_totalsize(fdt) does not exceed PAGE_SIZE in
>   kho_check_fdt() and using get_unaligned() for 64-bit FDT property
>   reads in kho_retrieve_subtree().
> - Patch 3 hardens kho_restore_vmalloc() and factors out shared vmalloc
>   helpers by introducing kho_vmalloc_validate() and kho_vmalloc_walk()
>   in kernel/liveupdate/kexec_handover_common.c to validate the
>   preservation metadata header and walk the chunk list.
> - Patch 4 avoids modifying ser->next and bs->head_pa in kho_block_add()
>   and kho_block_set_shrink_one() when operating on an incoming block
>   set, as the chain is already linked and incoming blocks must not be
>   modified in KHO read-only mode.
> - Patch 5 adds CONFIG_KEXEC_HANDOVER_READONLY and
>   kernel/liveupdate/kexec_handover_ro.c. When booted with
>   'kho_ro=<pa>', the KHO FDT is mapped and validated once in an
>   early_initcall, and radix-tree nodes, leaves, and folio/vmalloc
>   mappings are cached on first visit in a unified RCU-protected hash
>   table for the lifetime of the read-only KHO kernel, providing
>   kho_is_ro(), kho_ro_lookup_folio_order(), kho_ro_map_folio(), and
>   kho_ro_map_vmalloc().
> - Patch 6 wires read-only KHO mode into KHO core (kho_populate(),
>   kho_memory_init(), and kho_retrieve_subtree()).
> - Patch 7 updates kho_block to map incoming serialized blocks read-only
>   via kho_ro_map_folio() in read-only KHO mode.
> - Patches 8 and 9 extend test_kho and tools/testing/selftests/kho/vmtest.sh
>   to build a single kernel with both CONFIG_KEXEC_HANDOVER=y and
>   CONFIG_KEXEC_HANDOVER_READONLY=y and test both standard KHO and
>   read-only KHO handover when preserved memory lies outside the boot
>   kernel's initial memory range on x86_64 and arm64.
>
> This series is based on liveupdate/next commit 27be83a12b24 ("Merge
> branch 'lu-pci-preservation' into next").
>
> Changelog:
> v2:
> - Expand the cover letter with the LC architecture, explaining why
>   'kho_ro=<pa>' takes the FDT physical address on the command line and
>   describing the expected users of the read-only KHO APIs (Suggested by
>   Mike Rapoport).
> - Patch 2 (Suggested by Mike Rapoport):
>   - Move the shared radix-tree, FDT, and subtree retrieval helpers into
>     a dedicated kernel/liveupdate/kexec_handover_common.c file instead
>     of static inline functions in
>     kernel/liveupdate/kexec_handover_internal.h, and factor out
>     kho_radix_find_leaf() for radix leaf lookup.
>   - Check that fdt_totalsize(fdt) does not exceed PAGE_SIZE in
>     kho_check_fdt(), drop the "setup: " log prefix from FDT validation
>     warnings, and use get_unaligned() when reading 64-bit FDT properties
>     in kho_retrieve_subtree().
> - Patch 3:
>   - Move kho_flags_to_vmalloc() to kexec_handover_common.c alongside
>     kho_vmalloc_validate() and add a shared kho_vmalloc_walk() chunk
>     walker used by both kho_restore_vmalloc() and kho_ro_map_vmalloc().
> - Patches 5 and 6:
>   - Allow CONFIG_KEXEC_HANDOVER and CONFIG_KEXEC_HANDOVER_READONLY to be
>     compiled into the same kernel image and select the active mode via
>     the kernel command line ('kho_ro=<pa>' forces regular KHO disabled).
>   - Split the KHO core integration (kho_populate(), kho_memory_init(),
>     and kho_retrieve_subtree()) into a separate patch (Patch 6) so
>     Patch 5 only introduces the read-only KHO backend.
>   - Map and validate the KHO FDT and preserved-memory-map root once in
>     an early_initcall so kho_ro_get_fdt() and kho_retrieve_subtree() do
>     not sleep or map lazily.
>   - Replace kho_ro_restore_vmalloc() (which allocated RAM and copied
>     pages) with kho_ro_map_vmalloc() to map preserved kho_vmalloc
>     regions read-only in place using kho_vmalloc_walk().
>   - Cache radix-tree node, leaf, folio, and vmalloc mappings in a
>     unified RCU-protected hash table (kho_ro_map_ht) keyed by address,
>     size, and protection for the lifetime of the read-only KHO kernel,
>     and drop kho_ro_unmap().
> - Patch 9:
>   - Build the kernel and initrd only once in vmtest.sh with both
>     CONFIG_KEXEC_HANDOVER=y and CONFIG_KEXEC_HANDOVER_READONLY=y
>     enabled, running both the standard KHO test and the read-only KHO
>     test on the same kernel image.
> Link: https://lore.kernel.org/all/20261019021111.990394-1-pasha.tatashin@soleen.com/ # v1
>
> Pasha Tatashin (9):
>   kho: expose physical address of outgoing FDT
>   kho: move radix tree and FDT helpers to common file
>   kho: validate preservation metadata in kho_restore_vmalloc()
>   kho: do not modify incoming serialized blocks
>   kho: add read-only Kexec Handover mode
>   kho: support read-only KHO mode in KHO core
>   kho: support read-only KHO mode in kho_block
>   kho: test: support read-only KHO mode in test_kho
>   selftests: kho: add read-only KHO test to vmtest.sh
>
>  .../admin-guide/kernel-parameters.txt         |   8 +
>  Documentation/admin-guide/mm/kho.rst          |   3 +
>  Documentation/core-api/kho/index.rst          |   6 +
>  include/linux/kexec_handover.h                |  44 +-
>  kernel/liveupdate/Kconfig                     |  10 +
>  kernel/liveupdate/Makefile                    |   3 +-
>  kernel/liveupdate/kexec_handover.c            | 284 +++---------
>  kernel/liveupdate/kexec_handover_common.c     | 298 ++++++++++++
>  kernel/liveupdate/kexec_handover_debugfs.c    |  22 +-
>  kernel/liveupdate/kexec_handover_internal.h   |  47 +-
>  kernel/liveupdate/kexec_handover_ro.c         | 429 ++++++++++++++++++
>  kernel/liveupdate/kho_block.c                 |  78 +++-
>  lib/Kconfig.debug                             |   2 +-
>  lib/test_kho.c                                |  71 ++-
>  tools/testing/selftests/kho/arm64.conf        |   1 +
>  tools/testing/selftests/kho/init.c            |  38 +-
>  tools/testing/selftests/kho/vmtest.sh         |  65 ++-
>  tools/testing/selftests/kho/x86.conf          |   1 +
>  18 files changed, 1121 insertions(+), 289 deletions(-)
>  create mode 100644 kernel/liveupdate/kexec_handover_common.c
>  create mode 100644 kernel/liveupdate/kexec_handover_ro.c
>
>
> base-commit: 27be83a12b246b6b3783e7d3ac5c378ff7520f25
> -- 
> 2.56.0.307.g5fe7bd680c-goog

